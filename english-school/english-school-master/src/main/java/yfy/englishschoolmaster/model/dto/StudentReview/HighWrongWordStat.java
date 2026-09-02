package yfy.englishschoolmaster.model.dto.StudentReview;

import lombok.Data;

/**
 * 前一日高频错题统计行：
 * 复习计划生成时按学生、单词聚合前日答错次数，
 *       用于筛选 HIGH_WRONG 复习候选词
 */
@Data
public class HighWrongWordStat {

    /**
     * 学生ID，关联 user_account.id
     */
    private Long studentId;

    /**
     * 单词ID，关联 word.id
     */
    private Long wordId;

    /**
     * 答题时所属班级ID，关联 class_info.id
     */
    private Long classId;

    /**
     * 前一日答错次数
     */
    private Integer wrongCount;
}
