package yfy.englishschoolmaster.service;

import com.mybatisflex.core.service.IService;
import yfy.englishschoolmaster.model.dto.StudentReview.StudentReviewChoiceAnswerRequest;
import yfy.englishschoolmaster.model.dto.StudentReview.StudentReviewSpellAnswerRequest;
import yfy.englishschoolmaster.model.entity.StudentDailyReview;
import yfy.englishschoolmaster.model.vo.StudentAnswerResultVO;
import yfy.englishschoolmaster.model.vo.StudentReviewCacheVO;
import yfy.englishschoolmaster.model.vo.StudentReviewPlanRunResultVO;
import yfy.englishschoolmaster.model.vo.UserAccountVO;

import java.time.LocalDate;

/**
 * 学生复习服务：
 * 按艾宾浩斯等规则生成复习计划，提供今日复习词表与复习判题能力。
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
public interface StudentReviewService extends IService<StudentDailyReview> {

    /**
     * 按指定复习日生成全量复习计划（规则：高频错题 > 次日必复 > 艾宾浩斯）。
     *
     * @param reviewDate 复习日
     * @return 生成结果统计
     */
    StudentReviewPlanRunResultVO generateReviewPlanForDate(LocalDate reviewDate);

    /**
     * 管理员手动触发生成。
     *
     * @param reviewDate 复习日，空则今天
     * @param loginUser  管理员
     * @return 生成结果
     */
    StudentReviewPlanRunResultVO runPlanByAdmin(LocalDate reviewDate, UserAccountVO loginUser);

    /**
     * 重建学生今日复习 Redis 缓存。
     *
     * @param studentId 学生ID
     * @return 缓存内容
     */
    StudentReviewCacheVO refreshReviewCache(Long studentId);

    /**
     * 获取今日待复习列表。
     *
     * @param loginUser 当前学生
     * @return 复习词表
     */
    StudentReviewCacheVO getTodayReview(UserAccountVO loginUser);

    /**
     * 复习四选一判题：
     * 校验单词在今日待复习列表中，答对推进艾宾浩斯间隔
     *
     * @param request   作答请求（wordId、optionId）
     * @param loginUser 当前登录学生
     * @return 判题结果
     */
    StudentAnswerResultVO answerChoice(StudentReviewChoiceAnswerRequest request, UserAccountVO loginUser);

    /**
     * 复习拼写判题：
     * 忽略大小写比对，答错则次日再复
     *
     * @param request   作答请求（wordId、spelledText）
     * @param loginUser 当前登录学生
     * @return 判题结果
     */
    StudentAnswerResultVO answerSpell(StudentReviewSpellAnswerRequest request, UserAccountVO loginUser);
}
