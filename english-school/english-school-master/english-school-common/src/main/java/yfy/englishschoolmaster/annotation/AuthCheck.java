package yfy.englishschoolmaster.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 权限校验注解：
 * 标注在 Controller 方法上，
 *       由 {@link yfy.englishschoolmaster.aop.AuthInterceptor} 校验登录态与角色
 */
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
public @interface AuthCheck {

    /**
     * 必须拥有的角色：
     * 为空时仅校验是否已登录，
     *       非空时校验当前用户角色是否匹配
     *
     * @return 角色标识，如 ADMIN / TEACHER / STUDENT
     */
    String mustRole() default "";
}
