package yfy.englishschoolmaster.service;

import yfy.englishschoolmaster.model.dto.StudentStudy.StudentChoiceAnswerRequest;
import yfy.englishschoolmaster.model.dto.StudentStudy.StudentSpellAnswerRequest;
import yfy.englishschoolmaster.model.dto.StudentStudy.StudentWordStatusUpdateRequest;
import yfy.englishschoolmaster.model.vo.StudentAnswerResultVO;
import yfy.englishschoolmaster.model.vo.StudentHomeworkCacheVO;
import yfy.englishschoolmaster.model.vo.UserAccountVO;

/**
 * 学生学习服务：
 * 提供今日作业词表获取、四选一/拼写判题、学习状态修改及缓存进度回写。
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
public interface StudentStudyService {

    /**
     * 按学生 ID 重建今日作业 Redis 缓存（TTL 3 小时）。
     *
     * @param studentId 学生用户ID
     * @return 缓存内容
     */
    StudentHomeworkCacheVO refreshHomeworkCache(Long studentId);

    /**
     * 获取今日作业词表与数量：优先读 Redis，未命中则回源并回写。
     *
     * @param loginUser 当前登录学生
     * @return 今日作业
     */
    StudentHomeworkCacheVO getTodayHomework(UserAccountVO loginUser);

    /**
     * 四选一判题：
     * 校验选项归属后写答题记录，同步更新 DB 与 Redis 中的学习进度
     *
     * @param request   作答请求（wordId、optionId）
     * @param loginUser 当前登录学生
     * @return 判题结果（是否正确、正确答案、当前进度状态）
     */
    StudentAnswerResultVO answerChoice(StudentChoiceAnswerRequest request, UserAccountVO loginUser);

    /**
     * 拼写判题：
     * 忽略大小写比对拼写内容，写答题记录并同步进度
     *
     * @param request   作答请求（wordId、spelledText）
     * @param loginUser 当前登录学生
     * @return 判题结果
     */
    StudentAnswerResultVO answerSpell(StudentSpellAnswerRequest request, UserAccountVO loginUser);

    /**
     * 修改单词学习状态（LEARNING / MASTERED）。
     *
     * @param request   状态修改请求
     * @param loginUser 当前登录学生
     * @return 是否成功
     */
    boolean updateWordStatus(StudentWordStatusUpdateRequest request, UserAccountVO loginUser);

    /**
     * 扫描即将过期（剩余 TTL ≤ 10 分钟）的作业缓存，将学习进度回写数据库。
     *
     * @return 本次回写的学生数
     */
    int syncExpiringHomeworkProgressToDb();
}
