package yfy.englishschoolmaster.model.vo;

import lombok.Data;

import java.io.Serial;
import java.io.Serializable;

/**
 * 学生答题结果 VO：
 * 新词学习或复习作答后返回，
 *       包含判分结果及更新后的学习进度状态
 */
@Data
public class StudentAnswerResultVO implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 是否答对
     */
    private Boolean correct;

    /**
     * 单词ID
     */
    private Long wordId;

    /**
     * 正确中文释义 / 正确拼写
     */
    private String correctAnswer;

    /**
     * 更新后的学习进度：NEW 未学，LEARNING 学习中，MASTERED 已掌握
     */
    private String progressStatus;
}
