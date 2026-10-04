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
 * 班级每日单词分配批次实体：
 * 对应 class_daily_assignment 表，
 *       记录某日某班级任务的单词分配汇总及批次状态
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table("class_daily_assignment")
public class ClassDailyAssignment implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 班级每日分配批次ID
     */
    @Id(keyType = KeyType.Auto)
    private Long id;

    /**
     * 班级学习任务ID，关联 class_word_task.id
     */
    private Long taskId;

    /**
     * 班级ID，关联 class_info.id
     */
    private Long classId;

    /**
     * 词书ID，关联 word_book.id
     */
    private Long bookId;

    /**
     * 学习日期（业务日）
     */
    private Date assignDate;

    /**
     * 计划分配单词数
     */
    private Integer plannedCount;

    /**
     * 实际分配单词数
     */
    private Integer actualCount;

    /**
     * 批次状态：SUCCESS 足额，PARTIAL 词不够，SKIPPED 无词可分，FAILED 失败
     */
    private String status;

    /**
     * 创建时间
     */
    private LocalDateTime createdAt;
}
