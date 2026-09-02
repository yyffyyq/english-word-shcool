package yfy.englishschoolmaster.model.dto.StudentStudy;

import lombok.Data;

/**
 * 新词学习四选一作答请求：
 * 学生提交今日作业中所选中文选项，
 *       服务端判分并更新学习进度
 */
@Data
public class StudentChoiceAnswerRequest {

    /**
     * 单词ID
     */
    private Long wordId;

    /**
     * 所选选项ID
     */
    private Long optionId;
}
