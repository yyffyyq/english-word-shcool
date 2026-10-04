package yfy.englishschoolmaster.config;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.cache.RedisCacheConfiguration;
import org.springframework.data.redis.cache.RedisCacheManager;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.Jackson2JsonRedisSerializer;
import org.springframework.data.redis.serializer.RedisSerializationContext;
import org.springframework.data.redis.serializer.StringRedisSerializer;

import java.time.Duration;

/**
 * Redis 配置类：
 * 统一配置 RedisTemplate 与缓存管理器，
 *       默认缓存过期时间为 1 小时
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
@Configuration
@EnableCaching
public class RedisConfig {

    /**
     * 默认缓存过期时间：
     *       1 小时
     */
    public static final Duration DEFAULT_EXPIRE = Duration.ofHours(1);

    /**
     * 配置 RedisTemplate：
     * Key 使用 String 序列化，
     *       Value 使用 Jackson JSON 序列化
     * @param connectionFactory
     * @param objectMapper
     * @return
     */
    @Bean
    public RedisTemplate<String, Object> redisTemplate(RedisConnectionFactory connectionFactory,
                                                       ObjectMapper objectMapper) {

        // 1. 创建 RedisTemplate 并设置连接工厂
        RedisTemplate<String, Object> redisTemplate = new RedisTemplate<>();
        redisTemplate.setConnectionFactory(connectionFactory);

        // 2. 配置 Key 与 Value 序列化方式
        StringRedisSerializer stringSerializer = new StringRedisSerializer();
        Jackson2JsonRedisSerializer<Object> jsonSerializer = new Jackson2JsonRedisSerializer<>(objectMapper, Object.class);

        // 3. 应用序列化配置
        redisTemplate.setKeySerializer(stringSerializer);
        redisTemplate.setHashKeySerializer(stringSerializer);
        redisTemplate.setValueSerializer(jsonSerializer);
        redisTemplate.setHashValueSerializer(jsonSerializer);
        redisTemplate.afterPropertiesSet();

        // 4. 返回 RedisTemplate
        return redisTemplate;
    }

    /**
     * 配置 Redis 缓存管理器：
     * 默认缓存过期时间为 1 小时，
     *       不缓存空值
     * @param connectionFactory
     * @param objectMapper
     * @return
     */
    @Bean
    public RedisCacheManager cacheManager(RedisConnectionFactory connectionFactory,
                                          ObjectMapper objectMapper) {

        // 1. 配置 Value 序列化方式
        Jackson2JsonRedisSerializer<Object> jsonSerializer = new Jackson2JsonRedisSerializer<>(objectMapper, Object.class);

        // 2. 构建默认缓存配置
        RedisCacheConfiguration cacheConfiguration = RedisCacheConfiguration.defaultCacheConfig()
                .entryTtl(DEFAULT_EXPIRE)
                .serializeKeysWith(RedisSerializationContext.SerializationPair.fromSerializer(new StringRedisSerializer()))
                .serializeValuesWith(RedisSerializationContext.SerializationPair.fromSerializer(jsonSerializer))
                .disableCachingNullValues();

        // 3. 创建并返回缓存管理器
        return RedisCacheManager.builder(connectionFactory)
                .cacheDefaults(cacheConfiguration)
                .build();
    }
}
