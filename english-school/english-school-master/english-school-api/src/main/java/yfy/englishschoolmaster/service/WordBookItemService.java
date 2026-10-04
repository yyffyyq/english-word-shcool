package yfy.englishschoolmaster.service;

import com.mybatisflex.core.service.IService;
import yfy.englishschoolmaster.model.entity.WordBookItem;

/**
 * 词书与单词关系表 服务层：
 * 维护词书内单词排序、关联去重与数量统计。
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
public interface WordBookItemService extends IService<WordBookItem> {

    /**
     * 查询词书内当前最大排序号：
     * 无数据时返回 0，用于导入时继续递增排序。
     *
     * @param bookId 词书ID
     * @return 最大 sort_order
     */
    int getMaxSortOrder(Long bookId);

    /**
     * 写入词书与单词关联：
     * 若该书中尚无该单词则新增关联；已存在则跳过，避免重复导入。
     *
     * @param bookId    词书ID
     * @param wordId    单词ID
     * @param sortOrder 排序号
     * @param unitName  单元名称，可空
     * @return true 表示新写入关联，false 表示已存在
     */
    boolean linkIfAbsent(Long bookId, Long wordId, int sortOrder, String unitName);

    /**
     * 统计词书下单词数量：
     * 用于回写 word_book.word_count。
     *
     * @param bookId 词书ID
     * @return 数量
     */
    long countByBookId(Long bookId);
}
