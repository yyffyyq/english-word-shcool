package yfy.englishschoolmaster;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

/**
 * 英语单词学堂 Spring Boot 启动类：
 * 扫描各业务模块组件，启用 MyBatis Mapper 与定时任务。
 * 接口 context-path 仍为 /api，Controller 路径保持不变。
 */
@SpringBootApplication(scanBasePackages = "yfy.englishschoolmaster")
@MapperScan("yfy.englishschoolmaster.mapper")
@EnableScheduling
public class EnglishSchoolMasterApplication {

    /**
     * 应用入口
     *
     * @param args 启动参数
     */
    public static void main(String[] args) {
        SpringApplication.run(EnglishSchoolMasterApplication.class, args);
    }

}
