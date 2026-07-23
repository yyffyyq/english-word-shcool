package yfy.englishschoolmaster.model.dto.WordBook;

import lombok.Data;

/**
 * 词书修改请求
 */
@Data
public class WordBookUpdateRequest {

    /**
     * 词书ID
     */
    private Long id;

    /**
     * 词书名称
     */
    private String bookName;

    /**
     * 词书说明
     */
    private String description;

    /**
     * 词书封面图片地址
     */
    private String coverUrl;

    /**
     * 词书状态：ACTIVE 启用，DISABLED 停用
     */
    private String status;
}
