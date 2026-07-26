package yfy.englishschoolmaster.controller;

import com.mybatisflex.core.paginate.Page;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
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
import yfy.englishschoolmaster.model.dto.ClassWordTask.ClassWordTaskBindRequest;
import yfy.englishschoolmaster.model.dto.ClassWordTask.ClassWordTaskQueryRequest;
import yfy.englishschoolmaster.model.vo.ClassWordTaskVO;
import yfy.englishschoolmaster.model.vo.UserAccountVO;
import yfy.englishschoolmaster.service.ClassWordTaskService;

/**
 * 班级词书与每日学习规则表 控制层。
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
@RestController
@RequestMapping("/classWordTask")
public class ClassWordTaskController {

    @Autowired
    private ClassWordTaskService classWordTaskService;

    /**
     * 班级绑定词书接口（教师、管理员）：
     * 为指定班级创建生效中的词书学习任务；可配置每日新学数量与起止日期。
     * 请求头需携带 openid 或 userId。
     *
     * @param request     绑定请求
     * @param httpRequest HTTP 请求（用于取登录用户）
     * @return 班级词书任务信息
     */
    @PostMapping("/bind")
    @AuthCheck
    public BaseResponse<ClassWordTaskVO> bindClassWordBook(@RequestBody ClassWordTaskBindRequest request,
                                                           HttpServletRequest httpRequest) {
        // 1. 判断请求是否为空
        ThrowUtils.throwIf(request == null, ErrorCode.PARAMS_ERROR, "绑定请求为空");

        // 2. 获取当前登录用户并绑定
        UserAccountVO loginUser = getLoginUser(httpRequest);
        ClassWordTaskVO taskVO = classWordTaskService.bindClassWordBook(request, loginUser);

        // 3. 封装返回类型给前端
        return ResultUtils.success(taskVO);
    }

    /**
     * 班级解除词书绑定接口（教师、管理员）：
     * 将任务状态置为 STOPPED（软解除，保留历史记录）。
     * 请求头需携带 openid 或 userId。
     *
     * @param id          班级学习任务ID
     * @param httpRequest HTTP 请求（用于取登录用户）
     * @return 是否解绑成功
     */
    @DeleteMapping("/{id}")
    @AuthCheck
    public BaseResponse<Boolean> unbindClassWordBook(@PathVariable("id") Long id,
                                                     HttpServletRequest httpRequest) {
        // 1. 获取当前登录用户并解除绑定
        UserAccountVO loginUser = getLoginUser(httpRequest);
        boolean result = classWordTaskService.unbindClassWordBook(id, loginUser);

        // 2. 封装返回类型给前端
        return ResultUtils.success(result);
    }

    /**
     * 班级词书任务分页查询接口（教师、管理员）：
     * 教师仅可查询自己创建的任务，管理员可查询全部。
     * 支持按班级、词书、状态筛选；管理员还可按创建人筛选。
     * 请求头需携带 openid 或 userId。
     *
     * @param request     分页查询请求
     * @param httpRequest HTTP 请求（用于取登录用户）
     * @return 分页任务列表
     */
    @PostMapping("/list/page/vo")
    @AuthCheck
    public BaseResponse<Page<ClassWordTaskVO>> listClassWordTaskByPage(
            @RequestBody ClassWordTaskQueryRequest request,
            HttpServletRequest httpRequest) {
        // 1. 判断请求是否为空
        ThrowUtils.throwIf(request == null, ErrorCode.PARAMS_ERROR, "查询请求为空");

        // 2. 分页查询
        UserAccountVO loginUser = getLoginUser(httpRequest);
        Page<ClassWordTaskVO> page = classWordTaskService.listClassWordTaskByPage(request, loginUser);

        // 3. 封装返回类型给前端
        return ResultUtils.success(page);
    }

    private UserAccountVO getLoginUser(HttpServletRequest httpRequest) {
        Object attr = httpRequest.getAttribute(UserConstant.LOGIN_USER_ATTR);
        ThrowUtils.throwIf(!(attr instanceof UserAccountVO), ErrorCode.NOT_LOGIN_ERROR, "未登录");
        return (UserAccountVO) attr;
    }
}
