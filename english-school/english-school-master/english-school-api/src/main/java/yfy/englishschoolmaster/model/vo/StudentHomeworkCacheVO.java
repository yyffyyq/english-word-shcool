package yfy.englishschoolmaster.model.vo;

import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * 学生今日作业缓存 VO：
 * 对应 Redis 缓存 student.homework.list 及学习页返回，
 *       包含待学单词列表及进度回写标记
 */
@Data
public class StudentHomeworkCacheVO implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 学生ID
     */
    private Long studentId;

    /**
     * 当前在班班级ID
     */
    private Long classId;

    /**
     * 待学习单词数量
     */
    private Integer wordCount;

    /**
     * 待学习单词列表
     */
    private List<StudentHomeworkWordVO> words = new ArrayList<>();

    /**
     * 是否已在过期前窗口完成进度回写（避免重复刷库）
     */
    private Boolean progressSynced;
}
