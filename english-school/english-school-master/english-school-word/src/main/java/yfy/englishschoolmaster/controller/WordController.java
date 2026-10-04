package yfy.englishschoolmaster.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
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
import yfy.englishschoolmaster.model.dto.Word.WordUpdateRequest;
import yfy.englishschoolmaster.model.vo.UserAccountVO;
import yfy.englishschoolmaster.model.vo.WordVO;
import yfy.englishschoolmaster.service.WordService;

/**
 * 单词基础数据 控制层。
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
@Tag(name = "单词管理", description = "单词修改与物理删除接口（教师/管理员）")
@RestController
@RequestMapping("/word")
public class WordController {

    @Autowired
    private WordService wordService;

    /**
     * 单词修改接口（教师、管理员）：
     * 可修改英文、音标、正确释义、错误选项、例句及例句翻译。
     * 若更新正确释义或错误选项，需同时传入 3 个错误中文释义以覆盖四选一。
     * 请求头需携带 openid 或 userId。
     *
     * @param request     修改请求
     * @param httpRequest HTTP 请求（用于取登录用户）
     * @return 修改后的单词信息
     */
    @Operation(summary = "修改单词",
            description = "可修改英文、音标、正确释义、错误选项、例句等；更新选项时需同时传入 3 个错误中文释义。")
    @PutMapping("/update")
    @AuthCheck
    public BaseResponse<WordVO> updateWord(@RequestBody WordUpdateRequest request,
                                           HttpServletRequest httpRequest) {
        // 1. 判断请求是否为空
        ThrowUtils.throwIf(request == null, ErrorCode.PARAMS_ERROR, "修改单词请求为空");

        // 2. 修改单词
        UserAccountVO loginUser = getLoginUser(httpRequest);
        WordVO wordVO = wordService.updateWord(request, loginUser);

        // 3. 封装返回类型给前端
        return ResultUtils.success(wordVO);
    }

    /**
     * 单词删除接口（教师、管理员）：
     * 物理删除单词及其选项、词书关联，并回写受影响词书的 word_count。
     * 请求头需携带 openid 或 userId。
     *
     * @param id          单词ID
     * @param httpRequest HTTP 请求（用于取登录用户）
     * @return 是否删除成功
     */
    @Operation(summary = "物理删除单词",
            description = "物理删除单词及其选项、词书关联，并回写相关词书 word_count。")
    @DeleteMapping("/{id}")
    @AuthCheck
    public BaseResponse<Boolean> deleteWord(
            @Parameter(description = "单词ID", required = true) @PathVariable("id") Long id,
            HttpServletRequest httpRequest) {
        // 1. 获取当前登录用户并物理删除单词
        UserAccountVO loginUser = getLoginUser(httpRequest);
        boolean result = wordService.deleteWordPhysically(id, loginUser);

        // 2. 封装返回类型给前端
        return ResultUtils.success(result);
    }

    private UserAccountVO getLoginUser(HttpServletRequest httpRequest) {
        Object attr = httpRequest.getAttribute(UserConstant.LOGIN_USER_ATTR);
        ThrowUtils.throwIf(!(attr instanceof UserAccountVO), ErrorCode.NOT_LOGIN_ERROR, "未登录");
        return (UserAccountVO) attr;
    }
}
