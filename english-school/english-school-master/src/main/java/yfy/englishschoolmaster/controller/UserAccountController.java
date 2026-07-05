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

        // 2. 判断是否为第一次登录，如果是第一次进行注册操作
        UserAccountVO login_info = userAccountService.getLogin(request);
        // a. 判断login_info状态返回小程序信息用于进行下一步判断
        // 引导用户到注册接口进行注册
        ThrowUtils.throwIf(login_info == null ,ErrorCode.PARAMS_ERROR,"请注册用户");

        // 3. 封装返回类型给前端
        return ResultUtils.success(login_info);
    }

    // 2. 微信小程序登录注册接口：
    //  这里分为学生注册和教师注册
    //  我计划在这类采用模版方法实现
    //  教师注册多一个审核流程。

    // 3. 微信登录注销接口：
    //  这里需要做的是在注销用户信息。
}
