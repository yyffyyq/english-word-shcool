package yfy.englishschoolmaster.controller;

import com.mybatisflex.core.paginate.Page;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
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
import yfy.englishschoolmaster.model.dto.WordBook.WordBookAddRequest;
import yfy.englishschoolmaster.model.dto.WordBook.WordBookImportRequest;
import yfy.englishschoolmaster.model.dto.WordBook.WordBookQueryRequest;
import yfy.englishschoolmaster.model.dto.WordBook.WordBookUpdateRequest;
import yfy.englishschoolmaster.model.vo.UserAccountVO;
import yfy.englishschoolmaster.model.vo.WordBookImportResultVO;
import yfy.englishschoolmaster.model.vo.WordBookVO;
import yfy.englishschoolmaster.service.WordBookService;

/**
 * 平台内置词书表 控制层。
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
@RestController
@RequestMapping("/wordBook")
public class WordBookController {

    @Autowired
    private WordBookService wordBookService;

    /**
     * 词书创建接口（教师、管理员）：
     * 请求头需携带 openid，由 AuthInterceptor 校验登录态，
     * Service 内校验教师或管理员角色。
     *
     * @param request     创建请求
     * @param httpRequest HTTP 请求（用于取登录用户）
     * @return 词书信息
     */
    @PostMapping("/add")
    @AuthCheck
    public BaseResponse<WordBookVO> addWordBook(@RequestBody WordBookAddRequest request,
                                                HttpServletRequest httpRequest) {
        // 1. 判断请求是否为空
        ThrowUtils.throwIf(request == null, ErrorCode.PARAMS_ERROR, "创建词书请求为空");

        // 2. 获取当前登录用户并创建词书
        UserAccountVO loginUser = getLoginUser(httpRequest);
        WordBookVO wordBookVO = wordBookService.createWordBook(request, loginUser);

        // 3. 封装返回类型给前端
        return ResultUtils.success(wordBookVO);
    }

    /**
     * 词书分页查询接口（教师、管理员）：
     * 支持按词书名称、状态筛选。
     * 请求头需携带 openid。
     *
     * @param request     分页查询请求
     * @param httpRequest HTTP 请求（用于取登录用户）
     * @return 分页词书列表
     */
    @PostMapping("/list/page/vo")
    @AuthCheck
    public BaseResponse<Page<WordBookVO>> listWordBookByPage(@RequestBody WordBookQueryRequest request,
                                                             HttpServletRequest httpRequest) {
        // 1. 判断请求是否为空
        ThrowUtils.throwIf(request == null, ErrorCode.PARAMS_ERROR, "查询请求为空");

        // 2. 分页查询词书
        UserAccountVO loginUser = getLoginUser(httpRequest);
        Page<WordBookVO> page = wordBookService.listWordBookByPage(request, loginUser);

        // 3. 封装返回类型给前端
        return ResultUtils.success(page);
    }

    /**
     * 词书修改接口（教师、管理员）：
     * 可修改名称、说明、封面、状态。
     * 请求头需携带 openid。
     *
     * @param request     修改请求
     * @param httpRequest HTTP 请求（用于取登录用户）
     * @return 修改后的词书信息
     */
    @PutMapping("/update")
    @AuthCheck
    public BaseResponse<WordBookVO> updateWordBook(@RequestBody WordBookUpdateRequest request,
                                                   HttpServletRequest httpRequest) {
        // 1. 判断请求是否为空
        ThrowUtils.throwIf(request == null, ErrorCode.PARAMS_ERROR, "修改词书请求为空");

        // 2. 修改词书
        UserAccountVO loginUser = getLoginUser(httpRequest);
        WordBookVO wordBookVO = wordBookService.updateWordBook(request, loginUser);

        // 3. 封装返回类型给前端
        return ResultUtils.success(wordBookVO);
    }

    /**
     * 词书删除接口（教师、管理员）：
     * 软删除，将词书状态置为 DISABLED。
     * 请求头需携带 openid。
     *
     * @param id          词书ID
     * @param httpRequest HTTP 请求（用于取登录用户）
     * @return 是否删除成功
     */
    @DeleteMapping("/{id}")
    @AuthCheck
    public BaseResponse<Boolean> deleteWordBook(@PathVariable("id") Long id,
                                                HttpServletRequest httpRequest) {
        UserAccountVO loginUser = getLoginUser(httpRequest);
        boolean result = wordBookService.deleteWordBook(id, loginUser);
        return ResultUtils.success(result);
    }

    /**
     * 词书单词批量导入接口（教师、管理员）：
     * 全部字段手工录入：英文、音标、正确中文、3 个错误中文、例句及例句翻译。
     * 正确选项写入 word_option.is_correct=1，供学生四选一判分。
     * 请求头需携带 openid。
     *
     * @param bookId      词书ID
     * @param request     导入请求
     * @param httpRequest HTTP 请求（用于取登录用户）
     * @return 导入结果（含成功数、失败明细、词书单词总数）
     */
    @PostMapping("/{bookId}/words/import")
    @AuthCheck
    public BaseResponse<WordBookImportResultVO> importWords(@PathVariable("bookId") Long bookId,
                                                            @RequestBody WordBookImportRequest request,
                                                            HttpServletRequest httpRequest) {
        // 1. 判断请求是否为空
        ThrowUtils.throwIf(request == null, ErrorCode.PARAMS_ERROR, "导入请求为空");

        // 2. 获取当前登录用户并导入单词
        UserAccountVO loginUser = getLoginUser(httpRequest);
        WordBookImportResultVO result = wordBookService.importWords(bookId, request, loginUser);

        // 3. 封装返回类型给前端
        return ResultUtils.success(result);
    }

    private UserAccountVO getLoginUser(HttpServletRequest httpRequest) {
        Object attr = httpRequest.getAttribute(UserConstant.LOGIN_USER_ATTR);
        ThrowUtils.throwIf(!(attr instanceof UserAccountVO), ErrorCode.NOT_LOGIN_ERROR, "未登录");
        return (UserAccountVO) attr;
    }
}
