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
 *  实体类。
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table("class_student")
public class ClassStudent implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 班级学生关系ID
     */
    @Id(keyType = KeyType.Auto)
    private Long id;

    /**
     * 班级ID，关联 class_info.id
     */
    private Long classId;

    /**
     * 学生ID，关联 user_account.id
     */
    private Long studentId;

    /**
     * 加入班级时间
     */
    private LocalDateTime joinedAt;

    /**
     * 关系状态：IN_CLASS 在班，EXITED 已退出
     */
    private String status;

    /**
     * 退出班级时间
     */
    private LocalDateTime exitedAt;

    /**
     * 有效在班学生ID，用于限制一个学生只能加入一个当前班级
     */
    private Long activeStudentId;

}
