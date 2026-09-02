package yfy.englishschoolmaster.mapper;

import com.mybatisflex.core.BaseMapper;
import org.apache.ibatis.annotations.Param;
import yfy.englishschoolmaster.model.entity.ClassDailyAssignmentWord;

import java.util.List;

/**
 * 班级每日分配单词明细表 映射层：
 * 提供 class_daily_assignment_word 表的基础 CRUD 及随机抽词查询
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
public interface ClassDailyAssignmentWordMapper extends BaseMapper<ClassDailyAssignmentWord> {

    /**
     * 从词书中随机抽取尚未被本任务分配过的单词 ID：
     * 排除已在 class_daily_assignment_word 中的记录
     *
     * @param bookId 词书 ID
     * @param taskId 任务 ID
     * @param limit  抽取数量
     * @return 单词 ID 列表
     */
    List<Long> selectRandomUnassignedWordIds(@Param("bookId") Long bookId,
                                             @Param("taskId") Long taskId,
                                             @Param("limit") int limit);
}
