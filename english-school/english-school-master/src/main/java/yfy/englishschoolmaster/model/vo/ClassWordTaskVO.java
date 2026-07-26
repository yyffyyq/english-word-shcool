package yfy.englishschoolmaster.model.vo;

import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * 班级词书任务 VO
 */
@Data
public class ClassWordTaskVO implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 班级学习任务ID
     */
    private Long id;

    /**
     * 班级ID
     */
    private Long classId;

    /**
     * 词书ID
     */
    private Long bookId;

    /**
     * 每日新学单词数量
     */
    private Integer dailyNewCount;

    /**
     * 任务开始日期
     */
    private LocalDate startDate;

    /**
     * 任务结束日期
     */
    private LocalDate endDate;

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
