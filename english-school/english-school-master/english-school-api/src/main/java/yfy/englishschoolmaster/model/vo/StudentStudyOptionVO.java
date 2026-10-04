package yfy.englishschoolmaster.model.vo;

import lombok.Data;

import java.io.Serial;
import java.io.Serializable;

/**
 * 学生端四选一选项 VO：
 * 出题时隐藏 isCorrect 字段，
 *       学生提交答案时回传选项 ID 判分
 */
@Data
public class StudentStudyOptionVO implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 选项ID，学生提交答案时回传此 ID
     */
    private Long id;

    /**
     * 中文选项内容
     */
    private String optionText;

    /**
     * 选项排序
     */
    private Integer sortOrder;
}
