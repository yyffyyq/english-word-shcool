package yfy.englishschoolmaster.model.dto.WordBook;

import lombok.Data;

import java.util.List;

/**
 * 词书单词批量导入请求
 */
@Data
public class WordBookImportRequest {

    /**
     * 所属单元名称，例如 Unit 1；可空
     */
    private String unitName;

    /**
     * 待导入单词列表：
     * 单次最多 50 条，字段均需手工填写
     */
    private List<WordImportItem> words;
}
