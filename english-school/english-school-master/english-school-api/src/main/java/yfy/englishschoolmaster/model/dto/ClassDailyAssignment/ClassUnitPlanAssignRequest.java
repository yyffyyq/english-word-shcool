package yfy.englishschoolmaster.model.dto.ClassDailyAssignment;

import lombok.Data;

/**
 * 按词书周次单元分配今日学习计划请求：
 * 将该词书指定周次、单元下的全部单词，
 *       只写入指定班级中在班学生的今日计划
 */
@Data
public class ClassUnitPlanAssignRequest {

    /**
     * 班级ID
     */
    private Long classId;

    /**
     * 词书ID
     */
    private Long bookId;

    /**
     * 周次，整数
     */
    private Integer week;

    /**
     * 单元序号，整数
     */
    private Integer unitName;
}
