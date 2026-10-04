package yfy.englishschoolmaster.job;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import yfy.englishschoolmaster.model.vo.ClassDailyAssignmentRunResultVO;
import yfy.englishschoolmaster.service.ClassDailyAssignmentService;

import java.time.LocalDate;
import java.time.ZoneId;

/**
 * 每日学生学习计划自动分配定时任务：
 * 每天凌晨 2:00（Asia/Shanghai）按学生进度生成今日单词。
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
@Component
public class DailyWordAssignJob {

    private static final Logger log = LoggerFactory.getLogger(DailyWordAssignJob.class);
    private static final ZoneId ZONE_SHANGHAI = ZoneId.of("Asia/Shanghai");

    private final ClassDailyAssignmentService classDailyAssignmentService;

    public DailyWordAssignJob(ClassDailyAssignmentService classDailyAssignmentService) {
        this.classDailyAssignmentService = classDailyAssignmentService;
    }

    /**
     * 每天 02:00 执行全量分配：
     * 按学生未完成进度结转并补足每日新词额度
     */
    @Scheduled(cron = "0 0 2 * * ?", zone = "Asia/Shanghai")
    public void assignDailyWords() {
        LocalDate today = LocalDate.now(ZONE_SHANGHAI);
        log.info("开始执行每日单词分配, assignDate={}", today);
        ClassDailyAssignmentRunResultVO result = classDailyAssignmentService.assignForDate(today);
        log.info("每日单词分配结束, date={}, taskCount={}, created={}, skippedExist={}, skippedEmpty={}, success={}, partial={}",
                result.getAssignDate(),
                result.getTaskCount(),
                result.getCreatedCount(),
                result.getSkippedExistCount(),
                result.getSkippedEmptyCount(),
                result.getSuccessCount(),
                result.getPartialCount());
    }
}
