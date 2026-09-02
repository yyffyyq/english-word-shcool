package yfy.englishschoolmaster.model.vo;

import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * 教师注册审批信息 VO：
 * 分页查询审批列表时返回，
 *       展示申请人姓名、学校及审批状态
 */
@Data
public class TeacherApprovalVO implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 审批记录ID
     */
    private Long id;

    /**
     * 教师真实姓名
     */
    private String realName;

    /**
     * 所属学校名称
     */
    private String schoolName;

    /**
     * 审批状态：PENDING 待审批，APPROVED 已通过，REJECTED 已拒绝
     */
    private String status;

    /**
     * 拒绝原因，仅审批拒绝时有值
     */
    private String rejectReason;

    /**
     * 提交审批时间
     */
    private LocalDateTime createdAt;

    /**
     * 审批时间
     */
    private LocalDateTime approvedAt;
}
