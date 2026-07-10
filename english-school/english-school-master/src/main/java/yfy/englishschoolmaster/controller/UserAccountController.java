package yfy.englishschoolmaster.controller;

import com.mybatisflex.core.paginate.Page;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.beans.factory.annotation.Autowired;
import yfy.englishschoolmaster.common.BaseResponse;
import yfy.englishschoolmaster.common.ResultUtils;
import yfy.englishschoolmaster.exception.ErrorCode;
import yfy.englishschoolmaster.exception.ThrowUtils;
import yfy.englishschoolmaster.model.dto.SystemLoginRequest;
import yfy.englishschoolmaster.model.dto.SystemRegisterRequest;
import yfy.englishschoolmaster.model.dto.UserAccountLoginRequest;
import yfy.englishschoolmaster.model.dto.UserAccountStudentRegisterRequest;
import yfy.englishschoolmaster.model.dto.UserAccountTeacherRegisterRequest;
import yfy.englishschoolmaster.model.entity.UserAccount;
import yfy.englishschoolmaster.model.vo.TeacherApprovalVO;
import yfy.englishschoolmaster.model.vo.UserAccountVO;
import yfy.englishschoolmaster.service.TeacherApprovalService;
import yfy.englishschoolmaster.service.UserAccountService;
import org.springframework.web.bind.annotation.RestController;
import java.util.List;

/**
 * 用户账号表，统一存管理员、教师、学生基础信息 控制层。
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
@RestController
@RequestMapping("/userAccount")
public class UserAccountController {

    @Autowired
    private UserAccountService userAccountService;

    @Autowired
    private TeacherApprovalService teacherApprovalService;

    /**
     * 微信一键登录接口：
     * 匹配数据库中的用户信息，
     *       判断是否需要注册
     *       a. 第一次登录需要注册
     *       b. 已经登录过了，就匹配数据库中openid。
     * 这里需要注意 教师登录需要再做一个判断，这里采用多表查询 通过openid先是拿到user_account表中id再拿id去查找审核表中审核状态是否通过
     * @param request
     * @return
     */
    @PostMapping("/login")
    public BaseResponse<UserAccountVO> loginUser(@RequestBody UserAccountLoginRequest request){

        // 1. 判断请求是否为空
        ThrowUtils.throwIf(request == null , ErrorCode.PARAMS_ERROR,"微信登录请求为空");

        // 2. 查询登录信息：优先读 Redis，未命中再查库；未注册时返回仅含 openid 的 VO
        UserAccountVO loginInfo = userAccountService.getLogin(request);

        // 3. 封装返回类型给前端（id 为空表示未注册，openid 供注册接口使用）
        return ResultUtils.success(loginInfo);
    }

    /**
     * Web 管理端登录接口：
     * 校验管理员账号与密码，
     *       密码会先使用固定盐值加密
     *       再与数据库中 password_hash 字段比对
     * @param request
     * @return
     */
    @PostMapping("/system/login")
    public BaseResponse<UserAccountVO> systemLogin(@RequestBody SystemLoginRequest request){

        // 1. 判断请求是否为空
        ThrowUtils.throwIf(request == null , ErrorCode.PARAMS_ERROR,"登录请求为空");

        // 2. 校验账号密码并获取登录用户信息
        UserAccountVO userAccountVO = userAccountService.systemLogin(request);

        // 3. 封装返回类型给前端
        return ResultUtils.success(userAccountVO);
    }

    /**
     * Web 管理端注册接口：
     * 创建新的管理员账号，
     *       密码使用固定盐值加密后写入 password_hash
     *       角色默认设置为 ADMIN
     * @param request
     * @return
     */
    @PostMapping("/system/register")
    public BaseResponse<UserAccountVO> systemRegister(@RequestBody SystemRegisterRequest request){

        // 1. 判断请求是否为空
        ThrowUtils.throwIf(request == null , ErrorCode.PARAMS_ERROR,"注册请求为空");

        // 2. 创建管理员账号
        UserAccountVO userAccountVO = userAccountService.systemRegister(request);

        // 3. 封装返回类型给前端
        return ResultUtils.success(userAccountVO);
    }

    /**
     * 学生注册接口：
     * 微信小程序提交 openid、姓名、学号，
     *       校验通过后直接写入 user_account 表
     *       学生注册无需审批，注册成功即可登录
     * @param request
     * @return
     */
    @PostMapping("/register/student")
    public BaseResponse<UserAccountVO> registerStudent(@RequestBody UserAccountStudentRegisterRequest request){

        // 1. 判断请求是否为空
        ThrowUtils.throwIf(request == null , ErrorCode.PARAMS_ERROR,"学生注册请求为空");

        // 2. 写入学生账号信息
        UserAccountVO userAccountVO = userAccountService.registerStudent(request);

        // 3. 封装返回类型给前端
        return ResultUtils.success(userAccountVO);
    }

    /**
     * 教师注册接口：
     * 微信小程序提交教师注册信息，
     *       生成教师审批记录写入 teacher_approval 表
     *       审批状态为待审批，暂不创建 user_account 记录
     * @param request
     * @return
     */
    @PostMapping("/register/teacher")
    public BaseResponse<TeacherApprovalVO> registerTeacher(@RequestBody UserAccountTeacherRegisterRequest request){

        // 1. 判断请求是否为空
        ThrowUtils.throwIf(request == null , ErrorCode.PARAMS_ERROR,"教师注册请求为空");

        // 2. 提交教师注册审批申请
        TeacherApprovalVO teacherApprovalVO = teacherApprovalService.registerTeacher(request);

        // 3. 封装返回类型给前端
        return ResultUtils.success(teacherApprovalVO);
    }

    // 3. 微信登录注销接口：
    //  这里需要做的是在注销用户信息。
}
