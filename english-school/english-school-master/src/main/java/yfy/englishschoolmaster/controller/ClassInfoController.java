package yfy.englishschoolmaster.controller;

import com.mybatisflex.core.paginate.Page;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.resource.ResourceUrlProvider;
import yfy.englishschoolmaster.annotation.AuthCheck;
import yfy.englishschoolmaster.common.BaseResponse;
import yfy.englishschoolmaster.common.ResultUtils;
import yfy.englishschoolmaster.constant.RedisTypeConstant;
import yfy.englishschoolmaster.constant.UserConstant;
import yfy.englishschoolmaster.exception.BusinessException;
import yfy.englishschoolmaster.exception.ErrorCode;
import yfy.englishschoolmaster.exception.ThrowUtils;
import yfy.englishschoolmaster.model.dto.ClassInfo.ClassInfoAddRequest;
import yfy.englishschoolmaster.model.dto.ClassInfo.ClassInfoQueryRequest;
import yfy.englishschoolmaster.model.dto.ClassStudent.ClassStudentAddStudentRequest;
import yfy.englishschoolmaster.model.vo.ClassInfoVO;
import yfy.englishschoolmaster.model.vo.ClassStudentVO;
import yfy.englishschoolmaster.model.vo.UserAccountVO;
import yfy.englishschoolmaster.service.ClassInfoService;
import yfy.englishschoolmaster.service.ClassStudentService;
import yfy.englishschoolmaster.service.RedisService;

import java.util.List;

/**
 * 班级信息控制层
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
@RestController
@RequestMapping("/classInfo")
public class ClassInfoController {

    @Resource
    private ClassInfoService classInfoService;

    @Resource
    private RedisService redisService;

    @Resource
    private ClassStudentService classStudentService;

    /**
     * 学生加入班级接口（学生权限)
     */
    @PostMapping("/add/student")
    @AuthCheck
    public BaseResponse<String> studentJoinClass(@RequestBody ClassStudentAddStudentRequest request){

        // 1. 判断参数是否为空
        if (request.getInviteCode() == null)
            throw new BusinessException(ErrorCode.PARAMS_ERROR,"班级邀请码不可为空");

        // 2. 通过邀请码获取redis中班级缓存信息，判断是否为空
        String InviteCode = request.getInviteCode();
        ClassInfoVO redisResult = redisService.read(InviteCode, RedisTypeConstant.CLASS_INFO_INVOITE_CODE,ClassInfoVO.class);

        // a. 不为空说明已经有班级信息在redis中，获取classId，存入数据库中，并判断缓存剩余时间
        if (redisResult != null){
            int result = classStudentService.insertStudent(redisResult,request);
            return ResultUtils.success(String.valueOf(result));
        }

        // b. 为空，通过邀请码去获取数据库中班级信息，判断是否存在，存在就将它存到redis中
        int result = classStudentService.selectAndInsertStudent(request);

        // 3. 返回小程序是否加入成功信息
        return ResultUtils.success(String.valueOf(result));
    }



    /**
     * 班级创建接口（教师权限）：
     * 请求头需携带 openid，由 AuthInterceptor 校验教师身份。
     *
     * @param request     创建请求
     * @param httpRequest HTTP 请求（用于取登录用户）
     * @return 班级信息
     */
    @PostMapping("/add")
    @AuthCheck(mustRole = UserConstant.TEACHER_ROLE)
    public BaseResponse<ClassInfoVO> addClassInfo(@RequestBody ClassInfoAddRequest request,
                                                  HttpServletRequest httpRequest) {
        // 1. 判断请求是否为空
        ThrowUtils.throwIf(request == null, ErrorCode.PARAMS_ERROR, "创建班级请求为空");

        // 2. 获取当前登录教师并创建班级
        UserAccountVO loginUser = getLoginUser(httpRequest);
        ClassInfoVO classInfoVO = classInfoService.createClass(request, loginUser);

        // 3. 封装返回类型给前端
        return ResultUtils.success(classInfoVO);
    }

    /**
     * 班级分页查询接口（创建教师、管理员）：
     * 教师仅查看自己创建的班级，管理员可查看全部。
     * 请求头需携带 openid。
     *
     * @param request     分页查询请求
     * @param httpRequest HTTP 请求（用于取登录用户）
     * @return 分页班级列表
     */
    @PostMapping("/list/page/vo")
    @AuthCheck
    public BaseResponse<Page<ClassInfoVO>> listClassInfoByPage(@RequestBody ClassInfoQueryRequest request,
                                                               HttpServletRequest httpRequest) {
        // 1. 判断请求是否为空
        ThrowUtils.throwIf(request == null, ErrorCode.PARAMS_ERROR, "查询请求为空");

        // 2. 分页查询班级
        UserAccountVO loginUser = getLoginUser(httpRequest);
        Page<ClassInfoVO> page = classInfoService.listClassInfoByPage(request, loginUser);

        // 3. 封装返回类型给前端
        return ResultUtils.success(page);
    }

    /**
     * 班级详情接口（含在班学生数）：
     * 教师仅可查看自己的班级，管理员可查看全部。
     *
     * @param id          班级ID
     * @param httpRequest HTTP 请求
     * @return 班级详情
     */
    @GetMapping("/{id}")
    @AuthCheck
    public BaseResponse<ClassInfoVO> getClassInfo(@PathVariable("id") Long id,
                                                  HttpServletRequest httpRequest) {
        UserAccountVO loginUser = getLoginUser(httpRequest);
        ClassInfoVO classInfoVO = classInfoService.getClassDetail(id, loginUser);
        return ResultUtils.success(classInfoVO);
    }

    /**
     * 班级学生列表接口：
     * 返回当前在班学生，教师仅可查看自己的班级，管理员可查看全部。
     *
     * @param id          班级ID
     * @param httpRequest HTTP 请求
     * @return 学生列表
     */
    @GetMapping("/{id}/students")
    @AuthCheck
    public BaseResponse<List<ClassStudentVO>> listClassStudents(@PathVariable("id") Long id,
                                                                HttpServletRequest httpRequest) {
        UserAccountVO loginUser = getLoginUser(httpRequest);
        List<ClassStudentVO> students = classInfoService.listClassStudents(id, loginUser);
        return ResultUtils.success(students);
    }

    /**
     * 刷新班级邀请码接口（教师权限）：
     * 仅可刷新自己创建的班级邀请码。
     *
     * @param id          班级ID
     * @param httpRequest HTTP 请求
     * @return 刷新后的班级信息
     */
    @PostMapping("/{id}/refresh-invite")
    @AuthCheck(mustRole = UserConstant.TEACHER_ROLE)
    public BaseResponse<ClassInfoVO> refreshInviteCode(@PathVariable("id") Long id,
                                                       HttpServletRequest httpRequest) {
        UserAccountVO loginUser = getLoginUser(httpRequest);
        ClassInfoVO classInfoVO = classInfoService.refreshInviteCode(id, loginUser);
        return ResultUtils.success(classInfoVO);
    }

    private UserAccountVO getLoginUser(HttpServletRequest httpRequest) {
        Object attr = httpRequest.getAttribute(UserConstant.LOGIN_USER_ATTR);
        ThrowUtils.throwIf(!(attr instanceof UserAccountVO), ErrorCode.NOT_LOGIN_ERROR, "未登录");
        return (UserAccountVO) attr;
    }
}
