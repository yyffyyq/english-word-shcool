package yfy.englishschoolmaster.model.dto.WordBook;

import lombok.Data;
import lombok.EqualsAndHashCode;
import yfy.englishschoolmaster.common.PageRequest;

/**
 * 词书内单词分页查询请求：
 * 查询指定词书下的单词列表，
 *       支持按英文单词、周次、单元序号筛选
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class WordBookWordQueryRequest extends PageRequest {

    /**
     * 英文单词，模糊查询
     */
    private String wordText;

    /**
     * 所属周次，精确匹配
     */
    private Integer week;

    /**
     * 所属单元序号，精确匹配
     */
    private Integer unitName;
}
