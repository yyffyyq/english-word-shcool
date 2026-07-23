package yfy.englishschoolmaster.service;


import java.time.Duration;

/**
 * Redis缓存获取以及读写的抽象服务
 */
public interface  RedisService {

    /**
     * 读取Redis中需要的key信息
     * @param id
     * @param type
     * @param <T>
     */
    <T> T read(String id, String type,Class<T> clazz);

    /**
     * 写入Redis中信息
     * @param value
     * @param ttl
     * @param type
     * @param id
     * @param <T>
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

    // 延迟Redis中信息过期时间

}
