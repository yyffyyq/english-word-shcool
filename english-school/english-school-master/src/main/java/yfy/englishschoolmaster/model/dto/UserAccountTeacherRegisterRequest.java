package yfy.englishschoolmaster.model.dto;

import lombok.Data;

import java.io.Serializable;

/**
 * 微信小程序教师注册请求类
 */
@Data
public class UserAccountTeacherRegisterRequest implements Serializable {

    /**
     * 微信小程序 openid
     */
    private String openid;

    /**
     * 教师真实姓名
     */
    private String realName;

    /**
     * 所属学校名称
     */
    private String schoolName;
}
