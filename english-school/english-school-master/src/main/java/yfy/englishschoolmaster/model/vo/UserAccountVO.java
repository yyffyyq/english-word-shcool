package yfy.englishschoolmaster.model.vo;

import com.mybatisflex.annotation.Id;
import com.mybatisflex.annotation.KeyType;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;

/**
 * 封装用户信息类
 */
@Data
public class UserAccountVO implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 用户ID，系统内部唯一标识
     */
    @Id(keyType = KeyType.Auto)
    private Long id;

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
     * 微信 openid，仅未注册时返回，供前端引导注册
     */
    private String openid;
}
