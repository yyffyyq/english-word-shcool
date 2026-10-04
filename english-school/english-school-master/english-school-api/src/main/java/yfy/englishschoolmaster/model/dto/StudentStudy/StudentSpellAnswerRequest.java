package yfy.englishschoolmaster.model.dto.StudentStudy;

import lombok.Data;

/**
 * 新词学习拼写作答请求：
 * 学生提交今日作业中的英文拼写，
 *       服务端判分并更新学习进度
 */
@Data
public class StudentSpellAnswerRequest {

    /**
     * 单词ID
     */
    private Long wordId;

    /**
     * 学生拼写内容
     */
    private String spelledText;
}
