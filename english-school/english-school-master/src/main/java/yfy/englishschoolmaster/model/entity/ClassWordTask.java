package yfy.englishschoolmaster.model.entity;

import com.mybatisflex.annotation.Id;
import com.mybatisflex.annotation.KeyType;
import com.mybatisflex.annotation.Table;
import java.io.Serializable;
import java.sql.Date;
import java.time.LocalDateTime;

import java.io.Serial;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 班级词书与每日学习规则表 实体类。
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table("class_word_task")
public class ClassWordTask implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 班级学习任务ID
     */
    @Id(keyType = KeyType.Auto)
    private Long id;

    /**
     * 班级ID，关联 class_info.id
     */
    private Long classId;

    /**
     * 词书ID，关联 word_book.id
     */
    private Long bookId;

    /**
     * 每日新学单词数量
     */
    private Integer dailyNewCount;

    /**
     * 任务开始日期，为空表示立即开始
     */
    private Date startDate;

    /**
     * 任务结束日期，为空表示长期有效
     */
    private Date endDate;

    /**
     * 任务状态：ACTIVE 生效，STOPPED 停止
     */
    private String status;

    /**
     * 创建任务的教师ID
     */
    private Long createdBy;

    /**
     * 创建时间
     */
    private LocalDateTime createdAt;

    /**
     * 更新时间
     */
    private LocalDateTime updatedAt;

}
