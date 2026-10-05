package yfy.englishschoolmaster.mapper;

import com.mybatisflex.core.BaseMapper;
import org.apache.ibatis.annotations.Param;
import yfy.englishschoolmaster.model.entity.StudentWordProgress;

import java.util.List;

/**
 * 学生单词掌握进度表 映射层：
 * 提供 student_word_progress 表的基础 CRUD 及未完成词查询
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
public interface StudentWordProgressMapper extends BaseMapper<StudentWordProgress> {

    /**
     * 查询学生在指定班级、指定词书下尚未掌握的单词（NEW / LEARNING），
     * 按 week、unit_name、sort_order 升序结转。空的周次、单元排在后面。
     *
     * @param studentId 学生 ID
     * @param classId   班级 ID
     * @param bookId    词书 ID
     * @return 未完成单词 ID 列表
     */
    List<Long> selectUnfinishedWordIds(@Param("studentId") Long studentId,
                                       @Param("classId") Long classId,
                                       @Param("bookId") Long bookId);
}
