package yfy.englishschoolmaster.service;

import com.mybatisflex.core.paginate.Page;
import com.mybatisflex.core.service.IService;
import yfy.englishschoolmaster.model.dto.ClassInfoAddRequest;
import yfy.englishschoolmaster.model.dto.ClassInfoQueryRequest;
import yfy.englishschoolmaster.model.entity.ClassInfo;
import yfy.englishschoolmaster.model.vo.ClassInfoVO;
import yfy.englishschoolmaster.model.vo.UserAccountVO;

/**
 * 班级信息服务层
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
public interface ClassInfoService extends IService<ClassInfo> {

    /**
     * 教师创建班级：写入当前教师ID，系统生成邀请码
     *
     * @param request   创建请求
     * @param loginUser 当前登录教师
     * @return 班级信息
     */
    ClassInfoVO createClass(ClassInfoAddRequest request, UserAccountVO loginUser);

    /**
     * 班级分页查询：
     * 教师仅能查看自己创建的班级，管理员可查看全部并支持筛选
     *
     * @param request   分页查询请求
     * @param loginUser 当前登录用户
     * @return 分页班级列表
     */
    Page<ClassInfoVO> listClassInfoByPage(ClassInfoQueryRequest request, UserAccountVO loginUser);
}
