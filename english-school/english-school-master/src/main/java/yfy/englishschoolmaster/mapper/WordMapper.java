package yfy.englishschoolmaster.mapper;

import com.mybatisflex.core.BaseMapper;
import org.apache.ibatis.annotations.Param;
import yfy.englishschoolmaster.model.entity.Word;

/**
 * 单词基础数据表 映射层：
 * 提供 word 表的基础 CRUD 及级联物理删除操作
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
public interface WordMapper extends BaseMapper<Word> {

    /**
     * 物理删除单词选项：
     * 按单词 ID 删除 word_option 表关联记录
     *
     * @param id 单词 ID
     * @return 影响行数
     */
    int deleteWordOptionsByWordId(@Param("id") Long id);

    /**
     * 物理删除词书-单词关联：
     * 按单词 ID 删除 word_book_item 表关联记录
     *
     * @param id 单词 ID
     * @return 影响行数
     */
    int deleteWordBookItemsByWordId(@Param("id") Long id);

    /**
     * 物理删除单词主表记录：
     * 按 ID 删除 word 表记录
     *
     * @param id 单词 ID
     * @return 影响行数
     */
    int deleteWordById(@Param("id") Long id);
}
