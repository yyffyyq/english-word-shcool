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
 * 班级每日分配单词明细实体：
 * 对应 class_daily_assignment_word 表，
 *       记录某批次下分配到各学生的具体单词及排序
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table("class_daily_assignment_word")
public class ClassDailyAssignmentWord implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 班级每日分配单词明细ID
     */
    @Id(keyType = KeyType.Auto)
    private Long id;

    /**
     * 分配批次ID，关联 class_daily_assignment.id
     */
    private Long assignmentId;

    /**
     * 班级学习任务ID，关联 class_word_task.id
     */
    private Long taskId;

    /**
     * 单词ID，关联 word.id
     */
    private Long wordId;

    /**
     * 学习日期（业务日）
     */
    private Date assignDate;

    /**
     * 展示排序，从 1 开始
     */
    private Integer sortOrder;

    /**
     * 创建时间
     */
    private LocalDateTime createdAt;
}
