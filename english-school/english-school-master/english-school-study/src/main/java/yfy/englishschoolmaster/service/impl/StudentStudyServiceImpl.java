package yfy.englishschoolmaster.service.impl;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.StrUtil;
import com.mybatisflex.core.query.QueryWrapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import yfy.englishschoolmaster.constant.RedisTypeConstant;
import yfy.englishschoolmaster.constant.UserConstant;
import yfy.englishschoolmaster.exception.ErrorCode;
import yfy.englishschoolmaster.exception.ThrowUtils;
import yfy.englishschoolmaster.model.dto.StudentStudy.StudentChoiceAnswerRequest;
import yfy.englishschoolmaster.model.dto.StudentStudy.StudentSpellAnswerRequest;
import yfy.englishschoolmaster.model.dto.StudentStudy.StudentWordStatusUpdateRequest;
import yfy.englishschoolmaster.model.entity.AnswerRecord;
import yfy.englishschoolmaster.model.entity.ClassDailyAssignment;
import yfy.englishschoolmaster.model.entity.ClassDailyAssignmentWord;
import yfy.englishschoolmaster.model.entity.ClassStudent;
import yfy.englishschoolmaster.model.entity.StudentWordProgress;
import yfy.englishschoolmaster.model.entity.Word;
import yfy.englishschoolmaster.model.entity.WordOption;
import yfy.englishschoolmaster.model.vo.StudentAnswerResultVO;
import yfy.englishschoolmaster.model.vo.StudentHomeworkCacheVO;
import yfy.englishschoolmaster.model.vo.StudentHomeworkWordVO;
import yfy.englishschoolmaster.model.vo.StudentStudyOptionVO;
import yfy.englishschoolmaster.model.vo.UserAccountVO;
import yfy.englishschoolmaster.service.AnswerRecordService;
import yfy.englishschoolmaster.service.ClassDailyAssignmentService;
import yfy.englishschoolmaster.service.ClassDailyAssignmentWordService;
import yfy.englishschoolmaster.service.ClassStudentService;
import yfy.englishschoolmaster.service.RedisService;
import yfy.englishschoolmaster.service.StudentStudyService;
import yfy.englishschoolmaster.service.StudentWordProgressService;
import yfy.englishschoolmaster.service.WordOptionService;
import yfy.englishschoolmaster.service.WordService;

import java.sql.Date;
import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * 学生学习服务实现：
 * 今日作业以 Redis 缓存为主（TTL 3h），过期前回写 DB。
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
@Service
public class StudentStudyServiceImpl implements StudentStudyService {

    private static final Logger log = LoggerFactory.getLogger(StudentStudyServiceImpl.class);

    private static final ZoneId ZONE_SHANGHAI = ZoneId.of("Asia/Shanghai");
    private static final Duration HOMEWORK_TTL = Duration.ofHours(3);
    private static final Duration SYNC_BEFORE_EXPIRE = Duration.ofMinutes(10);
    private static final String STATUS_IN_CLASS = "IN_CLASS";
    private static final String STATUS_NEW = "NEW";
    private static final String STATUS_LEARNING = "LEARNING";
    private static final String STATUS_MASTERED = "MASTERED";
    private static final String ASSIGN_SKIPPED = "SKIPPED";
    private static final String ANSWER_TYPE_NEW = "NEW";
    private static final String QUESTION_CHOICE = "CHOICE";
    private static final String QUESTION_SPELL = "SPELL";
    private static final Set<String> STUDY_STATUS_SET = Set.of(STATUS_NEW, STATUS_LEARNING);
    private static final Set<String> UPDATABLE_STATUS_SET = Set.of(STATUS_LEARNING, STATUS_MASTERED);

    private final RedisService redisService;
    private final ClassStudentService classStudentService;
    private final ClassDailyAssignmentService classDailyAssignmentService;
    private final ClassDailyAssignmentWordService classDailyAssignmentWordService;
    private final StudentWordProgressService studentWordProgressService;
    private final WordService wordService;
    private final WordOptionService wordOptionService;
    private final AnswerRecordService answerRecordService;

    public StudentStudyServiceImpl(RedisService redisService,
                                   ClassStudentService classStudentService,
                                   ClassDailyAssignmentService classDailyAssignmentService,
                                   ClassDailyAssignmentWordService classDailyAssignmentWordService,
                                   StudentWordProgressService studentWordProgressService,
                                   WordService wordService,
                                   WordOptionService wordOptionService,
                                   AnswerRecordService answerRecordService) {
        this.redisService = redisService;
        this.classStudentService = classStudentService;
        this.classDailyAssignmentService = classDailyAssignmentService;
        this.classDailyAssignmentWordService = classDailyAssignmentWordService;
        this.studentWordProgressService = studentWordProgressService;
        this.wordService = wordService;
        this.wordOptionService = wordOptionService;
        this.answerRecordService = answerRecordService;
    }

    /** 实现今日作业缓存重建 */
    @Override
    public StudentHomeworkCacheVO refreshHomeworkCache(Long studentId) {
        ThrowUtils.throwIf(studentId == null || studentId <= 0, ErrorCode.PARAMS_ERROR, "学生ID不合法");

        StudentHomeworkCacheVO cacheVO = buildHomeworkFromDb(studentId);
        redisService.write(cacheVO, HOMEWORK_TTL, RedisTypeConstant.STUDENT_HOMEWORK_LIST, String.valueOf(studentId));
        return cacheVO;
    }

    /** 实现今日作业获取：Redis 优先，未命中回源 DB */
    @Override
    public StudentHomeworkCacheVO getTodayHomework(UserAccountVO loginUser) {
        // 1. 权限校验
        checkStudent(loginUser);
        Long studentId = loginUser.getId();

        // 2. 优先读 Redis
        StudentHomeworkCacheVO cache = redisService.read(
                String.valueOf(studentId),
                RedisTypeConstant.STUDENT_HOMEWORK_LIST,
                StudentHomeworkCacheVO.class
        );
        if (cache != null) {
            return cache;
        }

        // 3. 未命中则回源并回写
        return refreshHomeworkCache(studentId);
    }

    /** 实现四选一判题 */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public StudentAnswerResultVO answerChoice(StudentChoiceAnswerRequest request, UserAccountVO loginUser) {
        // 1. 参数与权限
        checkStudent(loginUser);
        ThrowUtils.throwIf(request == null, ErrorCode.PARAMS_ERROR, "作答请求为空");
        ThrowUtils.throwIf(request.getWordId() == null || request.getWordId() <= 0, ErrorCode.PARAMS_ERROR, "单词ID不合法");
        ThrowUtils.throwIf(request.getOptionId() == null || request.getOptionId() <= 0, ErrorCode.PARAMS_ERROR, "选项ID不合法");

        StudentWordProgress progress = requireStudyProgress(loginUser.getId(), request.getWordId());
        WordOption option = wordOptionService.getById(request.getOptionId());
        ThrowUtils.throwIf(option == null, ErrorCode.NOT_FOUND_ERROR, "选项不存在");
        ThrowUtils.throwIf(!Objects.equals(option.getWordId(), request.getWordId()),
                ErrorCode.PARAMS_ERROR, "选项不属于该单词");

        Word word = wordService.getById(request.getWordId());
        ThrowUtils.throwIf(word == null, ErrorCode.NOT_FOUND_ERROR, "单词不存在");

        boolean correct = option.getIsCorrect() != null && option.getIsCorrect() == 1;
        String correctAnswer = word.getCorrectMeaning();

        // 2. 写答题记录
        saveAnswerRecord(loginUser.getId(), progress.getClassId(), request.getWordId(),
                QUESTION_CHOICE, option.getOptionText(), correctAnswer, correct);

        // 3. 更新进度（DB + Redis）
        String newStatus = applyAnswerProgress(progress, correct);
        rewriteHomeworkCacheProgress(loginUser.getId(), request.getWordId(), newStatus,
                progress.getCorrectCount(), progress.getWrongCount());

        return buildAnswerResult(request.getWordId(), correct, correctAnswer, newStatus);
    }

    /** 实现拼写判题 */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public StudentAnswerResultVO answerSpell(StudentSpellAnswerRequest request, UserAccountVO loginUser) {
        // 1. 参数与权限
        checkStudent(loginUser);
        ThrowUtils.throwIf(request == null, ErrorCode.PARAMS_ERROR, "作答请求为空");
        ThrowUtils.throwIf(request.getWordId() == null || request.getWordId() <= 0, ErrorCode.PARAMS_ERROR, "单词ID不合法");
        ThrowUtils.throwIf(StrUtil.isBlank(request.getSpelledText()), ErrorCode.PARAMS_ERROR, "拼写内容不能为空");

        StudentWordProgress progress = requireStudyProgress(loginUser.getId(), request.getWordId());
        Word word = wordService.getById(request.getWordId());
        ThrowUtils.throwIf(word == null, ErrorCode.NOT_FOUND_ERROR, "单词不存在");

        String spelled = request.getSpelledText().trim();
        String correctAnswer = StrUtil.blankToDefault(word.getWordText(), "").trim();
        boolean correct = correctAnswer.equalsIgnoreCase(spelled);

        // 2. 写答题记录
        saveAnswerRecord(loginUser.getId(), progress.getClassId(), request.getWordId(),
                QUESTION_SPELL, spelled, correctAnswer, correct);

        // 3. 更新进度（DB + Redis）
        String newStatus = applyAnswerProgress(progress, correct);
        rewriteHomeworkCacheProgress(loginUser.getId(), request.getWordId(), newStatus,
                progress.getCorrectCount(), progress.getWrongCount());

        return buildAnswerResult(request.getWordId(), correct, correctAnswer, newStatus);
    }

    /** 实现学习状态修改：MASTERED 后重建缓存 */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateWordStatus(StudentWordStatusUpdateRequest request, UserAccountVO loginUser) {
        // 1. 参数与权限
        checkStudent(loginUser);
        ThrowUtils.throwIf(request == null, ErrorCode.PARAMS_ERROR, "状态修改请求为空");
        ThrowUtils.throwIf(request.getWordId() == null || request.getWordId() <= 0, ErrorCode.PARAMS_ERROR, "单词ID不合法");
        ThrowUtils.throwIf(StrUtil.isBlank(request.getStatus()), ErrorCode.PARAMS_ERROR, "学习状态不能为空");

        String targetStatus = request.getStatus().trim().toUpperCase();
        ThrowUtils.throwIf(!UPDATABLE_STATUS_SET.contains(targetStatus),
                ErrorCode.PARAMS_ERROR, "仅支持修改为 LEARNING 或 MASTERED");

        StudentWordProgress progress = studentWordProgressService.getOne(QueryWrapper.create()
                .eq(StudentWordProgress::getStudentId, loginUser.getId())
                .eq(StudentWordProgress::getWordId, request.getWordId()));
        ThrowUtils.throwIf(progress == null, ErrorCode.NOT_FOUND_ERROR, "单词学习进度不存在");

        // 2. 更新数据库
        LocalDateTime now = LocalDateTime.now();
        progress.setStatus(targetStatus);
        progress.setLastStudiedAt(now);
        progress.setUpdatedAt(now);
        boolean updated = studentWordProgressService.updateById(progress);
        ThrowUtils.throwIf(!updated, ErrorCode.OPERATION_ERROR, "更新学习状态失败");

        // 3. MASTERED 后重建缓存；否则同步 Redis 中该词状态
        if (STATUS_MASTERED.equals(targetStatus)) {
            refreshHomeworkCache(loginUser.getId());
        } else {
            rewriteHomeworkCacheProgress(loginUser.getId(), request.getWordId(), targetStatus,
                    progress.getCorrectCount(), progress.getWrongCount());
        }
        return true;
    }

    /** 实现即将过期作业缓存的进度回写 DB */
    @Override
    public int syncExpiringHomeworkProgressToDb() {
        Set<String> studentIds = redisService.listIdsByType(RedisTypeConstant.STUDENT_HOMEWORK_LIST);
        if (CollUtil.isEmpty(studentIds)) {
            return 0;
        }

        int synced = 0;
        for (String studentIdStr : studentIds) {
            Duration ttl = redisService.getExpire(studentIdStr, RedisTypeConstant.STUDENT_HOMEWORK_LIST);
            if (ttl == null) {
                continue;
            }
            // 过期前 10 分钟窗口：0 < ttl <= 10min
            if (ttl.isZero() || ttl.compareTo(SYNC_BEFORE_EXPIRE) > 0) {
                continue;
            }

            StudentHomeworkCacheVO cache = redisService.read(
                    studentIdStr,
                    RedisTypeConstant.STUDENT_HOMEWORK_LIST,
                    StudentHomeworkCacheVO.class
            );
            if (cache == null || Boolean.TRUE.equals(cache.getProgressSynced())) {
                continue;
            }
            try {
                flushCacheProgressToDb(cache);
                cache.setProgressSynced(true);
                redisService.write(cache, ttl, RedisTypeConstant.STUDENT_HOMEWORK_LIST, studentIdStr);
                synced++;
                log.info("作业进度回写成功, studentId={}, remainTtlSec={}", studentIdStr, ttl.getSeconds());
            } catch (Exception e) {
                log.error("作业进度回写失败, studentId={}", studentIdStr, e);
            }
        }
        return synced;
    }

    /** 从 DB 组装该生今日待学词表（NEW/LEARNING），选项随机打乱 */
    private StudentHomeworkCacheVO buildHomeworkFromDb(Long studentId) {
        StudentHomeworkCacheVO cacheVO = new StudentHomeworkCacheVO();
        cacheVO.setStudentId(studentId);
        cacheVO.setWordCount(0);
        cacheVO.setWords(new ArrayList<>());
        cacheVO.setProgressSynced(false);

        // 1. 在班班级
        ClassStudent classStudent = classStudentService.getOne(QueryWrapper.create()
                .eq(ClassStudent::getStudentId, studentId)
                .eq(ClassStudent::getStatus, STATUS_IN_CLASS));
        if (classStudent == null || classStudent.getClassId() == null) {
            return cacheVO;
        }
        Long classId = classStudent.getClassId();
        cacheVO.setClassId(classId);

        // 2. 今日分配批次
        LocalDate today = LocalDate.now(ZONE_SHANGHAI);
        Date todaySql = Date.valueOf(today);
        List<ClassDailyAssignment> assignments = classDailyAssignmentService.list(QueryWrapper.create()
                .eq(ClassDailyAssignment::getClassId, classId)
                .eq(ClassDailyAssignment::getAssignDate, todaySql)
                .ne(ClassDailyAssignment::getStatus, ASSIGN_SKIPPED));
        if (CollUtil.isEmpty(assignments)) {
            return cacheVO;
        }

        List<Long> assignmentIds = assignments.stream().map(ClassDailyAssignment::getId).toList();
        List<ClassDailyAssignmentWord> assignedWords = classDailyAssignmentWordService.list(QueryWrapper.create()
                .in(ClassDailyAssignmentWord::getAssignmentId, assignmentIds)
                .eq(ClassDailyAssignmentWord::getStudentId, studentId)
                .orderBy(ClassDailyAssignmentWord::getSortOrder, true));
        // 兼容升级前全班一份词表（student_id 为空）
        if (CollUtil.isEmpty(assignedWords)) {
            assignedWords = classDailyAssignmentWordService.list(QueryWrapper.create()
                    .in(ClassDailyAssignmentWord::getAssignmentId, assignmentIds)
                    .isNull("student_id")
                    .orderBy(ClassDailyAssignmentWord::getSortOrder, true));
        }
        if (CollUtil.isEmpty(assignedWords)) {
            return cacheVO;
        }

        List<Long> todayWordIds = assignedWords.stream()
                .map(ClassDailyAssignmentWord::getWordId)
                .filter(Objects::nonNull)
                .distinct()
                .toList();

        // 3. 进度过滤 NEW / LEARNING
        List<StudentWordProgress> progressList = studentWordProgressService.list(QueryWrapper.create()
                .eq(StudentWordProgress::getStudentId, studentId)
                .eq(StudentWordProgress::getClassId, classId)
                .in(StudentWordProgress::getWordId, todayWordIds)
                .in(StudentWordProgress::getStatus, STUDY_STATUS_SET));
        if (CollUtil.isEmpty(progressList)) {
            return cacheVO;
        }

        Map<Long, StudentWordProgress> progressMap = progressList.stream()
                .collect(Collectors.toMap(StudentWordProgress::getWordId, p -> p, (a, b) -> a));

        List<Long> studyWordIds = new ArrayList<>(progressMap.keySet());
        List<Word> words = wordService.listByIds(studyWordIds);
        Map<Long, Word> wordMap = words.stream()
                .collect(Collectors.toMap(Word::getId, w -> w, (a, b) -> a));

        Map<Long, List<WordOption>> optionMap = new HashMap<>();
        for (Long wordId : studyWordIds) {
            List<WordOption> options = wordOptionService.listByWordId(wordId);
            optionMap.put(wordId, options == null ? List.of() : options);
        }

        // 4. 按今日分配顺序组装，打乱选项
        List<StudentHomeworkWordVO> homeworkWords = new ArrayList<>();
        for (ClassDailyAssignmentWord assigned : assignedWords) {
            Long wordId = assigned.getWordId();
            StudentWordProgress progress = progressMap.get(wordId);
            Word word = wordMap.get(wordId);
            if (progress == null || word == null) {
                continue;
            }
            homeworkWords.add(toHomeworkWordVO(word, progress, optionMap.getOrDefault(wordId, List.of())));
        }

        cacheVO.setWords(homeworkWords);
        cacheVO.setWordCount(homeworkWords.size());
        return cacheVO;
    }

    private StudentHomeworkWordVO toHomeworkWordVO(Word word, StudentWordProgress progress, List<WordOption> options) {
        StudentHomeworkWordVO vo = new StudentHomeworkWordVO();
        vo.setWordId(word.getId());
        vo.setWordText(word.getWordText());
        vo.setPhonetic(word.getPhonetic());
        vo.setCorrectMeaning(word.getCorrectMeaning());
        vo.setExampleSentence(word.getExampleSentence());
        vo.setExampleTranslation(word.getExampleTranslation());
        vo.setProgressStatus(progress.getStatus());
        vo.setCorrectCount(progress.getCorrectCount() == null ? 0 : progress.getCorrectCount());
        vo.setWrongCount(progress.getWrongCount() == null ? 0 : progress.getWrongCount());

        List<StudentStudyOptionVO> optionVOs = new ArrayList<>();
        for (WordOption option : options) {
            StudentStudyOptionVO optionVO = new StudentStudyOptionVO();
            optionVO.setId(option.getId());
            optionVO.setOptionText(option.getOptionText());
            optionVO.setSortOrder(option.getSortOrder());
            optionVOs.add(optionVO);
        }
        Collections.shuffle(optionVOs);
        vo.setOptions(optionVOs);
        return vo;
    }

    /** 校验单词在学习计划中且未掌握 */
    private StudentWordProgress requireStudyProgress(Long studentId, Long wordId) {
        StudentWordProgress progress = studentWordProgressService.getOne(QueryWrapper.create()
                .eq(StudentWordProgress::getStudentId, studentId)
                .eq(StudentWordProgress::getWordId, wordId));
        ThrowUtils.throwIf(progress == null, ErrorCode.NOT_FOUND_ERROR, "单词不在学习计划中");
        ThrowUtils.throwIf(!STUDY_STATUS_SET.contains(progress.getStatus())
                        && !STATUS_MASTERED.equalsIgnoreCase(progress.getStatus()),
                ErrorCode.OPERATION_ERROR, "单词学习状态异常");
        ThrowUtils.throwIf(STATUS_MASTERED.equalsIgnoreCase(progress.getStatus()),
                ErrorCode.OPERATION_ERROR, "该单词已掌握，无需再答");
        return progress;
    }

    /** 根据作答结果更新进度：NEW 首次答对后变为 LEARNING */
    private String applyAnswerProgress(StudentWordProgress progress, boolean correct) {
        LocalDateTime now = LocalDateTime.now();
        if (correct) {
            progress.setCorrectCount((progress.getCorrectCount() == null ? 0 : progress.getCorrectCount()) + 1);
        } else {
            progress.setWrongCount((progress.getWrongCount() == null ? 0 : progress.getWrongCount()) + 1);
            progress.setIsWrongWord(1);
        }
        if (STATUS_NEW.equalsIgnoreCase(progress.getStatus())) {
            progress.setStatus(STATUS_LEARNING);
        }
        progress.setLastStudiedAt(now);
        progress.setUpdatedAt(now);
        boolean updated = studentWordProgressService.updateById(progress);
        ThrowUtils.throwIf(!updated, ErrorCode.OPERATION_ERROR, "更新学习进度失败");
        return progress.getStatus();
    }

    private void saveAnswerRecord(Long studentId, Long classId, Long wordId,
                                  String questionType, String selected, String correctAnswer, boolean correct) {
        AnswerRecord record = AnswerRecord.builder()
                .studentId(studentId)
                .classId(classId)
                .wordId(wordId)
                .answerType(ANSWER_TYPE_NEW)
                .questionType(questionType)
                .selectedAnswer(selected)
                .correctAnswer(correctAnswer)
                .isCorrect(correct ? 1 : 0)
                .answeredAt(LocalDateTime.now())
                .build();
        boolean saved = answerRecordService.save(record);
        ThrowUtils.throwIf(!saved, ErrorCode.OPERATION_ERROR, "保存答题记录失败");
    }

    private StudentAnswerResultVO buildAnswerResult(Long wordId, boolean correct, String correctAnswer, String status) {
        StudentAnswerResultVO result = new StudentAnswerResultVO();
        result.setWordId(wordId);
        result.setCorrect(correct);
        result.setCorrectAnswer(correctAnswer);
        result.setProgressStatus(status);
        return result;
    }

    /**
     * 在保留剩余 TTL 的前提下，更新 Redis 中对应单词的进度字段。
     */
    private void rewriteHomeworkCacheProgress(Long studentId, Long wordId, String status,
                                              Integer correctCount, Integer wrongCount) {
        String id = String.valueOf(studentId);
        StudentHomeworkCacheVO cache = redisService.read(id, RedisTypeConstant.STUDENT_HOMEWORK_LIST,
                StudentHomeworkCacheVO.class);
        if (cache == null || CollUtil.isEmpty(cache.getWords())) {
            return;
        }
        Duration ttl = redisService.getExpire(id, RedisTypeConstant.STUDENT_HOMEWORK_LIST);
        if (ttl == null || ttl.isZero() || ttl.isNegative()) {
            ttl = HOMEWORK_TTL;
        }

        for (StudentHomeworkWordVO wordVO : cache.getWords()) {
            if (Objects.equals(wordVO.getWordId(), wordId)) {
                wordVO.setProgressStatus(status);
                wordVO.setCorrectCount(correctCount == null ? 0 : correctCount);
                wordVO.setWrongCount(wrongCount == null ? 0 : wrongCount);
                break;
            }
        }
        cache.setProgressSynced(false);
        redisService.write(cache, ttl, RedisTypeConstant.STUDENT_HOMEWORK_LIST, id);
    }

    /** 将 Redis 缓存中的单词进度批量回写 student_word_progress */
    private void flushCacheProgressToDb(StudentHomeworkCacheVO cache) {
        if (cache == null || cache.getStudentId() == null || CollUtil.isEmpty(cache.getWords())) {
            return;
        }
        Long studentId = cache.getStudentId();
        LocalDateTime now = LocalDateTime.now();
        for (StudentHomeworkWordVO wordVO : cache.getWords()) {
            if (wordVO.getWordId() == null || StrUtil.isBlank(wordVO.getProgressStatus())) {
                continue;
            }
            StudentWordProgress progress = studentWordProgressService.getOne(QueryWrapper.create()
                    .eq(StudentWordProgress::getStudentId, studentId)
                    .eq(StudentWordProgress::getWordId, wordVO.getWordId()));
            if (progress == null) {
                continue;
            }
            progress.setStatus(wordVO.getProgressStatus().trim().toUpperCase());
            if (wordVO.getCorrectCount() != null) {
                progress.setCorrectCount(wordVO.getCorrectCount());
            }
            if (wordVO.getWrongCount() != null) {
                progress.setWrongCount(wordVO.getWrongCount());
            }
            progress.setUpdatedAt(now);
            progress.setLastStudiedAt(now);
            studentWordProgressService.updateById(progress);
        }
    }

    /** 校验当前用户为学生角色 */
    private void checkStudent(UserAccountVO loginUser) {
        ThrowUtils.throwIf(loginUser == null || loginUser.getId() == null, ErrorCode.NOT_LOGIN_ERROR, "未登录");
        ThrowUtils.throwIf(!UserConstant.STUDENT_ROLE.equalsIgnoreCase(loginUser.getRole()),
                ErrorCode.NO_AUTH_ERROR, "仅学生可访问学习接口");
    }
}
