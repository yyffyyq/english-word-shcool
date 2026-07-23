package yfy.englishschoolmaster.manager;

import cn.hutool.core.util.StrUtil;
import com.alibaba.nls.client.AccessToken;
import com.alibaba.nls.client.protocol.NlsClient;
import com.alibaba.nls.client.protocol.OutputFormatEnum;
import com.alibaba.nls.client.protocol.SampleRateEnum;
import com.alibaba.nls.client.protocol.tts.SpeechSynthesizer;
import com.alibaba.nls.client.protocol.tts.SpeechSynthesizerListener;
import com.alibaba.nls.client.protocol.tts.SpeechSynthesizerResponse;
import jakarta.annotation.PreDestroy;
import org.springframework.stereotype.Component;
import yfy.englishschoolmaster.config.AliyunProperties;
import yfy.englishschoolmaster.exception.BusinessException;
import yfy.englishschoolmaster.exception.ErrorCode;
import yfy.englishschoolmaster.exception.ThrowUtils;

import java.io.ByteArrayOutputStream;
import java.nio.ByteBuffer;
import java.util.concurrent.atomic.AtomicReference;

/**
 * 阿里云 TTS 客户端：
 * 用于单词导入场景下将英文单词合成为 MP3 音频。
 */
@Component
public class AliyunTtsClient {

    private static final long TOKEN_REFRESH_AHEAD_SECONDS = 60L;

    private final AliyunProperties aliyunProperties;
    private final Object lock = new Object();
    private volatile NlsClient nlsClient;
    private volatile long tokenExpireEpochSeconds;

    public AliyunTtsClient(AliyunProperties aliyunProperties) {
        this.aliyunProperties = aliyunProperties;
    }

    /**
     * 英文语音合成：
     * 调用阿里云智能语音交互 TTS，返回 MP3 字节数组。
     *
     * @param englishText 英文单词或短句
     * @return MP3 字节数组
     */
    public byte[] synthesizeMp3(String englishText) {
        ThrowUtils.throwIf(StrUtil.isBlank(englishText), ErrorCode.PARAMS_ERROR, "TTS 文本不能为空");
        ThrowUtils.throwIf(StrUtil.isBlank(aliyunProperties.getTts().getAppKey()),
                ErrorCode.SYSTEM_ERROR, "未配置阿里云 TTS AppKey");

        ByteArrayOutputStream audioBuffer = new ByteArrayOutputStream();
        AtomicReference<String> failMessage = new AtomicReference<>();

        SpeechSynthesizer synthesizer = null;
        try {
            ensureClient();
            SpeechSynthesizerListener listener = new SpeechSynthesizerListener() {
                @Override
                public void onComplete(SpeechSynthesizerResponse response) {
                    // 合成完成，音频已在 onMessage 中收集
                }

                @Override
                public void onFail(SpeechSynthesizerResponse response) {
                    failMessage.set("status=" + response.getStatus() + ", text=" + response.getStatusText());
                }

                @Override
                public void onMessage(ByteBuffer message) {
                    byte[] bytes = new byte[message.remaining()];
                    message.get(bytes);
                    audioBuffer.write(bytes, 0, bytes.length);
                }
            };

            synthesizer = new SpeechSynthesizer(nlsClient, listener);
            synthesizer.setAppKey(aliyunProperties.getTts().getAppKey());
            synthesizer.setFormat(OutputFormatEnum.MP3);
            synthesizer.setSampleRate(SampleRateEnum.SAMPLE_RATE_16K);
            synthesizer.setVoice(aliyunProperties.getTts().getVoice());
            synthesizer.setText(englishText.trim());
            synthesizer.start();
            synthesizer.waitForComplete();

            ThrowUtils.throwIf(StrUtil.isNotBlank(failMessage.get()),
                    ErrorCode.OPERATION_ERROR, "TTS 合成失败: " + failMessage.get());
            ThrowUtils.throwIf(audioBuffer.size() == 0, ErrorCode.OPERATION_ERROR, "TTS 合成结果为空");
            return audioBuffer.toByteArray();
        } catch (BusinessException e) {
            throw e;
        } catch (Exception e) {
            throw new BusinessException(ErrorCode.OPERATION_ERROR, "TTS 合成异常: " + e.getMessage());
        } finally {
            if (synthesizer != null) {
                synthesizer.close();
            }
        }
    }

    private void ensureClient() throws Exception {
        long now = System.currentTimeMillis() / 1000;
        if (nlsClient != null && now < tokenExpireEpochSeconds - TOKEN_REFRESH_AHEAD_SECONDS) {
            return;
        }
        synchronized (lock) {
            now = System.currentTimeMillis() / 1000;
            if (nlsClient != null && now < tokenExpireEpochSeconds - TOKEN_REFRESH_AHEAD_SECONDS) {
                return;
            }
            ThrowUtils.throwIf(StrUtil.isBlank(aliyunProperties.getAccessKeyId())
                            || StrUtil.isBlank(aliyunProperties.getAccessKeySecret()),
                    ErrorCode.SYSTEM_ERROR, "未配置阿里云 AccessKey");

            if (nlsClient != null) {
                nlsClient.shutdown();
                nlsClient = null;
            }
            AccessToken accessToken = new AccessToken(
                    aliyunProperties.getAccessKeyId(),
                    aliyunProperties.getAccessKeySecret()
            );
            accessToken.apply();
            nlsClient = new NlsClient(aliyunProperties.getTts().getGatewayUrl(), accessToken.getToken());
            tokenExpireEpochSeconds = accessToken.getExpireTime();
        }
    }

    @PreDestroy
    public void destroy() {
        if (nlsClient != null) {
            nlsClient.shutdown();
        }
    }
}
