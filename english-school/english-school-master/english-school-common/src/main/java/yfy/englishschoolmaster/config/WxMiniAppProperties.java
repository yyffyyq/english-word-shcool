package yfy.englishschoolmaster.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * 微信小程序配置
 */
@Data
@Component
@ConfigurationProperties(prefix = "wx.miniapp")
public class WxMiniAppProperties {

    /**
     * 小程序 AppID
     */
    private String appId;

    /**
     * 小程序 AppSecret
     */
    private String appSecret;
}
