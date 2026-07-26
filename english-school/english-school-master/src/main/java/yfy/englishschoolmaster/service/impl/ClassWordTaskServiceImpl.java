package yfy.englishschoolmaster.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.util.StrUtil;
import com.mybatisflex.core.paginate.Page;
import com.mybatisflex.core.query.QueryWrapper;
import com.mybatisflex.spring.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import yfy.englishschoolmaster.constant.UserConstant;
import yfy.englishschoolmaster.exception.ErrorCode;
import yfy.englishschoolmaster.exception.ThrowUtils;
import yfy.englishschoolmaster.mapper.ClassInfoMapper;
import yfy.englishschoolmaster.mapper.ClassWordTaskMapper;
import yfy.englishschoolmaster.mapper.WordBookMapper;
import yfy.englishschoolmaster.model.dto.ClassWordTask.ClassWordTaskBindRequest;
import yfy.englishschoolmaster.model.dto.ClassWordTask.ClassWordTaskQueryRequest;
import yfy.englishschoolmaster.model.entity.ClassInfo;
import yfy.englishschoolmaster.model.entity.ClassWordTask;
import yfy.englishschoolmaster.model.entity.WordBook;
import yfy.englishschoolmaster.model.vo.ClassWordTaskVO;
import yfy.englishschoolmaster.model.vo.UserAccountVO;
import yfy.englishschoolmaster.service.ClassWordTaskService;

import java.sql.Date;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Objects;
import java.util.Set;

/**
 * 班级词书与每日学习规则表 服务层实现。
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
@Service
public class ClassWordTaskServiceImpl extends ServiceImpl<ClassWordTaskMapper, ClassWordTask>
        implements ClassWordTaskService {

    private static final String STATUS_ACTIVE = "ACTIVE";
    private static final String STATUS_STOPPED = "STOPPED";
    private static final String STATUS_DISABLED = "DISABLED";
    private static final int DEFAULT_DAILY_NEW_COUNT = 10;
    private static final Set<String> SORT_FIELDS = Set.of(
            "createdAt", "updatedAt", "startDate", "endDate", "dailyNewCount", "status"
    );

    private final ClassInfoMapper classInfoMapper;
    private final WordBookMapper wordBookMapper;

    public ClassWordTaskServiceImpl(ClassInfoMapper classInfoMapper, WordBookMapper wordBookMapper) {
        this.classInfoMapper = classInfoMapper;
        this.wordBookMapper = wordBookMapper;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public ClassWordTaskVO bindClassWordBook(ClassWordTaskBindRequest request, UserAccountVO loginUser) {
        // 1. 参数与权限校验
        ThrowUtils.throwIf(request == null, ErrorCode.PARAMS_ERROR, "绑定请求为空");
        checkTeacherOrAdmin(loginUser);
        ThrowUtils.throwIf(request.getClassId() == null || request.getClassId() <= 0,
                ErrorCode.PARAMS_ERROR, "班级ID不合法");
        ThrowUtils.throwIf(request.getBookId() == null || request.getBookId() <= 0,
                ErrorCode.PARAMS_ERROR, "词书ID不合法");

        Integer dailyNewCount = request.getDailyNewCount() == null
                ? DEFAULT_DAILY_NEW_COUNT
                : request.getDailyNewCount();
        ThrowUtils.throwIf(dailyNewCount <= 0, ErrorCode.PARAMS_ERROR, "每日新学单词数量必须大于 0");

        LocalDate startDate = request.getStartDate();
        LocalDate endDate = request.getEndDate();
        if (startDate != null && endDate != null) {
            ThrowUtils.throwIf(endDate.isBefore(startDate), ErrorCode.PARAMS_ERROR, "结束日期不能早于开始日期");
        }

        // 2. 校验班级：存在、启用，教师仅可操作自己的班级
        ClassInfo classInfo = classInfoMapper.selectOneById(request.getClassId());
        ThrowUtils.throwIf(classInfo == null, ErrorCode.NOT_FOUND_ERROR, "班级不存在");
        ThrowUtils.throwIf(STATUS_DISABLED.equalsIgnoreCase(classInfo.getStatus()),
                ErrorCode.OPERATION_ERROR, "班级已停用，无法绑定词书");
        checkClassAccess(classInfo, loginUser);

        // 3. 校验词书：存在且启用
        WordBook wordBook = wordBookMapper.selectOneById(request.getBookId());
        ThrowUtils.throwIf(wordBook == null, ErrorCode.NOT_FOUND_ERROR, "词书不存在");
        ThrowUtils.throwIf(!STATUS_ACTIVE.equalsIgnoreCase(wordBook.getStatus()),
                ErrorCode.OPERATION_ERROR, "词书未启用，无法绑定");

        // 4. 同班级同词书：已生效则拒绝；已停止则重新激活
        ClassWordTask existTask = this.getOne(QueryWrapper.create()
                .eq(ClassWordTask::getClassId, request.getClassId())
                .eq(ClassWordTask::getBookId, request.getBookId()));
        LocalDateTime now = LocalDateTime.now();
        if (existTask != null) {
            ThrowUtils.throwIf(STATUS_ACTIVE.equalsIgnoreCase(existTask.getStatus()),
                    ErrorCode.OPERATION_ERROR, "该班级已绑定该词书");

            existTask.setDailyNewCount(dailyNewCount);
            existTask.setStartDate(toSqlDate(startDate));
            existTask.setEndDate(toSqlDate(endDate));
            existTask.setStatus(STATUS_ACTIVE);
            existTask.setUpdatedAt(now);
            boolean updated = this.updateById(existTask);
            ThrowUtils.throwIf(!updated, ErrorCode.OPERATION_ERROR, "重新绑定词书失败");
            return toClassWordTaskVO(existTask);
        }

        // 5. 新建绑定任务
        ClassWordTask task = ClassWordTask.builder()
                .classId(request.getClassId())
                .bookId(request.getBookId())
                .dailyNewCount(dailyNewCount)
                .startDate(toSqlDate(startDate))
                .endDate(toSqlDate(endDate))
                .status(STATUS_ACTIVE)
                .createdBy(loginUser.getId())
                .createdAt(now)
                .updatedAt(now)
                .build();
        boolean saved = this.save(task);
        ThrowUtils.throwIf(!saved, ErrorCode.OPERATION_ERROR, "绑定词书失败");
        return toClassWordTaskVO(task);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean unbindClassWordBook(Long id, UserAccountVO loginUser) {
        // 1. 参数与权限校验
        checkTeacherOrAdmin(loginUser);
        ThrowUtils.throwIf(id == null || id <= 0, ErrorCode.PARAMS_ERROR, "任务ID不合法");

        // 2. 查询任务
        ClassWordTask task = this.getById(id);
        ThrowUtils.throwIf(task == null, ErrorCode.NOT_FOUND_ERROR, "班级词书任务不存在");
        ThrowUtils.throwIf(STATUS_STOPPED.equalsIgnoreCase(task.getStatus()),
                ErrorCode.OPERATION_ERROR, "该绑定已解除");

        // 3. 校验班级访问权限
        ClassInfo classInfo = classInfoMapper.selectOneById(task.getClassId());
        ThrowUtils.throwIf(classInfo == null, ErrorCode.NOT_FOUND_ERROR, "班级不存在");
        checkClassAccess(classInfo, loginUser);

        // 4. 解除绑定：状态置为 STOPPED
        task.setStatus(STATUS_STOPPED);
        task.setUpdatedAt(LocalDateTime.now());
        boolean updated = this.updateById(task);
        ThrowUtils.throwIf(!updated, ErrorCode.OPERATION_ERROR, "解除绑定失败");
        return true;
    }

    @Override
    public Page<ClassWordTaskVO> listClassWordTaskByPage(ClassWordTaskQueryRequest request, UserAccountVO loginUser) {
        // 1. 参数与权限校验
        ThrowUtils.throwIf(request == null, ErrorCode.PARAMS_ERROR, "查询请求为空");
        checkTeacherOrAdmin(loginUser);

        boolean isAdmin = UserConstant.ADMIN_ROLE.equalsIgnoreCase(loginUser.getRole());
        boolean isTeacher = UserConstant.TEACHER_ROLE.equalsIgnoreCase(loginUser.getRole());

        int pageNum = request.getPageNum() <= 0 ? 1 : request.getPageNum();
        int pageSize = request.getPageSize() <= 0 ? 10 : request.getPageSize();

        // 2. 组装查询条件：教师仅看自己创建的任务；管理员可查全部并可按创建人筛选
        QueryWrapper queryWrapper = QueryWrapper.create();
        if (isTeacher) {
            queryWrapper.eq(ClassWordTask::getCreatedBy, loginUser.getId());
        } else if (isAdmin && request.getCreatedBy() != null && request.getCreatedBy() > 0) {
            queryWrapper.eq(ClassWordTask::getCreatedBy, request.getCreatedBy());
        }

        if (request.getClassId() != null && request.getClassId() > 0) {
            queryWrapper.eq(ClassWordTask::getClassId, request.getClassId());
        }
        if (request.getBookId() != null && request.getBookId() > 0) {
            queryWrapper.eq(ClassWordTask::getBookId, request.getBookId());
        }
        if (StrUtil.isNotBlank(request.getStatus())) {
            queryWrapper.eq(ClassWordTask::getStatus, request.getStatus().trim().toUpperCase());
        }

        applySort(queryWrapper, request.getSortField(), request.getSortOrder());

        // 3. 分页查询并转换 VO
        Page<ClassWordTask> page = this.page(Page.of(pageNum, pageSize), queryWrapper);
        return page.map(this::toClassWordTaskVO);
    }

    private void checkTeacherOrAdmin(UserAccountVO loginUser) {
        ThrowUtils.throwIf(loginUser == null || loginUser.getId() == null, ErrorCode.NOT_LOGIN_ERROR, "未登录");
        String role = loginUser.getRole();
        boolean isAdmin = UserConstant.ADMIN_ROLE.equalsIgnoreCase(role);
        boolean isTeacher = UserConstant.TEACHER_ROLE.equalsIgnoreCase(role);
        ThrowUtils.throwIf(!isAdmin && !isTeacher, ErrorCode.NO_AUTH_ERROR, "仅教师或管理员可操作");
    }

    /**
     * 教师仅可操作自己创建的班级，管理员可操作全部班级。
     */
    private void checkClassAccess(ClassInfo classInfo, UserAccountVO loginUser) {
        if (UserConstant.ADMIN_ROLE.equalsIgnoreCase(loginUser.getRole())) {
            return;
        }
        ThrowUtils.throwIf(!Objects.equals(classInfo.getTeacherId(), loginUser.getId()),
                ErrorCode.NO_AUTH_ERROR, "无权操作该班级");
    }

    private void applySort(QueryWrapper queryWrapper, String sortField, String sortOrder) {
        boolean isAsc = "ascend".equalsIgnoreCase(sortOrder);
        if (StrUtil.isNotBlank(sortField) && SORT_FIELDS.contains(sortField)) {
            switch (sortField) {
                case "updatedAt" -> queryWrapper.orderBy(ClassWordTask::getUpdatedAt, isAsc);
                case "startDate" -> queryWrapper.orderBy(ClassWordTask::getStartDate, isAsc);
                case "endDate" -> queryWrapper.orderBy(ClassWordTask::getEndDate, isAsc);
                case "dailyNewCount" -> queryWrapper.orderBy(ClassWordTask::getDailyNewCount, isAsc);
                case "status" -> queryWrapper.orderBy(ClassWordTask::getStatus, isAsc);
                default -> queryWrapper.orderBy(ClassWordTask::getCreatedAt, isAsc);
            }
            return;
        }
        queryWrapper.orderBy(ClassWordTask::getCreatedAt, false);
    }

    private Date toSqlDate(LocalDate localDate) {
        return localDate == null ? null : Date.valueOf(localDate);
    }

    private ClassWordTaskVO toClassWordTaskVO(ClassWordTask task) {
        ClassWordTaskVO vo = new ClassWordTaskVO();
        BeanUtil.copyProperties(task, vo);
        if (task.getStartDate() != null) {
            vo.setStartDate(task.getStartDate().toLocalDate());
        }
        if (task.getEndDate() != null) {
            vo.setEndDate(task.getEndDate().toLocalDate());
        }
        return vo;
    }
}
