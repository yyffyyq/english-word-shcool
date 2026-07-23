package yfy.englishschoolmaster.model.dto.WordBook;

import lombok.Data;
import lombok.EqualsAndHashCode;
import yfy.englishschoolmaster.common.PageRequest;

/**
 * 词书分页查询请求
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class WordBookQueryRequest extends PageRequest {

    /**
     * 词书名称，模糊查询
     */
    private String bookName;

    /**
     * 词书状态：ACTIVE / DISABLED
     */
    private String status;
}
