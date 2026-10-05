package yfy.englishschoolmaster.service.impl;

import com.mybatisflex.core.query.QueryWrapper;
import com.mybatisflex.spring.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import yfy.englishschoolmaster.mapper.WordBookItemMapper;
import yfy.englishschoolmaster.model.entity.WordBookItem;
import yfy.englishschoolmaster.service.WordBookItemService;

/**
 * 词书与单词关系表 服务层实现。
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
@Service
public class WordBookItemServiceImpl extends ServiceImpl<WordBookItemMapper, WordBookItem>
        implements WordBookItemService {

    @Override
    public int getMaxSortOrder(Long bookId) {
        WordBookItem item = this.getOne(QueryWrapper.create()
                .eq(WordBookItem::getBookId, bookId)
                .orderBy(WordBookItem::getSortOrder, false)
                .limit(1));
        return item == null || item.getSortOrder() == null ? 0 : item.getSortOrder();
    }

    @Override
    public boolean linkIfAbsent(Long bookId, Long wordId, int sortOrder, Integer week, Integer unitName) {
        WordBookItem exist = this.getOne(QueryWrapper.create()
                .eq(WordBookItem::getBookId, bookId)
                .eq(WordBookItem::getWordId, wordId));
        if (exist != null) {
            return false;
        }
        WordBookItem item = WordBookItem.builder()
                .bookId(bookId)
                .wordId(wordId)
                .sortOrder(sortOrder)
                .week(week)
                .unitName(unitName)
                .build();
        return this.save(item);
    }

    @Override
    public long countByBookId(Long bookId) {
        return this.count(QueryWrapper.create().eq(WordBookItem::getBookId, bookId));
    }
}
