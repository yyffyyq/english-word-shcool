package yfy.englishschoolmaster.service;

/**
 * 阿里云 OSS 存储服务：
 * 负责将单词音频等文件上传至对象存储。
 */
public interface OssService {

    /**
     * 上传字节数组到 OSS：
     * 写入指定对象路径后返回公网访问地址。
     *
     * @param objectKey   对象路径，例如 audio/words/apple.mp3
     * @param content     文件内容
     * @param contentType MIME 类型，例如 audio/mpeg
     * @return 公网 URL
     */
    String uploadBytes(String objectKey, byte[] content, String contentType);
}
