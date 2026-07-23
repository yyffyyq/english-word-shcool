package yfy.englishschoolmaster.model.vo;

import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.List;

/**
 * 单词信息 VO（含四选一选项）
 */
@Data
public class WordVO implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 单词ID
     */
    private Long id;

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
     * 中文选项列表（1 正确 + 3 干扰）
     */
    private List<WordOptionVO> options;

    /**
     * 创建时间
     */
    private LocalDateTime createdAt;

    /**
     * 更新时间
     */
    private LocalDateTime updatedAt;
}
