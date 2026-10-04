package yfy.englishschoolmaster.model.vo;

import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * 复习单词 VO：
 * 学生复习页展示的单个单词信息，
 *       含进入原因与四选一选项（不含 isCorrect）
 */
@Data
public class StudentReviewWordVO implements Serializable {

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
     * 正确中文释义（拼写题判分依据，前端可按需隐藏）
     */
    private String correctMeaning;

    /**
     * 英文例句
     */
    private String exampleSentence;

    /**
     * 例句中文翻译
     */
    private String exampleTranslation;

    /**
     * 进入复习计划的原因：
     * HIGH_WRONG 前一日高频错题，DAY1_FOLLOWUP 新学词次日必复，EBBINGHAUS 艾宾浩斯间隔到期
     */
    private String reason;

    /**
     * 当前学习进度：NEW 未学，LEARNING 学习中，MASTERED 已掌握
     */
    private String progressStatus;

    /**
     * 四选一选项列表（不含正确答案标记）
     */
    private List<StudentStudyOptionVO> options = new ArrayList<>();
}
