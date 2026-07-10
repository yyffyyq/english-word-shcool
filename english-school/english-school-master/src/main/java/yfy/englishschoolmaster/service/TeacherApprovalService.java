package yfy.englishschoolmaster.service;

import com.mybatisflex.core.paginate.Page;
import com.mybatisflex.core.service.IService;
import yfy.englishschoolmaster.model.dto.TeacherApprovalAuditRequest;
import yfy.englishschoolmaster.model.dto.TeacherApprovalQueryRequest;
import yfy.englishschoolmaster.model.dto.UserAccountTeacherRegisterRequest;
import yfy.englishschoolmaster.model.entity.TeacherApproval;
import yfy.englishschoolmaster.model.vo.TeacherApprovalVO;

/**
 *  服务层。
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
public interface TeacherApprovalService extends IService<TeacherApproval> {

    /**
     * 教师注册：提交审批申请，不写入 user_account
     *
     * @param request 教师注册请求体
     * @return 审批信息
     */
    TeacherApprovalVO registerTeacher(UserAccountTeacherRegisterRequest request);

    /**
     * 分页查询教师审批记录
     *
     * @param request 查询条件
     * @return 分页结果
     */
    Page<TeacherApprovalVO> listTeacherApprovalByPage(TeacherApprovalQueryRequest request);

    /**
     * 审核教师注册申请
     *
     * @param request 审核请求
     * @return 审核后的审批信息
     */
    TeacherApprovalVO auditTeacherApproval(TeacherApprovalAuditRequest request);
}
