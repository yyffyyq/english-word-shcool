-- 教学任务模块
-- 说明：存放教师给班级布置的词书和每日学习规则。

CREATE TABLE IF NOT EXISTS class_word_task (
  id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '班级学习任务ID',
  class_id BIGINT NOT NULL COMMENT '班级ID，关联 class_info.id',
  book_id BIGINT NOT NULL COMMENT '词书ID，关联 word_book.id',
  daily_new_count INT NOT NULL DEFAULT 10 COMMENT '每日新学单词数量',
  daily_review_count INT NOT NULL DEFAULT 20 COMMENT '每日复习单词数量',
  start_date DATE NULL COMMENT '任务开始日期，为空表示立即开始',
  end_date DATE NULL COMMENT '任务结束日期，为空表示长期有效',
  status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE' COMMENT '任务状态：ACTIVE 生效，STOPPED 停止',
  created_by BIGINT NOT NULL COMMENT '创建任务的教师ID',
  created_at DATETIME NOT NULL COMMENT '创建时间',
  updated_at DATETIME NOT NULL COMMENT '更新时间',
  KEY idx_class_word_task_class (class_id),
  KEY idx_class_word_task_book (book_id),
  KEY idx_class_word_task_status (status),
  CONSTRAINT fk_class_word_task_class
    FOREIGN KEY (class_id) REFERENCES class_info (id),
  CONSTRAINT fk_class_word_task_book
    FOREIGN KEY (book_id) REFERENCES word_book (id),
  CONSTRAINT fk_class_word_task_creator
    FOREIGN KEY (created_by) REFERENCES user_account (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='班级词书与每日学习规则表';
