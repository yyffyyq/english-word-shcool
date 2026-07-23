package yfy.englishschoolmaster.constant;

public interface RedisTypeConstant {

    /**
     * 班级邀请码 Redis 键前缀
     */
    String CLASS_INFO_INVOITE_CODE = "class.info.invite.code";

    /**
     * 学生已加入班级 ID 列表 Redis 键前缀（key: student.class.ids:{userId}）
     */
    String STUDENT_CLASS_IDS = "student.class.ids";

    /**
     * 系统登录用户会话 Redis 键前缀（key: system.user.login.ids:{userId}）
     */
    String SYSTEM_USER_LOGIN_IDS = "system.user.login.ids";

}
