package yfy.englishschoolmaster.constant;

/**
 *
 * 用户常量
 */
public interface UserConstant {

    /**
     * 微信登录 Redis 键前缀
     */
    String WX_LOGIN_KEY = "wx.login";

    /**
     * 请求头中的微信 openid 字段名
     */
    String OPENID_HEADER = "openid";

    /**
     * 请求属性中存放当前登录用户的 key
     */
    String LOGIN_USER_ATTR = "loginUser";

    /**
     * 密码加盐值
     */
    String PASSWORD_SALT = "yfy";

    //  region 权限

    /**
     * 管理员角色
     */
    String ADMIN_ROLE = "ADMIN";

    /**
     * 学生角色
     */
    String STUDENT_ROLE = "STUDENT";

    /**
     * 教师角色
     */
    String TEACHER_ROLE = "TEACHER";

    // endregion
}
