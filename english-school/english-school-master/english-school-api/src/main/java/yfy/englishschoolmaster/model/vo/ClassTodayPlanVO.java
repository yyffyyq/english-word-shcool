package yfy.englishschoolmaster.model.vo;

import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDate;
import java.util.List;

/**
 * 班级今日学习计划：
 * 按班级返回当天已分配给在班学生的单词，相同单词只出现一次
 */
@Data
public class ClassTodayPlanVO implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 班级ID
     */
    private Long classId;

    /**
     * 学习日期，上海时区的今天
     */
    private LocalDate assignDate;

    /**
     * 今日单词数
     */
    private Integer wordCount;

    /**
     * 今日学习单词，按周次、单元、排序升序
     */
    private List<ClassTodayPlanWordVO> words;
}
