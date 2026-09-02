package yfy.englishschoolmaster.model.vo;

import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * 学生今日作业中的单个单词 VO：
 * 学习页展示的待学单词信息，
 *       含进度状态与四选一选项（不含 isCorrect）
 */
@Data
public class StudentHomeworkWordVO implements Serializable {

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
     * 正确中文释义
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
     * 学习进度：NEW / LEARNING / MASTERED
     */
    private String progressStatus;

    /**
     * 答对次数（Redis 侧累计，过期前回写 DB）
     */
    private Integer correctCount;

    /**
     * 答错次数（Redis 侧累计，过期前回写 DB）
     */
    private Integer wrongCount;

    /**
     * 四选一选项（不含正确答案标记）
     */
    private List<StudentStudyOptionVO> options = new ArrayList<>();
}
