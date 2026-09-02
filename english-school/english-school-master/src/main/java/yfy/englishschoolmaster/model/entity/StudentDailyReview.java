package yfy.englishschoolmaster.model.entity;

import com.mybatisflex.annotation.Id;
import com.mybatisflex.annotation.KeyType;
import com.mybatisflex.annotation.Table;
import java.io.Serial;
import java.io.Serializable;
import java.sql.Date;
import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 学生每日复习计划明细实体：
 * 对应 student_daily_review 表，
 *       记录每日待复习单词及进入原因、完成状态
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table("student_daily_review")
public class StudentDailyReview implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 复习明细ID
     */
    @Id(keyType = KeyType.Auto)
    private Long id;

    /**
     * 学生ID，关联 user_account.id
     */
    private Long studentId;

    /**
     * 复习时所属班级ID，关联 class_info.id
     */
    private Long classId;

    /**
     * 单词ID，关联 word.id
     */
    private Long wordId;

    /**
     * 复习日期（业务日）
     */
    private Date reviewDate;

    /**
     * 进入复习计划的原因：
     * HIGH_WRONG 前一日高频错题，DAY1_FOLLOWUP 新学词次日必复，EBBINGHAUS 艾宾浩斯间隔到期
     */
    private String reason;

    /**
     * 复习状态：PENDING 待复习，DONE 已完成
     */
    private String status;

    /**
     * 创建时间
     */
    private LocalDateTime createdAt;

    /**
     * 更新时间
     */
    private LocalDateTime updatedAt;
}
