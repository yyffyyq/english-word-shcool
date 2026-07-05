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
 * 用户账号表，统一存管理员、教师、学生基础信息 实体类。
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table("user_account")
public class UserAccount implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 用户ID，系统内部唯一标识
     */
    @Id(keyType = KeyType.Auto)
    private Long id;

    /**
     * 微信小程序 openid，教师和学生微信登录使用
     */
    private String openid;

    /**
     * 管理员账号登录名，普通小程序用户可为空
     */
    private String username;

    /**
     * 管理员密码加密值，小程序用户可为空
     */
    private String passwordHash;

    /**
     * 用户角色：ADMIN 管理员，TEACHER 教师，STUDENT 学生
     */
    private String role;

    /**
     * 真实姓名，用于教师、学生资料展示
     */
    private String realName;

    /**
     * 所属学校名称，当前 MVP 可直接存学校文本
     */
    private String schoolName;

    /**
     * 学生学号，学生可选填写
     */
    private String studentNo;

    /**
     * 微信头像地址或用户头像地址
     */
    private String avatarUrl;

    /**
     * 账号状态：NORMAL 正常，DISABLED 禁用
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
