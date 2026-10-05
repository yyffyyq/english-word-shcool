package yfy.englishschoolmaster.model.vo;

import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDate;

/**
 * 按词书周次单元分配今日学习计划的结果：
 * 汇总命中的单词数、班级数、学生数，以及新写入的计划明细数
 */
@Data
public class ClassUnitPlanAssignResultVO implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 学习日期，上海时区的今天
     */
    private LocalDate assignDate;

    /**
     * 班级ID
     */
    private Long classId;

    /**
     * 词书ID
     */
    private Long bookId;

    /**
     * 周次
     */
    private Integer week;

    /**
     * 单元序号
     */
    private Integer unitName;

    /**
     * 该周次单元下的单词数
     */
    private Integer wordCount;

    /**
     * 实际写入计划的班级数
     */
    private Integer classCount;

    /**
     * 实际写入计划的学生数
     */
    private Integer studentCount;

    /**
     * 新追加的学生计划明细条数；已在今日计划中的单词不重复写入
     */
    private Integer addedCount;
}
