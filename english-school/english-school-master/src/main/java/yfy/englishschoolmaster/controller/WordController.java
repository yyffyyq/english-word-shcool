package yfy.englishschoolmaster.controller;

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
    @DeleteMapping("/{id}")
    @AuthCheck
    public BaseResponse<Boolean> deleteWord(@PathVariable("id") Long id,
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
