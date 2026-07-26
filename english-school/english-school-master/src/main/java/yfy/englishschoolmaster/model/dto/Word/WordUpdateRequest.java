package yfy.englishschoolmaster.model.dto.Word;

import lombok.Data;

import java.util.List;

/**
 * 单词修改请求
 */
@Data
public class WordUpdateRequest {

    /**
     * 单词ID，必填
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
     * 3 个错误中文释义；传入时会整体覆盖四选一选项
     */
    private List<String> wrongMeanings;

    /**
     * 英文例句
     */
    private String exampleSentence;

    /**
     * 例句中文翻译
     */
    private String exampleTranslation;
}
