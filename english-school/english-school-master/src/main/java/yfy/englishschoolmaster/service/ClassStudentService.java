package yfy.englishschoolmaster.service;

import com.mybatisflex.core.service.IService;
import yfy.englishschoolmaster.model.dto.ClassStudent.ClassStudentAddStudentRequest;
import yfy.englishschoolmaster.model.entity.ClassStudent;
import yfy.englishschoolmaster.model.vo.ClassInfoVO;
import yfy.englishschoolmaster.model.vo.ClassStudentVO;

/**
 *  服务层。
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
public interface ClassStudentService extends IService<ClassStudent> {
    /**
     * 学生加入班级方法（缓存命中）
     * @param redisResult 缓冲中的班级信息
     * @param request 学生加入班级请求
     * @return
     */
    int insertStudent(ClassInfoVO redisResult, ClassStudentAddStudentRequest request);

    /**
     * 查找邀请码，并且加入学生
     * @param request 学生加入班级请求
     * @return
     */
    int selectAndInsertStudent(ClassStudentAddStudentRequest request);
}
