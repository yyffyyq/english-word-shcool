package yfy.englishschoolmaster.service.impl;

import cn.hutool.core.collection.CollUtil;
import com.mybatisflex.core.query.QueryWrapper;
import com.mybatisflex.spring.service.impl.ServiceImpl;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.TransactionTemplate;
import yfy.englishschoolmaster.constant.UserConstant;
import yfy.englishschoolmaster.exception.ErrorCode;
import yfy.englishschoolmaster.exception.ThrowUtils;
import yfy.englishschoolmaster.mapper.ClassDailyAssignmentMapper;
import yfy.englishschoolmaster.mapper.ClassDailyAssignmentWordMapper;
import yfy.englishschoolmaster.mapper.ClassInfoMapper;
import yfy.englishschoolmaster.mapper.ClassStudentMapper;
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
 * 单任务独立事务分配，失败不影响其他任务。
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

    private final ClassWordTaskService classWordTaskService;
    private final ClassInfoMapper classInfoMapper;
    private final ClassStudentMapper classStudentMapper;
    private final ClassDailyAssignmentWordMapper classDailyAssignmentWordMapper;
    private final ClassDailyAssignmentWordService classDailyAssignmentWordService;
    private final StudentWordProgressService studentWordProgressService;
    private final TransactionTemplate transactionTemplate;

    public ClassDailyAssignmentServiceImpl(ClassWordTaskService classWordTaskService,
                                           ClassInfoMapper classInfoMapper,
                                           ClassStudentMapper classStudentMapper,
                                           ClassDailyAssignmentWordMapper classDailyAssignmentWordMapper,
                                           ClassDailyAssignmentWordService classDailyAssignmentWordService,
                                           StudentWordProgressService studentWordProgressService,
                                           PlatformTransactionManager transactionManager) {
        this.classWordTaskService = classWordTaskService;
        this.classInfoMapper = classInfoMapper;
        this.classStudentMapper = classStudentMapper;
        this.classDailyAssignmentWordMapper = classDailyAssignmentWordMapper;
        this.classDailyAssignmentWordService = classDailyAssignmentWordService;
        this.studentWordProgressService = studentWordProgressService;
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

    /** 实现学生入班后补发当日已分配词表 */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void backfillTodayForStudent(Long classId, Long studentId) {
        // 1. 参数校验
        ThrowUtils.throwIf(classId == null || classId <= 0, ErrorCode.PARAMS_ERROR, "班级ID不合法");
        ThrowUtils.throwIf(studentId == null || studentId <= 0, ErrorCode.PARAMS_ERROR, "学生ID不合法");

        // 2. 查询今日该班级已存在的分配批次
        LocalDate today = LocalDate.now(ZONE_SHANGHAI);
        Date todaySql = Date.valueOf(today);
        List<ClassDailyAssignment> assignments = this.list(QueryWrapper.create()
                .eq(ClassDailyAssignment::getClassId, classId)
                .eq(ClassDailyAssignment::getAssignDate, todaySql)
                .ne(ClassDailyAssignment::getStatus, ASSIGN_SKIPPED));
        if (CollUtil.isEmpty(assignments)) {
            return;
        }

        // 3. 将各批次词表补发到该学生进度
        for (ClassDailyAssignment assignment : assignments) {
            List<ClassDailyAssignmentWord> words = classDailyAssignmentWordService.list(QueryWrapper.create()
                    .eq(ClassDailyAssignmentWord::getAssignmentId, assignment.getId()));
            if (CollUtil.isEmpty(words)) {
                continue;
            }
            List<Long> wordIds = words.stream()
                    .map(ClassDailyAssignmentWord::getWordId)
                    .filter(Objects::nonNull)
                    .toList();
            fanOutProgressToStudents(classId, List.of(studentId), wordIds);
        }
    }

    /**
     * 对单个任务执行分配。
     * 返回 SUCCESS / PARTIAL / SKIPPED；已存在返回 EXISTED；班级不可用返回 null。
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

        // 2. 幂等：同一任务同一天只分配一次
        ClassDailyAssignment exist = this.getOne(QueryWrapper.create()
                .eq(ClassDailyAssignment::getTaskId, task.getId())
                .eq(ClassDailyAssignment::getAssignDate, assignSqlDate));
        if (exist != null) {
            return ASSIGN_EXISTED;
        }

        int plannedCount = task.getDailyNewCount() == null || task.getDailyNewCount() <= 0
                ? 10
                : task.getDailyNewCount();

        // 3. 随机抽取未分配过的单词
        List<Long> wordIds = classDailyAssignmentWordMapper.selectRandomUnassignedWordIds(
                task.getBookId(), task.getId(), plannedCount);
        if (wordIds == null) {
            wordIds = List.of();
        }

        String status;
        if (wordIds.isEmpty()) {
            status = ASSIGN_SKIPPED;
        } else if (wordIds.size() < plannedCount) {
            status = ASSIGN_PARTIAL;
        } else {
            status = ASSIGN_SUCCESS;
        }

        // 4. 落批次
        LocalDateTime now = LocalDateTime.now();
        ClassDailyAssignment assignment = ClassDailyAssignment.builder()
                .taskId(task.getId())
                .classId(task.getClassId())
                .bookId(task.getBookId())
                .assignDate(assignSqlDate)
                .plannedCount(plannedCount)
                .actualCount(wordIds.size())
                .status(status)
                .createdAt(now)
                .build();
        boolean saved = this.save(assignment);
        ThrowUtils.throwIf(!saved, ErrorCode.OPERATION_ERROR, "保存分配批次失败");

        // 5. 落明细
        if (CollUtil.isNotEmpty(wordIds)) {
            List<ClassDailyAssignmentWord> detailList = new ArrayList<>(wordIds.size());
            int order = 1;
            for (Long wordId : wordIds) {
                detailList.add(ClassDailyAssignmentWord.builder()
                        .assignmentId(assignment.getId())
                        .taskId(task.getId())
                        .wordId(wordId)
                        .assignDate(assignSqlDate)
                        .sortOrder(order++)
                        .createdAt(now)
                        .build());
            }
            boolean wordsSaved = classDailyAssignmentWordService.saveBatch(detailList);
            ThrowUtils.throwIf(!wordsSaved, ErrorCode.OPERATION_ERROR, "保存分配明细失败");

            // 6. 下发给在班学生
            List<Long> studentIds = listInClassStudentIds(task.getClassId());
            fanOutProgressToStudents(task.getClassId(), studentIds, wordIds);
        }

        log.info("每日单词分配完成, taskId={}, date={}, status={}, actual={}",
                task.getId(), assignDate, status, wordIds.size());
        return status;
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

    /**
     * 批量写入学生单词进度；已存在 (studentId, wordId) 则跳过。
     */
    private void fanOutProgressToStudents(Long classId, List<Long> studentIds, List<Long> wordIds) {
        if (CollUtil.isEmpty(studentIds) || CollUtil.isEmpty(wordIds)) {
            return;
        }

        Set<String> existKeys = studentWordProgressService.list(QueryWrapper.create()
                        .in(StudentWordProgress::getStudentId, studentIds)
                        .in(StudentWordProgress::getWordId, wordIds))
                .stream()
                .map(p -> p.getStudentId() + "_" + p.getWordId())
                .collect(Collectors.toSet());

        LocalDateTime now = LocalDateTime.now();
        List<StudentWordProgress> toInsert = new ArrayList<>();
        for (Long studentId : studentIds) {
            for (Long wordId : wordIds) {
                String key = studentId + "_" + wordId;
                if (existKeys.contains(key)) {
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
        }
        if (CollUtil.isNotEmpty(toInsert)) {
            studentWordProgressService.saveBatch(toInsert);
        }
    }
}
