package yfy.englishschoolmaster.config;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.module.SimpleModule;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;

import org.springframework.boot.jackson.JsonComponent;
import org.springframework.context.annotation.Bean;
import org.springframework.http.converter.json.Jackson2ObjectMapperBuilder;

/**
 * JSON 序列化配置：
 * 解决 Long 类型在前端 JavaScript 中精度丢失的问题
 */
@JsonComponent
public class JsonConfig {

    /**
     * 配置 ObjectMapper：
     * 将 Long 类型序列化为字符串，
     *       避免前端 JSON 解析精度丢失
     *
     * @param builder Jackson 构建器
     * @return 配置后的 ObjectMapper
     */
    @Bean
    public ObjectMapper jacksonObjectMapper(Jackson2ObjectMapperBuilder builder) {        ObjectMapper objectMapper = builder.createXmlMapper(false).build();
        SimpleModule module = new SimpleModule();
        module.addSerializer(Long.class, ToStringSerializer.instance);
        module.addSerializer(Long.TYPE, ToStringSerializer.instance);
        objectMapper.registerModule(module);
        return objectMapper;
    }
}