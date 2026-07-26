package yfy.englishschoolmaster.model.dto.ClassWordTask;

import lombok.Data;

import java.time.LocalDate;

/**
 * 班级绑定词书请求
 */
@Data
public class ClassWordTaskBindRequest {

    /**
     * 班级ID
     */
    private Long classId;

    /**
     * 词书ID
     */
    private Long bookId;

    /**
     * 每日新学单词数量，为空时默认 10
     */
    private Integer dailyNewCount;

    /**
     * 任务开始日期，为空表示立即开始
     */
    private LocalDate startDate;

    /**
     * 任务结束日期，为空表示长期有效
     */
    private LocalDate endDate;
}
