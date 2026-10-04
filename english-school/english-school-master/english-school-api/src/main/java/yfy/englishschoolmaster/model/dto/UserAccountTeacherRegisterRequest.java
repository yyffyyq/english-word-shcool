package yfy.englishschoolmaster.model.dto;

import lombok.Data;

import java.io.Serializable;

/**
 * 微信小程序教师注册请求：
 * 教师首次登录后提交姓名、学校，
 *       生成教师审批记录写入 teacher_approval 表
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
