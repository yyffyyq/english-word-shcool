package yfy.englishschoolmaster.model.dto;

import lombok.Data;

import java.io.Serializable;

/**
 * Web 管理端登录请求：
 * 管理员使用账号密码登录后台，
 *       校验通过后返回 ADMIN 角色会话
 */
@Data
public class SystemLoginRequest implements Serializable {

    /**
     * 管理员账号
     */
    private String username;

    /**
     * 密码（明文，登录时会使用盐值加密后与 password_hash 比对）
     */
    private String password;
}
