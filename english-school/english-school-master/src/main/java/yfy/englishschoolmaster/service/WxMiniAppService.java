package yfy.englishschoolmaster.service;

import yfy.englishschoolmaster.model.dto.WxSessionResult;

/**
 * 微信小程序服务
 */
public interface WxMiniAppService {

    /**
     * 使用 wx.login() 返回的 code 换取 openid
     *
     * @param code 临时登录凭证
     * @return 微信会话信息
     */
    WxSessionResult code2Session(String code);
}
