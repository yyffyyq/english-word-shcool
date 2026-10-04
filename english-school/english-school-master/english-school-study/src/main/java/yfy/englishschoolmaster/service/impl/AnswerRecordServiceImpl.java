package yfy.englishschoolmaster.service.impl;

import com.mybatisflex.spring.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import yfy.englishschoolmaster.mapper.AnswerRecordMapper;
import yfy.englishschoolmaster.model.entity.AnswerRecord;
import yfy.englishschoolmaster.service.AnswerRecordService;

/**
 * 学生答题记录服务实现：
 * 无自定义业务方法，由学习/复习服务在判题时写入。
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
@Service
public class AnswerRecordServiceImpl extends ServiceImpl<AnswerRecordMapper, AnswerRecord>
        implements AnswerRecordService {

}
