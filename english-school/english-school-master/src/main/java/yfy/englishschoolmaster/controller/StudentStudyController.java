package yfy.englishschoolmaster.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import yfy.englishschoolmaster.annotation.AuthCheck;
import yfy.englishschoolmaster.common.BaseResponse;
import yfy.englishschoolmaster.common.ResultUtils;
import yfy.englishschoolmaster.constant.UserConstant;
import yfy.englishschoolmaster.exception.ErrorCode;
import yfy.englishschoolmaster.exception.ThrowUtils;
import yfy.englishschoolmaster.model.dto.StudentStudy.StudentChoiceAnswerRequest;
import yfy.englishschoolmaster.model.dto.StudentStudy.StudentSpellAnswerRequest;
import yfy.englishschoolmaster.model.dto.StudentStudy.StudentWordStatusUpdateRequest;
import yfy.englishschoolmaster.model.vo.StudentAnswerResultVO;
import yfy.englishschoolmaster.model.vo.StudentHomeworkCacheVO;
import yfy.englishschoolmaster.model.vo.UserAccountVO;
import yfy.englishschoolmaster.service.StudentStudyService;

/**
 * 学生学习 控制层。
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
@Tag(name = "学生学习", description = "今日新词作业、四选一/拼写做题、学习状态修改")
@RestController
@RequestMapping("/studentStudy")
public class StudentStudyController {

    @Autowired
    private StudentStudyService studentStudyService;

    /**
     * 获取今日作业单词列表与数量（学生）：
     * 优先读 Redis（student.homework.list），未命中则回源数据库并回写。
     * 请求头需携带 openid。
     *
     * @param httpRequest HTTP 请求
     * @return 今日作业词表与数量
     */
    @Operation(summary = "获取今日新词作业",
            description = "优先读 Redis（student.homework.list），未命中则回源 DB 并回写；返回词表与 wordCount。含英文、音标、释义及四选一选项（不含答案标记）。")
    @GetMapping("/homework/today")
    @AuthCheck
    public BaseResponse<StudentHomeworkCacheVO> getTodayHomework(HttpServletRequest httpRequest) {
        // 1. 获取登录用户并查询今日作业
        UserAccountVO loginUser = getLoginUser(httpRequest);
        StudentHomeworkCacheVO homework = studentStudyService.getTodayHomework(loginUser);

        // 2. 封装返回
        return ResultUtils.success(homework);
    }

    /**
     * 四选一做题接口（学生）：
     * 根据选项 ID 判分，写入答题记录，并更新学习进度。
     *
     * @param request     作答请求
     * @param httpRequest HTTP 请求
     * @return 判题结果
     */
    @Operation(summary = "新词四选一做题",
            description = "根据 optionId 判分，写入 answer_record（NEW/CHOICE），并更新学习进度（NEW→LEARNING）。")
    @PostMapping("/answer/choice")
    @AuthCheck
    public BaseResponse<StudentAnswerResultVO> answerChoice(@RequestBody StudentChoiceAnswerRequest request,
                                                            HttpServletRequest httpRequest) {
        // 1. 判断请求是否为空
        ThrowUtils.throwIf(request == null, ErrorCode.PARAMS_ERROR, "作答请求为空");

        // 2. 判题
        UserAccountVO loginUser = getLoginUser(httpRequest);
        StudentAnswerResultVO result = studentStudyService.answerChoice(request, loginUser);

        // 3. 封装返回
        return ResultUtils.success(result);
    }

    /**
     * 拼写做题接口（学生）：
     * 比对拼写字符串与单词原文（忽略大小写），写入答题记录并更新进度。
     *
     * @param request     作答请求
     * @param httpRequest HTTP 请求
     * @return 判题结果
     */
    @Operation(summary = "新词拼写做题",
            description = "比对拼写字符串与单词原文（忽略大小写），写入 answer_record（NEW/SPELL）并更新进度。")
    @PostMapping("/answer/spell")
    @AuthCheck
    public BaseResponse<StudentAnswerResultVO> answerSpell(@RequestBody StudentSpellAnswerRequest request,
                                                           HttpServletRequest httpRequest) {
        // 1. 判断请求是否为空
        ThrowUtils.throwIf(request == null, ErrorCode.PARAMS_ERROR, "作答请求为空");

        // 2. 判题
        UserAccountVO loginUser = getLoginUser(httpRequest);
        StudentAnswerResultVO result = studentStudyService.answerSpell(request, loginUser);

        // 3. 封装返回
        return ResultUtils.success(result);
    }

    /**
     * 每日单词学习状态修改接口（学生）：
     * 可将状态改为 LEARNING 或 MASTERED；MASTERED 后会刷新作业缓存。
     *
     * @param request     状态修改请求
     * @param httpRequest HTTP 请求
     * @return 是否成功
     */
    @Operation(summary = "修改单词学习状态",
            description = "可将状态改为 LEARNING 或 MASTERED；置为 MASTERED 后会刷新今日作业 Redis 缓存。")
    @PutMapping("/progress/status")
    @AuthCheck
    public BaseResponse<Boolean> updateWordStatus(@RequestBody StudentWordStatusUpdateRequest request,
                                                  HttpServletRequest httpRequest) {
        // 1. 判断请求是否为空
        ThrowUtils.throwIf(request == null, ErrorCode.PARAMS_ERROR, "状态修改请求为空");

        // 2. 更新状态
        UserAccountVO loginUser = getLoginUser(httpRequest);
        boolean result = studentStudyService.updateWordStatus(request, loginUser);

        // 3. 封装返回
        return ResultUtils.success(result);
    }

    private UserAccountVO getLoginUser(HttpServletRequest httpRequest) {
        Object attr = httpRequest.getAttribute(UserConstant.LOGIN_USER_ATTR);
        ThrowUtils.throwIf(!(attr instanceof UserAccountVO), ErrorCode.NOT_LOGIN_ERROR, "未登录");
        return (UserAccountVO) attr;
    }
}
