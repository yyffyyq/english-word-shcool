package yfy.englishschoolmaster.model.dto;

import lombok.Data;

import java.io.Serializable;

/**
 * Web 管理端登录请求
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
