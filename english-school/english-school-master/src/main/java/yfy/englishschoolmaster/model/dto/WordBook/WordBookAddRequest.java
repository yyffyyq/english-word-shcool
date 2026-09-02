package yfy.englishschoolmaster.model.dto.WordBook;

import lombok.Data;

/**
 * 词书创建请求：
 * 管理员新建词书并写入 word_book 表，
 *       初始状态为 ACTIVE
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
