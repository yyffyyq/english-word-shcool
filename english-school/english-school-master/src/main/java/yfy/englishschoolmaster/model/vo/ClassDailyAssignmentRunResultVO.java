package yfy.englishschoolmaster.model.vo;

import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDate;

/**
 * 每日单词分配执行结果 VO：
 * 管理员手动触发分配任务后返回，
 *       汇总各批次创建、跳过及成功状态计数
 */
@Data
public class ClassDailyAssignmentRunResultVO implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 学习日期
     */
    private LocalDate assignDate;

    /**
     * 扫描到的生效任务数
     */
    private Integer taskCount;

    /**
     * 新创建的分配批次数
     */
    private Integer createdCount;

    /**
     * 因已存在而跳过的批次数
     */
    private Integer skippedExistCount;

    /**
     * 无词可分的批次数
     */
    private Integer skippedEmptyCount;

    /**
     * 足额成功批次数
     */
    private Integer successCount;

    /**
     * 词不够的部分成功批次数
     */
    private Integer partialCount;
}
