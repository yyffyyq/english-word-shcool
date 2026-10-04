package yfy.englishschoolmaster.model.dto;

import lombok.Data;

import java.io.Serializable;

/**
 * 微信小程序学生注册请求：
 * 学生首次登录后提交姓名、学号，
 *       写入 user_account 表并创建 STUDENT 角色账号
 */
@Data
public class UserAccountStudentRegisterRequest implements Serializable {

    /**
     * 微信小程序 openid
     */
    private String openid;

    /**
     * 学生真实姓名
     */
    private String realName;

    /**
     * 学生学号
     */
    private String studentNo;
}
