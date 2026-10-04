package yfy.englishschoolmaster.service;

import com.mybatisflex.core.service.IService;
import yfy.englishschoolmaster.model.dto.ClassStudent.ClassStudentAddStudentRequest;
import yfy.englishschoolmaster.model.entity.ClassStudent;
import yfy.englishschoolmaster.model.vo.ClassInfoVO;
import yfy.englishschoolmaster.model.vo.ClassStudentVO;

/**
 * 班级学生关系服务：
 * 管理学生通过邀请码加入班级，
 *       入班后补发当日已分配词表到个人学习进度。
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
public interface ClassStudentService extends IService<ClassStudent> {
    /**
     * 学生加入班级（邀请码已命中 Redis 缓存）：
     * 校验一名学生只能加入一个班级，
     *       写入 class_student 关系并补发当日词表
     *
     * @param redisResult 缓存中的班级信息
     * @param request     学生加入班级请求（studentId）
     * @return 影响行数
     */
    int insertStudent(ClassInfoVO redisResult, ClassStudentAddStudentRequest request);

    /**
     * 按邀请码查找班级并加入学生：
     * 数据库查 invite_code 后回写 Redis，
     *       写入 class_student 并补发当日词表
     *
     * @param request 学生加入班级请求（inviteCode、studentId）
     * @return 影响行数
     */
    int selectAndInsertStudent(ClassStudentAddStudentRequest request);
}
