package yfy.englishschoolmaster.model.vo;

import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * 词书信息 VO
 */
@Data
public class WordBookVO implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

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
     * 词书单词总数
     */
    private Integer wordCount;

    /**
     * 词书状态：ACTIVE 启用，DISABLED 停用
     */
    private String status;

    /**
     * 创建时间
     */
    private LocalDateTime createdAt;

    /**
     * 更新时间
     */
    private LocalDateTime updatedAt;
}
