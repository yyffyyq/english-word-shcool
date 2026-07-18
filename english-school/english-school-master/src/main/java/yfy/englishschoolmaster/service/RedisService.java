package yfy.englishschoolmaster.service;


import yfy.englishschoolmaster.model.vo.UserAccountVO;

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

    // 延迟Redis中信息过期时间

}
