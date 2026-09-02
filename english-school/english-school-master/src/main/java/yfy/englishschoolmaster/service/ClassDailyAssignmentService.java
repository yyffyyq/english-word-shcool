package yfy.englishschoolmaster.service;

import com.mybatisflex.core.service.IService;
import yfy.englishschoolmaster.model.entity.ClassDailyAssignment;
import yfy.englishschoolmaster.model.vo.ClassDailyAssignmentRunResultVO;
import yfy.englishschoolmaster.model.vo.UserAccountVO;

import java.time.LocalDate;

/**
 * 班级每日单词分配服务：
 * 按班级词书任务定时/手动抽词，下发给在班学生并支持入班补发。
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
public interface ClassDailyAssignmentService extends IService<ClassDailyAssignment> {

    /**
     * 按指定学习日执行全量分配（定时任务 / 管理员手动触发）：
     * 扫描生效中的班级词书任务，班级维度抽词后下发给在班学生。
     *
     * @param assignDate 学习日期
     * @return 执行结果统计
     */
    ClassDailyAssignmentRunResultVO assignForDate(LocalDate assignDate);

    /**
     * 管理员手动触发指定日期的单词分配。
     *
     * @param assignDate 学习日期，为空则取今天
     * @param loginUser  当前登录管理员
     * @return 执行结果统计
     */
    ClassDailyAssignmentRunResultVO runAssignByAdmin(LocalDate assignDate, UserAccountVO loginUser);

    /**
     * 学生入班后补发当日已存在的班级词表到个人进度。
     *
     * @param classId   班级ID
     * @param studentId 学生ID
     */
    void backfillTodayForStudent(Long classId, Long studentId);
}
