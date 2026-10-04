package yfy.englishschoolmaster.model.dto.StudentReview;

import lombok.Data;

/**
 * 复习拼写作答请求：
 * 学生提交复习模式下的英文拼写，
 *       服务端比对拼写正误并更新复习进度
 */
@Data
public class StudentReviewSpellAnswerRequest {

    /**
     * 单词ID
     */
    private Long wordId;

    /**
     * 学生拼写的英文单词内容
     */
    private String spelledText;
}
