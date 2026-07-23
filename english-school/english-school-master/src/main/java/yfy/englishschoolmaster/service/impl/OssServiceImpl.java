package yfy.englishschoolmaster.service.impl;

import cn.hutool.core.util.StrUtil;
import com.aliyun.oss.OSS;
import com.aliyun.oss.OSSClientBuilder;
import com.aliyun.oss.model.ObjectMetadata;
import com.aliyun.oss.model.PutObjectRequest;
import jakarta.annotation.PreDestroy;
import org.springframework.stereotype.Service;
import yfy.englishschoolmaster.config.AliyunProperties;
import yfy.englishschoolmaster.exception.ErrorCode;
import yfy.englishschoolmaster.exception.ThrowUtils;
import yfy.englishschoolmaster.service.OssService;

import java.io.ByteArrayInputStream;

/**
 * 阿里云 OSS 存储服务实现：
 * 懒加载 OSS 客户端，上传文件后返回公网访问地址。
 */
@Service
public class OssServiceImpl implements OssService {

    private final AliyunProperties aliyunProperties;
    private volatile OSS ossClient;

    public OssServiceImpl(AliyunProperties aliyunProperties) {
        this.aliyunProperties = aliyunProperties;
    }

    @Override
    public String uploadBytes(String objectKey, byte[] content, String contentType) {
        // 1. 参数与配置校验
        ThrowUtils.throwIf(StrUtil.isBlank(objectKey), ErrorCode.PARAMS_ERROR, "OSS 对象路径不能为空");
        ThrowUtils.throwIf(content == null || content.length == 0, ErrorCode.PARAMS_ERROR, "上传内容不能为空");

        AliyunProperties.Oss oss = aliyunProperties.getOss();
        ThrowUtils.throwIf(StrUtil.isBlank(aliyunProperties.getAccessKeyId())
                        || StrUtil.isBlank(aliyunProperties.getAccessKeySecret()),
                ErrorCode.SYSTEM_ERROR, "未配置阿里云 AccessKey");
        ThrowUtils.throwIf(StrUtil.isBlank(oss.getEndpoint()) || StrUtil.isBlank(oss.getBucketName()),
                ErrorCode.SYSTEM_ERROR, "未配置阿里云 OSS");

        // 2. 组装元数据并上传
        ObjectMetadata metadata = new ObjectMetadata();
        metadata.setContentLength(content.length);
        if (StrUtil.isNotBlank(contentType)) {
            metadata.setContentType(contentType);
        }

        PutObjectRequest putObjectRequest = new PutObjectRequest(
                oss.getBucketName(),
                objectKey,
                new ByteArrayInputStream(content),
                metadata
        );
        getClient().putObject(putObjectRequest);

        // 3. 返回公网访问地址
        return buildFileUrl(oss.getEndpoint(), oss.getBucketName(), objectKey);
    }

    private OSS getClient() {
        if (ossClient == null) {
            synchronized (this) {
                if (ossClient == null) {
                    ossClient = new OSSClientBuilder().build(
                            aliyunProperties.getOss().getEndpoint(),
                            aliyunProperties.getAccessKeyId(),
                            aliyunProperties.getAccessKeySecret()
                    );
                }
            }
        }
        return ossClient;
    }

    private static String buildFileUrl(String endpoint, String bucketName, String objectKey) {
        String host = endpoint.replace("https://", "").replace("http://", "");
        return "https://" + bucketName + "." + host + "/" + objectKey;
    }

    @PreDestroy
    public void destroy() {
        if (ossClient != null) {
            ossClient.shutdown();
        }
    }
}
