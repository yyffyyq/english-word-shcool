package yfy.englishschoolmaster;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

/**
 * 英语单词学堂 Spring Boot 启动类：
 * 启用 MyBatis Mapper 扫描与定时任务调度
 */
@SpringBootApplication
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
