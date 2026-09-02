package yfy.englishschoolmaster.model.dto.ClassWordTask;

import lombok.Data;
import lombok.EqualsAndHashCode;
import yfy.englishschoolmaster.common.PageRequest;

/**
 * 班级词书任务分页查询请求：
 * 支持按班级、词书、任务状态筛选，
 *       教师端强制限定为本人创建的任务
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class ClassWordTaskQueryRequest extends PageRequest {

    /**
     * 班级ID
     */
    private Long classId;

    /**
     * 词书ID
     */
    private Long bookId;

    /**
     * 任务状态：ACTIVE / STOPPED
     */
    private String status;

    /**
     * 创建人ID；管理员可按创建人筛选，教师端强制为自己，忽略该字段
     */
    private Long createdBy;
}
