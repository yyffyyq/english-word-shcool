package yfy.englishschoolmaster.model.vo;

import lombok.Data;

import java.io.Serial;
import java.io.Serializable;

/**
 * 班级今日学习计划中的单词
 */
@Data
public class ClassTodayPlanWordVO implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 单词ID
     */
    private Long wordId;

    /**
     * 英文单词
     */
    private String wordText;

    /**
     * 音标
     */
    private String phonetic;

    /**
     * 正确中文释义
     */
    private String correctMeaning;

    /**
     * 词书ID
     */
    private Long bookId;

    /**
     * 所属周次
     */
    private Integer week;

    /**
     * 所属单元序号
     */
    private Integer unitName;

    /**
     * 今日计划中的展示排序
     */
    private Integer sortOrder;
}
