package yfy.englishschoolmaster.model.vo;

import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * 学生今日复习列表 VO：
 * 对应 Redis 缓存 student.review.list 及复习接口返回，
 *       包含待复习单词数量与明细列表
 */
@Data
public class StudentReviewCacheVO implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 学生ID
     */
    private Long studentId;

    /**
     * 当前在班班级ID
     */
    private Long classId;

    /**
     * 待复习单词数量
     */
    private Integer wordCount;

    /**
     * 待复习单词明细列表
     */
    private List<StudentReviewWordVO> words = new ArrayList<>();
}
