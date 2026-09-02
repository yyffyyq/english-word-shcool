package yfy.englishschoolmaster.service;

import com.mybatisflex.core.paginate.Page;
import com.mybatisflex.core.service.IService;
import yfy.englishschoolmaster.model.dto.TeacherApprovalAuditRequest;
import yfy.englishschoolmaster.model.dto.TeacherApprovalQueryRequest;
import yfy.englishschoolmaster.model.dto.UserAccountTeacherRegisterRequest;
import yfy.englishschoolmaster.model.entity.TeacherApproval;
import yfy.englishschoolmaster.model.vo.TeacherApprovalVO;

/**
 * 教师审批服务：
 * 管理微信小程序教师注册申请的提交、分页查询与管理员审核。
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
public interface TeacherApprovalService extends IService<TeacherApproval> {

    /**
     * 教师注册接口：
     * 微信小程序提交教师注册信息，
     *       生成教师审批记录写入 teacher_approval 表
     *       审批状态为待审批，暂不创建 user_account 记录
     *       同一 openid 不可重复注册或重复提交待审批申请
     *
     * @param request 教师注册请求体（openid、姓名、学校名称）
     * @return 审批记录 VO
     */
    TeacherApprovalVO registerTeacher(UserAccountTeacherRegisterRequest request);

    /**
     * 分页查询教师审批记录：
     * 支持按审批状态、姓名、学校名称筛选与排序
     *
     * @param request 分页及筛选条件
     * @return 审批记录分页结果
     */
    Page<TeacherApprovalVO> listTeacherApprovalByPage(TeacherApprovalQueryRequest request);

    /**
     * 审核教师注册申请：
     * 仅管理员可操作；
     *       通过时创建 TEACHER 角色 user_account 并回写 teacher_id
     *       拒绝时必须填写拒绝原因
     *
     * @param request 审核请求（审批记录 ID、审核结果、管理员 ID）
     * @return 审核后的审批记录 VO
     */
    TeacherApprovalVO auditTeacherApproval(TeacherApprovalAuditRequest request);
}
