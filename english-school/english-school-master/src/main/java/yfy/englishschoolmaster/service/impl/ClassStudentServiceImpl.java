package yfy.englishschoolmaster.service.impl;

import com.mybatisflex.spring.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import yfy.englishschoolmaster.mapper.ClassStudentMapper;
import yfy.englishschoolmaster.model.entity.ClassStudent;
import yfy.englishschoolmaster.service.ClassStudentService;

/**
 *  服务层实现。
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
@Service
public class ClassStudentServiceImpl extends ServiceImpl<ClassStudentMapper, ClassStudent>  implements ClassStudentService {

}
