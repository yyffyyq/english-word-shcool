package yfy.englishschoolmaster.mapper;

import com.mybatisflex.core.BaseMapper;
import org.apache.ibatis.annotations.Param;
import yfy.englishschoolmaster.model.entity.StudentDailyReview;
import yfy.englishschoolmaster.model.dto.StudentReview.HighWrongWordStat;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 学生每日复习计划表 映射层：
 * 提供 student_daily_review 表的基础 CRUD 及高频错题统计查询
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
public interface StudentDailyReviewMapper extends BaseMapper<StudentDailyReview> {

    /**
     * 统计指定时间范围内答错次数 > 3 的记录：
     * 按 (student_id, word_id, class_id) 分组汇总
     *
     * @param startInclusive 开始时间（含）
     * @param endExclusive   结束时间（不含）
     * @return 高频错题统计列表
     */
    List<HighWrongWordStat> selectHighWrongWords(@Param("startInclusive") LocalDateTime startInclusive,
                                                 @Param("endExclusive") LocalDateTime endExclusive);
}
