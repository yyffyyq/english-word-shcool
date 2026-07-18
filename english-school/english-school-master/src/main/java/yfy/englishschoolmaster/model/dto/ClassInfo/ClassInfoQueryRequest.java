package yfy.englishschoolmaster.model.dto.ClassInfo;

import lombok.Data;
import lombok.EqualsAndHashCode;
import yfy.englishschoolmaster.common.PageRequest;

/**
 * 班级分页查询请求
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class ClassInfoQueryRequest extends PageRequest {

    /**
     * 班级名称，模糊查询
     */
    private String className;

    /**
     * 年级名称
     */
    private String grade;

    /**
     * 学校名称，模糊查询
     */
    private String schoolName;

    /**
     * 班级状态：ACTIVE / DISABLED
     */
    private String status;

    /**
     * 教师ID；管理员可按教师筛选，教师端忽略该字段
     */
    private Long teacherId;
}
