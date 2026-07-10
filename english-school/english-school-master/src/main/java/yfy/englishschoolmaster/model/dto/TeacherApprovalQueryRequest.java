package yfy.englishschoolmaster.model.dto;

import lombok.Data;
import lombok.EqualsAndHashCode;
import yfy.englishschoolmaster.common.PageRequest;

/**
 * 教师审批分页查询请求
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class TeacherApprovalQueryRequest extends PageRequest {

    /**
     * 审批状态：PENDING / APPROVED / REJECTED
     */
    private String status;

    /**
     * 教师姓名，模糊查询
     */
    private String realName;

    /**
     * 学校名称，模糊查询
     */
    private String schoolName;
}
