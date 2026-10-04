package yfy.englishschoolmaster;

import com.mybatisflex.core.query.QueryWrapper;
import jakarta.annotation.Resource;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import yfy.englishschoolmaster.constant.UserConstant;
import yfy.englishschoolmaster.model.entity.ClassDailyAssignment;
import yfy.englishschoolmaster.model.entity.ClassDailyAssignmentWord;
import yfy.englishschoolmaster.model.entity.ClassStudent;
import yfy.englishschoolmaster.model.entity.StudentWordProgress;
import yfy.englishschoolmaster.model.vo.ClassDailyAssignmentRunResultVO;
import yfy.englishschoolmaster.model.vo.UserAccountVO;
import yfy.englishschoolmaster.service.ClassDailyAssignmentService;
import yfy.englishschoolmaster.service.ClassDailyAssignmentWordService;
import yfy.englishschoolmaster.service.ClassStudentService;
import yfy.englishschoolmaster.service.StudentWordProgressService;

import java.sql.Date;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * 班级每日单词自动分配测试。
 * <p>
 * 依赖本机 MySQL（需已执行 sql/07_daily_assign.sql）与 Redis。
 * 前置条件：存在 ACTIVE 的 class_word_task、词书内有单词、班级有 IN_CLASS 学生。
 * 分配按学生进度进行：学完发新词，未学完则结转后补足每日额度。
 */
@SpringBootTest
@Disabled
class ClassDailyAssignmentServiceTest {

    private static final ZoneId ZONE_SHANGHAI = ZoneId.of("Asia/Shanghai");

    @Resource
    private ClassDailyAssignmentService classDailyAssignmentService;

    @Resource
    private ClassDailyAssignmentWordService classDailyAssignmentWordService;

    @Resource
    private ClassStudentService classStudentService;

    @Resource
    private StudentWordProgressService studentWordProgressService;

    /**
     * 执行今日分配，并校验：
     * 1）可正常返回统计结果；
     * 2）再次执行同一天应命中幂等（skippedExist 增加或 created=0）；
     * 3）若产生批次，每个学生应有自己的当日词表，且进度记录覆盖该词表。
     */
    @Test
    void testAssignForToday() {
        LocalDate today = LocalDate.now(ZONE_SHANGHAI);

        // 1. 首次分配
        ClassDailyAssignmentRunResultVO first = classDailyAssignmentService.assignForDate(today);
        Assertions.assertNotNull(first);
        Assertions.assertEquals(today, first.getAssignDate());
        Assertions.assertNotNull(first.getTaskCount());
        System.out.println("首次分配结果: taskCount=" + first.getTaskCount()
                + ", created=" + first.getCreatedCount()
                + ", skippedExist=" + first.getSkippedExistCount()
                + ", skippedEmpty=" + first.getSkippedEmptyCount()
                + ", success=" + first.getSuccessCount()
                + ", partial=" + first.getPartialCount());

        // 2. 再次分配：应幂等，不再新建批次
        ClassDailyAssignmentRunResultVO second = classDailyAssignmentService.assignForDate(today);
        Assertions.assertNotNull(second);
        Assertions.assertEquals(0, second.getCreatedCount().intValue());
        if (second.getTaskCount() > 0) {
            Assertions.assertTrue(second.getSkippedExistCount() >= 0);
        }
        System.out.println("二次分配结果: created=" + second.getCreatedCount()
                + ", skippedExist=" + second.getSkippedExistCount());

        // 3. 若今日有成功/部分成功批次，校验每个学生都有自己的当日词表
        Date todaySql = Date.valueOf(today);
        List<ClassDailyAssignment> assignments = classDailyAssignmentService.list(QueryWrapper.create()
                .eq(ClassDailyAssignment::getAssignDate, todaySql)
                .in(ClassDailyAssignment::getStatus, List.of("SUCCESS", "PARTIAL")));
        if (assignments.isEmpty()) {
            System.out.println("今日无 SUCCESS/PARTIAL 批次，跳过学生词表校验（请确认任务、词书、学生数据）");
            return;
        }

        ClassDailyAssignment sample = assignments.get(0);
        List<ClassStudent> students = classStudentService.list(QueryWrapper.create()
                .eq(ClassStudent::getClassId, sample.getClassId())
                .eq(ClassStudent::getStatus, "IN_CLASS"));
        Assertions.assertFalse(students.isEmpty(), "班级应有在班学生才能验证下发");

        for (ClassStudent student : students) {
            List<Long> studentWordIds = classDailyAssignmentWordService.list(QueryWrapper.create()
                            .eq(ClassDailyAssignmentWord::getAssignmentId, sample.getId())
                            .eq(ClassDailyAssignmentWord::getStudentId, student.getStudentId())
                            .orderBy(ClassDailyAssignmentWord::getSortOrder, true))
                    .stream()
                    .map(ClassDailyAssignmentWord::getWordId)
                    .collect(Collectors.toList());
            Assertions.assertFalse(studentWordIds.isEmpty(),
                    "学生 " + student.getStudentId() + " 应有当日词表");
            if ("SUCCESS".equals(sample.getStatus())) {
                Assertions.assertTrue(studentWordIds.size() >= sample.getPlannedCount(),
                        "足额批次下学生当日词表不应少于每日额度");
            }

            List<StudentWordProgress> progressList = studentWordProgressService.list(QueryWrapper.create()
                    .eq(StudentWordProgress::getStudentId, student.getStudentId())
                    .eq(StudentWordProgress::getClassId, sample.getClassId())
                    .in(StudentWordProgress::getWordId, studentWordIds));
            Set<Long> actual = progressList.stream()
                    .map(StudentWordProgress::getWordId)
                    .collect(Collectors.toSet());
            Assertions.assertEquals(new HashSet<>(studentWordIds), actual,
                    "学生 " + student.getStudentId() + " 的进度应覆盖当日词表");
        }
        System.out.println("学生词表校验通过, classId=" + sample.getClassId()
                + ", plannedCount=" + sample.getPlannedCount()
                + ", studentCount=" + students.size());
    }

    /**
     * 管理员手动触发接口 Service 层：权限校验 + 默认今天。
     */
    @Test
    void testRunAssignByAdmin() {
        UserAccountVO admin = new UserAccountVO();
        admin.setId(1L);
        admin.setRole(UserConstant.ADMIN_ROLE);

        ClassDailyAssignmentRunResultVO result = classDailyAssignmentService.runAssignByAdmin(null, admin);
        Assertions.assertNotNull(result);
        Assertions.assertEquals(LocalDate.now(ZONE_SHANGHAI), result.getAssignDate());
        System.out.println("管理员触发结果: " + result);
    }
}
