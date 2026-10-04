package yfy.englishschoolmaster.model.dto.ClassDailyAssignment;

import lombok.Data;

import java.time.LocalDate;

/**
 * 管理员手动触发每日单词分配请求：
 * 扫描所有 ACTIVE 任务，按每个学生的未完成进度结转并补足每日额度，
 *       写入 class_daily_assignment 及按学生明细
 */
@Data
public class ClassDailyAssignmentRunRequest {

    /**
     * 学习日期；为空时默认今天（Asia/Shanghai）
     */
    private LocalDate assignDate;
}
