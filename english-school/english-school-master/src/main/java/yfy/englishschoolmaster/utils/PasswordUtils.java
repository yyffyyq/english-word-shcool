package yfy.englishschoolmaster.utils;

import cn.hutool.crypto.digest.DigestUtil;
import yfy.englishschoolmaster.constant.UserConstant;

/**
 * 密码工具类
 */
public final class PasswordUtils {

    private PasswordUtils() {
    }

    /**
     * 使用固定盐值加密密码
     */
    public static String encode(String password) {
        return DigestUtil.md5Hex(password + UserConstant.PASSWORD_SALT);
    }

    /**
     * 校验明文密码与加密密码是否一致
     */
    public static boolean matches(String rawPassword, String encodedPassword) {
        return encode(rawPassword).equals(encodedPassword);
    }
}
