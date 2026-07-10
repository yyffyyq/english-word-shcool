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
     * 密码加盐值
     */
    String PASSWORD_SALT = "yfy";

    //  region 权限

    /**
     * 默认角色
     */
    String DEFAULT_ROLE = "user";

    /**
     * 管理员角色
     */
    String ADMIN_ROLE = "admin";

    /**
     * 学生角色
     */
    String STUDENT_ROLE = "student";

    /**
     * 教师角色
     */
    String TEACHER_ROLE = "teacher";

    // endregion
}