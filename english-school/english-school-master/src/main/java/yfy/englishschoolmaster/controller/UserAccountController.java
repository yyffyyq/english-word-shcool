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
import yfy.englishschoolmaster.model.dto.UserAccountLoginRequest;
import yfy.englishschoolmaster.model.dto.UserAccountStudentRegisterRequest;
import yfy.englishschoolmaster.model.entity.UserAccount;
import yfy.englishschoolmaster.model.vo.UserAccountVO;
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

        // 2. 查询登录信息；未注册时返回仅含 openid 的 VO，前端据此引导注册
        UserAccountVO loginInfo = userAccountService.getLogin(request);

        // 3. 封装返回类型给前端（id 为空表示未注册，openid 供注册接口使用）
        return ResultUtils.success(loginInfo);
    }

    /**
     * 学生注册接口：微信小程序提交 openid、姓名、学号后写入数据库
     *
     * @param request 学生注册请求体
     * @return 注册成功后的用户信息
     */
    @PostMapping("/register/student")
    public BaseResponse<UserAccountVO> registerStudent(@RequestBody UserAccountStudentRegisterRequest request) {
        ThrowUtils.throwIf(request == null, ErrorCode.PARAMS_ERROR, "学生注册请求为空");
        UserAccountVO userAccountVO = userAccountService.registerStudent(request);
        return ResultUtils.success(userAccountVO);
    }

    /**
     * 教师注册接口：待实现，暂返回空
     *
     * @return 空
     */
    @PostMapping("/register/teacher")
    public BaseResponse<Void> registerTeacher() {
        return ResultUtils.success(null);
    }

    // 3. 微信登录注销接口：
    //  这里需要做的是在注销用户信息。
}
