package yfy.englishschoolmaster.service.impl;

import cn.hutool.core.collection.CollUtil;
import com.mybatisflex.core.query.QueryWrapper;
import com.mybatisflex.spring.service.impl.ServiceImpl;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.support.TransactionTemplate;
import yfy.englishschoolmaster.constant.UserConstant;
import yfy.englishschoolmaster.exception.ErrorCode;
import yfy.englishschoolmaster.exception.ThrowUtils;
import yfy.englishschoolmaster.mapper.ClassDailyAssignmentMapper;
import yfy.englishschoolmaster.mapper.ClassDailyAssignmentWordMapper;
import yfy.englishschoolmaster.mapper.ClassInfoMapper;
import yfy.englishschoolmaster.mapper.ClassStudentMapper;
import yfy.englishschoolmaster.mapper.StudentWordProgressMapper;
import yfy.englishschoolmaster.model.entity.ClassDailyAssignment;
import yfy.englishschoolmaster.model.entity.ClassDailyAssignmentWord;
import yfy.englishschoolmaster.model.entity.ClassInfo;
import yfy.englishschoolmaster.model.entity.ClassStudent;
import yfy.englishschoolmaster.model.entity.ClassWordTask;
import yfy.englishschoolmaster.model.entity.StudentWordProgress;
import yfy.englishschoolmaster.model.vo.ClassDailyAssignmentRunResultVO;
import yfy.englishschoolmaster.model.vo.UserAccountVO;
import yfy.englishschoolmaster.service.ClassDailyAssignmentService;
import yfy.englishschoolmaster.service.ClassDailyAssignmentWordService;
import yfy.englishschoolmaster.service.ClassWordTaskService;
import yfy.englishschoolmaster.service.StudentStudyService;
import yfy.englishschoolmaster.service.StudentWordProgressService;

import java.math.BigDecimal;
import java.sql.Date;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * 班级每日单词分配服务实现：
 * 按学生进度生成当日词表——已掌握则发全新词，未完成则结转后补足每日额度。
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
@Service
public class ClassDailyAssignmentServiceImpl
        extends ServiceImpl<ClassDailyAssignmentMapper, ClassDailyAssignment>
        implements ClassDailyAssignmentService {

    private static final Logger log = LoggerFactory.getLogger(ClassDailyAssignmentServiceImpl.class);

    private static final ZoneId ZONE_SHANGHAI = ZoneId.of("Asia/Shanghai");
    private static final String TASK_STATUS_ACTIVE = "ACTIVE";
    private static final String CLASS_STATUS_ACTIVE = "ACTIVE";
    private static final String STUDENT_IN_CLASS = "IN_CLASS";
    private static final String PROGRESS_STATUS_NEW = "NEW";
    private static final String ASSIGN_SUCCESS = "SUCCESS";
    private static final String ASSIGN_PARTIAL = "PARTIAL";
    private static final String ASSIGN_SKIPPED = "SKIPPED";
    private static final String ASSIGN_EXISTED = "EXISTED";
    private static final int DEFAULT_DAILY_NEW_COUNT = 10;

    private final ClassWordTaskService classWordTaskService;
    private final ClassInfoMapper classInfoMapper;
    private final ClassStudentMapper classStudentMapper;
    private final ClassDailyAssignmentWordMapper classDailyAssignmentWordMapper;
    private final ClassDailyAssignmentWordService classDailyAssignmentWordService;
    private final StudentWordProgressMapper studentWordProgressMapper;
    private final StudentWordProgressService studentWordProgressService;
    private final StudentStudyService studentStudyService;
    private final TransactionTemplate transactionTemplate;

    public ClassDailyAssignmentServiceImpl(ClassWordTaskService classWordTaskService,
                                           ClassInfoMapper classInfoMapper,
                                           ClassStudentMapper classStudentMapper,
                                           ClassDailyAssignmentWordMapper classDailyAssignmentWordMapper,
                                           ClassDailyAssignmentWordService classDailyAssignmentWordService,
                                           StudentWordProgressMapper studentWordProgressMapper,
                                           StudentWordProgressService studentWordProgressService,
                                           @Lazy StudentStudyService studentStudyService,
                                           PlatformTransactionManager transactionManager) {
        this.classWordTaskService = classWordTaskService;
        this.classInfoMapper = classInfoMapper;
        this.classStudentMapper = classStudentMapper;
        this.classDailyAssignmentWordMapper = classDailyAssignmentWordMapper;
        this.classDailyAssignmentWordService = classDailyAssignmentWordService;
        this.studentWordProgressMapper = studentWordProgressMapper;
        this.studentWordProgressService = studentWordProgressService;
        this.studentStudyService = studentStudyService;
        this.transactionTemplate = new TransactionTemplate(transactionManager);
    }

    /** 实现指定日期的全量单词分配 */
    @Override
    public ClassDailyAssignmentRunResultVO assignForDate(LocalDate assignDate) {
        // 1. 参数校验
        ThrowUtils.throwIf(assignDate == null, ErrorCode.PARAMS_ERROR, "学习日期不能为空");
        Date assignSqlDate = Date.valueOf(assignDate);

        ClassDailyAssignmentRunResultVO result = new ClassDailyAssignmentRunResultVO();
        result.setAssignDate(assignDate);
        result.setTaskCount(0);
        result.setCreatedCount(0);
        result.setSkippedExistCount(0);
        result.setSkippedEmptyCount(0);
        result.setSuccessCount(0);
        result.setPartialCount(0);

        // 2. 加载生效中的班级词书任务
        List<ClassWordTask> tasks = listActiveTasks(assignDate);
        result.setTaskCount(tasks.size());
        if (CollUtil.isEmpty(tasks)) {
            return result;
        }

        // 3. 逐个任务分配（单任务独立事务，失败不影响其他任务）
        for (ClassWordTask task : tasks) {
            try {
                String status = transactionTemplate.execute(statusHolder ->
                        assignOneTask(task, assignDate, assignSqlDate));
                if (ASSIGN_EXISTED.equals(status)) {
                    result.setSkippedExistCount(result.getSkippedExistCount() + 1);
                    continue;
                }
                if (status == null) {
                    continue;
                }
                result.setCreatedCount(result.getCreatedCount() + 1);
                switch (status) {
                    case ASSIGN_SUCCESS -> result.setSuccessCount(result.getSuccessCount() + 1);
                    case ASSIGN_PARTIAL -> result.setPartialCount(result.getPartialCount() + 1);
                    case ASSIGN_SKIPPED -> result.setSkippedEmptyCount(result.getSkippedEmptyCount() + 1);
                    default -> {
                    }
                }
            } catch (Exception e) {
                log.error("每日单词分配失败, taskId={}, assignDate={}", task.getId(), assignDate, e);
            }
        }
        return result;
    }

    /** 实现管理员手动触发分配，日期默认今天 */
    @Override
    public ClassDailyAssignmentRunResultVO runAssignByAdmin(LocalDate assignDate, UserAccountVO loginUser) {
        // 1. 权限校验：仅管理员
        ThrowUtils.throwIf(loginUser == null || loginUser.getId() == null, ErrorCode.NOT_LOGIN_ERROR, "未登录");
        ThrowUtils.throwIf(!UserConstant.ADMIN_ROLE.equalsIgnoreCase(loginUser.getRole()),
                ErrorCode.NO_AUTH_ERROR, "仅管理员可手动触发分配");

        // 2. 日期默认今天（上海时区）
        LocalDate date = assignDate == null ? LocalDate.now(ZONE_SHANGHAI) : assignDate;
        return assignForDate(date);
    }

    /** 实现学生入班后补发「今日已分配」的学习计划 */
    @Override
    public void backfillTodayForStudent(Long classId, Long studentId) {
        // 1. 参数校验
        ThrowUtils.throwIf(classId == null || classId <= 0, ErrorCode.PARAMS_ERROR, "班级ID不合法");
        ThrowUtils.throwIf(studentId == null || studentId <= 0, ErrorCode.PARAMS_ERROR, "学生ID不合法");

        // 2. 对该班今日生效任务：优先复制已有今日词表，没有则按额度新生成
        LocalDate today = LocalDate.now(ZONE_SHANGHAI);
        Date todaySql = Date.valueOf(today);
        List<ClassWordTask> tasks = listActiveTasks(today).stream()
                .filter(task -> classId.equals(task.getClassId()))
                .toList();
        for (ClassWordTask task : tasks) {
            transactionTemplate.execute(statusHolder -> {
                assignTodayPlanToNewStudent(task, studentId, todaySql);
                return Boolean.TRUE;
            });
        }
        refreshHomeworkCacheQuietly(studentId);
    }

    /**
     * 对单个任务执行按学生分配。
     * 返回 SUCCESS / PARTIAL / SKIPPED；批次已存在仍会补齐缺失学生后返回 EXISTED；班级不可用返回 null。
     */
    private String assignOneTask(ClassWordTask task,
                                 LocalDate assignDate,
                                 Date assignSqlDate) {
        // 1. 校验班级状态
        ClassInfo classInfo = classInfoMapper.selectOneById(task.getClassId());
        if (classInfo == null || !CLASS_STATUS_ACTIVE.equalsIgnoreCase(classInfo.getStatus())) {
            log.warn("跳过分配：班级不存在或已停用, taskId={}, classId={}", task.getId(), task.getClassId());
            return null;
        }

        int plannedCount = resolveDailyNewCount(task);
        ClassDailyAssignment exist = this.getOne(QueryWrapper.create()
                .eq(ClassDailyAssignment::getTaskId, task.getId())
                .eq(ClassDailyAssignment::getAssignDate, assignSqlDate));
        boolean existed = exist != null;

        // 2. 已有批次则补齐尚未生成今日计划的学生；新建批次先落库再按学生生成词表
        ClassDailyAssignment assignment = exist;
        if (!existed) {
            assignment = ClassDailyAssignment.builder()
                    .taskId(task.getId())
                    .classId(task.getClassId())
                    .bookId(task.getBookId())
                    .assignDate(assignSqlDate)
                    .plannedCount(plannedCount)
                    .actualCount(0)
                    .status(ASSIGN_SKIPPED)
                    .createdAt(LocalDateTime.now())
                    .build();
            boolean saved = this.save(assignment);
            ThrowUtils.throwIf(!saved, ErrorCode.OPERATION_ERROR, "保存分配批次失败");
        }

        List<Long> studentIds = listInClassStudentIds(task.getClassId());
        int minPlanSize = Integer.MAX_VALUE;
        int studentWithPlan = 0;
        boolean anyPartial = false;
        for (Long studentId : studentIds) {
            int planSize = ensureStudentDailyPlan(assignment, task, studentId, plannedCount, assignSqlDate);
            if (planSize > 0) {
                studentWithPlan++;
                minPlanSize = Math.min(minPlanSize, planSize);
            } else {
                minPlanSize = Math.min(minPlanSize, 0);
            }
            if (planSize < plannedCount) {
                anyPartial = true;
            }
        }
        if (studentWithPlan == 0) {
            minPlanSize = 0;
        }

        String status;
        if (CollUtil.isEmpty(studentIds) || studentWithPlan == 0) {
            status = ASSIGN_SKIPPED;
        } else if (!anyPartial) {
            status = ASSIGN_SUCCESS;
        } else {
            status = ASSIGN_PARTIAL;
        }

        assignment.setPlannedCount(plannedCount);
        assignment.setActualCount(minPlanSize);
        assignment.setStatus(status);
        boolean updated = this.updateById(assignment);
        ThrowUtils.throwIf(!updated, ErrorCode.OPERATION_ERROR, "更新分配批次失败");

        // 批次状态落库后再刷新缓存，避免作业回源时仍命中初始 SKIPPED
        for (Long studentId : studentIds) {
            refreshHomeworkCacheQuietly(studentId);
        }

        log.info("每日单词分配完成, taskId={}, date={}, existed={}, status={}, studentCount={}, minPlanSize={}",
                task.getId(), assignDate, existed, status, studentIds.size(), minPlanSize);
        return existed ? ASSIGN_EXISTED : status;
    }

    /**
     * 为学生生成当日词表：
     * 未掌握词全部结转，再按每日额度补新词；当日已有计划则跳过。
     *
     * @return 该生当日词表数量
     */
    private int ensureStudentDailyPlan(ClassDailyAssignment assignment,
                                       ClassWordTask task,
                                       Long studentId,
                                       int plannedCount,
                                       Date assignSqlDate) {
        long existCount = classDailyAssignmentWordService.count(QueryWrapper.create()
                .eq(ClassDailyAssignmentWord::getAssignmentId, assignment.getId())
                .eq(ClassDailyAssignmentWord::getStudentId, studentId));
        if (existCount > 0) {
            return (int) existCount;
        }

        List<Long> unfinishedIds = studentWordProgressMapper.selectUnfinishedWordIds(
                studentId, task.getClassId(), task.getBookId());
        if (unfinishedIds == null) {
            unfinishedIds = List.of();
        }

        List<Long> planWordIds = new ArrayList<>(unfinishedIds);
        int needNew = Math.max(0, plannedCount - planWordIds.size());
        List<Long> newWordIds = List.of();
        if (needNew > 0) {
            newWordIds = classDailyAssignmentWordMapper.selectUnlearnedWordIdsInOrder(
                    task.getBookId(), studentId, needNew);
            if (newWordIds == null) {
                newWordIds = List.of();
            }
            insertNewProgress(task.getClassId(), studentId, newWordIds);
            planWordIds.addAll(newWordIds);
        }

        if (CollUtil.isEmpty(planWordIds)) {
            log.info("学生当日无词可分, studentId={}, taskId={}", studentId, task.getId());
            return 0;
        }

        LocalDateTime now = LocalDateTime.now();
        List<ClassDailyAssignmentWord> detailList = new ArrayList<>(planWordIds.size());
        int order = 1;
        for (Long wordId : planWordIds) {
            detailList.add(ClassDailyAssignmentWord.builder()
                    .assignmentId(assignment.getId())
                    .studentId(studentId)
                    .taskId(task.getId())
                    .wordId(wordId)
                    .assignDate(assignSqlDate)
                    .sortOrder(order++)
                    .createdAt(now)
                    .build());
        }
        boolean wordsSaved = classDailyAssignmentWordService.saveBatch(detailList);
        ThrowUtils.throwIf(!wordsSaved, ErrorCode.OPERATION_ERROR, "保存学生当日词表失败");
        saveClassTodayTemplateIfAbsent(assignment, task, planWordIds, assignSqlDate);

        log.info("学生当日词表已生成, studentId={}, taskId={}, unfinished={}, newCount={}, total={}",
                studentId, task.getId(), unfinishedIds.size(), newWordIds.size(), planWordIds.size());
        return planWordIds.size();
    }

    private void insertNewProgress(Long classId, Long studentId, List<Long> wordIds) {
        if (CollUtil.isEmpty(wordIds)) {
            return;
        }
        Set<Long> existWordIds = studentWordProgressService.list(QueryWrapper.create()
                        .eq(StudentWordProgress::getStudentId, studentId)
                        .in(StudentWordProgress::getWordId, wordIds))
                .stream()
                .map(StudentWordProgress::getWordId)
                .collect(Collectors.toSet());

        LocalDateTime now = LocalDateTime.now();
        List<StudentWordProgress> toInsert = new ArrayList<>();
        for (Long wordId : wordIds) {
            if (existWordIds.contains(wordId)) {
                continue;
            }
            toInsert.add(StudentWordProgress.builder()
                    .studentId(studentId)
                    .wordId(wordId)
                    .classId(classId)
                    .status(PROGRESS_STATUS_NEW)
                    .reviewCount(0)
                    .correctCount(0)
                    .wrongCount(0)
                    .easeFactor(new BigDecimal("2.50"))
                    .intervalDays(0)
                    .isFavorite(0)
                    .isWrongWord(0)
                    .createdAt(now)
                    .updatedAt(now)
                    .build());
        }
        if (CollUtil.isEmpty(toInsert)) {
            return;
        }
        boolean saved = studentWordProgressService.saveBatch(toInsert);
        ThrowUtils.throwIf(!saved, ErrorCode.OPERATION_ERROR, "保存学生单词进度失败");
    }

    /**
     * 入班学生补发今日计划：
     * 已有班级今日词表则原样复制；尚无今日批次则按每日额度新生成。
     */
    private void assignTodayPlanToNewStudent(ClassWordTask task, Long studentId, Date assignSqlDate) {
        ClassInfo classInfo = classInfoMapper.selectOneById(task.getClassId());
        if (classInfo == null || !CLASS_STATUS_ACTIVE.equalsIgnoreCase(classInfo.getStatus())) {
            log.warn("入班补发跳过：班级不存在或已停用, taskId={}, classId={}", task.getId(), task.getClassId());
            return;
        }

        int plannedCount = resolveDailyNewCount(task);
        ClassDailyAssignment assignment = this.getOne(QueryWrapper.create()
                .eq(ClassDailyAssignment::getTaskId, task.getId())
                .eq(ClassDailyAssignment::getAssignDate, assignSqlDate));
        if (assignment == null) {
            assignment = ClassDailyAssignment.builder()
                    .taskId(task.getId())
                    .classId(task.getClassId())
                    .bookId(task.getBookId())
                    .assignDate(assignSqlDate)
                    .plannedCount(plannedCount)
                    .actualCount(0)
                    .status(ASSIGN_SKIPPED)
                    .createdAt(LocalDateTime.now())
                    .build();
            boolean saved = this.save(assignment);
            ThrowUtils.throwIf(!saved, ErrorCode.OPERATION_ERROR, "保存分配批次失败");
        }

        long existCount = classDailyAssignmentWordService.count(QueryWrapper.create()
                .eq(ClassDailyAssignmentWord::getAssignmentId, assignment.getId())
                .eq(ClassDailyAssignmentWord::getStudentId, studentId));
        if (existCount > 0) {
            log.info("入班补发跳过：学生已有今日计划, studentId={}, assignmentId={}", studentId, assignment.getId());
            return;
        }

        List<Long> todayPlanIds = loadClassTodayPlanWordIds(assignment.getId());
        int planSize;
        if (CollUtil.isNotEmpty(todayPlanIds)) {
            planSize = copyTodayPlanToStudent(assignment, task, studentId, todayPlanIds, plannedCount, assignSqlDate);
            saveClassTodayTemplateIfAbsent(assignment, task, todayPlanIds, assignSqlDate);
            log.info("入班补发今日词表, studentId={}, taskId={}, copied={}, total={}",
                    studentId, task.getId(), todayPlanIds.size(), planSize);
        } else {
            planSize = ensureStudentDailyPlan(assignment, task, studentId, plannedCount, assignSqlDate);
            log.info("入班时今日尚无班级词表，已按额度生成, studentId={}, taskId={}, total={}",
                    studentId, task.getId(), planSize);
        }
        markAssignmentHasPlan(assignment, plannedCount, planSize);
    }

    /**
     * 读取班级今日词表：优先全班模板（student_id 为空），否则取一名已分配同学的词表。
     */
    private List<Long> loadClassTodayPlanWordIds(Long assignmentId) {
        List<ClassDailyAssignmentWord> templateWords = classDailyAssignmentWordService.list(QueryWrapper.create()
                .eq(ClassDailyAssignmentWord::getAssignmentId, assignmentId)
                .isNull("student_id")
                .orderBy(ClassDailyAssignmentWord::getSortOrder, true));
        if (CollUtil.isNotEmpty(templateWords)) {
            return templateWords.stream()
                    .map(ClassDailyAssignmentWord::getWordId)
                    .filter(Objects::nonNull)
                    .distinct()
                    .toList();
        }

        List<ClassDailyAssignmentWord> studentWords = classDailyAssignmentWordService.list(QueryWrapper.create()
                .eq(ClassDailyAssignmentWord::getAssignmentId, assignmentId)
                .isNotNull("student_id")
                .orderBy(ClassDailyAssignmentWord::getStudentId, true)
                .orderBy(ClassDailyAssignmentWord::getSortOrder, true));
        if (CollUtil.isEmpty(studentWords)) {
            return List.of();
        }
        Long sampleStudentId = studentWords.get(0).getStudentId();
        return studentWords.stream()
                .filter(word -> sampleStudentId.equals(word.getStudentId()))
                .map(ClassDailyAssignmentWord::getWordId)
                .filter(Objects::nonNull)
                .distinct()
                .toList();
    }

    /**
     * 把今日已分配词表复制给新学生；数量不足每日额度时再补新词。
     */
    private int copyTodayPlanToStudent(ClassDailyAssignment assignment,
                                       ClassWordTask task,
                                       Long studentId,
                                       List<Long> todayPlanIds,
                                       int plannedCount,
                                       Date assignSqlDate) {
        List<Long> planWordIds = new ArrayList<>();
        for (Long wordId : todayPlanIds) {
            if (wordId != null && !planWordIds.contains(wordId)) {
                planWordIds.add(wordId);
            }
        }

        int needNew = Math.max(0, plannedCount - planWordIds.size());
        if (needNew > 0) {
            List<Long> extraIds = classDailyAssignmentWordMapper.selectUnlearnedWordIdsInOrder(
                    task.getBookId(), studentId, needNew + planWordIds.size());
            if (extraIds != null) {
                for (Long extraId : extraIds) {
                    if (extraId == null || planWordIds.contains(extraId)) {
                        continue;
                    }
                    planWordIds.add(extraId);
                    if (planWordIds.size() >= plannedCount) {
                        break;
                    }
                }
            }
        }

        insertNewProgress(task.getClassId(), studentId, planWordIds);
        saveStudentAssignmentWords(assignment, task, studentId, planWordIds, assignSqlDate);
        return planWordIds.size();
    }

    private void saveStudentAssignmentWords(ClassDailyAssignment assignment,
                                            ClassWordTask task,
                                            Long studentId,
                                            List<Long> wordIds,
                                            Date assignSqlDate) {
        if (CollUtil.isEmpty(wordIds)) {
            return;
        }
        LocalDateTime now = LocalDateTime.now();
        List<ClassDailyAssignmentWord> detailList = new ArrayList<>(wordIds.size());
        int order = 1;
        for (Long wordId : wordIds) {
            detailList.add(ClassDailyAssignmentWord.builder()
                    .assignmentId(assignment.getId())
                    .studentId(studentId)
                    .taskId(task.getId())
                    .wordId(wordId)
                    .assignDate(assignSqlDate)
                    .sortOrder(order++)
                    .createdAt(now)
                    .build());
        }
        boolean wordsSaved = classDailyAssignmentWordService.saveBatch(detailList);
        ThrowUtils.throwIf(!wordsSaved, ErrorCode.OPERATION_ERROR, "保存学生当日词表失败");
    }

    private void saveClassTodayTemplateIfAbsent(ClassDailyAssignment assignment,
                                                ClassWordTask task,
                                                List<Long> wordIds,
                                                Date assignSqlDate) {
        if (CollUtil.isEmpty(wordIds)) {
            return;
        }
        long templateCount = classDailyAssignmentWordService.count(QueryWrapper.create()
                .eq(ClassDailyAssignmentWord::getAssignmentId, assignment.getId())
                .isNull("student_id"));
        if (templateCount > 0) {
            return;
        }
        LocalDateTime now = LocalDateTime.now();
        List<ClassDailyAssignmentWord> templateList = new ArrayList<>(wordIds.size());
        int order = 1;
        for (Long wordId : wordIds) {
            if (wordId == null) {
                continue;
            }
            templateList.add(ClassDailyAssignmentWord.builder()
                    .assignmentId(assignment.getId())
                    .studentId(null)
                    .taskId(task.getId())
                    .wordId(wordId)
                    .assignDate(assignSqlDate)
                    .sortOrder(order++)
                    .createdAt(now)
                    .build());
        }
        if (CollUtil.isEmpty(templateList)) {
            return;
        }
        boolean saved = classDailyAssignmentWordService.saveBatch(templateList);
        ThrowUtils.throwIf(!saved, ErrorCode.OPERATION_ERROR, "保存班级今日词表模板失败");
    }

    private void markAssignmentHasPlan(ClassDailyAssignment assignment, int plannedCount, int planSize) {
        if (planSize <= 0) {
            return;
        }
        if (!ASSIGN_SKIPPED.equalsIgnoreCase(assignment.getStatus())) {
            return;
        }
        assignment.setStatus(planSize >= plannedCount ? ASSIGN_SUCCESS : ASSIGN_PARTIAL);
        assignment.setActualCount(planSize);
        boolean updated = this.updateById(assignment);
        ThrowUtils.throwIf(!updated, ErrorCode.OPERATION_ERROR, "更新分配批次失败");
    }

    private void refreshHomeworkCacheQuietly(Long studentId) {
        try {
            studentStudyService.refreshHomeworkCache(studentId);
        } catch (Exception e) {
            log.warn("刷新学生作业缓存失败, studentId={}", studentId, e);
        }
    }

    private int resolveDailyNewCount(ClassWordTask task) {
        if (task.getDailyNewCount() == null || task.getDailyNewCount() <= 0) {
            return DEFAULT_DAILY_NEW_COUNT;
        }
        return task.getDailyNewCount();
    }

    /** 加载指定日期内生效中的班级词书任务 */
    private List<ClassWordTask> listActiveTasks(LocalDate assignDate) {
        Date assignSqlDate = Date.valueOf(assignDate);
        List<ClassWordTask> allActive = classWordTaskService.list(QueryWrapper.create()
                .eq(ClassWordTask::getStatus, TASK_STATUS_ACTIVE));
        if (CollUtil.isEmpty(allActive)) {
            return List.of();
        }
        return allActive.stream()
                .filter(task -> isTaskEffectiveOn(task, assignSqlDate))
                .toList();
    }

    /** 判断任务在指定日期是否处于生效区间内 */
    private boolean isTaskEffectiveOn(ClassWordTask task, Date assignSqlDate) {
        if (task.getStartDate() != null && task.getStartDate().after(assignSqlDate)) {
            return false;
        }
        if (task.getEndDate() != null && task.getEndDate().before(assignSqlDate)) {
            return false;
        }
        return true;
    }

    /** 查询班级内在班学生 ID 列表 */
    private List<Long> listInClassStudentIds(Long classId) {
        List<ClassStudent> students = classStudentMapper.selectListByQuery(QueryWrapper.create()
                .eq(ClassStudent::getClassId, classId)
                .eq(ClassStudent::getStatus, STUDENT_IN_CLASS));
        if (CollUtil.isEmpty(students)) {
            return List.of();
        }
        return students.stream()
                .map(ClassStudent::getStudentId)
                .filter(Objects::nonNull)
                .toList();
    }
}
