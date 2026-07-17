package yfy.englishschoolmaster.model.vo;

import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * 班级信息 VO
 */
@Data
public class ClassInfoVO implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 班级ID
     */
    private Long id;

    /**
     * 创建班级的教师ID
     */
    private Long teacherId;

    /**
     * 班级名称
     */
    private String className;

    /**
     * 年级名称
     */
    private String grade;

    /**
     * 学校名称
     */
    private String schoolName;

    /**
     * 6位班级邀请码
     */
    private String inviteCode;

    /**
     * 班级状态：ACTIVE 正常，DISABLED 停用
     */
    private String status;

    /**
     * 创建时间
     */
    private LocalDateTime createdAt;

    /**
     * 更新时间
     */
    private LocalDateTime updatedAt;
}
