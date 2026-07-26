package yfy.englishschoolmaster.model.dto.WordBook;

import lombok.Data;
import lombok.EqualsAndHashCode;
import yfy.englishschoolmaster.common.PageRequest;

/**
 * 词书内单词分页查询请求
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class WordBookWordQueryRequest extends PageRequest {

    /**
     * 英文单词，模糊查询
     */
    private String wordText;

    /**
     * 所属单元名称，例如 Unit 1
     */
    private String unitName;
}
