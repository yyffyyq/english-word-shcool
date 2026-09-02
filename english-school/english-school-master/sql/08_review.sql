-- 学生每日复习计划模块
-- 说明：存放按规则生成的每日复习词表（高频错题 / 次日必复 / 艾宾浩斯到期）。

CREATE TABLE IF NOT EXISTS student_daily_review (
  id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '学生每日复习明细ID',
  student_id BIGINT NOT NULL COMMENT '学生ID，关联 user_account.id',
  class_id BIGINT NOT NULL COMMENT '班级ID，关联 class_info.id',
  word_id BIGINT NOT NULL COMMENT '单词ID，关联 word.id',
  review_date DATE NOT NULL COMMENT '复习日期（业务日）',
  reason VARCHAR(30) NOT NULL COMMENT '进入原因：HIGH_WRONG 高频错题，DAY1_FOLLOWUP 次日必复，EBBINGHAUS 艾宾浩斯到期',
  status VARCHAR(20) NOT NULL DEFAULT 'PENDING' COMMENT '复习状态：PENDING 待复习，DONE 已完成',
  created_at DATETIME NOT NULL COMMENT '创建时间',
  updated_at DATETIME NOT NULL COMMENT '更新时间',
  UNIQUE KEY uk_student_daily_review (student_id, word_id, review_date),
  KEY idx_student_daily_review_date_status (student_id, review_date, status),
  KEY idx_student_daily_review_class_date (class_id, review_date),
  CONSTRAINT fk_student_daily_review_student
    FOREIGN KEY (student_id) REFERENCES user_account (id),
  CONSTRAINT fk_student_daily_review_class
    FOREIGN KEY (class_id) REFERENCES class_info (id),
  CONSTRAINT fk_student_daily_review_word
    FOREIGN KEY (word_id) REFERENCES word (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='学生每日复习计划明细表';
