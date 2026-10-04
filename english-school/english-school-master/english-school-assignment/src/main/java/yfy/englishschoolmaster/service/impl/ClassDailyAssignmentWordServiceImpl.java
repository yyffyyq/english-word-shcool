package yfy.englishschoolmaster.service.impl;

import com.mybatisflex.spring.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import yfy.englishschoolmaster.mapper.ClassDailyAssignmentWordMapper;
import yfy.englishschoolmaster.model.entity.ClassDailyAssignmentWord;
import yfy.englishschoolmaster.service.ClassDailyAssignmentWordService;

/**
 * 班级每日分配单词明细服务实现：
 * 无自定义业务方法，由 ClassDailyAssignmentService 调用基础 CRUD。
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
@Service
public class ClassDailyAssignmentWordServiceImpl
        extends ServiceImpl<ClassDailyAssignmentWordMapper, ClassDailyAssignmentWord>
        implements ClassDailyAssignmentWordService {

}
