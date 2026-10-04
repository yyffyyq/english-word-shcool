package yfy.englishschoolmaster.service.impl;

import com.mybatisflex.spring.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import yfy.englishschoolmaster.mapper.StudentWordProgressMapper;
import yfy.englishschoolmaster.model.entity.StudentWordProgress;
import yfy.englishschoolmaster.service.StudentWordProgressService;

/**
 * 学生单词掌握进度服务实现：
 * 无自定义业务方法，进度写入由分配/学习/复习服务负责。
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
@Service
public class StudentWordProgressServiceImpl
        extends ServiceImpl<StudentWordProgressMapper, StudentWordProgress>
        implements StudentWordProgressService {

}
