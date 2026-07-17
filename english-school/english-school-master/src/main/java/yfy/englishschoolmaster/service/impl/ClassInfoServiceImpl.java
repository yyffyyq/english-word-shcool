package yfy.englishschoolmaster.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.util.RandomUtil;
import cn.hutool.core.util.StrUtil;
import com.mybatisflex.core.paginate.Page;
import com.mybatisflex.core.query.QueryWrapper;
import com.mybatisflex.spring.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import yfy.englishschoolmaster.constant.UserConstant;
import yfy.englishschoolmaster.exception.BusinessException;
import yfy.englishschoolmaster.exception.ErrorCode;
import yfy.englishschoolmaster.exception.ThrowUtils;
import yfy.englishschoolmaster.mapper.ClassInfoMapper;
import yfy.englishschoolmaster.model.dto.ClassInfoAddRequest;
import yfy.englishschoolmaster.model.dto.ClassInfoQueryRequest;
import yfy.englishschoolmaster.model.entity.ClassInfo;
import yfy.englishschoolmaster.model.vo.ClassInfoVO;
import yfy.englishschoolmaster.model.vo.UserAccountVO;
import yfy.englishschoolmaster.service.ClassInfoService;

import java.time.LocalDateTime;
import java.util.Set;

/**
 * 班级信息服务层实现
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
@Service
public class ClassInfoServiceImpl extends ServiceImpl<ClassInfoMapper, ClassInfo> implements ClassInfoService {

    private static final String STATUS_ACTIVE = "ACTIVE";
    private static final String INVITE_CODE_CHARS = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789";
    private static final int INVITE_CODE_LENGTH = 6;
    private static final int INVITE_CODE_MAX_RETRY = 10;
    private static final Set<String> SORT_FIELDS = Set.of("createdAt", "updatedAt", "className", "status");

    @Override
    public ClassInfoVO createClass(ClassInfoAddRequest request, UserAccountVO loginUser) {
        // 1. 参数校验
        ThrowUtils.throwIf(request == null, ErrorCode.PARAMS_ERROR, "创建班级请求为空");
        ThrowUtils.throwIf(loginUser == null || loginUser.getId() == null, ErrorCode.NOT_LOGIN_ERROR, "未登录");
        ThrowUtils.throwIf(StrUtil.isBlank(request.getClassName()), ErrorCode.PARAMS_ERROR, "班级名称不能为空");

        String className = request.getClassName().trim();
        String grade = StrUtil.isBlank(request.getGrade()) ? null : request.getGrade().trim();
        String schoolName = StrUtil.isNotBlank(request.getSchoolName())
                ? request.getSchoolName().trim()
                : loginUser.getSchoolName();

        // 2. 生成唯一邀请码并落库
        LocalDateTime now = LocalDateTime.now();
        String inviteCode = generateUniqueInviteCode();
        ClassInfo classInfo = ClassInfo.builder()
                .teacherId(loginUser.getId())
                .className(className)
                .grade(grade)
                .schoolName(schoolName)
                .inviteCode(inviteCode)
                .status(STATUS_ACTIVE)
                .createdAt(now)
                .updatedAt(now)
                .build();

        boolean saved = this.save(classInfo);
        ThrowUtils.throwIf(!saved, ErrorCode.OPERATION_ERROR, "创建班级失败");

        return toClassInfoVO(classInfo);
    }

    @Override
    public Page<ClassInfoVO> listClassInfoByPage(ClassInfoQueryRequest request, UserAccountVO loginUser) {
        // 1. 参数与权限校验
        ThrowUtils.throwIf(request == null, ErrorCode.PARAMS_ERROR, "查询请求为空");
        ThrowUtils.throwIf(loginUser == null || loginUser.getId() == null, ErrorCode.NOT_LOGIN_ERROR, "未登录");

        String role = loginUser.getRole();
        boolean isAdmin = UserConstant.ADMIN_ROLE.equalsIgnoreCase(role);
        boolean isTeacher = UserConstant.TEACHER_ROLE.equalsIgnoreCase(role);
        ThrowUtils.throwIf(!isAdmin && !isTeacher, ErrorCode.NO_AUTH_ERROR, "仅教师或管理员可查询班级");

        int pageNum = request.getPageNum() <= 0 ? 1 : request.getPageNum();
        int pageSize = request.getPageSize() <= 0 ? 10 : request.getPageSize();

        // 2. 组装查询条件：教师仅看自己的班级，管理员可按条件筛选
        QueryWrapper queryWrapper = QueryWrapper.create();
        if (isTeacher) {
            queryWrapper.eq(ClassInfo::getTeacherId, loginUser.getId());
        } else if (request.getTeacherId() != null && request.getTeacherId() > 0) {
            queryWrapper.eq(ClassInfo::getTeacherId, request.getTeacherId());
        }

        if (StrUtil.isNotBlank(request.getClassName())) {
            queryWrapper.like(ClassInfo::getClassName, request.getClassName().trim());
        }
        if (StrUtil.isNotBlank(request.getGrade())) {
            queryWrapper.eq(ClassInfo::getGrade, request.getGrade().trim());
        }
        if (StrUtil.isNotBlank(request.getSchoolName())) {
            queryWrapper.like(ClassInfo::getSchoolName, request.getSchoolName().trim());
        }
        if (StrUtil.isNotBlank(request.getStatus())) {
            queryWrapper.eq(ClassInfo::getStatus, request.getStatus().trim().toUpperCase());
        }

        applySort(queryWrapper, request.getSortField(), request.getSortOrder());

        // 3. 分页查询并转换 VO
        Page<ClassInfo> page = this.page(Page.of(pageNum, pageSize), queryWrapper);
        return page.map(this::toClassInfoVO);
    }

    /**
     * 生成唯一的 6 位邀请码
     */
    private String generateUniqueInviteCode() {
        for (int i = 0; i < INVITE_CODE_MAX_RETRY; i++) {
            String inviteCode = RandomUtil.randomString(INVITE_CODE_CHARS, INVITE_CODE_LENGTH);
            ClassInfo exist = this.getOne(QueryWrapper.create()
                    .eq(ClassInfo::getInviteCode, inviteCode));
            if (exist == null) {
                return inviteCode;
            }
        }
        throw new BusinessException(ErrorCode.OPERATION_ERROR, "邀请码生成失败，请重试");
    }

    private void applySort(QueryWrapper queryWrapper, String sortField, String sortOrder) {
        boolean isAsc = "ascend".equalsIgnoreCase(sortOrder);
        if (StrUtil.isNotBlank(sortField) && SORT_FIELDS.contains(sortField)) {
            switch (sortField) {
                case "updatedAt" -> queryWrapper.orderBy(ClassInfo::getUpdatedAt, isAsc);
                case "className" -> queryWrapper.orderBy(ClassInfo::getClassName, isAsc);
                case "status" -> queryWrapper.orderBy(ClassInfo::getStatus, isAsc);
                default -> queryWrapper.orderBy(ClassInfo::getCreatedAt, isAsc);
            }
            return;
        }
        queryWrapper.orderBy(ClassInfo::getCreatedAt, false);
    }

    private ClassInfoVO toClassInfoVO(ClassInfo classInfo) {
        ClassInfoVO classInfoVO = new ClassInfoVO();
        BeanUtil.copyProperties(classInfo, classInfoVO);
        return classInfoVO;
    }
}
