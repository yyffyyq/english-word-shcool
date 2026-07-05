package yfy.englishschoolmaster.model.dto;

import lombok.Data;

import java.io.Serializable;

/**
 * 微信 jscode2session 接口返回结果
 */
@Data
public class WxSessionResult implements Serializable {

    /**
     * 用户在该小程序下的唯一标识
     */
    private String openid;

    /**
     * 会话密钥
     */
    private String sessionKey;

    /**
     * 开放平台统一标识，可能为空
     */
    private String unionid;

    /**
     * 错误码，成功时为 null 或 0
     */
    private Integer errcode;

    /**
     * 错误信息
     */
    private String errmsg;
}
