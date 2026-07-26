package yfy.englishschoolmaster.service;

import com.mybatisflex.core.paginate.Page;
import com.mybatisflex.core.service.IService;
import yfy.englishschoolmaster.model.dto.ClassWordTask.ClassWordTaskBindRequest;
import yfy.englishschoolmaster.model.dto.ClassWordTask.ClassWordTaskQueryRequest;
import yfy.englishschoolmaster.model.entity.ClassWordTask;
import yfy.englishschoolmaster.model.vo.ClassWordTaskVO;
import yfy.englishschoolmaster.model.vo.UserAccountVO;

/**
 * 班级词书与每日学习规则表 服务层。
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
public interface ClassWordTaskService extends IService<ClassWordTask> {

    /**
     * 班级绑定词书（教师、管理员）：
     * 为班级创建生效中的词书学习任务；若同班级同词书已存在 STOPPED 记录则重新激活。
     *
     * @param request   绑定请求
     * @param loginUser 当前登录用户
     * @return 班级词书任务信息
     */
    ClassWordTaskVO bindClassWordBook(ClassWordTaskBindRequest request, UserAccountVO loginUser);

    /**
     * 班级解除词书绑定（教师、管理员）：
     * 将任务状态置为 STOPPED。
     *
     * @param id        班级学习任务ID
     * @param loginUser 当前登录用户
     * @return 是否解绑成功
     */
    boolean unbindClassWordBook(Long id, UserAccountVO loginUser);

    /**
     * 班级词书任务分页查询（教师、管理员）：
     * 教师仅可查询自己创建的任务，管理员可查询全部。
     *
     * @param request   分页查询请求
     * @param loginUser 当前登录用户
     * @return 分页任务列表
     */
    Page<ClassWordTaskVO> listClassWordTaskByPage(ClassWordTaskQueryRequest request, UserAccountVO loginUser);
}
