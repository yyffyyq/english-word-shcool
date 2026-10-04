package yfy.englishschoolmaster.model.dto.ClassInfo;

import lombok.Data;

/**
 * 班级创建请求：
 * 教师创建新班级并写入 class_info 表，
 *       系统自动生成 6 位邀请码
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
