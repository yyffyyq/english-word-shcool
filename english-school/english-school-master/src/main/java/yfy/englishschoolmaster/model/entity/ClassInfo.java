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
@Table("class_info")
public class ClassInfo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 班级ID
     */
    @Id(keyType = KeyType.Auto)
    private Long id;

    /**
     * 创建班级的教师ID，关联 user_account.id
     */
    private Long teacherId;

    /**
     * 班级名称，例如 三年级一班
     */
    private String className;

    /**
     * 年级名称，用于学生按年级筛选班级
     */
    private String grade;

    /**
     * 学校名称，用于班级筛选
     */
    private String schoolName;

    /**
     * 6位班级邀请码，用于学生快速加入
     */
    private String inviteCode;

    /**
     * 班级状态：ACTIVE 正常，DISABLED 停用
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
