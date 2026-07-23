package yfy.englishschoolmaster.model.entity;

import com.mybatisflex.annotation.Id;
import com.mybatisflex.annotation.KeyType;
import com.mybatisflex.annotation.Table;
import java.io.Serializable;
import java.time.LocalDateTime;

import java.io.Serial;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 平台内置词书表 实体类。
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table("word_book")
public class WordBook implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 词书ID
     */
    @Id(keyType = KeyType.Auto)
    private Long id;

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

    /**
     * 词书单词总数，便于列表展示
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
