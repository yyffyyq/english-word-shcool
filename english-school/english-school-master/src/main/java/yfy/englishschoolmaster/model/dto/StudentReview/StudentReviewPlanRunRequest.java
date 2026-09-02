package yfy.englishschoolmaster.model.dto.StudentReview;

import lombok.Data;

import java.time.LocalDate;

/**
 * 管理员手动触发生成复习计划请求：
 * 按 HIGH_WRONG、DAY1_FOLLOWUP、EBBINGHAUS 规则
 *       生成当日复习明细写入 student_daily_review 表
 */
@Data
public class StudentReviewPlanRunRequest {

    /**
     * 复习日；为空默认今天
     */
    private LocalDate reviewDate;
}
