package yfy.englishschoolmaster.model.dto;

import lombok.Data;

import java.io.Serializable;

/**
 * 教师审批审核请求：
 * 管理员对 PENDING 记录执行通过或拒绝，
 *       通过时创建教师账号，拒绝时填写原因
 */
@Data
public class TeacherApprovalAuditRequest implements Serializable {

    /**
     * 审批记录ID
     */
    private Long id;

    /**
     * 审批结果：APPROVED 通过，REJECTED 拒绝
     */
    private String status;

    /**
     * 拒绝原因，status 为 REJECTED 时必填
     */
    private String rejectReason;

    /**
     * 审批管理员ID，关联 user_account.id
     */
    private Long approvedBy;
}
