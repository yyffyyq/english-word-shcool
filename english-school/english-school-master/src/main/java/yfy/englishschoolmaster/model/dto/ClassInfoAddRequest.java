package yfy.englishschoolmaster.model.dto;

import lombok.Data;

/**
 * 班级创建请求
 */
@Data
public class ClassInfoAddRequest {

    /**
     * 班级名称，例如 三年级一班
     */
    private String className;

    /**
     * 年级名称
     */
    private String grade;

    /**
     * 学校名称；为空时默认取登录教师的学校
     */
    private String schoolName;
}
