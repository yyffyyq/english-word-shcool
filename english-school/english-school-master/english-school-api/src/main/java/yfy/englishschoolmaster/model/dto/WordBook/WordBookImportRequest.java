package yfy.englishschoolmaster.model.dto.WordBook;

import lombok.Data;

import java.util.List;

/**
 * 词书单词批量导入请求：
 * 向指定词书批量导入手工录入的单词，
 *       单次最多 50 条，同步写入 word 与 word_option
 */
@Data
public class WordBookImportRequest {

    /**
     * 所属周次，整数；可空，本批单词共用
     */
    private Integer week;

    /**
     * 所属单元序号，整数；可空，本批单词共用
     */
    private Integer unitName;

    /**
     * 待导入单词列表：
     * 单次最多 50 条，字段均需手工填写
     */
    private List<WordImportItem> words;
}
