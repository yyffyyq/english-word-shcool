package yfy.englishschoolmaster.mapper;

import com.mybatisflex.core.BaseMapper;
import yfy.englishschoolmaster.model.entity.UserAccount;

/**
 * 用户账号表 映射层：
 * 统一存管理员、教师、学生基础信息，
 *       提供 user_account 表的基础 CRUD 操作
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
public interface UserAccountMapper extends BaseMapper<UserAccount> {

}
