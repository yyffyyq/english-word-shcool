package yfy.englishschoolmaster.service.impl;

import com.mybatisflex.core.query.QueryWrapper;
import com.mybatisflex.spring.service.impl.ServiceImpl;
import jakarta.annotation.Resource;
import org.springframework.beans.BeanUtils;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;
import yfy.englishschoolmaster.constant.RedisTypeConstant;
import yfy.englishschoolmaster.exception.BusinessException;
import yfy.englishschoolmaster.exception.ErrorCode;
import yfy.englishschoolmaster.exception.ThrowUtils;
import yfy.englishschoolmaster.mapper.ClassInfoMapper;
import yfy.englishschoolmaster.mapper.ClassStudentMapper;
import yfy.englishschoolmaster.model.dto.ClassStudent.ClassStudentAddStudentRequest;
import yfy.englishschoolmaster.model.entity.ClassInfo;
import yfy.englishschoolmaster.model.entity.ClassStudent;
import yfy.englishschoolmaster.model.vo.ClassInfoVO;
import yfy.englishschoolmaster.service.ClassDailyAssignmentService;
import yfy.englishschoolmaster.service.ClassStudentService;
import yfy.englishschoolmaster.service.RedisService;

import java.time.Duration;
import java.time.LocalDateTime;

/**
 * 班级学生关系服务实现：
 * 处理学生入班及当日词表补发。
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
@Service
public class ClassStudentServiceImpl extends ServiceImpl<ClassStudentMapper, ClassStudent>  implements ClassStudentService {

    @Resource
    private ClassStudentMapper classStudentMapper;

    @Resource
    private ClassInfoMapper classInfoMapper;

    @Lazy
    @Resource
    private RedisService redisService;

    @Lazy
    @Resource
    private ClassDailyAssignmentService classDailyAssignmentService;

    /** 实现缓存命中路径的入班逻辑 */
    @Override
    public int insertStudent(ClassInfoVO redisResult, ClassStudentAddStudentRequest request) {

        // 1. 判断参数
        ThrowUtils.throwIf(redisResult == null || request == null, ErrorCode.PARAMS_ERROR,"请求参数为空");

        // 2. 存入数据表中,先判断该学生是否已经加过任何班级
        QueryWrapper queryWrapper = new QueryWrapper();
        queryWrapper.eq("student_id", request.getStudentId());
        if(classStudentMapper.selectOneByQuery(queryWrapper) != null){
            throw new BusinessException(ErrorCode.OPERATION_ERROR,"一位学生只能加入一个班级");
        }
        ClassStudent classStudent = new ClassStudent();
        classStudent.setStudentId(request.getStudentId());
        classStudent.setClassId(redisResult.getId());
        classStudent.setStatus("IN_CLASS");
        classStudent.setJoinedAt(LocalDateTime.now());
        // active_student_id 为数据库生成列，禁止手动赋值

        // 3. 写入入班关系
        int rows = classStudentMapper.insert(classStudent);

        // 4. 补发当日已分配词表到该学生进度
        if (rows > 0) {
            classDailyAssignmentService.backfillTodayForStudent(redisResult.getId(), request.getStudentId());
        }
        return rows;
    }

    /** 实现邀请码查库入班，并回写 Redis 缓存 */
    @Override
    public int selectAndInsertStudent(ClassStudentAddStudentRequest request) {

        // 1. 判断是否为空
        ThrowUtils.throwIf(request == null, ErrorCode.PARAMS_ERROR, "请求参数为空");

        // 2. 通过邀请码查找
        QueryWrapper queryWrapper = new QueryWrapper();
        queryWrapper.eq("invite_code", request.getInviteCode());
        ClassInfo classInfo = classInfoMapper.selectOneByQuery(queryWrapper);
        if(classInfo == null){
            throw new BusinessException(ErrorCode.OPERATION_ERROR,"邀请码查询为空");
        }
        // 3. 将班级信息转为 VO 后写入 redis（与读取时 ClassInfoVO.class 保持一致）
        ClassInfoVO classInfoVO = new ClassInfoVO();
        BeanUtils.copyProperties(classInfo, classInfoVO);
        redisService.write(classInfoVO, Duration.ofSeconds(2700),
                RedisTypeConstant.CLASS_INFO_INVOITE_CODE, request.getInviteCode());

        // 4. 加入学生到班级中
        ClassStudent classStudent = new ClassStudent();
        classStudent.setClassId(classInfo.getId());
        classStudent.setStudentId(request.getStudentId());
        classStudent.setStatus("IN_CLASS");
        classStudent.setJoinedAt(LocalDateTime.now());
        // active_student_id 为数据库生成列，禁止手动赋值
        int rows = classStudentMapper.insert(classStudent);

        // 5. 补发当日已分配词表到该学生进度
        if (rows > 0) {
            classDailyAssignmentService.backfillTodayForStudent(classInfo.getId(), request.getStudentId());
        }
        return rows;
    }
}
