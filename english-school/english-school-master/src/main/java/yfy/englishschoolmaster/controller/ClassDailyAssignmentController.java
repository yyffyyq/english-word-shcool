package yfy.englishschoolmaster.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
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
import yfy.englishschoolmaster.model.vo.ClassDailyAssignmentRunResultVO;
import yfy.englishschoolmaster.model.vo.UserAccountVO;
import yfy.englishschoolmaster.service.ClassDailyAssignmentService;

/**
 * 班级每日单词分配 控制层。
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
@Tag(name = "每日单词分配", description = "管理员手动触发班级每日新词分配（定时任务默认定点执行）")
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
            description = "管理员按指定学习日（默认今天）执行全量分配：班级抽词、下发学生进度。系统定时任务每天 02:00 也会执行。")
    @PostMapping("/run")
    @AuthCheck(mustRole = UserConstant.ADMIN_ROLE)
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

    private UserAccountVO getLoginUser(HttpServletRequest httpRequest) {
        Object attr = httpRequest.getAttribute(UserConstant.LOGIN_USER_ATTR);
        ThrowUtils.throwIf(!(attr instanceof UserAccountVO), ErrorCode.NOT_LOGIN_ERROR, "未登录");
        return (UserAccountVO) attr;
    }
}
