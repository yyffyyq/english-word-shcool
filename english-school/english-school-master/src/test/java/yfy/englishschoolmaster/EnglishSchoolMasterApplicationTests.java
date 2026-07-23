package yfy.englishschoolmaster;

import com.aliyun.oss.OSS;
import com.aliyun.oss.OSSClientBuilder;
import com.aliyun.oss.model.PutObjectRequest;
import com.aliyun.oss.model.PutObjectResult;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

import java.io.ByteArrayInputStream;
import java.nio.charset.StandardCharsets;

/**
 * 阿里云 OSS 连通性测试。
 * <p>
 * 使用前请先填写下方 【需要你手动填写】 的配置项，
 * 填写来源见类末尾注释「配置去哪里找」。
 * <p>
 * 注意：本测试不启动 Spring，避免依赖本机 MySQL/Redis。
 * AccessKey 属于敏感信息，测完后请勿提交到 Git。
 */
class EnglishSchoolMasterApplicationTests {

    // ========================= 【需要你手动填写】 =========================

    /**
     * Endpoint（地域节点），例如：https://oss-cn-hangzhou.aliyuncs.com
     * 不要带 bucket 名称。
     */
    private static final String ENDPOINT = "";

    /**
     * AccessKey ID
     */
    private static final String ACCESS_KEY_ID = "";

    /**
     * AccessKey Secret
     */
    private static final String ACCESS_KEY_SECRET = "";

    /**
     * Bucket 名称（你在 OSS 控制台创建的存储空间名）
     */
    private static final String BUCKET_NAME = "";

    /**
     * 可选：对象在 Bucket 中的路径/文件名。
     * 例如：test/hello.txt
     */
    private static final String OBJECT_KEY = "test/hello.txt";

    // ====================================================================

    @Test
    void contextLoads() {
        // Spring 上下文冒烟测试（需要本机 MySQL/Redis 时再单独加 @SpringBootTest）
    }

    /**
     * 上传一段文本内容到 OSS，并打印可访问地址。
     */
    @Test
    void testOssUpload() {
        Assertions.assertFalse(ENDPOINT.isBlank(), "请先填写 ENDPOINT");
        Assertions.assertFalse(ACCESS_KEY_ID.isBlank(), "请先填写 ACCESS_KEY_ID");
        Assertions.assertFalse(ACCESS_KEY_SECRET.isBlank(), "请先填写 ACCESS_KEY_SECRET");
        Assertions.assertFalse(BUCKET_NAME.isBlank(), "请先填写 BUCKET_NAME");

        OSS ossClient = new OSSClientBuilder().build(ENDPOINT, ACCESS_KEY_ID, ACCESS_KEY_SECRET);
        try {
            byte[] content = "hello english-school oss".getBytes(StandardCharsets.UTF_8);
            PutObjectRequest putObjectRequest = new PutObjectRequest(
                    BUCKET_NAME,
                    OBJECT_KEY,
                    new ByteArrayInputStream(content)
            );
            PutObjectResult result = ossClient.putObject(putObjectRequest);

            Assertions.assertNotNull(result);
            Assertions.assertNotNull(result.getETag());

            // 公网访问地址（Bucket 需为公共读，或后续改用签名 URL）
            String fileUrl = buildFileUrl(ENDPOINT, BUCKET_NAME, OBJECT_KEY);
            System.out.println("OSS 上传成功");
            System.out.println("ETag = " + result.getETag());
            System.out.println("文件地址 = " + fileUrl);
        } finally {
            ossClient.shutdown();
        }
    }

    /**
     * 删除刚才上传的测试文件（可选，确认上传成功后再跑）。
     */
    @Test
    void testOssDelete() {
        Assertions.assertFalse(ENDPOINT.isBlank(), "请先填写 ENDPOINT");
        Assertions.assertFalse(ACCESS_KEY_ID.isBlank(), "请先填写 ACCESS_KEY_ID");
        Assertions.assertFalse(ACCESS_KEY_SECRET.isBlank(), "请先填写 ACCESS_KEY_SECRET");
        Assertions.assertFalse(BUCKET_NAME.isBlank(), "请先填写 BUCKET_NAME");

        OSS ossClient = new OSSClientBuilder().build(ENDPOINT, ACCESS_KEY_ID, ACCESS_KEY_SECRET);
        try {
            ossClient.deleteObject(BUCKET_NAME, OBJECT_KEY);
            System.out.println("OSS 删除成功: " + OBJECT_KEY);
        } finally {
            ossClient.shutdown();
        }
    }

    private static String buildFileUrl(String endpoint, String bucketName, String objectKey) {
        String host = endpoint.replace("https://", "").replace("http://", "");
        return "https://" + bucketName + "." + host + "/" + objectKey;
    }
}

/*
 * ======================== 配置去哪里找 ========================
 *
 * 1）ENDPOINT（地域节点）
 *    - 打开：阿里云控制台 → 对象存储 OSS → 你的 Bucket → 概览
 *    - 查看「访问端口 / Endpoint」中的「外网访问」
 *    - 示例：https://oss-cn-hangzhou.aliyuncs.com（杭州）
 *    - 文档：https://help.aliyun.com/zh/oss/user-guide/regions-and-endpoints
 *
 * 2）ACCESS_KEY_ID / ACCESS_KEY_SECRET
 *    - 打开：阿里云控制台右上角头像 → AccessKey 管理
 *    - 或直接访问：https://ram.console.aliyun.com/manage/ak
 *    - 建议创建「RAM 子用户」，只授予 OSS 权限，不要用主账号长期 Key
 *    - 创建后只能看到一次 Secret，请立刻复制保存
 *
 * 3）BUCKET_NAME
 *    - 打开：阿里云控制台 → 对象存储 OSS → Bucket 列表
 *    - 若还没有：点击「创建 Bucket」
 *      · 读写权限：测试阶段可选「公共读」（正式环境建议私有 + 签名 URL）
 *      · 地域：与 Endpoint 保持一致（如杭州 → oss-cn-hangzhou）
 *
 * 4）OBJECT_KEY
 *    - 可自定义，表示文件在 Bucket 里的路径，例如 test/hello.txt
 *
 * 5）Maven 依赖
 *    - 已在 pom.xml 加入 aliyun-sdk-oss:3.18.5
 *    - 填写配置后，在 IDE 中右键运行 testOssUpload 即可
 *
 * ============================================================
 */
