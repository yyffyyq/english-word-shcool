package yfy.englishschoolmaster.config;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Contact;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.parameters.Parameter;
import io.swagger.v3.oas.models.media.StringSchema;
import org.springdoc.core.customizers.OperationCustomizer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.method.HandlerMethod;
import yfy.englishschoolmaster.annotation.AuthCheck;

/**
 * Knife4j / OpenAPI 文档配置。
 * 文档地址：/doc.html
 */
@Configuration
public class OpenApiConfig {

    /**
     * 注册 OpenAPI 文档元信息：
     * 配置 API 标题、描述与版本号
     *
     * @return OpenAPI 实例
     */
    @Bean
    public OpenAPI englishSchoolOpenAPI() {
        return new OpenAPI()
                .info(new Info()
                        .title("英语单词学堂 API 文档")
                        .description("英语单词学堂后端接口说明。需登录的接口请在请求头携带 openid（小程序）或 userId（Web 管理端）。")
                        .version("1.0.0")
                        .contact(new Contact().name("yfy").url("https://github.com/yyffyyq")));
    }

    /**
     * 给带 @AuthCheck 的接口自动补充登录请求头说明，
     *       便于在 doc.html 调试
     *
     * @return OperationCustomizer 实例
     */
    @Bean
    public OperationCustomizer authHeaderCustomizer() {
        return (operation, handlerMethod) -> {
            if (hasAuthCheck(handlerMethod)) {
                operation.addParametersItem(new Parameter()
                        .in("header")
                        .name("openid")
                        .description("微信小程序登录态：用户 openid（与 userId 二选一）")
                        .required(false)
                        .schema(new StringSchema()));
                operation.addParametersItem(new Parameter()
                        .in("header")
                        .name("userId")
                        .description("Web 管理端登录态：系统用户 ID（与 openid 二选一）")
                        .required(false)
                        .schema(new StringSchema()));
            }
            return operation;
        };
    }

    private boolean hasAuthCheck(HandlerMethod handlerMethod) {
        return handlerMethod.getMethodAnnotation(AuthCheck.class) != null
                || handlerMethod.getBeanType().getAnnotation(AuthCheck.class) != null;
    }
}
