package yfy.englishschoolmaster.model.dto.ClassStudent;

import lombok.Data;

import java.io.Serializable;

/**
 * 学生加入班级请求：
 * 学生通过班级邀请码加入指定班级，
 *       写入 class_student 关系记录
 */
@Data
public class ClassStudentAddStudentRequest implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * 学生ID，关联 user_account.id
     */
    private Long studentId;

    /**
     * 6 位班级邀请码，对应 class_info.invite_code
     */
    private String inviteCode;

}
