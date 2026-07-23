package yfy.englishschoolmaster.model.dto.WordBook;

import lombok.Data;

/**
 * 词书创建请求
 */
@Data
public class WordBookAddRequest {

    /**
     * 词书名称，例如 小学英语三年级上册
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
}
