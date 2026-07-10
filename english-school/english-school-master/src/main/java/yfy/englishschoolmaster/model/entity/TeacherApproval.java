package yfy.englishschoolmaster.model.entity;

import com.mybatisflex.annotation.Id;
import com.mybatisflex.annotation.KeyType;
import com.mybatisflex.annotation.Table;
import java.io.Serializable;
import java.time.LocalDateTime;

import java.io.Serial;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 *  实体类。
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table("teacher_approval")
public class TeacherApproval implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 审批记录ID
     */
    @Id(keyType = KeyType.Auto)
    private Long id;

    /**
     * 微信小程序 openid，审批通过前用于标识申请人
     */
    private String openid;

    /**
     * 教师真实姓名
     */
    private String realName;

    /**
     * 所属学校名称
     */
    private String schoolName;

    /**
     * 审批通过后关联 user_account.id
     */
    private Long teacherId;

    /**
     * 审批状态：PENDING 待审批，APPROVED 已通过，REJECTED 已拒绝
     */
    private String status;

    /**
     * 拒绝原因，只有审批拒绝时填写
     */
    private String rejectReason;

    /**
     * 审批管理员ID，关联 user_account.id
     */
    private Long approvedBy;

    /**
     * 审批时间
     */
    private LocalDateTime approvedAt;

    /**
     * 提交审批时间
     */
    private LocalDateTime createdAt;

    /**
     * 更新时间
     */
    private LocalDateTime updatedAt;

}
