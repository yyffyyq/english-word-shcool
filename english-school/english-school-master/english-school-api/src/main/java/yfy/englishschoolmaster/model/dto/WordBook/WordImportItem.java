package yfy.englishschoolmaster.model.dto.WordBook;

import lombok.Data;

import java.util.List;

/**
 * 单词导入条目 DTO：
 * 词书批量导入时的单条单词数据，
 *       全部手工录入，含 3 个错误中文释义
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
