package yfy.englishschoolmaster.service;

import com.mybatisflex.core.service.IService;
import yfy.englishschoolmaster.model.dto.WordBook.WordImportItem;
import yfy.englishschoolmaster.model.entity.Word;

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
}
