package yfy.englishschoolmaster.constant;

/**
 * Redis 键类型常量：
 * 统一定义各业务场景在 Redis 中使用的键前缀
 */
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

    /**
     * 学生今日作业单词列表 Redis 键前缀（key: student.homework.list:{studentId}）
     * TTL 3 小时；过期前 10 分钟会将学习进度回写数据库
     */
    String STUDENT_HOMEWORK_LIST = "student.homework.list";

    /**
     * 学生今日复习单词列表 Redis 键前缀（key: student.review.list:{studentId}）
     * TTL 3 小时
     */
    String STUDENT_REVIEW_LIST = "student.review.list";

}
