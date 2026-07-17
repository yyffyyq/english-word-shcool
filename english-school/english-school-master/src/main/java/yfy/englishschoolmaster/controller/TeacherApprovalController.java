package yfy.englishschoolmaster.controller;

import com.mybatisflex.core.paginate.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import yfy.englishschoolmaster.annotation.AuthCheck;
import yfy.englishschoolmaster.common.BaseResponse;
import yfy.englishschoolmaster.common.ResultUtils;
import yfy.englishschoolmaster.constant.UserConstant;
import yfy.englishschoolmaster.exception.ErrorCode;
import yfy.englishschoolmaster.exception.ThrowUtils;
import yfy.englishschoolmaster.model.dto.TeacherApprovalAuditRequest;
import yfy.englishschoolmaster.model.dto.TeacherApprovalQueryRequest;
import yfy.englishschoolmaster.model.vo.TeacherApprovalVO;
import yfy.englishschoolmaster.service.TeacherApprovalService;

/**
 * 教师注册审批控制器
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
@RestController
@RequestMapping("/teacherApproval")
public class TeacherApprovalController {

    @Autowired
    private TeacherApprovalService teacherApprovalService;

    /**
     * 分页查询教师审批记录接口：
     * 支持按审批状态、姓名、学校名称筛选，
     *       并返回分页后的教师审批信息
     * @param request
     * @return
     */
    @PostMapping("/list/page/vo")
    public BaseResponse<Page<TeacherApprovalVO>> listTeacherApprovalByPage(@RequestBody TeacherApprovalQueryRequest request){

        // 1. 判断请求是否为空
        ThrowUtils.throwIf(request == null , ErrorCode.PARAMS_ERROR,"查询请求为空");

        // 2. 分页查询教师审批记录
        Page<TeacherApprovalVO> page = teacherApprovalService.listTeacherApprovalByPage(request);

        // 3. 封装返回类型给前端
        return ResultUtils.success(page);
    }

    /**
     * 审核教师注册申请接口：
     * 管理员对教师注册申请进行审批，
     *       通过后创建教师账号，拒绝则记录拒绝原因。
     * 请求头需携带 openid，由 AuthInterceptor 校验管理员权限。
     *
     * @param request 审核请求
     * @return 审批结果
     */
    @PostMapping("/audit")
    @AuthCheck(mustRole = UserConstant.ADMIN_ROLE)
    public BaseResponse<TeacherApprovalVO> auditTeacherApproval(@RequestBody TeacherApprovalAuditRequest request){

        // 1. 判断请求是否为空
        ThrowUtils.throwIf(request == null , ErrorCode.PARAMS_ERROR,"审核请求为空");

        // 2. 处理教师注册审批
        TeacherApprovalVO teacherApprovalVO = teacherApprovalService.auditTeacherApproval(request);

        // 3. 封装返回类型给前端
        return ResultUtils.success(teacherApprovalVO);
    }
}
