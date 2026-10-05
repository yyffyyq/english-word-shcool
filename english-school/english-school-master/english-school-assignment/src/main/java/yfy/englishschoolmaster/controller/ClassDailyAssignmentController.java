package yfy.englishschoolmaster.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import yfy.englishschoolmaster.annotation.AuthCheck;
import yfy.englishschoolmaster.common.BaseResponse;
import yfy.englishschoolmaster.common.ResultUtils;
import yfy.englishschoolmaster.constant.UserConstant;
import yfy.englishschoolmaster.exception.ErrorCode;
import yfy.englishschoolmaster.exception.ThrowUtils;
import yfy.englishschoolmaster.model.dto.ClassDailyAssignment.ClassDailyAssignmentRunRequest;
import yfy.englishschoolmaster.model.dto.ClassDailyAssignment.ClassUnitPlanAssignRequest;
import yfy.englishschoolmaster.model.vo.ClassDailyAssignmentRunResultVO;
import yfy.englishschoolmaster.model.vo.ClassTodayPlanVO;
import yfy.englishschoolmaster.model.vo.ClassUnitPlanAssignResultVO;
import yfy.englishschoolmaster.model.vo.UserAccountVO;
import yfy.englishschoolmaster.service.ClassDailyAssignmentService;

/**
 * 班级每日单词分配 控制层。
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
@Tag(name = "每日单词分配", description = "管理员手动触发按学生进度生成每日学习计划；教师可按班级、词书周次单元把单词分配到该班今日计划")
@RestController
@RequestMapping("/classDailyAssignment")
public class ClassDailyAssignmentController {

    @Autowired
    private ClassDailyAssignmentService classDailyAssignmentService;

    /**
     * 手动触发每日单词分配接口（管理员）：
     * 可指定学习日期，为空则分配今天。
     * 请求头需携带 openid 或 userId。
     *
     * @param request     触发请求
     * @param httpRequest HTTP 请求（用于取登录用户）
     * @return 分配执行结果统计
     */
    @Operation(summary = "手动触发每日单词分配",
            description = "管理员按指定学习日（默认今天）为每个在班学生生成当日计划：已掌握则发新词，未完成则结转后补足每日额度。系统定时任务每天 02:00 也会执行。")
    @PostMapping("/run")
    @AuthCheck(mustRole = UserConstant.TEACHER_ROLE)
    public BaseResponse<ClassDailyAssignmentRunResultVO> runAssign(
            @RequestBody(required = false) ClassDailyAssignmentRunRequest request,
            HttpServletRequest httpRequest) {
        // 1. 获取当前登录用户并触发分配
        UserAccountVO loginUser = getLoginUser(httpRequest);
        ClassDailyAssignmentRunResultVO result = classDailyAssignmentService.runAssignByAdmin(
                request == null ? null : request.getAssignDate(),
                loginUser
        );

        // 2. 封装返回类型给前端
        return ResultUtils.success(result);
    }

    /**
     * 按班级、词书、周次、单元分配今日学习计划（教师、管理员）：
     * 将该单元全部单词只追加到指定班级里在班学生的今日计划。
     * 教师只能分配自己的班级。请求头需携带 openid 或 userId。
     *
     * @param request     班级、词书、周次、单元
     * @param httpRequest HTTP 请求（用于取登录用户）
     * @return 分配结果
     */
    @Operation(summary = "按周次单元分配今日学习计划",
            description = "选择班级、词书、week、unitName，将该单元全部单词只追加到该班级在班学生的今日学习计划。已在今日计划中的单词不重复写入。已掌握的单词会改回 LEARNING，以便出现在今日作业中。")
    @PostMapping("/unit")
    @AuthCheck
    public BaseResponse<ClassUnitPlanAssignResultVO> assignUnitPlan(
            @RequestBody ClassUnitPlanAssignRequest request,
            HttpServletRequest httpRequest) {
        // 1. 判断请求是否为空
        ThrowUtils.throwIf(request == null, ErrorCode.PARAMS_ERROR, "分配请求为空");

        // 2. 获取当前登录用户并分配
        UserAccountVO loginUser = getLoginUser(httpRequest);
        ClassUnitPlanAssignResultVO result = classDailyAssignmentService.assignUnitPlan(request, loginUser);

        // 3. 封装返回类型给前端
        return ResultUtils.success(result);
    }

    /**
     * 查询班级今日学习单词（教师、管理员）：
     * 按班级 ID 返回今天已分配给该班学生的单词。相同单词只返回一次。
     * 教师只能查询自己的班级。请求头需携带 openid 或 userId。
     *
     * @param classId     班级ID
     * @param httpRequest HTTP 请求（用于取登录用户）
     * @return 该班今日学习单词
     */
    @Operation(summary = "查询班级今日学习单词",
            description = "教师或管理员按班级 ID 查询今天已分配给该班学生的单词。教师只能查自己的班级。当天没有计划时单词列表为空。")
    @GetMapping("/class/{classId}/today")
    @AuthCheck
    public BaseResponse<ClassTodayPlanVO> getTodayPlanByClass(
            @Parameter(description = "班级ID", required = true) @PathVariable("classId") Long classId,
            HttpServletRequest httpRequest) {
        // 1. 获取当前登录用户并查询
        UserAccountVO loginUser = getLoginUser(httpRequest);
        ClassTodayPlanVO result = classDailyAssignmentService.getTodayPlanByClass(classId, loginUser);

        // 2. 封装返回类型给前端
        return ResultUtils.success(result);
    }

    private UserAccountVO getLoginUser(HttpServletRequest httpRequest) {
        Object attr = httpRequest.getAttribute(UserConstant.LOGIN_USER_ATTR);
        ThrowUtils.throwIf(!(attr instanceof UserAccountVO), ErrorCode.NOT_LOGIN_ERROR, "未登录");
        return (UserAccountVO) attr;
    }
}
