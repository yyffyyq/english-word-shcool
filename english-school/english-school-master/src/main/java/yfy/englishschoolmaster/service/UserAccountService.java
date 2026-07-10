package yfy.englishschoolmaster.service;

import com.mybatisflex.core.service.IService;
import yfy.englishschoolmaster.model.dto.SystemLoginRequest;
import yfy.englishschoolmaster.model.dto.SystemRegisterRequest;
import yfy.englishschoolmaster.model.dto.UserAccountLoginRequest;
import yfy.englishschoolmaster.model.dto.UserAccountStudentRegisterRequest;
import yfy.englishschoolmaster.model.entity.UserAccount;
import yfy.englishschoolmaster.model.vo.UserAccountVO;

/**
 * 用户账号表，统一存管理员、教师、学生基础信息 服务层。
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
public interface UserAccountService extends IService<UserAccount> {

    /**
     * 获取登录用户信息
     * @param request 登录请求体
     * @return 封装后信息 UserAccountVO
     */
    UserAccountVO getLogin(UserAccountLoginRequest request);

    /**
     * 学生注册
     *
     * @param request 学生注册请求体
     * @return 注册成功后的用户信息
     */
    UserAccountVO registerStudent(UserAccountStudentRegisterRequest request);

    /**
     * Web 管理端登录
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
