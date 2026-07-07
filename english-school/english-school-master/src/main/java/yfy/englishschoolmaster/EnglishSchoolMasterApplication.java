package yfy.englishschoolmaster;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("yfy.englishschoolmaster.mapper")
public class EnglishSchoolMasterApplication {

    public static void main(String[] args) {
        SpringApplication.run(EnglishSchoolMasterApplication.class, args);
    }

}
