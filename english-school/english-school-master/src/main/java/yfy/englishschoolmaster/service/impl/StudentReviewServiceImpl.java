package yfy.englishschoolmaster.service.impl;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.StrUtil;
import com.mybatisflex.core.query.QueryWrapper;
import com.mybatisflex.spring.service.impl.ServiceImpl;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import yfy.englishschoolmaster.constant.RedisTypeConstant;
import yfy.englishschoolmaster.constant.UserConstant;
import yfy.englishschoolmaster.exception.ErrorCode;
import yfy.englishschoolmaster.exception.ThrowUtils;
import yfy.englishschoolmaster.mapper.StudentDailyReviewMapper;
import yfy.englishschoolmaster.model.dto.StudentReview.HighWrongWordStat;
import yfy.englishschoolmaster.model.dto.StudentReview.StudentReviewChoiceAnswerRequest;
import yfy.englishschoolmaster.model.dto.StudentReview.StudentReviewSpellAnswerRequest;
import yfy.englishschoolmaster.model.entity.AnswerRecord;
import yfy.englishschoolmaster.model.entity.StudentDailyReview;
import yfy.englishschoolmaster.model.entity.StudentWordProgress;
import yfy.englishschoolmaster.model.entity.Word;
import yfy.englishschoolmaster.model.entity.WordOption;
import yfy.englishschoolmaster.model.vo.StudentAnswerResultVO;
import yfy.englishschoolmaster.model.vo.StudentReviewCacheVO;
import yfy.englishschoolmaster.model.vo.StudentReviewPlanRunResultVO;
import yfy.englishschoolmaster.model.vo.StudentReviewWordVO;
import yfy.englishschoolmaster.model.vo.StudentStudyOptionVO;
import yfy.englishschoolmaster.model.vo.UserAccountVO;
import yfy.englishschoolmaster.service.AnswerRecordService;
import yfy.englishschoolmaster.service.RedisService;
import yfy.englishschoolmaster.service.StudentReviewService;
import yfy.englishschoolmaster.service.StudentWordProgressService;
import yfy.englishschoolmaster.service.WordOptionService;
import yfy.englishschoolmaster.service.WordService;

import java.sql.Date;
import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

/**
 * 学生复习服务实现：
 * 复习计划优先级：高频错题 > 次日必复 > 艾宾浩斯到期。
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
@Service
public class StudentReviewServiceImpl extends ServiceImpl<StudentDailyReviewMapper, StudentDailyReview>
        implements StudentReviewService {

    private static final Logger log = LoggerFactory.getLogger(StudentReviewServiceImpl.class);

    private static final ZoneId ZONE_SHANGHAI = ZoneId.of("Asia/Shanghai");
    private static final Duration REVIEW_CACHE_TTL = Duration.ofHours(3);

    private static final String REASON_HIGH_WRONG = "HIGH_WRONG";
    private static final String REASON_DAY1 = "DAY1_FOLLOWUP";
    private static final String REASON_EBBINGHAUS = "EBBINGHAUS";
    private static final String STATUS_PENDING = "PENDING";
    private static final String STATUS_DONE = "DONE";
    private static final String STATUS_LEARNING = "LEARNING";
    private static final String ANSWER_TYPE_REVIEW = "REVIEW";
    private static final String QUESTION_CHOICE = "CHOICE";
    private static final String QUESTION_SPELL = "SPELL";

    /** 复习成功后（review_count=1..n）对应间隔：2,4,7,15,30 */
    private static final int[] EBBINGHAUS_AFTER_SUCCESS = {2, 4, 7, 15, 30};

    private final StudentWordProgressService studentWordProgressService;
    private final WordService wordService;
    private final WordOptionService wordOptionService;
    private final AnswerRecordService answerRecordService;
    private final RedisService redisService;

    public StudentReviewServiceImpl(StudentWordProgressService studentWordProgressService,
                                    WordService wordService,
                                    WordOptionService wordOptionService,
                                    AnswerRecordService answerRecordService,
                                    RedisService redisService) {
        this.studentWordProgressService = studentWordProgressService;
        this.wordService = wordService;
        this.wordOptionService = wordOptionService;
        this.answerRecordService = answerRecordService;
        this.redisService = redisService;
    }

    /** 实现全量复习计划生成：三条规则合并去重后幂等落库 */
    @Override
    public StudentReviewPlanRunResultVO generateReviewPlanForDate(LocalDate reviewDate) {
        // 1. 参数
        ThrowUtils.throwIf(reviewDate == null, ErrorCode.PARAMS_ERROR, "复习日期不能为空");
        LocalDate yesterday = reviewDate.minusDays(1);
        Date reviewSqlDate = Date.valueOf(reviewDate);

        StudentReviewPlanRunResultVO result = new StudentReviewPlanRunResultVO();
        result.setReviewDate(reviewDate);
        result.setHighWrongCount(0);
        result.setDay1FollowupCount(0);
        result.setEbbinghausCount(0);
        result.setTotalUpsertCount(0);

        // key: studentId_wordId
        Map<String, PlanCandidate> candidates = new HashMap<>();

        // 2. 规则：昨日答错次数 > 3（最高优先）
        LocalDateTime start = yesterday.atStartOfDay();
        LocalDateTime end = reviewDate.atStartOfDay();
        List<HighWrongWordStat> highWrongList = this.getMapper().selectHighWrongWords(start, end);
        if (CollUtil.isNotEmpty(highWrongList)) {
            for (HighWrongWordStat stat : highWrongList) {
                if (stat.getStudentId() == null || stat.getWordId() == null || stat.getClassId() == null) {
                    continue;
                }
                String key = buildKey(stat.getStudentId(), stat.getWordId());
                candidates.put(key, new PlanCandidate(
                        stat.getStudentId(), stat.getWordId(), stat.getClassId(), REASON_HIGH_WRONG));
            }
            result.setHighWrongCount(highWrongList.size());
        }

        // 3. 规则：昨日新学词次日必复
        LocalDateTime day1Start = yesterday.atStartOfDay();
        LocalDateTime day1End = LocalDateTime.of(yesterday, LocalTime.MAX);
        List<StudentWordProgress> day1Progress = studentWordProgressService.list(QueryWrapper.create()
                .ge(StudentWordProgress::getCreatedAt, day1Start)
                .le(StudentWordProgress::getCreatedAt, day1End));
        int day1Added = 0;
        if (CollUtil.isNotEmpty(day1Progress)) {
            for (StudentWordProgress progress : day1Progress) {
                String key = buildKey(progress.getStudentId(), progress.getWordId());
                if (candidates.containsKey(key)) {
                    continue;
                }
                candidates.put(key, new PlanCandidate(
                        progress.getStudentId(), progress.getWordId(), progress.getClassId(), REASON_DAY1));
                day1Added++;
            }
        }
        result.setDay1FollowupCount(day1Added);

        // 4. 规则：艾宾浩斯到期（next_review_date = 今天）
        List<StudentWordProgress> dueList = studentWordProgressService.list(QueryWrapper.create()
                .eq(StudentWordProgress::getNextReviewDate, reviewSqlDate));
        int ebbinghausAdded = 0;
        if (CollUtil.isNotEmpty(dueList)) {
            for (StudentWordProgress progress : dueList) {
                String key = buildKey(progress.getStudentId(), progress.getWordId());
                if (candidates.containsKey(key)) {
                    continue;
                }
                candidates.put(key, new PlanCandidate(
                        progress.getStudentId(), progress.getWordId(), progress.getClassId(), REASON_EBBINGHAUS));
                ebbinghausAdded++;
            }
        }
        result.setEbbinghausCount(ebbinghausAdded);

        // 5. 落库（幂等 upsert）并回写 progress
        int upsert = 0;
        LocalDateTime now = LocalDateTime.now();
        for (PlanCandidate candidate : candidates.values()) {
            boolean saved = upsertReviewItem(candidate, reviewSqlDate, now);
            if (saved) {
                upsert++;
            }
            applyProgressForPlan(candidate, reviewDate, now);
        }
        result.setTotalUpsertCount(upsert);
        log.info("复习计划生成完成, date={}, highWrong={}, day1={}, ebbinghaus={}, upsert={}",
                reviewDate, result.getHighWrongCount(), result.getDay1FollowupCount(),
                result.getEbbinghausCount(), upsert);
        return result;
    }

    /** 实现管理员手动触发生成 */
    @Override
    public StudentReviewPlanRunResultVO runPlanByAdmin(LocalDate reviewDate, UserAccountVO loginUser) {
        ThrowUtils.throwIf(loginUser == null || loginUser.getId() == null, ErrorCode.NOT_LOGIN_ERROR, "未登录");
        ThrowUtils.throwIf(!UserConstant.ADMIN_ROLE.equalsIgnoreCase(loginUser.getRole()),
                ErrorCode.NO_AUTH_ERROR, "仅管理员可手动生成复习计划");
        LocalDate date = reviewDate == null ? LocalDate.now(ZONE_SHANGHAI) : reviewDate;
        return generateReviewPlanForDate(date);
    }

    /** 实现今日复习缓存重建 */
    @Override
    public StudentReviewCacheVO refreshReviewCache(Long studentId) {
        ThrowUtils.throwIf(studentId == null || studentId <= 0, ErrorCode.PARAMS_ERROR, "学生ID不合法");
        StudentReviewCacheVO cache = buildReviewFromDb(studentId);
        redisService.write(cache, REVIEW_CACHE_TTL, RedisTypeConstant.STUDENT_REVIEW_LIST, String.valueOf(studentId));
        return cache;
    }

    /** 实现今日复习获取：Redis 优先，未命中回源 DB */
    @Override
    public StudentReviewCacheVO getTodayReview(UserAccountVO loginUser) {
        checkStudent(loginUser);
        Long studentId = loginUser.getId();
        StudentReviewCacheVO cache = redisService.read(
                String.valueOf(studentId),
                RedisTypeConstant.STUDENT_REVIEW_LIST,
                StudentReviewCacheVO.class
        );
        if (cache != null) {
            return cache;
        }
        return refreshReviewCache(studentId);
    }

    /** 实现复习四选一判题 */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public StudentAnswerResultVO answerChoice(StudentReviewChoiceAnswerRequest request, UserAccountVO loginUser) {
        checkStudent(loginUser);
        ThrowUtils.throwIf(request == null, ErrorCode.PARAMS_ERROR, "作答请求为空");
        ThrowUtils.throwIf(request.getWordId() == null || request.getWordId() <= 0, ErrorCode.PARAMS_ERROR, "单词ID不合法");
        ThrowUtils.throwIf(request.getOptionId() == null || request.getOptionId() <= 0, ErrorCode.PARAMS_ERROR, "选项ID不合法");

        StudentDailyReview review = requirePendingReview(loginUser.getId(), request.getWordId());
        WordOption option = wordOptionService.getById(request.getOptionId());
        ThrowUtils.throwIf(option == null, ErrorCode.NOT_FOUND_ERROR, "选项不存在");
        ThrowUtils.throwIf(!Objects.equals(option.getWordId(), request.getWordId()),
                ErrorCode.PARAMS_ERROR, "选项不属于该单词");

        Word word = wordService.getById(request.getWordId());
        ThrowUtils.throwIf(word == null, ErrorCode.NOT_FOUND_ERROR, "单词不存在");

        boolean correct = option.getIsCorrect() != null && option.getIsCorrect() == 1;
        String correctAnswer = word.getCorrectMeaning();

        saveAnswerRecord(loginUser.getId(), review.getClassId(), request.getWordId(),
                QUESTION_CHOICE, option.getOptionText(), correctAnswer, correct);

        String status = applyReviewResult(loginUser.getId(), review, correct);
        refreshReviewCache(loginUser.getId());
        return buildAnswerResult(request.getWordId(), correct, correctAnswer, status);
    }

    /** 实现复习拼写判题 */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public StudentAnswerResultVO answerSpell(StudentReviewSpellAnswerRequest request, UserAccountVO loginUser) {
        checkStudent(loginUser);
        ThrowUtils.throwIf(request == null, ErrorCode.PARAMS_ERROR, "作答请求为空");
        ThrowUtils.throwIf(request.getWordId() == null || request.getWordId() <= 0, ErrorCode.PARAMS_ERROR, "单词ID不合法");
        ThrowUtils.throwIf(StrUtil.isBlank(request.getSpelledText()), ErrorCode.PARAMS_ERROR, "拼写内容不能为空");

        StudentDailyReview review = requirePendingReview(loginUser.getId(), request.getWordId());
        Word word = wordService.getById(request.getWordId());
        ThrowUtils.throwIf(word == null, ErrorCode.NOT_FOUND_ERROR, "单词不存在");

        String spelled = request.getSpelledText().trim();
        String correctAnswer = StrUtil.blankToDefault(word.getWordText(), "").trim();
        boolean correct = correctAnswer.equalsIgnoreCase(spelled);

        saveAnswerRecord(loginUser.getId(), review.getClassId(), request.getWordId(),
                QUESTION_SPELL, spelled, correctAnswer, correct);

        String status = applyReviewResult(loginUser.getId(), review, correct);
        refreshReviewCache(loginUser.getId());
        return buildAnswerResult(request.getWordId(), correct, correctAnswer, status);
    }

    /** 幂等写入复习项：已存在时按 reason 优先级决定是否更新 */
    private boolean upsertReviewItem(PlanCandidate candidate, Date reviewSqlDate, LocalDateTime now) {
        StudentDailyReview exist = this.getOne(QueryWrapper.create()
                .eq(StudentDailyReview::getStudentId, candidate.studentId)
                .eq(StudentDailyReview::getWordId, candidate.wordId)
                .eq(StudentDailyReview::getReviewDate, reviewSqlDate));
        if (exist != null) {
            // 已存在：若新 reason 优先级更高则更新 reason；已 DONE 不改回 PENDING
            if (reasonPriority(candidate.reason) > reasonPriority(exist.getReason())
                    && !STATUS_DONE.equalsIgnoreCase(exist.getStatus())) {
                exist.setReason(candidate.reason);
                exist.setUpdatedAt(now);
                return this.updateById(exist);
            }
            return false;
        }
        StudentDailyReview item = StudentDailyReview.builder()
                .studentId(candidate.studentId)
                .classId(candidate.classId)
                .wordId(candidate.wordId)
                .reviewDate(reviewSqlDate)
                .reason(candidate.reason)
                .status(STATUS_PENDING)
                .createdAt(now)
                .updatedAt(now)
                .build();
        return this.save(item);
    }

    /** 生成计划时同步回写 student_word_progress 的 next_review_date 等字段 */
    private void applyProgressForPlan(PlanCandidate candidate, LocalDate reviewDate, LocalDateTime now) {
        StudentWordProgress progress = studentWordProgressService.getOne(QueryWrapper.create()
                .eq(StudentWordProgress::getStudentId, candidate.studentId)
                .eq(StudentWordProgress::getWordId, candidate.wordId));
        if (progress == null) {
            return;
        }
        progress.setNextReviewDate(Date.valueOf(reviewDate));
        progress.setStatus(STATUS_LEARNING);
        progress.setUpdatedAt(now);

        if (REASON_HIGH_WRONG.equals(candidate.reason)) {
            // 重置艾宾浩斯节奏
            progress.setReviewCount(0);
            progress.setIntervalDays(1);
            progress.setIsWrongWord(1);
        } else if (REASON_DAY1.equals(candidate.reason)) {
            if (progress.getReviewCount() == null) {
                progress.setReviewCount(0);
            }
            progress.setIntervalDays(1);
        }
        studentWordProgressService.updateById(progress);
    }

    /** 从 DB 组装今日 PENDING 状态的复习词表 */
    private StudentReviewCacheVO buildReviewFromDb(Long studentId) {
        StudentReviewCacheVO cache = new StudentReviewCacheVO();
        cache.setStudentId(studentId);
        cache.setWordCount(0);
        cache.setWords(new ArrayList<>());

        LocalDate today = LocalDate.now(ZONE_SHANGHAI);
        Date todaySql = Date.valueOf(today);
        List<StudentDailyReview> reviews = this.list(QueryWrapper.create()
                .eq(StudentDailyReview::getStudentId, studentId)
                .eq(StudentDailyReview::getReviewDate, todaySql)
                .eq(StudentDailyReview::getStatus, STATUS_PENDING));
        if (CollUtil.isEmpty(reviews)) {
            return cache;
        }

        cache.setClassId(reviews.get(0).getClassId());
        List<Long> wordIds = reviews.stream().map(StudentDailyReview::getWordId).filter(Objects::nonNull).distinct().toList();
        Map<Long, String> reasonMap = new HashMap<>();
        for (StudentDailyReview review : reviews) {
            reasonMap.put(review.getWordId(), review.getReason());
        }

        List<Word> words = wordService.listByIds(wordIds);
        Map<Long, Word> wordMap = new HashMap<>();
        for (Word word : words) {
            wordMap.put(word.getId(), word);
        }

        List<StudentWordProgress> progressList = studentWordProgressService.list(QueryWrapper.create()
                .eq(StudentWordProgress::getStudentId, studentId)
                .in(StudentWordProgress::getWordId, wordIds));
        Map<Long, StudentWordProgress> progressMap = new HashMap<>();
        for (StudentWordProgress progress : progressList) {
            progressMap.put(progress.getWordId(), progress);
        }

        List<StudentReviewWordVO> wordVOs = new ArrayList<>();
        for (Long wordId : wordIds) {
            Word word = wordMap.get(wordId);
            if (word == null) {
                continue;
            }
            StudentReviewWordVO vo = new StudentReviewWordVO();
            vo.setWordId(word.getId());
            vo.setWordText(word.getWordText());
            vo.setPhonetic(word.getPhonetic());
            vo.setCorrectMeaning(word.getCorrectMeaning());
            vo.setExampleSentence(word.getExampleSentence());
            vo.setExampleTranslation(word.getExampleTranslation());
            vo.setReason(reasonMap.get(wordId));
            StudentWordProgress progress = progressMap.get(wordId);
            vo.setProgressStatus(progress == null ? STATUS_LEARNING : progress.getStatus());

            List<WordOption> options = wordOptionService.listByWordId(wordId);
            List<StudentStudyOptionVO> optionVOs = new ArrayList<>();
            if (CollUtil.isNotEmpty(options)) {
                for (WordOption option : options) {
                    StudentStudyOptionVO optionVO = new StudentStudyOptionVO();
                    optionVO.setId(option.getId());
                    optionVO.setOptionText(option.getOptionText());
                    optionVO.setSortOrder(option.getSortOrder());
                    optionVOs.add(optionVO);
                }
                Collections.shuffle(optionVOs);
            }
            vo.setOptions(optionVOs);
            wordVOs.add(vo);
        }
        cache.setWords(wordVOs);
        cache.setWordCount(wordVOs.size());
        return cache;
    }

    private StudentDailyReview requirePendingReview(Long studentId, Long wordId) {
        LocalDate today = LocalDate.now(ZONE_SHANGHAI);
        StudentDailyReview review = this.getOne(QueryWrapper.create()
                .eq(StudentDailyReview::getStudentId, studentId)
                .eq(StudentDailyReview::getWordId, wordId)
                .eq(StudentDailyReview::getReviewDate, Date.valueOf(today))
                .eq(StudentDailyReview::getStatus, STATUS_PENDING));
        ThrowUtils.throwIf(review == null, ErrorCode.OPERATION_ERROR, "该单词不在今日待复习列表中");
        return review;
    }

    /**
     * 复习答对：推进艾宾浩斯并标记 DONE；答错：次日再复，当日 review 仍 DONE（已完成本次作答）。
     */
    private String applyReviewResult(Long studentId, StudentDailyReview review, boolean correct) {
        LocalDateTime now = LocalDateTime.now();
        LocalDate today = LocalDate.now(ZONE_SHANGHAI);

        review.setStatus(STATUS_DONE);
        review.setUpdatedAt(now);
        this.updateById(review);

        StudentWordProgress progress = studentWordProgressService.getOne(QueryWrapper.create()
                .eq(StudentWordProgress::getStudentId, studentId)
                .eq(StudentWordProgress::getWordId, review.getWordId()));
        ThrowUtils.throwIf(progress == null, ErrorCode.NOT_FOUND_ERROR, "学习进度不存在");

        progress.setLastStudiedAt(now);
        progress.setUpdatedAt(now);
        progress.setStatus(STATUS_LEARNING);

        if (correct) {
            progress.setCorrectCount((progress.getCorrectCount() == null ? 0 : progress.getCorrectCount()) + 1);
            int nextCount = (progress.getReviewCount() == null ? 0 : progress.getReviewCount()) + 1;
            progress.setReviewCount(nextCount);
            int interval = resolveIntervalDays(nextCount);
            progress.setIntervalDays(interval);
            progress.setNextReviewDate(Date.valueOf(today.plusDays(interval)));
        } else {
            progress.setWrongCount((progress.getWrongCount() == null ? 0 : progress.getWrongCount()) + 1);
            progress.setIsWrongWord(1);
            progress.setNextReviewDate(Date.valueOf(today.plusDays(1)));
            progress.setIntervalDays(1);
        }
        studentWordProgressService.updateById(progress);
        return progress.getStatus();
    }

    /** 根据 review_count 查表得到艾宾浩斯间隔天数（2/4/7/15/30） */
    private int resolveIntervalDays(int reviewCountAfterSuccess) {
        if (reviewCountAfterSuccess <= 0) {
            return 1;
        }
        int index = Math.min(reviewCountAfterSuccess - 1, EBBINGHAUS_AFTER_SUCCESS.length - 1);
        return EBBINGHAUS_AFTER_SUCCESS[index];
    }

    private void saveAnswerRecord(Long studentId, Long classId, Long wordId,
                                  String questionType, String selected, String correctAnswer, boolean correct) {
        AnswerRecord record = AnswerRecord.builder()
                .studentId(studentId)
                .classId(classId)
                .wordId(wordId)
                .answerType(ANSWER_TYPE_REVIEW)
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

    /** 复习 reason 优先级：HIGH_WRONG > DAY1 > EBBINGHAUS */
    private int reasonPriority(String reason) {
        if (REASON_HIGH_WRONG.equals(reason)) {
            return 3;
        }
        if (REASON_DAY1.equals(reason)) {
            return 2;
        }
        if (REASON_EBBINGHAUS.equals(reason)) {
            return 1;
        }
        return 0;
    }

    private String buildKey(Long studentId, Long wordId) {
        return studentId + "_" + wordId;
    }

    private void checkStudent(UserAccountVO loginUser) {
        ThrowUtils.throwIf(loginUser == null || loginUser.getId() == null, ErrorCode.NOT_LOGIN_ERROR, "未登录");
        ThrowUtils.throwIf(!UserConstant.STUDENT_ROLE.equalsIgnoreCase(loginUser.getRole()),
                ErrorCode.NO_AUTH_ERROR, "仅学生可访问复习接口");
    }

    private record PlanCandidate(Long studentId, Long wordId, Long classId, String reason) {
    }
}
