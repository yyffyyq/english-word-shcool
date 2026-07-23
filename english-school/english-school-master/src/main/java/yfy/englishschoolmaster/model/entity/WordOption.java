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
import java.time.LocalDateTime;

/**
 * 单词中文选项表 实体类：
 * 每个单词包含 1 个正确项（isCorrect=1）与 3 个干扰项（isCorrect=0）。
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table("word_option")
public class WordOption implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 单词选项ID
     */
    @Id(keyType = KeyType.Auto)
    private Long id;

    /**
     * 单词ID，关联 word.id
     */
    private Long wordId;

    /**
     * 中文选项内容
     */
    private String optionText;

    /**
     * 是否正确答案：1 正确，0 错误（干扰项）
     */
    private Integer isCorrect;

    /**
     * 选项排序；导入时写入，出题时可打乱
     */
    private Integer sortOrder;

    /**
     * 创建时间
     */
    private LocalDateTime createdAt;

    /**
     * 更新时间
     */
    private LocalDateTime updatedAt;
}
