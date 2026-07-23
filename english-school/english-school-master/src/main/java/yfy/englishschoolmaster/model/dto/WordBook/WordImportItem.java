package yfy.englishschoolmaster.model.dto.WordBook;

import lombok.Data;

import java.util.List;

/**
 * 单词导入条目（全部手工录入，不调用机器翻译）：
 * 英文单词、音标、正确中文、3 个错误中文、英文例句、例句中文翻译。
 */
@Data
public class WordImportItem {

    /**
     * 英文单词，必填
     */
    private String wordText;

    /**
     * 音标，必填
     */
    private String phonetic;

    /**
     * 正确中文释义，必填
     */
    private String correctMeaning;

    /**
     * 3 个错误中文释义，必填
     */
    private List<String> wrongMeanings;

    /**
     * 英文例句，必填
     */
    private String exampleSentence;

    /**
     * 例句中文翻译，必填
     */
    private String exampleTranslation;
}
