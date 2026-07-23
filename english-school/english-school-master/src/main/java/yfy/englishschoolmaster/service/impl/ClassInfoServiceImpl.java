package yfy.englishschoolmaster.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.util.RandomUtil;
import cn.hutool.core.util.StrUtil;
import com.mybatisflex.core.paginate.Page;
import com.mybatisflex.core.query.QueryWrapper;
import com.mybatisflex.spring.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import yfy.englishschoolmaster.config.RedisConfig;
import yfy.englishschoolmaster.constant.RedisTypeConstant;
import yfy.englishschoolmaster.constant.UserConstant;
import yfy.englishschoolmaster.exception.BusinessException;
import yfy.englishschoolmaster.exception.ErrorCode;
import yfy.englishschoolmaster.exception.ThrowUtils;
import yfy.englishschoolmaster.mapper.ClassInfoMapper;
import yfy.englishschoolmaster.model.dto.ClassInfo.ClassInfoAddRequest;
import yfy.englishschoolmaster.model.dto.ClassInfo.ClassInfoQueryRequest;
import yfy.englishschoolmaster.model.entity.ClassInfo;
import yfy.englishschoolmaster.model.entity.ClassStudent;
import yfy.englishschoolmaster.model.entity.UserAccount;
import yfy.englishschoolmaster.model.vo.ClassInfoVO;
import yfy.englishschoolmaster.model.vo.ClassStudentVO;
import yfy.englishschoolmaster.model.vo.UserAccountVO;
import yfy.englishschoolmaster.service.ClassInfoService;
import yfy.englishschoolmaster.service.ClassStudentService;
import yfy.englishschoolmaster.service.RedisService;
import yfy.englishschoolmaster.service.UserAccountService;

import java.time.Duration;
import java.time.LocalDateTime;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Set;
import java.util.function.Function;
import java.util.stream.Collectors;

/**
 * 班级信息服务层实现
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
@Service
public class ClassInfoServiceImpl extends ServiceImpl<ClassInfoMapper, ClassInfo> implements ClassInfoService {

    private static final String STATUS_ACTIVE = "ACTIVE";
    private static final String STATUS_IN_CLASS = "IN_CLASS";
    private static final String INVITE_CODE_CHARS = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789";
    private static final int INVITE_CODE_LENGTH = 6;
    private static final int INVITE_CODE_MAX_RETRY = 10;
    /** 班级邀请码 Redis 缓存时长：45 分钟（与学生加入班级写入时一致） */
    private static final Duration INVITE_CODE_CACHE_TTL = Duration.ofSeconds(2700);
    private static final Set<String> SORT_FIELDS = Set.of("createdAt", "updatedAt", "className", "status");

    @Autowired
    private ClassStudentService classStudentService;

    @Autowired
    private UserAccountService userAccountService;

    @Autowired
    private RedisService redisService;

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
        boolean isStudent = UserConstant.STUDENT_ROLE.equalsIgnoreCase(role);
        ThrowUtils.throwIf(!isAdmin && !isTeacher && !isStudent, ErrorCode.NO_AUTH_ERROR, "仅教师、学生或管理员可查询班级");

        int pageNum = request.getPageNum() <= 0 ? 1 : request.getPageNum();
        int pageSize = request.getPageSize() <= 0 ? 10 : request.getPageSize();

        // 2. 组装查询条件：
        //    教师仅看自己的班级；学生仅看自己加入的班级（优先读 Redis）；管理员可按条件筛选
        QueryWrapper queryWrapper = QueryWrapper.create();
        if (isTeacher) {
            queryWrapper.eq(ClassInfo::getTeacherId, loginUser.getId());
        } else if (isStudent) {
            List<Long> joinedClassIds = listStudentJoinedClassIds(loginUser.getId());
            if (joinedClassIds.isEmpty()) {
                Page<ClassInfo> emptyPage = Page.of(pageNum, pageSize);
                emptyPage.setRecords(Collections.emptyList());
                emptyPage.setTotalRow(0);
                return emptyPage.map(this::toClassInfoVO);
            }
            queryWrapper.in(ClassInfo::getId, joinedClassIds);
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
     * 获取学生已加入的班级 ID 列表：
     *       优先从 Redis 读取（key: student.class.ids:{studentId}）
     *       未命中时回源 class_student 并回写缓存
     *
     * @param studentId 学生用户 id
     * @return 班级 id 列表，无数据时返回空列表
     */
    private List<Long> listStudentJoinedClassIds(Long studentId) {
        // 1. 优先读 Redis
        List<?> cached = redisService.read(String.valueOf(studentId),
                RedisTypeConstant.STUDENT_CLASS_IDS, List.class);
        if (cached != null) {
            return cached.stream()
                    .filter(Objects::nonNull)
                    .map(id -> Long.valueOf(id.toString()))
                    .distinct()
                    .collect(Collectors.toList());
        }

        // 2. Redis 未命中，回源数据库
        List<ClassStudent> classStudents = classStudentService.list(QueryWrapper.create()
                .eq(ClassStudent::getStudentId, studentId)
                .eq(ClassStudent::getStatus, STATUS_IN_CLASS));
        List<Long> classIds = classStudents == null || classStudents.isEmpty()
                ? Collections.emptyList()
                : classStudents.stream()
                .map(ClassStudent::getClassId)
                .filter(Objects::nonNull)
                .distinct()
                .collect(Collectors.toList());

        // 3. 回写 Redis，与登录缓存过期时间保持一致
        redisService.write(classIds, RedisConfig.DEFAULT_EXPIRE,
                RedisTypeConstant.STUDENT_CLASS_IDS, String.valueOf(studentId));
        return classIds;
    }

    @Override
    public ClassInfoVO getClassDetail(Long classId, UserAccountVO loginUser) {
        ClassInfo classInfo = getAccessibleClass(classId, loginUser, false);
        ClassInfoVO classInfoVO = toClassInfoVO(classInfo);
        long studentCount = classStudentService.count(QueryWrapper.create()
                .eq(ClassStudent::getClassId, classId)
                .eq(ClassStudent::getStatus, STATUS_IN_CLASS));
        classInfoVO.setStudentCount(studentCount);
        return classInfoVO;
    }

    @Override
    public List<ClassStudentVO> listClassStudents(Long classId, UserAccountVO loginUser) {
        getAccessibleClass(classId, loginUser, false);

        List<ClassStudent> classStudents = classStudentService.list(QueryWrapper.create()
                .eq(ClassStudent::getClassId, classId)
                .eq(ClassStudent::getStatus, STATUS_IN_CLASS)
                .orderBy(ClassStudent::getJoinedAt, true));
        if (classStudents == null || classStudents.isEmpty()) {
            return Collections.emptyList();
        }

        List<Long> studentIds = classStudents.stream()
                .map(ClassStudent::getStudentId)
                .filter(Objects::nonNull)
                .distinct()
                .toList();
        Map<Long, UserAccount> studentMap = studentIds.isEmpty()
                ? Collections.emptyMap()
                : userAccountService.listByIds(studentIds).stream()
                .collect(Collectors.toMap(UserAccount::getId, Function.identity(), (a, b) -> a));

        return classStudents.stream().map(classStudent -> {
            ClassStudentVO vo = new ClassStudentVO();
            vo.setId(classStudent.getId());
            vo.setClassId(classStudent.getClassId());
            vo.setStudentId(classStudent.getStudentId());
            vo.setJoinedAt(classStudent.getJoinedAt());
            vo.setStatus(classStudent.getStatus());
            UserAccount student = studentMap.get(classStudent.getStudentId());
            if (student != null) {
                vo.setRealName(student.getRealName());
                vo.setStudentNo(student.getStudentNo());
                vo.setAvatarUrl(student.getAvatarUrl());
            }
            return vo;
        }).toList();
    }

    @Override
    public ClassInfoVO refreshInviteCode(Long classId, UserAccountVO loginUser) {
        // 1. 校验权限并拿到旧邀请码
        ClassInfo classInfo = getAccessibleClass(classId, loginUser, true);
        String oldInviteCode = classInfo.getInviteCode();

        // 2. 生成新邀请码并更新数据库
        String newInviteCode = generateUniqueInviteCode();
        classInfo.setInviteCode(newInviteCode);
        classInfo.setUpdatedAt(LocalDateTime.now());
        boolean updated = this.updateById(classInfo);
        ThrowUtils.throwIf(!updated, ErrorCode.OPERATION_ERROR, "刷新邀请码失败");

        // 3. 删除 Redis 中旧邀请码缓存，写入新邀请码缓存
        ClassInfoVO classInfoVO = toClassInfoVO(classInfo);
        if (StrUtil.isNotBlank(oldInviteCode)) {
            redisService.delete(oldInviteCode, RedisTypeConstant.CLASS_INFO_INVOITE_CODE);
        }
        redisService.write(classInfoVO, INVITE_CODE_CACHE_TTL,
                RedisTypeConstant.CLASS_INFO_INVOITE_CODE, newInviteCode);

        // 4. 返回刷新后的班级信息
        return classInfoVO;
    }

    /**
     * 校验班级存在，并校验访问权限：
     * 教师仅可操作自己的班级；管理员可读全部（刷新邀请码仅教师）
     *
     * @param classId        班级ID
     * @param loginUser      当前登录用户
     * @param teacherOnlyWrite 是否仅教师可写（刷新邀请码）
     */
    private ClassInfo getAccessibleClass(Long classId, UserAccountVO loginUser, boolean teacherOnlyWrite) {
        ThrowUtils.throwIf(loginUser == null || loginUser.getId() == null, ErrorCode.NOT_LOGIN_ERROR, "未登录");
        ThrowUtils.throwIf(classId == null || classId <= 0, ErrorCode.PARAMS_ERROR, "班级ID不合法");

        ClassInfo classInfo = this.getById(classId);
        ThrowUtils.throwIf(classInfo == null, ErrorCode.NOT_FOUND_ERROR, "班级不存在");

        String role = loginUser.getRole();
        boolean isAdmin = UserConstant.ADMIN_ROLE.equalsIgnoreCase(role);
        boolean isTeacher = UserConstant.TEACHER_ROLE.equalsIgnoreCase(role);

        if (teacherOnlyWrite) {
            ThrowUtils.throwIf(!isTeacher, ErrorCode.NO_AUTH_ERROR, "仅教师可刷新邀请码");
            ThrowUtils.throwIf(!Objects.equals(classInfo.getTeacherId(), loginUser.getId()),
                    ErrorCode.NO_AUTH_ERROR, "无权操作该班级");
            return classInfo;
        }

        ThrowUtils.throwIf(!isAdmin && !isTeacher, ErrorCode.NO_AUTH_ERROR, "仅教师或管理员可访问班级");
        if (isTeacher) {
            ThrowUtils.throwIf(!Objects.equals(classInfo.getTeacherId(), loginUser.getId()),
                    ErrorCode.NO_AUTH_ERROR, "无权访问该班级");
        }
        return classInfo;
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
