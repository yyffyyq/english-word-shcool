package yfy.englishschoolmaster.model.vo;

import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * 班级学生信息 VO
 */
@Data
public class ClassStudentVO implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 班级学生关系ID
     */
    private Long id;

    /**
     * 班级ID
     */
    private Long classId;

    /**
     * 学生ID
     */
    private Long studentId;

    /**
     * 学生真实姓名
     */
    private String realName;

    /**
     * 学号
     */
    private String studentNo;

    /**
     * 头像地址
     */
    private String avatarUrl;

    /**
     * 加入班级时间
     */
    private LocalDateTime joinedAt;

    /**
     * 关系状态：IN_CLASS 在班，EXITED 已退出
     */
    private String status;
}
