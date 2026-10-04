package yfy.englishschoolmaster.model.dto.StudentStudy;

import lombok.Data;

/**
 * 单词学习状态修改请求：
 * 学生手动将单词标记为 LEARNING 或 MASTERED，
 *       更新 student_word_progress 表
 */
@Data
public class StudentWordStatusUpdateRequest {

    /**
     * 单词ID
     */
    private Long wordId;

    /**
     * 目标状态：LEARNING / MASTERED
     */
    private String status;
}
