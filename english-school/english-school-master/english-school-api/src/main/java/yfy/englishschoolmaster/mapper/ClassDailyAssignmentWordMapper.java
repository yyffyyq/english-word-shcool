package yfy.englishschoolmaster.mapper;

import com.mybatisflex.core.BaseMapper;
import org.apache.ibatis.annotations.Param;
import yfy.englishschoolmaster.model.entity.ClassDailyAssignmentWord;

import java.util.List;

/**
 * 学生每日学习词表明细表 映射层：
 * 提供 class_daily_assignment_word 表的基础 CRUD 及按词书关系 ID 顺序抽取未学新词
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
public interface ClassDailyAssignmentWordMapper extends BaseMapper<ClassDailyAssignmentWord> {

    /**
     * 按词书关系 ID（word_book_item.id）升序，抽取该学生尚未有学习进度的单词。
     * 已学过的词会被跳过，因此会从上次分配位置继续往后取。
     *
     * @param bookId    词书 ID
     * @param studentId 学生 ID
     * @param limit     抽取数量
     * @return 单词 ID 列表
     */
    List<Long> selectUnlearnedWordIdsInOrder(@Param("bookId") Long bookId,
                                             @Param("studentId") Long studentId,
                                             @Param("limit") int limit);
}
