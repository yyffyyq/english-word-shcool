package yfy.englishschoolmaster.service;

import yfy.englishschoolmaster.model.vo.UserAccountVO;

/**
 * 用户登录会话 Redis 服务
 */
public interface UserSessionRedisService {

    /**
     * 缓存登录用户信息
     *
     * @param userAccountVO 登录用户信息
     */
    void saveLoginUser(UserAccountVO userAccountVO);

    /**
     * 根据 openid 获取已登录用户信息
     *
     * @param openid 微信 openid
     * @return 登录用户信息，未命中返回 null
     */
    UserAccountVO getLoginUserByOpenid(String openid);

    /**
     * 根据 openid 延长登录用户 Redis 过期时间：
     * 仅当剩余过期时间小于 10 分钟时，随机延迟 10～15 分钟
     *
     * @param openid 微信 openid
     * @return 续期成功返回 true，无需续期 / openid 为空 / key 不存在返回 false
     */
    boolean delayLoginUserExpire(String openid);
}
