package yfy.englishschoolmaster.service.impl;

import cn.hutool.core.util.RandomUtil;
import cn.hutool.core.util.StrUtil;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import yfy.englishschoolmaster.constant.UserConstant;
import yfy.englishschoolmaster.model.vo.UserAccountVO;
import yfy.englishschoolmaster.service.UserSessionRedisService;

import java.time.Duration;
import java.util.concurrent.TimeUnit;

/**
 * 用户登录会话 Redis 服务实现：
 * key 格式为 wx.login:{openid}，支持会话续期。
 */
@Service
public class UserSessionRedisServiceImpl implements UserSessionRedisService {

    /** 微信登录会话过期时间：2 天 */
    private static final Duration WX_LOGIN_EXPIRE = Duration.ofDays(2);

    /** 剩余时间低于该阈值时才续期 */
    private static final Duration RENEW_THRESHOLD = Duration.ofMinutes(10);

    /** 续期随机增加小时数，闭区间 [8, 10] */
    private static final int RENEW_HOURS_MIN = 8;
    private static final int RENEW_HOURS_MAX_INCLUSIVE = 10;

    @Autowired
    private RedisTemplate<String, Object> redisTemplate;

    @Autowired
    private ObjectMapper objectMapper;

    /** 实现登录用户缓存写入 */
    @Override
    public void saveLoginUser(UserAccountVO userAccountVO) {

        // 1.判断登录信息是否有空值
        if (userAccountVO == null || userAccountVO.getId() == null || StrUtil.isBlank(userAccountVO.getOpenid())) {
            return;
        }

        // 2.创建 key 用于检索redis中的信息
        String key = buildOpenidKey(userAccountVO.getOpenid());

        // 3. 设置并存入redis缓存中，微信登录会话 2 天过期
        redisTemplate.opsForValue().set(key, userAccountVO, WX_LOGIN_EXPIRE);
    }

    /** 实现按 openid 读取登录用户，兼容 Jackson 反序列化 */
    @Override
    public UserAccountVO getLoginUserByOpenid(String openid) {

        // 1. 判断参数是否为空
        if (StrUtil.isBlank(openid)) {
            return null;
        }

        // 2. 获取redis中信息通过OpenId，并且判断信息是否为空
        Object value = redisTemplate.opsForValue().get(buildOpenidKey(openid));
        if (value == null) {
            return null;
        }

        // 3.判断类型是否匹配 匹配后安全转换类型并赋值返回，这个就是用来判断redis里获取到的值是否匹配
        if (value instanceof UserAccountVO userAccountVO) {
            return userAccountVO;
        }

        // 4. 返回 UserAccountVO 类型
        return objectMapper.convertValue(value, UserAccountVO.class);
    }

    /**
     * 根据 openid 延长登录用户 Redis 过期时间：
     * 仅当剩余过期时间小于 10 分钟时，随机增加 8～10 小时
     *
     * @param openid 微信 openid
     * @return 续期成功返回 true，无需续期 / openid 为空 / key 不存在返回 false
     */
    @Override
    public boolean delayLoginUserExpire(String openid) {
        // 1. 判断参数是否为空
        if (StrUtil.isBlank(openid)) {
            return false;
        }

        // 2. 确认 Redis 中是否存在该登录会话
        String key = buildOpenidKey(openid.trim());
        Boolean hasKey = redisTemplate.hasKey(key);
        if (!Boolean.TRUE.equals(hasKey)) {
            return false;
        }

        // 3. 剩余过期时间（秒）；-1 永不过期，-2 key 不存在
        Long ttlSeconds = redisTemplate.getExpire(key, TimeUnit.SECONDS);
        if (ttlSeconds == null || ttlSeconds < 0) {
            return false;
        }

        // 4. 剩余时间 >= 10 分钟则不续期
        if (ttlSeconds >= RENEW_THRESHOLD.getSeconds()) {
            return false;
        }

        // 5. 在剩余时间上随机增加 8～10 小时
        int extraHours = RandomUtil.randomInt(RENEW_HOURS_MIN, RENEW_HOURS_MAX_INCLUSIVE + 1);
        Duration newTtl = Duration.ofSeconds(ttlSeconds).plusHours(extraHours);
        return Boolean.TRUE.equals(redisTemplate.expire(key, newTtl));
    }

    /**
     * 构建redis key 用于查找redis中用户信息
     * @param openid
     * @return
     */
    private String buildOpenidKey(String openid) {
        return UserConstant.WX_LOGIN_KEY + ":" + openid;
    }
}
