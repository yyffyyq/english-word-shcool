package yfy.englishschoolmaster.utils;

import cn.hutool.crypto.digest.DigestUtil;
import yfy.englishschoolmaster.constant.UserConstant;

/**
 * 密码加解密工具类：
 * 使用固定盐值对明文密码做 MD5 加密与校验
 */
public final class PasswordUtils {

    private PasswordUtils() {
    }

    /**
     * 加密明文密码：
     * 拼接固定盐值后计算 MD5 摘要
     *
     * @param password 明文密码
     * @return 加密后的密码字符串
     */
    public static String encode(String password) {
        return DigestUtil.md5Hex(password + UserConstant.PASSWORD_SALT);
    }

    /**
     * 校验明文密码是否与密文匹配
     *
     * @param rawPassword     明文密码
     * @param encodedPassword 加密后的密码
     * @return 匹配返回 true，否则 false
     */
    public static boolean matches(String rawPassword, String encodedPassword) {
        return encode(rawPassword).equals(encodedPassword);
    }
}
