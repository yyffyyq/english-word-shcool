package yfy.englishschoolmaster.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.util.StrUtil;
import com.mybatisflex.core.paginate.Page;
import com.mybatisflex.core.query.QueryWrapper;
import com.mybatisflex.spring.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import yfy.englishschoolmaster.exception.ErrorCode;
import yfy.englishschoolmaster.exception.ThrowUtils;
import yfy.englishschoolmaster.mapper.TeacherApprovalMapper;
import yfy.englishschoolmaster.model.dto.TeacherApprovalAuditRequest;
import yfy.englishschoolmaster.model.dto.TeacherApprovalQueryRequest;
import yfy.englishschoolmaster.model.dto.UserAccountTeacherRegisterRequest;
import yfy.englishschoolmaster.model.entity.TeacherApproval;
import yfy.englishschoolmaster.model.entity.UserAccount;
import yfy.englishschoolmaster.model.vo.TeacherApprovalVO;
import yfy.englishschoolmaster.service.TeacherApprovalService;
import yfy.englishschoolmaster.service.UserAccountService;

import java.time.LocalDateTime;
import java.util.Set;

/**
 *  服务层实现。
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
@Service
public class TeacherApprovalServiceImpl extends ServiceImpl<TeacherApprovalMapper, TeacherApproval> implements TeacherApprovalService {

    private static final String STATUS_PENDING = "PENDING";
    private static final String STATUS_APPROVED = "APPROVED";
    private static final String STATUS_REJECTED = "REJECTED";
    private static final String ROLE_TEACHER = "TEACHER";
    private static final String ROLE_ADMIN = "ADMIN";
    private static final String STATUS_NORMAL = "NORMAL";
    private static final Set<String> AUDIT_STATUS = Set.of(STATUS_APPROVED, STATUS_REJECTED);
    private static final Set<String> SORT_FIELDS = Set.of("createdAt", "approvedAt", "status");

    @Autowired
    private UserAccountService userAccountService;

    @Override
    public TeacherApprovalVO registerTeacher(UserAccountTeacherRegisterRequest request) {
        ThrowUtils.throwIf(request == null, ErrorCode.PARAMS_ERROR, "教师注册请求为空");
        ThrowUtils.throwIf(StrUtil.isBlank(request.getOpenid()), ErrorCode.PARAMS_ERROR, "openid 不能为空");
        ThrowUtils.throwIf(StrUtil.isBlank(request.getRealName()), ErrorCode.PARAMS_ERROR, "姓名不能为空");
        ThrowUtils.throwIf(StrUtil.isBlank(request.getSchoolName()), ErrorCode.PARAMS_ERROR, "学校名称不能为空");

        String openid = request.getOpenid().trim();
        String realName = request.getRealName().trim();
        String schoolName = request.getSchoolName().trim();

        UserAccount existAccount = userAccountService.getOne(QueryWrapper.create()
                .eq(UserAccount::getOpenid, openid));
        ThrowUtils.throwIf(existAccount != null, ErrorCode.OPERATION_ERROR, "该微信账号已注册，请直接登录");

        TeacherApproval pendingApproval = this.getOne(QueryWrapper.create()
                .eq(TeacherApproval::getOpenid, openid)
                .eq(TeacherApproval::getStatus, STATUS_PENDING));
        ThrowUtils.throwIf(pendingApproval != null, ErrorCode.OPERATION_ERROR, "您已有待审批的申请，请耐心等待");

        LocalDateTime now = LocalDateTime.now();
        TeacherApproval teacherApproval = TeacherApproval.builder()
                .openid(openid)
                .realName(realName)
                .schoolName(schoolName)
                .status(STATUS_PENDING)
                .createdAt(now)
                .updatedAt(now)
                .build();

        boolean saved = this.save(teacherApproval);
        ThrowUtils.throwIf(!saved, ErrorCode.OPERATION_ERROR, "教师注册申请提交失败");

        return toTeacherApprovalVO(teacherApproval);
    }

    @Override
    public Page<TeacherApprovalVO> listTeacherApprovalByPage(TeacherApprovalQueryRequest request) {
        ThrowUtils.throwIf(request == null, ErrorCode.PARAMS_ERROR, "查询请求为空");

        int pageNum = request.getPageNum() <= 0 ? 1 : request.getPageNum();
        int pageSize = request.getPageSize() <= 0 ? 10 : request.getPageSize();

        QueryWrapper queryWrapper = QueryWrapper.create();
        if (StrUtil.isNotBlank(request.getStatus())) {
            queryWrapper.eq(TeacherApproval::getStatus, request.getStatus().trim().toUpperCase());
        }
        if (StrUtil.isNotBlank(request.getRealName())) {
            queryWrapper.like(TeacherApproval::getRealName, request.getRealName().trim());
        }
        if (StrUtil.isNotBlank(request.getSchoolName())) {
            queryWrapper.like(TeacherApproval::getSchoolName, request.getSchoolName().trim());
        }

        applySort(queryWrapper, request.getSortField(), request.getSortOrder());

        Page<TeacherApproval> page = this.page(Page.of(pageNum, pageSize), queryWrapper);
        return page.map(this::toTeacherApprovalVO);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public TeacherApprovalVO auditTeacherApproval(TeacherApprovalAuditRequest request) {
        ThrowUtils.throwIf(request == null, ErrorCode.PARAMS_ERROR, "审核请求为空");
        ThrowUtils.throwIf(request.getId() == null || request.getId() <= 0, ErrorCode.PARAMS_ERROR, "审批记录ID不合法");
        ThrowUtils.throwIf(request.getApprovedBy() == null || request.getApprovedBy() <= 0, ErrorCode.PARAMS_ERROR, "审批管理员ID不合法");
        ThrowUtils.throwIf(StrUtil.isBlank(request.getStatus()), ErrorCode.PARAMS_ERROR, "审批结果不能为空");

        String auditStatus = request.getStatus().trim().toUpperCase();
        ThrowUtils.throwIf(!AUDIT_STATUS.contains(auditStatus), ErrorCode.PARAMS_ERROR, "审批结果仅支持 APPROVED 或 REJECTED");

        TeacherApproval teacherApproval = this.getById(request.getId());
        ThrowUtils.throwIf(teacherApproval == null, ErrorCode.NOT_FOUND_ERROR, "审批记录不存在");
        ThrowUtils.throwIf(!STATUS_PENDING.equals(teacherApproval.getStatus()), ErrorCode.OPERATION_ERROR, "该申请已处理，无法重复审批");

        UserAccount admin = userAccountService.getById(request.getApprovedBy());
        ThrowUtils.throwIf(admin == null, ErrorCode.NOT_FOUND_ERROR, "审批管理员不存在");
        ThrowUtils.throwIf(!ROLE_ADMIN.equals(admin.getRole()), ErrorCode.NO_AUTH_ERROR, "仅管理员可审批");

        LocalDateTime now = LocalDateTime.now();
        teacherApproval.setApprovedBy(request.getApprovedBy());
        teacherApproval.setApprovedAt(now);
        teacherApproval.setUpdatedAt(now);

        if (STATUS_REJECTED.equals(auditStatus)) {
            ThrowUtils.throwIf(StrUtil.isBlank(request.getRejectReason()), ErrorCode.PARAMS_ERROR, "拒绝原因不能为空");
            teacherApproval.setStatus(STATUS_REJECTED);
            teacherApproval.setRejectReason(request.getRejectReason().trim());
        } else {
            UserAccount existAccount = userAccountService.getOne(QueryWrapper.create()
                    .eq(UserAccount::getOpenid, teacherApproval.getOpenid()));
            ThrowUtils.throwIf(existAccount != null, ErrorCode.OPERATION_ERROR, "该微信账号已注册，无法重复通过审批");

            UserAccount teacherAccount = UserAccount.builder()
                    .openid(teacherApproval.getOpenid())
                    .realName(teacherApproval.getRealName())
                    .schoolName(teacherApproval.getSchoolName())
                    .role(ROLE_TEACHER)
                    .status(STATUS_NORMAL)
                    .createdAt(now)
                    .updatedAt(now)
                    .build();
            boolean saved = userAccountService.save(teacherAccount);
            ThrowUtils.throwIf(!saved, ErrorCode.OPERATION_ERROR, "创建教师账号失败");

            teacherApproval.setStatus(STATUS_APPROVED);
            teacherApproval.setTeacherId(teacherAccount.getId());
            teacherApproval.setRejectReason(null);
        }

        boolean updated = this.updateById(teacherApproval);
        ThrowUtils.throwIf(!updated, ErrorCode.OPERATION_ERROR, "审批处理失败");

        return toTeacherApprovalVO(teacherApproval);
    }

    private void applySort(QueryWrapper queryWrapper, String sortField, String sortOrder) {
        boolean isAsc = "ascend".equalsIgnoreCase(sortOrder);
        if (StrUtil.isNotBlank(sortField) && SORT_FIELDS.contains(sortField)) {
            switch (sortField) {
                case "approvedAt" -> queryWrapper.orderBy(TeacherApproval::getApprovedAt, isAsc);
                case "status" -> queryWrapper.orderBy(TeacherApproval::getStatus, isAsc);
                default -> queryWrapper.orderBy(TeacherApproval::getCreatedAt, isAsc);
            }
            return;
        }
        queryWrapper.orderBy(TeacherApproval::getCreatedAt, false);
    }

    private TeacherApprovalVO toTeacherApprovalVO(TeacherApproval teacherApproval) {
        TeacherApprovalVO teacherApprovalVO = new TeacherApprovalVO();
        BeanUtil.copyProperties(teacherApproval, teacherApprovalVO);
        return teacherApprovalVO;
    }
}
