package yfy.englishschoolmaster.service.impl;

import cn.hutool.core.util.StrUtil;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ScanOptions;
import org.springframework.stereotype.Service;
import yfy.englishschoolmaster.service.RedisService;

import java.time.Duration;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;
import java.util.concurrent.TimeUnit;

/**
 * Redis 缓存读写服务实现：
 * 基于 RedisTemplate 提供泛型读写，兼容 Jackson 反序列化类型转换。
 */
@Service
public class RedisServiceImpl implements RedisService {

    @Autowired
    private RedisTemplate<String, Object> redisTemplate;

    @Autowired
    private ObjectMapper objectMapper;

    /** 实现 Redis 泛型读操作 */
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

    /** 实现 Redis 写入，key 格式 type:id */
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

    /** 实现 Redis key 删除 */
    @Override
    public boolean delete(String id, String type) {
        // 1. 判断参数是否为空
        if (StrUtil.isEmpty(type) || StrUtil.isEmpty(id)) {
            return false;
        }

        // 2. 删除对应 key
        return Boolean.TRUE.equals(redisTemplate.delete(buildKey(type, id)));
    }

    /** 实现过期时间查询：key 不存在或无 TTL 返回 null */
    @Override
    public Duration getExpire(String id, String type) {
        if (StrUtil.isEmpty(type) || StrUtil.isEmpty(id)) {
            return null;
        }
        Long seconds = redisTemplate.getExpire(buildKey(type, id), TimeUnit.SECONDS);
        if (seconds == null || seconds < 0) {
            return null;
        }
        return Duration.ofSeconds(seconds);
    }

    /** 扫描指定 type 前缀下的全部业务 id（key 格式 type:id） */
    @Override
    public Set<String> listIdsByType(String type) {
        if (StrUtil.isEmpty(type)) {
            return Collections.emptySet();
        }
        String pattern = type + ":*";
        Set<String> ids = new HashSet<>();
        ScanOptions options = ScanOptions.scanOptions().match(pattern).count(200).build();
        try (var cursor = redisTemplate.scan(options)) {
            while (cursor.hasNext()) {
                String key = cursor.next();
                if (StrUtil.isBlank(key) || !key.startsWith(type + ":")) {
                    continue;
                }
                ids.add(key.substring(type.length() + 1));
            }
        }
        return ids;
    }

    /**
     * 构建 redis key：type:id
     */
    private String buildKey(String type, String id) {
        return type + ":" + id;
    }
}
