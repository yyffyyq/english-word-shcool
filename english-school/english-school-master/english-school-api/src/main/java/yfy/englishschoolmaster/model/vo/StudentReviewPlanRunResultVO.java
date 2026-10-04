package yfy.englishschoolmaster.model.vo;

import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDate;

/**
 * 复习计划生成结果 VO：
 * 管理员手动触发复习计划生成后返回，
 *       汇总各来源写入的复习词数量
 */
@Data
public class StudentReviewPlanRunResultVO implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 复习业务日
     */
    private LocalDate reviewDate;

    /**
     * 高频错题写入数
     */
    private Integer highWrongCount;

    /**
     * 次日必复写入数
     */
    private Integer day1FollowupCount;

    /**
     * 艾宾浩斯到期写入数
     */
    private Integer ebbinghausCount;

    /**
     * 实际新增/更新的复习明细条数
     */
    private Integer totalUpsertCount;
}
