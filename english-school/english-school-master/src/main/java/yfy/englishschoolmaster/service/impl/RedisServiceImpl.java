package yfy.englishschoolmaster.service.impl;

import cn.hutool.core.util.StrUtil;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import yfy.englishschoolmaster.service.RedisService;

import java.time.Duration;

@Service
public class RedisServiceImpl implements RedisService {

    @Autowired
    private RedisTemplate<String, Object> redisTemplate;

    @Autowired
    private ObjectMapper objectMapper;

    /**
     * 泛型 redis 读操作。
     * 注意：Jackson 反序列化后 value 经常是 LinkedHashMap，不能只用 isInstance 判断。
     *
     * @param id    业务编号（如邀请码）
     * @param type  key 前缀类型
     * @param clazz 期望转换的目标类型
     * @return 转换后的对象，未命中返回 null
     */
    @Override
    public <T> T read(String id, String type, Class<T> clazz) {
        // 1. 判断参数是否为空
        if (StrUtil.isEmpty(type) || StrUtil.isEmpty(id) || clazz == null) {
            return null;
        }

        // 2. 获取 redis 中的信息
        Object value = redisTemplate.opsForValue().get(buildKey(type, id));
        if (value == null) {
            return null;
        }

        // 3. 类型已匹配则直接返回
        if (clazz.isInstance(value)) {
            return clazz.cast(value);
        }

        // 4. LinkedHashMap / 其它 JSON 结构 → 转成目标类型
        return objectMapper.convertValue(value, clazz);
    }

    /**
     * 写入 Redis 中信息
     *
     * @param value 存入的值
     * @param ttl   过期时间
     * @param type  存入类型
     * @param id    编号(用于查找)
     */
    @Override
    public <T> void write(T value, Duration ttl, String type, String id) {
        // 1. 判断参数是否为空
        if (value == null || ttl == null || StrUtil.isEmpty(type) || StrUtil.isEmpty(id)) {
            return;
        }

        // 2. 创建 key 用于检索 redis 中信息
        String key = buildKey(type, id);

        // 3. 设置并存入 redis 中
        redisTemplate.opsForValue().set(key, value, ttl);
    }

    /**
     * 构建 redis key：type:id
     */
    private String buildKey(String type, String id) {
        return type + ":" + id;
    }
}
