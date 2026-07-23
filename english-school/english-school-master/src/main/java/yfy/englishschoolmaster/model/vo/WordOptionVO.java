package yfy.englishschoolmaster.model.vo;

import lombok.Data;

import java.io.Serial;
import java.io.Serializable;

/**
 * 单词中文选项 VO：
 * 管理端可返回 isCorrect；学生端出题时应隐藏该字段。
 */
@Data
public class WordOptionVO implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 选项ID，学生提交答案时回传此 ID 判分
     */
    private Long id;

    /**
     * 中文选项内容
     */
    private String optionText;

    /**
     * 是否正确答案：1 正确，0 错误
     */
    private Integer isCorrect;

    /**
     * 选项排序
     */
    private Integer sortOrder;
}
