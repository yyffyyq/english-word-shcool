package yfy.englishschoolmaster.model.dto;

import lombok.Data;

import java.io.Serializable;

/**
 * Web 管理端注册请求
 */
@Data
public class SystemRegisterRequest implements Serializable {

    /**
     * 管理员账号
     */
    private String username;

    /**
     * 明文密码，入库前会加盐加密
     */
    private String password;

    /**
     * 真实姓名
     */
    private String realName;

    /**
     * 所属学校名称
     */
    private String schoolName;
}
