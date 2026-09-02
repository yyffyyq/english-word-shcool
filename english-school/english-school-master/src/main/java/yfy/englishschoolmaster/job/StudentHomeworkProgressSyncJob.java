package yfy.englishschoolmaster.job;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import yfy.englishschoolmaster.service.StudentStudyService;

/**
 * 学生作业 Redis 进度回写定时任务：
 * 每分钟扫描即将过期（剩余 TTL ≤ 10 分钟）的作业缓存，将学习进度同步到数据库。
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
@Component
public class StudentHomeworkProgressSyncJob {

    private static final Logger log = LoggerFactory.getLogger(StudentHomeworkProgressSyncJob.class);

    private final StudentStudyService studentStudyService;

    public StudentHomeworkProgressSyncJob(StudentStudyService studentStudyService) {
        this.studentStudyService = studentStudyService;
    }

    /**
     * 每分钟执行一次过期前回写：
     * 扫描 TTL 剩余 ≤ 10 分钟的作业缓存，
     *       将学习进度同步到数据库
     */
    @Scheduled(cron = "0 * * * * ?", zone = "Asia/Shanghai")
    public void syncExpiringHomeworkProgress() {
        int synced = studentStudyService.syncExpiringHomeworkProgressToDb();
        if (synced > 0) {
            log.info("作业进度过期前回写完成, syncedStudents={}", synced);
        }
    }
}
