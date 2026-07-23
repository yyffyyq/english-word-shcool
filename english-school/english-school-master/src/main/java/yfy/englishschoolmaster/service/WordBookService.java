package yfy.englishschoolmaster.service;

import com.mybatisflex.core.paginate.Page;
import com.mybatisflex.core.service.IService;
import yfy.englishschoolmaster.model.dto.WordBook.WordBookAddRequest;
import yfy.englishschoolmaster.model.dto.WordBook.WordBookImportRequest;
import yfy.englishschoolmaster.model.dto.WordBook.WordBookQueryRequest;
import yfy.englishschoolmaster.model.dto.WordBook.WordBookUpdateRequest;
import yfy.englishschoolmaster.model.entity.WordBook;
import yfy.englishschoolmaster.model.vo.UserAccountVO;
import yfy.englishschoolmaster.model.vo.WordBookImportResultVO;
import yfy.englishschoolmaster.model.vo.WordBookVO;

/**
 * 平台内置词书表 服务层。
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
public interface WordBookService extends IService<WordBook> {

    /**
     * 创建词书（教师、管理员）
     *
     * @param request   创建请求
     * @param loginUser 当前登录用户
     * @return 词书信息
     */
    WordBookVO createWordBook(WordBookAddRequest request, UserAccountVO loginUser);

    /**
     * 词书分页查询（教师、管理员）
     *
     * @param request   分页查询请求
     * @param loginUser 当前登录用户
     * @return 分页词书列表
     */
    Page<WordBookVO> listWordBookByPage(WordBookQueryRequest request, UserAccountVO loginUser);

    /**
     * 修改词书（教师、管理员）
     *
     * @param request   修改请求
     * @param loginUser 当前登录用户
     * @return 修改后的词书信息
     */
    WordBookVO updateWordBook(WordBookUpdateRequest request, UserAccountVO loginUser);

    /**
     * 删除词书（教师、管理员）：软删除，将状态置为 DISABLED
     *
     * @param id        词书ID
     * @param loginUser 当前登录用户
     * @return 是否删除成功
     */
    boolean deleteWordBook(Long id, UserAccountVO loginUser);

    /**
     * 批量导入单词到词书（教师、管理员）：
     * 手工录入英文、音标、正确中文、3 个错误中文、例句及例句翻译；
     * 正确项标记 is_correct=1，并维护词书关联与 word_count。
     * 单条失败不影响其他条目。
     *
     * @param bookId    词书ID
     * @param request   导入请求
     * @param loginUser 当前登录用户
     * @return 导入结果
     */
    WordBookImportResultVO importWords(Long bookId, WordBookImportRequest request, UserAccountVO loginUser);
}
