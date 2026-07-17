package yfy.englishschoolmaster.service.impl;

import com.mybatisflex.spring.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import yfy.englishschoolmaster.mapper.ClassInfoMapper;
import yfy.englishschoolmaster.model.entity.ClassInfo;
import yfy.englishschoolmaster.service.ClassInfoService;

/**
 *  服务层实现。
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
@Service
public class ClassInfoServiceImpl extends ServiceImpl<ClassInfoMapper, ClassInfo>  implements ClassInfoService {

}
