package yfy.englishschoolmaster.service;

import com.mybatisflex.core.service.IService;
import yfy.englishschoolmaster.model.dto.SystemLoginRequest;
import yfy.englishschoolmaster.model.dto.SystemRegisterRequest;
import yfy.englishschoolmaster.model.dto.UserAccountLoginRequest;
import yfy.englishschoolmaster.model.dto.UserAccountStudentRegisterRequest;
import yfy.englishschoolmaster.model.entity.UserAccount;
import yfy.englishschoolmaster.model.vo.UserAccountVO;

/**
 * 用户账号服务：
 * 统一管理管理员、教师、学生账号，
 *       提供小程序微信登录、学生注册及 Web 管理端登录注册能力。
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
public interface UserAccountService extends IService<UserAccount> {

    /**
     * 小程序微信登录：
     * 通过 code 换取 openid 后查询或缓存用户信息，
     *       未注册时仅返回 openid
     *       学生登录成功后刷新班级、今日作业与复习 Redis 缓存
     *
     * @param request 登录请求体（code、登录角色 TEACHER/STUDENT）
     * @return 用户信息 VO；未注册时仅含 openid
     */
    UserAccountVO getLogin(UserAccountLoginRequest request);

    /**
     * 学生注册：
     * 将 openid、姓名、学号写入 user_account 表，
     *       注册前校验微信账号与学号是否重复
     *
     * @param request 学生注册请求体
     * @return 注册成功后的用户信息
     */
    UserAccountVO registerStudent(UserAccountStudentRegisterRequest request);

    /**
     * Web 管理端登录：
     * 校验账号密码后，将用户信息写入 Redis（key: system.user.login.ids:{userId}）
     *
     * @param request 登录请求体
     * @return 登录用户信息
     */
    UserAccountVO systemLogin(SystemLoginRequest request);

    /**
     * Web 管理端注册
     *
     * @param request 注册请求体
     * @return 注册后的用户信息
     */
    UserAccountVO systemRegister(SystemRegisterRequest request);
}
