package yfy.englishschoolmaster.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.util.StrUtil;
import com.mybatisflex.core.query.QueryWrapper;
import com.mybatisflex.spring.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.Collections;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;
import yfy.englishschoolmaster.config.RedisConfig;
import yfy.englishschoolmaster.constant.RedisTypeConstant;
import yfy.englishschoolmaster.exception.ErrorCode;
import yfy.englishschoolmaster.exception.ThrowUtils;
import yfy.englishschoolmaster.mapper.UserAccountMapper;
import yfy.englishschoolmaster.model.dto.SystemLoginRequest;
import yfy.englishschoolmaster.model.dto.SystemRegisterRequest;
import yfy.englishschoolmaster.model.dto.UserAccountLoginRequest;
import yfy.englishschoolmaster.model.dto.UserAccountStudentRegisterRequest;
import yfy.englishschoolmaster.model.dto.WxSessionResult;
import yfy.englishschoolmaster.model.entity.ClassStudent;
import yfy.englishschoolmaster.model.entity.UserAccount;
import yfy.englishschoolmaster.model.vo.UserAccountVO;
import yfy.englishschoolmaster.service.ClassStudentService;
import yfy.englishschoolmaster.service.RedisService;
import yfy.englishschoolmaster.service.UserAccountService;
import yfy.englishschoolmaster.service.UserSessionRedisService;
import yfy.englishschoolmaster.service.WxMiniAppService;
import yfy.englishschoolmaster.utils.PasswordUtils;

/**
 * 用户账号表，统一存管理员、教师、学生基础信息 服务层实现。
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
@Service
public class UserAccountServiceImpl extends ServiceImpl<UserAccountMapper, UserAccount> implements UserAccountService {

    private static final String STATUS_DISABLED = "DISABLED";
    private static final String STATUS_NORMAL = "NORMAL";
    private static final String STATUS_IN_CLASS = "IN_CLASS";
    private static final String ROLE_STUDENT = "STUDENT";
    private static final String ROLE_ADMIN = "ADMIN";

    @Autowired
    private WxMiniAppService wxMiniAppService;

    @Autowired
    private UserSessionRedisService userSessionRedisService;

    @Autowired
    private ClassStudentService classStudentService;

    @Autowired
    private RedisService redisService;

    /**
     * 获取登录用户信息
     *
     * @param request 登录请求体
     * @return 封装后信息 UserAccountVO；未注册时仅返回 openid
     */
    @Override
    public UserAccountVO getLogin(UserAccountLoginRequest request) {

        // 1. 判断参数是否正确
        ThrowUtils.throwIf(request == null, ErrorCode.PARAMS_ERROR, "微信登录请求为空");
        ThrowUtils.throwIf(StrUtil.isBlank(request.getCode()), ErrorCode.PARAMS_ERROR, "微信登录 code 不能为空");
        ThrowUtils.throwIf(StrUtil.isBlank(request.getLoginRole()), ErrorCode.PARAMS_ERROR, "登录角色不能为空");

        // 2. 提取登录用户请求身份
        String loginRole = normalizeRole(request.getLoginRole());
        ThrowUtils.throwIf(!isValidMiniAppRole(loginRole), ErrorCode.PARAMS_ERROR, "登录角色仅支持 TEACHER 或 STUDENT");

        // 3. 发起获取登录微信用户信息，并提取openId
        WxSessionResult sessionResult = wxMiniAppService.code2Session(request.getCode());
        String openid = sessionResult.getOpenid();

        // 4. 优先从 Redis 读取已登录用户，命中则直接返回
        UserAccountVO cachedUser = userSessionRedisService.getLoginUserByOpenid(openid);
        if (cachedUser != null && cachedUser.getId() != null) {
            validateLoginUser(cachedUser, loginRole);
            userSessionRedisService.saveLoginUser(cachedUser);
            // 登录成功后缓存该用户已加入的班级 ID 列表
            cacheStudentClassIds(cachedUser);
            return cachedUser;
        }

        // 5. Redis 未命中，通过 openId 查询数据库
        UserAccount userAccount = this.getOne(QueryWrapper.create()
                .eq(UserAccount::getOpenid, openid));
        if (userAccount == null) {
            UserAccountVO unregisteredVO = new UserAccountVO();
            unregisteredVO.setOpenid(openid);
            return unregisteredVO;
        }

        // 6. 校验账号状态并写入 Redis
        UserAccountVO userAccountVO = toUserAccountVO(userAccount);
        validateLoginUser(userAccountVO, loginRole);
        userSessionRedisService.saveLoginUser(userAccountVO);
        // 登录成功后缓存该用户已加入的班级 ID 列表
        cacheStudentClassIds(userAccountVO);
        return userAccountVO;
    }

    /**
     * 登录成功后，按用户 id 查询 class_student 中在班班级，
     *       将 classId 列表写入 Redis（key: student.class.ids:{userId}）
     * @param userAccountVO 已登录用户
     */
    private void cacheStudentClassIds(UserAccountVO userAccountVO) {

        // 1. 未注册用户或无 id 时跳过
        if (userAccountVO == null || userAccountVO.getId() == null) {
            return;
        }

        // 2. 按学生 id 查询在班班级关系
        List<ClassStudent> classStudents = classStudentService.list(QueryWrapper.create()
                .eq(ClassStudent::getStudentId, userAccountVO.getId())
                .eq(ClassStudent::getStatus, STATUS_IN_CLASS));

        // 3. 提取班级 id 列表（可能为空列表）
        List<Long> classIds = classStudents == null || classStudents.isEmpty()
                ? Collections.emptyList()
                : classStudents.stream()
                .map(ClassStudent::getClassId)
                .filter(Objects::nonNull)
                .distinct()
                .collect(Collectors.toList());

        // 4. 写入 Redis，过期时间与登录会话一致
        redisService.write(classIds, RedisConfig.DEFAULT_EXPIRE,
                RedisTypeConstant.STUDENT_CLASS_IDS, String.valueOf(userAccountVO.getId()));
    }

    /**
     * 判断登录用户角色与登录入口是否一致：
     *       校验登录入口角色是否与账号角色匹配
     *       校验账号是否处于禁用状态
     * @param userAccountVO
     * @param loginRole
     */
    private void validateLoginUser(UserAccountVO userAccountVO, String loginRole) {

        // 1. 判断登录入口与账号角色是否一致
        ThrowUtils.throwIf(!loginRole.equalsIgnoreCase(userAccountVO.getRole()),
                ErrorCode.NO_AUTH_ERROR, "当前账号角色与登录入口不一致，请切换入口后重试");

        // 2. 判断账号是否被禁用
        ThrowUtils.throwIf(STATUS_DISABLED.equals(userAccountVO.getStatus()),
                ErrorCode.FORBIDDEN_ERROR, "账号已被禁用，请联系管理员");
    }

    /**
     * 学生注册：
     * 将 openid、姓名、学号写入 user_account 表，
     *       注册前校验微信账号与学号是否重复
     * @param request
     * @return
     */
    @Override
    public UserAccountVO registerStudent(UserAccountStudentRegisterRequest request) {

        // 1. 判断参数是否正确
        ThrowUtils.throwIf(request == null, ErrorCode.PARAMS_ERROR, "学生注册请求为空");
        ThrowUtils.throwIf(StrUtil.isBlank(request.getOpenid()), ErrorCode.PARAMS_ERROR, "openid 不能为空");
        ThrowUtils.throwIf(StrUtil.isBlank(request.getRealName()), ErrorCode.PARAMS_ERROR, "姓名不能为空");
        ThrowUtils.throwIf(StrUtil.isBlank(request.getStudentNo()), ErrorCode.PARAMS_ERROR, "学号不能为空");

        // 2. 提取需要判断的字段
        String openid = request.getOpenid().trim();
        String realName = request.getRealName().trim();
        String studentNo = request.getStudentNo().trim();

        // 3. 判断微信账号是否已注册
        UserAccount existByOpenid = this.getOne(QueryWrapper.create()
                .eq(UserAccount::getOpenid, openid));
        ThrowUtils.throwIf(existByOpenid != null, ErrorCode.OPERATION_ERROR, "该微信账号已注册，请直接登录");

        // 4. 判断学号是否已被占用
        UserAccount existByStudentNo = this.getOne(QueryWrapper.create()
                .eq(UserAccount::getStudentNo, studentNo)
                .eq(UserAccount::getRole, ROLE_STUDENT));
        ThrowUtils.throwIf(existByStudentNo != null, ErrorCode.OPERATION_ERROR, "该学号已被注册");

        // 5. 创建学生账号对象
        LocalDateTime now = LocalDateTime.now();
        UserAccount userAccount = UserAccount.builder()
                .openid(openid)
                .realName(realName)
                .studentNo(studentNo)
                .role(ROLE_STUDENT)
                .status(STATUS_NORMAL)
                .createdAt(now)
                .updatedAt(now)
                .build();

        // 6. 存入数据库
        boolean saved = this.save(userAccount);
        ThrowUtils.throwIf(!saved, ErrorCode.OPERATION_ERROR, "学生注册失败");

        // 7. 返回封装后的用户信息
        return toUserAccountVO(userAccount);
    }

    /**
     * Web 管理端登录：
     * 校验 username 与加盐后的 password_hash 是否匹配，
     *       密码会先使用固定盐值加密后再查询数据库；
     * 登录成功后将用户信息写入 Redis（key: system.user.login.ids:{userId}），
     *       供管理端无 openid 场景下的会话校验使用。
     *
     * @param request 登录请求
     * @return 登录用户信息
     */
    @Override
    public UserAccountVO systemLogin(SystemLoginRequest request) {

        // 1. 判断参数是否正确
        ThrowUtils.throwIf(request == null, ErrorCode.PARAMS_ERROR, "登录请求为空");
        ThrowUtils.throwIf(StrUtil.isBlank(request.getUsername()), ErrorCode.PARAMS_ERROR, "账号不能为空");
        ThrowUtils.throwIf(StrUtil.isBlank(request.getPassword()), ErrorCode.PARAMS_ERROR, "密码不能为空");

        // 2. 提取账号并对密码加盐加密
        String username = request.getUsername().trim();
        String passwordHash = PasswordUtils.encode(request.getPassword());

        // 3. 查询数据库中是否存在匹配账号
        UserAccount userAccount = this.getOne(QueryWrapper.create()
                .eq(UserAccount::getUsername, username)
                .eq(UserAccount::getPasswordHash, passwordHash));
        ThrowUtils.throwIf(userAccount == null, ErrorCode.NOT_LOGIN_ERROR, "账号或密码错误");
        ThrowUtils.throwIf(STATUS_DISABLED.equals(userAccount.getStatus()),
                ErrorCode.FORBIDDEN_ERROR, "账号已被禁用，请联系管理员");

        // 4. 封装登录用户，并按用户 ID 写入 Redis 会话（无 openid）
        UserAccountVO userAccountVO = toUserAccountVO(userAccount);
        ThrowUtils.throwIf(userAccountVO.getId() == null, ErrorCode.SYSTEM_ERROR, "用户 ID 异常");
        redisService.write(
                userAccountVO,
                RedisConfig.DEFAULT_EXPIRE,
                RedisTypeConstant.SYSTEM_USER_LOGIN_IDS,
                String.valueOf(userAccountVO.getId())
        );

        // 5. 返回封装后的用户信息
        return userAccountVO;
    }

    /**
     * Web 管理端注册：
     * 创建管理员账号，
     *       密码使用固定盐值加密后写入 password_hash
     *       角色默认设置为 ADMIN
     * @param request
     * @return
     */
    @Override
    public UserAccountVO systemRegister(SystemRegisterRequest request) {

        // 1. 判断参数是否正确
        ThrowUtils.throwIf(request == null, ErrorCode.PARAMS_ERROR, "注册请求为空");
        ThrowUtils.throwIf(StrUtil.isBlank(request.getUsername()), ErrorCode.PARAMS_ERROR, "账号不能为空");
        ThrowUtils.throwIf(StrUtil.isBlank(request.getPassword()), ErrorCode.PARAMS_ERROR, "密码不能为空");
        ThrowUtils.throwIf(StrUtil.isBlank(request.getRealName()), ErrorCode.PARAMS_ERROR, "姓名不能为空");

        // 2. 提取需要写入的字段
        String username = request.getUsername().trim();
        String realName = request.getRealName().trim();
        String schoolName = StrUtil.isBlank(request.getSchoolName()) ? null : request.getSchoolName().trim();

        // 3. 判断账号是否已存在
        UserAccount existByUsername = this.getOne(QueryWrapper.create()
                .eq(UserAccount::getUsername, username));
        ThrowUtils.throwIf(existByUsername != null, ErrorCode.OPERATION_ERROR, "该账号已存在");

        // 4. 创建管理员账号对象
        LocalDateTime now = LocalDateTime.now();
        UserAccount userAccount = UserAccount.builder()
                .username(username)
                .passwordHash(PasswordUtils.encode(request.getPassword()))
                .role(ROLE_ADMIN)
                .realName(realName)
                .schoolName(schoolName)
                .status(STATUS_NORMAL)
                .createdAt(now)
                .updatedAt(now)
                .build();

        // 5. 存入数据库
        boolean saved = this.save(userAccount);
        ThrowUtils.throwIf(!saved, ErrorCode.OPERATION_ERROR, "账号创建失败");

        // 6. 返回封装后的用户信息
        return toUserAccountVO(userAccount);
    }

    /**
     * 统一角色值为大写：
     *       便于和数据库字段比对
     * @param role
     * @return
     */
    private String normalizeRole(String role) {
        return role.trim().toUpperCase();
    }

    /**
     * 校验小程序登录角色：
     *       仅支持 TEACHER 或 STUDENT
     * @param role
     * @return
     */
    private boolean isValidMiniAppRole(String role) {
        return "TEACHER".equals(role) || "STUDENT".equals(role);
    }

    /**
     * 实体转 VO：
     *       避免向前端暴露 openid 等敏感字段
     * @param userAccount
     * @return
     */
    private UserAccountVO toUserAccountVO(UserAccount userAccount) {

        // 1. 创建 VO 对象并复制属性
        UserAccountVO userAccountVO = new UserAccountVO();
        BeanUtil.copyProperties(userAccount, userAccountVO);

        // 2. 返回封装后的信息
        return userAccountVO;
    }
}
