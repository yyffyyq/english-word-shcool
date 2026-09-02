package yfy.englishschoolmaster.model.entity;

import com.mybatisflex.annotation.Id;
import com.mybatisflex.annotation.KeyType;
import com.mybatisflex.annotation.Table;
import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 学生答题记录实体：
 * 对应 answer_record 表，
 *       记录学生新词学习与复习测验的作答明细
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table("answer_record")
public class AnswerRecord implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 答题记录ID
     */
    @Id(keyType = KeyType.Auto)
    private Long id;

    /**
     * 学生ID，关联 user_account.id
     */
    private Long studentId;

    /**
     * 单词ID，关联 word.id
     */
    private Long wordId;

    /**
     * 答题时所属班级ID，关联 class_info.id
     */
    private Long classId;

    /**
     * 答题类型：NEW 新词测验，REVIEW 复习测验
     */
    private String answerType;

    /**
     * 题型：CHOICE 四选一，SPELL 拼写
     */
    private String questionType;

    /**
     * 学生提交的答案（选项文本或拼写内容）
     */
    private String selectedAnswer;

    /**
     * 正确答案（正确中文释义或正确拼写）
     */
    private String correctAnswer;

    /**
     * 是否答对：0 否，1 是
     */
    private Integer isCorrect;

    /**
     * SM-2 算法质量评分，范围 0-5，供复习间隔计算预留
     */
    private Integer qualityScore;

    /**
     * 答题时间
     */
    private LocalDateTime answeredAt;
}
