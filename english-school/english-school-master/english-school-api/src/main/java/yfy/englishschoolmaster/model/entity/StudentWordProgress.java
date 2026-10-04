package yfy.englishschoolmaster.model.entity;

import com.mybatisflex.annotation.Id;
import com.mybatisflex.annotation.KeyType;
import com.mybatisflex.annotation.Table;
import java.io.Serial;
import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Date;
import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 学生单词掌握进度实体：
 * 对应 student_word_progress 表，
 *       记录学生对每个单词的学习状态、答题统计及 SM-2 复习参数
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table("student_word_progress")
public class StudentWordProgress implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 学生单词学习进度ID
     */
    @Id(keyType = KeyType.Auto)
    private Long id;

    /**
     * 学生ID，关联 user_account.id
     */
    private Long studentId;

    /**
     * 单词ID，关联 word.id
     */
    private Long wordId;

    /**
     * 学习时所属班级ID
     */
    private Long classId;

    /**
     * 学习状态：NEW 未学，LEARNING 学习中，MASTERED 已掌握
     */
    private String status;

    /**
     * 已复习次数
     */
    private Integer reviewCount;

    /**
     * 答对次数
     */
    private Integer correctCount;

    /**
     * 答错次数
     */
    private Integer wrongCount;

    /**
     * SM-2 难度系数
     */
    private BigDecimal easeFactor;

    /**
     * 当前复习间隔天数
     */
    private Integer intervalDays;

    /**
     * 下次应复习日期
     */
    private Date nextReviewDate;

    /**
     * 最近一次学习或复习时间
     */
    private LocalDateTime lastStudiedAt;

    /**
     * 是否收藏：0 否，1 是
     */
    private Integer isFavorite;

    /**
     * 是否错题：0 否，1 是
     */
    private Integer isWrongWord;

    /**
     * 创建时间
     */
    private LocalDateTime createdAt;

    /**
     * 更新时间
     */
    private LocalDateTime updatedAt;
}
