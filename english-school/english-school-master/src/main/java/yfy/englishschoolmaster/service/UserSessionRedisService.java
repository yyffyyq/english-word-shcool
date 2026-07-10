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
}
