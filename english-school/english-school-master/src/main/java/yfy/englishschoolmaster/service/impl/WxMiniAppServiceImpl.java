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

    /**
     * 通过code 获取 用户登录信息
     * @param code 临时登录凭证
     * @return
     */
    @Override
    public WxSessionResult code2Session(String code) {
        // 1. 拿到微信小程序id和秘钥
        String appId = wxMiniAppProperties.getAppId();
        String appSecret = wxMiniAppProperties.getAppSecret();

        // 2. 判断参数是否正确
        if (StrUtil.hasBlank(appId, appSecret)) {
            throw new BusinessException(ErrorCode.SYSTEM_ERROR, "微信小程序配置缺失，请检查 appId 和 appSecret");
        }

        // 3. 构建请求体
        String url = StrUtil.format(CODE2SESSION_URL, appId, appSecret, code);
        String responseBody = HttpUtil.get(url);

        // 4. 调用并返回获取到的登录的微信用户信息
        WxSessionResult sessionResult = JSONUtil.toBean(responseBody, WxSessionResult.class);

        // 5. 判断返回响应体
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

        // 6. 返回登录微信用户信息
        return sessionResult;
    }
}
