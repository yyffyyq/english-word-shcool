package yfy.englishschoolmaster.controller;

import com.mybatisflex.core.paginate.Page;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import yfy.englishschoolmaster.annotation.AuthCheck;
import yfy.englishschoolmaster.common.BaseResponse;
import yfy.englishschoolmaster.common.ResultUtils;
import yfy.englishschoolmaster.constant.UserConstant;
import yfy.englishschoolmaster.exception.ErrorCode;
import yfy.englishschoolmaster.exception.ThrowUtils;
import yfy.englishschoolmaster.model.dto.ClassInfoAddRequest;
import yfy.englishschoolmaster.model.dto.ClassInfoQueryRequest;
import yfy.englishschoolmaster.model.vo.ClassInfoVO;
import yfy.englishschoolmaster.model.vo.ClassStudentVO;
import yfy.englishschoolmaster.model.vo.UserAccountVO;
import yfy.englishschoolmaster.service.ClassInfoService;

import java.util.List;

/**
 * 班级信息控制层
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
@RestController
@RequestMapping("/classInfo")
public class ClassInfoController {

    @Autowired
    private ClassInfoService classInfoService;

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
