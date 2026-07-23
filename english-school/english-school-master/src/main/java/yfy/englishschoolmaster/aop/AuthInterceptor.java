package yfy.englishschoolmaster.aop;

import cn.hutool.core.util.StrUtil;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import yfy.englishschoolmaster.annotation.AuthCheck;
import yfy.englishschoolmaster.constant.RedisTypeConstant;
import yfy.englishschoolmaster.constant.UserConstant;
import yfy.englishschoolmaster.exception.ErrorCode;
import yfy.englishschoolmaster.exception.ThrowUtils;
import yfy.englishschoolmaster.model.vo.UserAccountVO;
import yfy.englishschoolmaster.service.RedisService;
import yfy.englishschoolmaster.service.UserSessionRedisService;

/**
 * 权限校验切面：
 * 微信登录从请求头取 openid，读 wx.login 会话；
 * 系统登录无 openid，从请求头取 userId，读 system.user.login.ids 会话。
 */
@Aspect
@Component
public class AuthInterceptor {

    private static final String STATUS_DISABLED = "DISABLED";

    @Resource
    private UserSessionRedisService userSessionRedisService;

    @Resource
    private RedisService redisService;

    /**
     * 执行拦截：
     * 优先按 openid 识别微信会话，否则按 userId 识别系统会话，
     *       再校验账号状态与 mustRole。
     *
     * @param joinPoint 切入点
     * @param authCheck 权限校验注解
     * @return 目标方法执行结果
     * @throws Throwable 目标方法或权限校验抛出的异常
     */
    @Around("@annotation(authCheck)")
    public Object doIntercepter(ProceedingJoinPoint joinPoint, AuthCheck authCheck) throws Throwable {
        // 1. 获取当前请求
        ServletRequestAttributes requestAttributes =
                (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        HttpServletRequest request = requestAttributes.getRequest();

        // 2. 按登录来源读取会话：有 openid → 微信登录；无 openid 有 userId → 系统登录
        UserAccountVO loginUser = resolveLoginUser(request);
        ThrowUtils.throwIf(loginUser == null || loginUser.getId() == null,
                ErrorCode.NOT_LOGIN_ERROR, "登录已过期，请重新登录");

        // 3. 校验账号状态
        ThrowUtils.throwIf(STATUS_DISABLED.equals(loginUser.getStatus()),
                ErrorCode.FORBIDDEN_ERROR, "账号已被禁用，请联系管理员");

        // 4. 校验角色（mustRole 为空则仅校验登录）
        String mustRole = authCheck.mustRole();
        if (StrUtil.isNotBlank(mustRole)) {
            ThrowUtils.throwIf(!mustRole.equalsIgnoreCase(loginUser.getRole()),
                    ErrorCode.NO_AUTH_ERROR, "无权限访问");
        }

        // 5. 将登录用户放入请求属性，供 Controller 使用
        request.setAttribute(UserConstant.LOGIN_USER_ATTR, loginUser);
        return joinPoint.proceed();
    }

    /**
     * 解析当前登录用户：
     * 1）请求头携带 openid → 从微信登录 Redis 读取；
     * 2）请求头携带 userId → 从系统登录 Redis 读取；
     * 3）两者都没有 → 未登录。
     *
     * @param request HTTP 请求
     * @return 登录用户，未命中返回 null
     */
    private UserAccountVO resolveLoginUser(HttpServletRequest request) {
        String openid = request.getHeader(UserConstant.OPENID_HEADER);
        if (StrUtil.isNotBlank(openid)) {
            return userSessionRedisService.getLoginUserByOpenid(openid.trim());
        }

        String userId = request.getHeader(UserConstant.USER_ID_HEADER);
        ThrowUtils.throwIf(StrUtil.isBlank(userId), ErrorCode.NOT_LOGIN_ERROR, "未登录，请先登录");
        return redisService.read(
                userId.trim(),
                RedisTypeConstant.SYSTEM_USER_LOGIN_IDS,
                UserAccountVO.class
        );
    }
}
