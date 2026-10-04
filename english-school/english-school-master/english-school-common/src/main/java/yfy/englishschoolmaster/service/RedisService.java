package yfy.englishschoolmaster.service;


import java.time.Duration;
import java.util.Set;

/**
 * Redis 缓存读写服务：
 * 统一 key 格式为 type:id，提供泛型读写、删除、过期查询与扫描能力。
 */
public interface  RedisService {

    /**
     * 读取 Redis 缓存：
     * 支持 Jackson 反序列化后的 LinkedHashMap 自动转换为目标类型
     *
     * @param id    业务编号（如邀请码、用户 ID）
     * @param type  key 前缀类型
     * @param clazz 期望转换的目标类型
     * @param <T>   返回值泛型
     * @return 转换后的对象，未命中或参数无效时返回 null
     */
    <T> T read(String id, String type,Class<T> clazz);

    /**
     * 写入 Redis 缓存：
     * key 格式为 type:id，并设置过期时间
     *
     * @param value 存入的值
     * @param ttl   过期时间
     * @param type  key 前缀类型
     * @param id    业务编号
     * @param <T>   值类型泛型
     */
    <T> void write( T value, Duration ttl, String type, String id);

    /**
     * 删除 Redis 中指定 key
     *
     * @param id   业务编号（如邀请码）
     * @param type key 前缀类型
     * @return 是否删除成功（key 不存在也返回 false）
     */
    boolean delete(String id, String type);

    /**
     * 获取 key 剩余过期时间；不存在或无 TTL 返回 null
     *
     * @param id   业务编号
     * @param type key 前缀类型
     * @return 剩余 TTL
     */
    Duration getExpire(String id, String type);

    /**
     * 扫描指定前缀类型下的全部业务 id（key 格式 type:id）
     *
     * @param type key 前缀类型
     * @return 业务 id 集合
     */
    Set<String> listIdsByType(String type);

}
