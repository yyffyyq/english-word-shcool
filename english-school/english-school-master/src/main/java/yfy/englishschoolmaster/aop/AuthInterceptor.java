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
import yfy.englishschoolmaster.constant.UserConstant;
import yfy.englishschoolmaster.exception.ErrorCode;
import yfy.englishschoolmaster.exception.ThrowUtils;
import yfy.englishschoolmaster.model.vo.UserAccountVO;
import yfy.englishschoolmaster.service.UserSessionRedisService;

/**
 * 权限校验切面：从请求头取 openid，读 Redis 会话并校验角色
 */
@Aspect
@Component
public class AuthInterceptor {

    private static final String STATUS_DISABLED = "DISABLED";

    @Resource
    private UserSessionRedisService userSessionRedisService;

    /**
     * 执行拦截
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

        // 2. 从请求头读取 openid
        String openid = request.getHeader(UserConstant.OPENID_HEADER);
        ThrowUtils.throwIf(StrUtil.isBlank(openid), ErrorCode.NOT_LOGIN_ERROR, "未登录，请先登录");

        // 3. 从 Redis 获取登录用户
        UserAccountVO loginUser = userSessionRedisService.getLoginUserByOpenid(openid.trim());
        ThrowUtils.throwIf(loginUser == null || loginUser.getId() == null,
                ErrorCode.NOT_LOGIN_ERROR, "登录已过期，请重新登录");

        // 4. 校验账号状态
        ThrowUtils.throwIf(STATUS_DISABLED.equals(loginUser.getStatus()),
                ErrorCode.FORBIDDEN_ERROR, "账号已被禁用，请联系管理员");

        // 5. 校验角色（mustRole 为空则仅校验登录）
        String mustRole = authCheck.mustRole();
        if (StrUtil.isNotBlank(mustRole)) {
            ThrowUtils.throwIf(!mustRole.equalsIgnoreCase(loginUser.getRole()),
                    ErrorCode.NO_AUTH_ERROR, "无权限访问");
        }

        // 6. 将登录用户放入请求属性，供 Controller 使用
        request.setAttribute(UserConstant.LOGIN_USER_ATTR, loginUser);
        return joinPoint.proceed();
    }
}
