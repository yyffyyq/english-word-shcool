-- 班级每日单词分配模块
-- 说明：存放按作业计划每日抽出的班级词表，保证全班一致且不重复分配。

CREATE TABLE IF NOT EXISTS class_daily_assignment (
  id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '班级每日分配批次ID',
  task_id BIGINT NOT NULL COMMENT '班级学习任务ID，关联 class_word_task.id',
  class_id BIGINT NOT NULL COMMENT '班级ID，关联 class_info.id',
  book_id BIGINT NOT NULL COMMENT '词书ID，关联 word_book.id',
  assign_date DATE NOT NULL COMMENT '学习日期（业务日）',
  planned_count INT NOT NULL COMMENT '计划分配单词数',
  actual_count INT NOT NULL DEFAULT 0 COMMENT '实际分配单词数',
  status VARCHAR(20) NOT NULL COMMENT '批次状态：SUCCESS 足额，PARTIAL 词不够，SKIPPED 无词可分，FAILED 失败',
  created_at DATETIME NOT NULL COMMENT '创建时间',
  UNIQUE KEY uk_class_daily_assignment_task_date (task_id, assign_date),
  KEY idx_class_daily_assignment_class_date (class_id, assign_date),
  KEY idx_class_daily_assignment_status (status),
  CONSTRAINT fk_class_daily_assignment_task
    FOREIGN KEY (task_id) REFERENCES class_word_task (id),
  CONSTRAINT fk_class_daily_assignment_class
    FOREIGN KEY (class_id) REFERENCES class_info (id),
  CONSTRAINT fk_class_daily_assignment_book
    FOREIGN KEY (book_id) REFERENCES word_book (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='班级每日单词分配批次表';

CREATE TABLE IF NOT EXISTS class_daily_assignment_word (
  id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '班级每日分配单词明细ID',
  assignment_id BIGINT NOT NULL COMMENT '分配批次ID，关联 class_daily_assignment.id',
  task_id BIGINT NOT NULL COMMENT '班级学习任务ID，关联 class_word_task.id',
  word_id BIGINT NOT NULL COMMENT '单词ID，关联 word.id',
  assign_date DATE NOT NULL COMMENT '学习日期（业务日）',
  sort_order INT NOT NULL DEFAULT 0 COMMENT '展示排序，从 1 开始',
  created_at DATETIME NOT NULL COMMENT '创建时间',
  UNIQUE KEY uk_class_daily_assignment_word (assignment_id, word_id),
  KEY idx_class_daily_assignment_word_task_word (task_id, word_id),
  KEY idx_class_daily_assignment_word_date (assign_date),
  CONSTRAINT fk_class_daily_assignment_word_assignment
    FOREIGN KEY (assignment_id) REFERENCES class_daily_assignment (id),
  CONSTRAINT fk_class_daily_assignment_word_task
    FOREIGN KEY (task_id) REFERENCES class_word_task (id),
  CONSTRAINT fk_class_daily_assignment_word_word
    FOREIGN KEY (word_id) REFERENCES word (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='班级每日分配单词明细表，同时作为任务维度已分配标记';
