package yfy.englishschoolmaster.service.impl;

import cn.hutool.core.util.StrUtil;
import cn.hutool.http.HttpUtil;
import cn.hutool.json.JSONUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import yfy.englishschoolmaster.config.WxMiniAppProperties;
import yfy.englishschoolmaster.exception.BusinessException;
import yfy.englishschoolmaster.exception.ErrorCode;
import yfy.englishschoolmaster.model.dto.WxSessionResult;
import yfy.englishschoolmaster.service.WxMiniAppService;

/**
 * 微信小程序服务实现
 */
@Service
public class WxMiniAppServiceImpl implements WxMiniAppService {

    private static final String CODE2SESSION_URL =
            "https://api.weixin.qq.com/sns/jscode2session?appid={}&secret={}&js_code={}&grant_type=authorization_code";

    @Autowired
    private WxMiniAppProperties wxMiniAppProperties;

    @Override
    public WxSessionResult code2Session(String code) {
        String appId = wxMiniAppProperties.getAppId();
        String appSecret = wxMiniAppProperties.getAppSecret();
        if (StrUtil.hasBlank(appId, appSecret)) {
            throw new BusinessException(ErrorCode.SYSTEM_ERROR, "微信小程序配置缺失，请检查 appId 和 appSecret");
        }

        String url = StrUtil.format(CODE2SESSION_URL, appId, appSecret, code);
        String responseBody = HttpUtil.get(url);
        WxSessionResult sessionResult = JSONUtil.toBean(responseBody, WxSessionResult.class);

        if (sessionResult == null) {
            throw new BusinessException(ErrorCode.SYSTEM_ERROR, "微信登录失败，响应为空");
        }
        if (sessionResult.getErrcode() != null && sessionResult.getErrcode() != 0) {
            throw new BusinessException(ErrorCode.OPERATION_ERROR,
                    "微信登录失败：" + sessionResult.getErrmsg());
        }
        if (StrUtil.isBlank(sessionResult.getOpenid())) {
            throw new BusinessException(ErrorCode.OPERATION_ERROR, "微信登录失败，未获取到 openid");
        }
        return sessionResult;
    }
}
