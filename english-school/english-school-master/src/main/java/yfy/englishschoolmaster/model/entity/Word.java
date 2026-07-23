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
 * 单词基础数据表 实体类（手工录入）。
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table("word")
public class Word implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 单词ID
     */
    @Id(keyType = KeyType.Auto)
    private Long id;

    /**
     * 英文单词内容
     */
    private String wordText;

    /**
     * 音标
     */
    private String phonetic;

    /**
     * 正确中文释义，学生答题判分依据
     */
    private String correctMeaning;

    /**
     * 英文例句
     */
    private String exampleSentence;

    /**
     * 例句中文翻译
     */
    private String exampleTranslation;

    /**
     * 创建时间
     */
    private LocalDateTime createdAt;

    /**
     * 更新时间
     */
    private LocalDateTime updatedAt;
}
