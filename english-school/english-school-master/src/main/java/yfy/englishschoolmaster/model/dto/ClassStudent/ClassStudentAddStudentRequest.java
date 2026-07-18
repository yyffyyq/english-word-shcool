package yfy.englishschoolmaster.model.dto.ClassStudent;

import lombok.Data;
import lombok.Getter;

import java.io.Serializable;

/**
 * 学生加入班级请求
 */

@Data
public class ClassStudentAddStudentRequest implements Serializable {
    private static final long serialVersionUID = 1L;

    // 学生ID
    private Long studentId;

    // 邀请码
    private String inviteCode;

}
