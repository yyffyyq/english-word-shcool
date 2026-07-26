package yfy.englishschoolmaster.service;

import com.mybatisflex.core.service.IService;
import yfy.englishschoolmaster.model.dto.Word.WordUpdateRequest;
import yfy.englishschoolmaster.model.dto.WordBook.WordImportItem;
import yfy.englishschoolmaster.model.entity.Word;
import yfy.englishschoolmaster.model.vo.UserAccountVO;
import yfy.englishschoolmaster.model.vo.WordVO;

/**
 * 单词基础数据表 服务层。
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
public interface WordService extends IService<Word> {

    /**
     * 按导入条目手工保存单词：
     * 校验英文、音标、正确中文、3 个错误中文、例句及例句翻译后落库；
     * 正确项写入 word_option.is_correct=1；已存在单词则复用并补齐缺失选项。
     *
     * @param item 导入条目
     * @return 持久化后的单词
     */
    Word enrichAndSave(WordImportItem item);

    /**
     * 修改单词（教师、管理员）：
     * 可修改英文、音标、正确释义、错误选项、例句及例句翻译；
     * 若更新正确释义或错误选项，则整体覆盖四选一选项。
     *
     * @param request   修改请求
     * @param loginUser 当前登录用户
     * @return 修改后的单词信息
     */
    WordVO updateWord(WordUpdateRequest request, UserAccountVO loginUser);

    /**
     * 物理删除单词（教师、管理员）：
     * 先删除选项与词书关联，再删除单词主表，并回写受影响词书的 word_count。
     *
     * @param id        单词ID
     * @param loginUser 当前登录用户
     * @return 是否删除成功
     */
    boolean deleteWordPhysically(Long id, UserAccountVO loginUser);
}
