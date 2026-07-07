package yfy.englishschoolmaster.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.util.StrUtil;
import com.mybatisflex.core.query.QueryWrapper;
import com.mybatisflex.spring.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import yfy.englishschoolmaster.exception.ErrorCode;
import yfy.englishschoolmaster.exception.ThrowUtils;
import yfy.englishschoolmaster.mapper.UserAccountMapper;
import yfy.englishschoolmaster.model.dto.UserAccountLoginRequest;
import yfy.englishschoolmaster.model.dto.UserAccountStudentRegisterRequest;
import yfy.englishschoolmaster.model.dto.WxSessionResult;
import yfy.englishschoolmaster.model.entity.UserAccount;
import yfy.englishschoolmaster.model.vo.UserAccountVO;
import yfy.englishschoolmaster.service.UserAccountService;
import yfy.englishschoolmaster.service.WxMiniAppService;

/**
 * 用户账号表，统一存管理员、教师、学生基础信息 服务层实现。
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
@Service
public class UserAccountServiceImpl extends ServiceImpl<UserAccountMapper, UserAccount> implements UserAccountService {

    private static final String STATUS_DISABLED = "DISABLED";
    private static final String STATUS_NORMAL = "NORMAL";
    private static final String ROLE_STUDENT = "STUDENT";

    @Autowired
    private WxMiniAppService wxMiniAppService;

    /**
     * 获取登录用户信息
     *
     * @param request 登录请求体
     * @return 封装后信息 UserAccountVO；未注册时返回 null
     */
    @Override
    public UserAccountVO getLogin(UserAccountLoginRequest request) {
        ThrowUtils.throwIf(request == null, ErrorCode.PARAMS_ERROR, "微信登录请求为空");
        ThrowUtils.throwIf(StrUtil.isBlank(request.getCode()), ErrorCode.PARAMS_ERROR, "微信登录 code 不能为空");
        ThrowUtils.throwIf(StrUtil.isBlank(request.getLoginRole()), ErrorCode.PARAMS_ERROR, "登录角色不能为空");

        String loginRole = normalizeRole(request.getLoginRole());
        ThrowUtils.throwIf(!isValidMiniAppRole(loginRole), ErrorCode.PARAMS_ERROR, "登录角色仅支持 TEACHER 或 STUDENT");

        WxSessionResult sessionResult = wxMiniAppService.code2Session(request.getCode());
        String openid = sessionResult.getOpenid();

        UserAccount userAccount = this.getOne(QueryWrapper.create()
                .eq(UserAccount::getOpenid, openid));
        if (userAccount == null) {
            return null;
        }

        ThrowUtils.throwIf(!loginRole.equalsIgnoreCase(userAccount.getRole()),
                ErrorCode.NO_AUTH_ERROR, "当前账号角色与登录入口不一致，请切换入口后重试");
        ThrowUtils.throwIf(STATUS_DISABLED.equals(userAccount.getStatus()),
                ErrorCode.FORBIDDEN_ERROR, "账号已被禁用，请联系管理员");

        return toUserAccountVO(userAccount);
    }

    /**
     * 学生注册：将 openid、姓名、学号写入 user_account 表
     *
     * @param request 学生注册请求体
     * @return 注册成功后的用户信息
     */
    @Override
    public UserAccountVO registerStudent(UserAccountStudentRegisterRequest request) {
        ThrowUtils.throwIf(request == null, ErrorCode.PARAMS_ERROR, "学生注册请求为空");
        ThrowUtils.throwIf(StrUtil.isBlank(request.getOpenid()), ErrorCode.PARAMS_ERROR, "openid 不能为空");
        ThrowUtils.throwIf(StrUtil.isBlank(request.getRealName()), ErrorCode.PARAMS_ERROR, "姓名不能为空");
        ThrowUtils.throwIf(StrUtil.isBlank(request.getStudentNo()), ErrorCode.PARAMS_ERROR, "学号不能为空");

        String openid = request.getOpenid().trim();
        String realName = request.getRealName().trim();
        String studentNo = request.getStudentNo().trim();

        UserAccount existByOpenid = this.getOne(QueryWrapper.create()
                .eq(UserAccount::getOpenid, openid));
        ThrowUtils.throwIf(existByOpenid != null, ErrorCode.OPERATION_ERROR, "该微信账号已注册，请直接登录");

        UserAccount existByStudentNo = this.getOne(QueryWrapper.create()
                .eq(UserAccount::getStudentNo, studentNo)
                .eq(UserAccount::getRole, ROLE_STUDENT));
        ThrowUtils.throwIf(existByStudentNo != null, ErrorCode.OPERATION_ERROR, "该学号已被注册");

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

        boolean saved = this.save(userAccount);
        ThrowUtils.throwIf(!saved, ErrorCode.OPERATION_ERROR, "学生注册失败");

        return toUserAccountVO(userAccount);
    }

    /**
     * 统一角色值为大写，便于和数据库字段比对
     */
    private String normalizeRole(String role) {
        return role.trim().toUpperCase();
    }

    /**
     * 校验小程序登录角色
     */
    private boolean isValidMiniAppRole(String role) {
        return "TEACHER".equals(role) || "STUDENT".equals(role);
    }

    /**
     * 实体转 VO，避免向前端暴露 openid 等敏感字段
     */
    private UserAccountVO toUserAccountVO(UserAccount userAccount) {
        UserAccountVO userAccountVO = new UserAccountVO();
        BeanUtil.copyProperties(userAccount, userAccountVO);
        return userAccountVO;
    }
}
