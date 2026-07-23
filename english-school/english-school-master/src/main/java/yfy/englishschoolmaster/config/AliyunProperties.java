package yfy.englishschoolmaster.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * 阿里云通用配置：
 * OSS、TTS 共用 AccessKey。
 */
@Data
@Component
@ConfigurationProperties(prefix = "aliyun")
public class AliyunProperties {

    /**
     * AccessKey ID
     */
    private String accessKeyId;

    /**
     * AccessKey Secret
     */
    private String accessKeySecret;

    /**
     * 对象存储 OSS 配置
     */
    private Oss oss = new Oss();

    /**
     * 语音合成 TTS 配置
     */
    private Tts tts = new Tts();

    @Data
    public static class Oss {
        /**
         * Endpoint，例如 https://oss-cn-hangzhou.aliyuncs.com
         */
        private String endpoint;

        /**
         * Bucket 名称
         */
        private String bucketName;
    }

    @Data
    public static class Tts {
        /**
         * 智能语音交互项目 AppKey
         */
        private String appKey;

        /**
         * NLS WebSocket 网关，默认上海
         */
        private String gatewayUrl = "wss://nls-gateway-cn-shanghai.aliyuncs.com/ws/v1";

        /**
         * 英文发音人，例如 Betty / Luca / Harry
         */
        private String voice = "Betty";
    }
}
