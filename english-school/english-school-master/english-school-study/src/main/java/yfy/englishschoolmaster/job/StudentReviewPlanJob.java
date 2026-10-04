package yfy.englishschoolmaster.job;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import yfy.englishschoolmaster.model.vo.StudentReviewPlanRunResultVO;
import yfy.englishschoolmaster.service.StudentReviewService;

import java.time.LocalDate;
import java.time.ZoneId;

/**
 * 学生每日复习计划定时任务：
 * 每天凌晨 4:00（Asia/Shanghai）按规则生成今日复习清单。
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
@Component

public class StudentReviewPlanJob {

    private static final Logger log = LoggerFactory.getLogger(StudentReviewPlanJob.class);
    private static final ZoneId ZONE_SHANGHAI = ZoneId.of("Asia/Shanghai");

    private final StudentReviewService studentReviewService;

    public StudentReviewPlanJob(StudentReviewService studentReviewService) {
        this.studentReviewService = studentReviewService;
    }

    /**
     * 每天 04:00 生成当日复习计划：
     * 调用 StudentReviewService 按规则写入 student_daily_review 表
     */
    @Scheduled(cron = "0 0 4 * * ?", zone = "Asia/Shanghai")
    public void generateDailyReviewPlan() {
        LocalDate today = LocalDate.now(ZONE_SHANGHAI);
        log.info("开始生成复习计划, reviewDate={}", today);
        StudentReviewPlanRunResultVO result = studentReviewService.generateReviewPlanForDate(today);
        log.info("复习计划生成结束, date={}, highWrong={}, day1={}, ebbinghaus={}, upsert={}",
                result.getReviewDate(),
                result.getHighWrongCount(),
                result.getDay1FollowupCount(),
                result.getEbbinghausCount(),
                result.getTotalUpsertCount());
    }
}
