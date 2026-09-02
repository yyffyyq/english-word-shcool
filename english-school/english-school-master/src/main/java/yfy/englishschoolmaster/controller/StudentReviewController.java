package yfy.englishschoolmaster.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
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
import yfy.englishschoolmaster.model.dto.StudentReview.StudentReviewChoiceAnswerRequest;
import yfy.englishschoolmaster.model.dto.StudentReview.StudentReviewPlanRunRequest;
import yfy.englishschoolmaster.model.dto.StudentReview.StudentReviewSpellAnswerRequest;
import yfy.englishschoolmaster.model.vo.StudentAnswerResultVO;
import yfy.englishschoolmaster.model.vo.StudentReviewCacheVO;
import yfy.englishschoolmaster.model.vo.StudentReviewPlanRunResultVO;
import yfy.englishschoolmaster.model.vo.UserAccountVO;
import yfy.englishschoolmaster.service.StudentReviewService;

/**
 * 学生复习 控制层。
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
@Tag(name = "学生复习", description = "今日复习词表、复习做题，以及管理员手动生成复习计划")
@RestController
@RequestMapping("/studentReview")
public class StudentReviewController {

    @Autowired
    private StudentReviewService studentReviewService;

    /**
     * 获取今日待复习单词列表（学生）：
     * 优先读 Redis（student.review.list），未命中回源。
     *
     * @param httpRequest HTTP 请求
     * @return 今日复习词表与数量
     */
    @Operation(summary = "获取今日复习词表",
            description = "优先读 Redis（student.review.list），未命中回源；返回 PENDING 复习词及 reason（高频错题/次日必复/艾宾浩斯）。")
    @GetMapping("/today")
    @AuthCheck
    public BaseResponse<StudentReviewCacheVO> getTodayReview(HttpServletRequest httpRequest) {
        UserAccountVO loginUser = getLoginUser(httpRequest);
        StudentReviewCacheVO review = studentReviewService.getTodayReview(loginUser);
        return ResultUtils.success(review);
    }

    /**
     * 复习四选一做题接口（学生）。
     */
    @Operation(summary = "复习四选一做题",
            description = "判分并写入 answer_record（REVIEW/CHOICE）；答对推进艾宾浩斯，答错次日再复。")
    @PostMapping("/answer/choice")
    @AuthCheck
    public BaseResponse<StudentAnswerResultVO> answerChoice(
            @RequestBody StudentReviewChoiceAnswerRequest request,
            HttpServletRequest httpRequest) {
        ThrowUtils.throwIf(request == null, ErrorCode.PARAMS_ERROR, "作答请求为空");
        UserAccountVO loginUser = getLoginUser(httpRequest);
        StudentAnswerResultVO result = studentReviewService.answerChoice(request, loginUser);
        return ResultUtils.success(result);
    }

    /**
     * 复习拼写做题接口（学生）。
     */
    @Operation(summary = "复习拼写做题",
            description = "拼写判分并写入 answer_record（REVIEW/SPELL）；答对推进艾宾浩斯，答错次日再复。")
    @PostMapping("/answer/spell")
    @AuthCheck
    public BaseResponse<StudentAnswerResultVO> answerSpell(
            @RequestBody StudentReviewSpellAnswerRequest request,
            HttpServletRequest httpRequest) {
        ThrowUtils.throwIf(request == null, ErrorCode.PARAMS_ERROR, "作答请求为空");
        UserAccountVO loginUser = getLoginUser(httpRequest);
        StudentAnswerResultVO result = studentReviewService.answerSpell(request, loginUser);
        return ResultUtils.success(result);
    }

    /**
     * 手动生成复习计划（管理员）：可指定复习日，默认今天。
     */
    @Operation(summary = "手动生成复习计划",
            description = "管理员按复习日生成清单（默认今天）：高频错题>次日必复>艾宾浩斯到期。系统定时任务每天 04:00 也会执行。")
    @PostMapping("/plan/run")
    @AuthCheck(mustRole = UserConstant.ADMIN_ROLE)
    public BaseResponse<StudentReviewPlanRunResultVO> runPlan(
            @RequestBody(required = false) StudentReviewPlanRunRequest request,
            HttpServletRequest httpRequest) {
        UserAccountVO loginUser = getLoginUser(httpRequest);
        StudentReviewPlanRunResultVO result = studentReviewService.runPlanByAdmin(
                request == null ? null : request.getReviewDate(),
                loginUser
        );
        return ResultUtils.success(result);
    }

    private UserAccountVO getLoginUser(HttpServletRequest httpRequest) {
        Object attr = httpRequest.getAttribute(UserConstant.LOGIN_USER_ATTR);
        ThrowUtils.throwIf(!(attr instanceof UserAccountVO), ErrorCode.NOT_LOGIN_ERROR, "未登录");
        return (UserAccountVO) attr;
    }
}
