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
import yfy.englishschoolmaster.model.vo.ClassStudentVO;
import yfy.englishschoolmaster.service.ClassInfoService;
import yfy.englishschoolmaster.service.ClassStudentService;
import yfy.englishschoolmaster.service.RedisService;

import java.time.Duration;
import java.time.LocalDateTime;

/**
 *  服务层实现。
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

    /**
     * 学生加入班级方法（缓存命中）
     * @param redisResult 缓冲中的班级信息
     * @param request 学生加入班级请求
     * @return
     */
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

        // 3. 封装并返回
        return classStudentMapper.insert(classStudent);
    }

    /**
     * 查找邀请码，并且加入学生
     * @param request 学生加入班级请求
     * @return
     */
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

        // 4. 加入学生到班级中，并返回
        ClassStudent classStudent = new ClassStudent();
        classStudent.setClassId(classInfo.getId());
        classStudent.setStudentId(request.getStudentId());
        classStudent.setStatus("IN_CLASS");
        classStudent.setJoinedAt(LocalDateTime.now());
        // active_student_id 为数据库生成列，禁止手动赋值
        return classStudentMapper.insert(classStudent);
    }
}
