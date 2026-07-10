package yfy.englishschoolmaster.service.impl;

import cn.hutool.core.util.StrUtil;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import yfy.englishschoolmaster.config.RedisConfig;
import yfy.englishschoolmaster.constant.UserConstant;
import yfy.englishschoolmaster.model.vo.UserAccountVO;
import yfy.englishschoolmaster.service.UserSessionRedisService;

/**
 * 用户登录会话 Redis 服务实现
 */
@Service
public class UserSessionRedisServiceImpl implements UserSessionRedisService {

    @Autowired
    private RedisTemplate<String, Object> redisTemplate;

    @Autowired
    private ObjectMapper objectMapper;

    /**
     * 将登录后的用户信息存入redis
     * @param userAccountVO 登录用户信息
     */
    @Override
    public void saveLoginUser(UserAccountVO userAccountVO) {

        // 1.判断登录信息是否有空值
        if (userAccountVO == null || userAccountVO.getId() == null || StrUtil.isBlank(userAccountVO.getOpenid())) {
            return;
        }

        // 2.创建 key 用于检索redis中的信息
        String key = buildOpenidKey(userAccountVO.getOpenid());

        // 3. 设置并存入redis缓存中
        redisTemplate.opsForValue().set(key, userAccountVO, RedisConfig.DEFAULT_EXPIRE);
    }

    /**
     * 根据 openid 获取redis中用户信息
     * @param openid 微信 openid
     * @return
     */
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
     * 构建redis key 用于查找redis中用户信息
     * @param openid
     * @return
     */
    private String buildOpenidKey(String openid) {
        return UserConstant.WX_LOGIN_KEY + ":" + openid;
    }
}
