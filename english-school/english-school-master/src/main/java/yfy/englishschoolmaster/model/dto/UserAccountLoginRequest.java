package yfy.englishschoolmaster.model.dto;

import lombok.Data;

import java.io.Serializable;

/**
 * 微信小程序登录请求类
 */
@Data
public class UserAccountLoginRequest implements Serializable {
    /**
     * wx.login() 返回的临时凭证，后端用它换取 openid
     */
    private String code;
    /**
     * 登录入口：TEACHER / STUDENT
     * MVP 一个微信只能有一种角色，查库时用 openid + role
     */
    private String loginRole;
}
