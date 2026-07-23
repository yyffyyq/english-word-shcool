package yfy.englishschoolmaster.service;

import com.mybatisflex.core.service.IService;
import yfy.englishschoolmaster.model.entity.WordOption;

import java.util.List;

/**
 * 单词中文选项表 服务层：
 * 维护每个单词的 1 个正确项与 3 个干扰项。
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
public interface WordOptionService extends IService<WordOption> {

    /**
     * 覆盖保存单词选项：
     * 先删除该单词旧选项，再写入 1 个正确项 + 3 个干扰项。
     *
     * @param wordId          单词ID
     * @param correctMeaning  正确中文释义
     * @param wrongMeanings   3 个错误中文释义
     */
    void replaceOptions(Long wordId, String correctMeaning, List<String> wrongMeanings);

    /**
     * 查询单词全部选项（含正确标记，供管理端/判分使用）
     *
     * @param wordId 单词ID
     * @return 选项列表
     */
    List<WordOption> listByWordId(Long wordId);

    /**
     * 判断该单词是否已具备完整四选一选项（1 正确 + 3 错误）
     *
     * @param wordId 单词ID
     * @return true 表示选项完整
     */
    boolean hasCompleteOptions(Long wordId);
}
