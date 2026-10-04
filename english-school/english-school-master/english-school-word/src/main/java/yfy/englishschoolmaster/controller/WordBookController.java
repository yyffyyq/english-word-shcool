package yfy.englishschoolmaster.controller;

import com.mybatisflex.core.paginate.Page;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
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
import yfy.englishschoolmaster.model.dto.WordBook.WordBookWordQueryRequest;
import yfy.englishschoolmaster.model.vo.UserAccountVO;
import yfy.englishschoolmaster.model.vo.WordBookImportResultVO;
import yfy.englishschoolmaster.model.vo.WordBookVO;
import yfy.englishschoolmaster.model.vo.WordVO;
import yfy.englishschoolmaster.service.WordBookService;

/**
 * 平台内置词书表 控制层。
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
@Tag(name = "词书管理", description = "词书创建/查询/修改/删除，以及词书内单词导入与分页查询")
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
    @Operation(summary = "创建词书",
            description = "教师/管理员创建词书，可填写名称、说明、封面。")
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
    @Operation(summary = "词书分页查询",
            description = "教师/管理员分页查询词书，支持按名称、状态筛选。")
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
    @Operation(summary = "修改词书",
            description = "教师/管理员修改词书名称、说明、封面、状态。")
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
    @Operation(summary = "删除词书（软删除）",
            description = "将词书状态置为 DISABLED，不物理删除。")
    @DeleteMapping("/{id}")
    @AuthCheck
    public BaseResponse<Boolean> deleteWordBook(
            @Parameter(description = "词书ID", required = true) @PathVariable("id") Long id,
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
    @Operation(summary = "批量导入词书单词",
            description = "手工录入英文、音标、正确中文、3 个错误中文、例句及翻译；正确项写入 word_option.is_correct=1。")
    @PostMapping("/{bookId}/words/import")
    @AuthCheck
    public BaseResponse<WordBookImportResultVO> importWords(
            @Parameter(description = "词书ID", required = true) @PathVariable("bookId") Long bookId,
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

    /**
     * 词书内单词分页查询接口（教师、管理员）：
     * 根据词书 ID 分页查询关联单词，支持按英文单词、单元名称筛选。
     * 返回结果含四选一选项、单元名称与词书内排序。
     * 请求头需携带 openid 或 userId。
     *
     * @param bookId      词书ID
     * @param request     分页查询请求
     * @param httpRequest HTTP 请求（用于取登录用户）
     * @return 分页单词列表
     */
    @Operation(summary = "词书内单词分页查询",
            description = "按词书 ID 分页查询关联单词，支持按英文、单元筛选；返回含四选一选项。")
    @PostMapping("/{bookId}/words/list/page/vo")
    @AuthCheck
    public BaseResponse<Page<WordVO>> listWordsByBookPage(
            @Parameter(description = "词书ID", required = true) @PathVariable("bookId") Long bookId,
            @RequestBody WordBookWordQueryRequest request,
            HttpServletRequest httpRequest) {
        // 1. 判断请求是否为空
        ThrowUtils.throwIf(request == null, ErrorCode.PARAMS_ERROR, "查询请求为空");

        // 2. 分页查询词书内单词
        UserAccountVO loginUser = getLoginUser(httpRequest);
        Page<WordVO> page = wordBookService.listWordsByBookPage(bookId, request, loginUser);

        // 3. 封装返回类型给前端
        return ResultUtils.success(page);
    }

    private UserAccountVO getLoginUser(HttpServletRequest httpRequest) {
        Object attr = httpRequest.getAttribute(UserConstant.LOGIN_USER_ATTR);
        ThrowUtils.throwIf(!(attr instanceof UserAccountVO), ErrorCode.NOT_LOGIN_ERROR, "未登录");
        return (UserAccountVO) attr;
    }
}
