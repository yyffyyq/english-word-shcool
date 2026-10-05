package yfy.englishschoolmaster.service;

import com.mybatisflex.core.service.IService;
import yfy.englishschoolmaster.model.dto.ClassDailyAssignment.ClassUnitPlanAssignRequest;
import yfy.englishschoolmaster.model.entity.ClassDailyAssignment;
import yfy.englishschoolmaster.model.vo.ClassDailyAssignmentRunResultVO;
import yfy.englishschoolmaster.model.vo.ClassTodayPlanVO;
import yfy.englishschoolmaster.model.vo.ClassUnitPlanAssignResultVO;
import yfy.englishschoolmaster.model.vo.UserAccountVO;

import java.time.LocalDate;

/**
 * 班级每日单词分配服务：
 * 按学生进度生成当日词表（学完发新词，未学完结转后补足），并支持入班补发。
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
public interface ClassDailyAssignmentService extends IService<ClassDailyAssignment> {

    /**
     * 按指定学习日执行全量分配（定时任务 / 管理员手动触发）：
     * 扫描生效中的班级词书任务，按每个学生的未完成进度结转并补足每日额度。
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
     * 学生入班后补发当日已分配的学习计划：
     * 有今日词表则复制给该生，没有则按每日额度新生成。
     *
     * @param classId   班级ID
     * @param studentId 学生ID
     */
    void backfillTodayForStudent(Long classId, Long studentId);

    /**
     * 按班级、词书、周次、单元把该单元全部单词追加到今日学习计划。
     * 只写入该班级的在班学生；教师仅能分配自己的班级。
     *
     * @param request   班级、词书、周次、单元
     * @param loginUser 当前登录教师或管理员
     * @return 分配结果
     */
    ClassUnitPlanAssignResultVO assignUnitPlan(ClassUnitPlanAssignRequest request, UserAccountVO loginUser);

    /**
     * 按班级查询今日学习单词。
     * 教师仅可查询自己的班级，管理员可查询全部班级。
     * 当天没有计划时返回空单词列表。
     *
     * @param classId   班级ID
     * @param loginUser 当前登录教师或管理员
     * @return 该班今日学习单词
     */
    ClassTodayPlanVO getTodayPlanByClass(Long classId, UserAccountVO loginUser);
}
