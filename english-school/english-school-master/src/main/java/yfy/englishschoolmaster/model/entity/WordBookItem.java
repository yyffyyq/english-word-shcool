package yfy.englishschoolmaster.model.entity;

import com.mybatisflex.annotation.Id;
import com.mybatisflex.annotation.KeyType;
import com.mybatisflex.annotation.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serial;
import java.io.Serializable;

/**
 * 词书与单词关系表 实体类。
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table("word_book_item")
public class WordBookItem implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 词书单词关系ID
     */
    @Id(keyType = KeyType.Auto)
    private Long id;

    /**
     * 词书ID，关联 word_book.id
     */
    private Long bookId;

    /**
     * 单词ID，关联 word.id
     */
    private Long wordId;

    /**
     * 单词在词书中的排序
     */
    private Integer sortOrder;

    /**
     * 所属单元名称，例如 Unit 1
     */
    private String unitName;
}
