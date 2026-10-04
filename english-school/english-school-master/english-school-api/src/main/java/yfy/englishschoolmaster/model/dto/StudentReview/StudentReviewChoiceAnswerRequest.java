package yfy.englishschoolmaster.model.dto.StudentReview;

import lombok.Data;

/**
 * 复习四选一作答请求：
 * 学生提交复习模式下所选中文选项，
 *       服务端比对选项正误并更新复习进度
 */
@Data
public class StudentReviewChoiceAnswerRequest {

    /**
     * 单词ID
     */
    private Long wordId;

    /**
     * 所选选项ID，关联 word_option.id
     */
    private Long optionId;
}
