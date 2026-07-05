-- 学习、复习、答题与打卡模块
-- 说明：存放学生单词掌握进度、答题记录、每日学习统计和打卡数据。

CREATE TABLE IF NOT EXISTS student_word_progress (
  id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '学生单词学习进度ID',
  student_id BIGINT NOT NULL COMMENT '学生ID，关联 user_account.id',
  word_id BIGINT NOT NULL COMMENT '单词ID，关联 word.id',
  class_id BIGINT NOT NULL COMMENT '学习时所属班级ID',
  status VARCHAR(20) NOT NULL DEFAULT 'NEW' COMMENT '学习状态：NEW 未学，LEARNING 学习中，MASTERED 已掌握',
  review_count INT NOT NULL DEFAULT 0 COMMENT '已复习次数',
  correct_count INT NOT NULL DEFAULT 0 COMMENT '答对次数',
  wrong_count INT NOT NULL DEFAULT 0 COMMENT '答错次数',
  ease_factor DECIMAL(4,2) NOT NULL DEFAULT 2.50 COMMENT 'SM-2 难度系数，用于计算下次复习间隔',
  interval_days INT NOT NULL DEFAULT 0 COMMENT '当前复习间隔天数',
  next_review_date DATE NULL COMMENT '下次应复习日期',
  last_studied_at DATETIME NULL COMMENT '最近一次学习或复习时间',
  is_favorite TINYINT NOT NULL DEFAULT 0 COMMENT '是否收藏：0 否，1 是',
  is_wrong_word TINYINT NOT NULL DEFAULT 0 COMMENT '是否错题：0 否，1 是',
  created_at DATETIME NOT NULL COMMENT '创建时间',
  updated_at DATETIME NOT NULL COMMENT '更新时间',
  UNIQUE KEY uk_student_word_progress (student_id, word_id),
  KEY idx_student_word_progress_review (student_id, next_review_date),
  KEY idx_student_word_progress_class (class_id),
  CONSTRAINT fk_student_word_progress_student
    FOREIGN KEY (student_id) REFERENCES user_account (id),
  CONSTRAINT fk_student_word_progress_word
    FOREIGN KEY (word_id) REFERENCES word (id),
  CONSTRAINT fk_student_word_progress_class
    FOREIGN KEY (class_id) REFERENCES class_info (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='学生单词掌握进度表，支持 SM-2 复习算法';

CREATE TABLE IF NOT EXISTS answer_record (
  id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '答题记录ID',
  student_id BIGINT NOT NULL COMMENT '学生ID，关联 user_account.id',
  word_id BIGINT NOT NULL COMMENT '单词ID，关联 word.id',
  class_id BIGINT NOT NULL COMMENT '班级ID',
  answer_type VARCHAR(20) NOT NULL COMMENT '答题类型：NEW 新词测验，REVIEW 复习测验',
  question_type VARCHAR(20) NOT NULL COMMENT '题型：CHOICE 四选一，后续可扩展 SPELL 拼写',
  selected_answer VARCHAR(500) NULL COMMENT '学生选择的答案内容',
  correct_answer VARCHAR(500) NOT NULL COMMENT '正确答案内容',
  is_correct TINYINT NOT NULL COMMENT '是否答对：0 否，1 是',
  quality_score INT NULL COMMENT 'SM-2 评分，通常 0-5 分',
  answered_at DATETIME NOT NULL COMMENT '答题时间',
  KEY idx_answer_record_student_time (student_id, answered_at),
  KEY idx_answer_record_word (word_id),
  KEY idx_answer_record_class (class_id),
  CONSTRAINT fk_answer_record_student
    FOREIGN KEY (student_id) REFERENCES user_account (id),
  CONSTRAINT fk_answer_record_word
    FOREIGN KEY (word_id) REFERENCES word (id),
  CONSTRAINT fk_answer_record_class
    FOREIGN KEY (class_id) REFERENCES class_info (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='学生答题记录表，用于错题、统计和复习算法计算';

CREATE TABLE IF NOT EXISTS study_daily_record (
  id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '每日学习记录ID',
  student_id BIGINT NOT NULL COMMENT '学生ID，关联 user_account.id',
  class_id BIGINT NOT NULL COMMENT '班级ID',
  study_date DATE NOT NULL COMMENT '学习日期',
  new_word_count INT NOT NULL DEFAULT 0 COMMENT '当天新学单词数',
  review_word_count INT NOT NULL DEFAULT 0 COMMENT '当天复习单词数',
  correct_count INT NOT NULL DEFAULT 0 COMMENT '当天答对次数',
  wrong_count INT NOT NULL DEFAULT 0 COMMENT '当天答错次数',
  is_checked_in TINYINT NOT NULL DEFAULT 0 COMMENT '是否完成打卡：0 否，1 是',
  checked_in_at DATETIME NULL COMMENT '打卡完成时间',
  created_at DATETIME NOT NULL COMMENT '创建时间',
  updated_at DATETIME NOT NULL COMMENT '更新时间',
  UNIQUE KEY uk_study_daily_student_date (student_id, study_date),
  KEY idx_study_daily_class_date (class_id, study_date),
  CONSTRAINT fk_study_daily_student
    FOREIGN KEY (student_id) REFERENCES user_account (id),
  CONSTRAINT fk_study_daily_class
    FOREIGN KEY (class_id) REFERENCES class_info (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='学生每日学习与打卡记录表';
