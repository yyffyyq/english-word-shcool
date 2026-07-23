-- 词书与单词模块
-- 说明：存放平台内置词书、单词基础数据、四选一中文选项，以及词书和单词的关系。
-- 单词内容由教师/管理员手工录入，不依赖机器翻译。
--
-- 注意：本脚本会重建 word、word_option、word_book_item，
--       并清空学习模块中引用旧单词 ID 的答题记录和学习进度。
--       正式环境执行前请先备份数据库。

-- 1. 保存当前外键检查状态并临时关闭，避免删除父表时触发 3730 错误
SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS;
SET FOREIGN_KEY_CHECKS = 0;

-- 2. 如果学习模块已初始化，先清理引用旧 word.id 的业务数据，避免重建后出现孤儿记录
SET @DELETE_ANSWER_RECORD_SQL = IF(
  EXISTS(
    SELECT 1
    FROM information_schema.TABLES
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'answer_record'
  ),
  'DELETE FROM answer_record',
  'SELECT 1'
);
PREPARE delete_answer_record_stmt FROM @DELETE_ANSWER_RECORD_SQL;
EXECUTE delete_answer_record_stmt;
DEALLOCATE PREPARE delete_answer_record_stmt;

SET @DELETE_WORD_PROGRESS_SQL = IF(
  EXISTS(
    SELECT 1
    FROM information_schema.TABLES
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'student_word_progress'
  ),
  'DELETE FROM student_word_progress',
  'SELECT 1'
);
PREPARE delete_word_progress_stmt FROM @DELETE_WORD_PROGRESS_SQL;
EXECUTE delete_word_progress_stmt;
DEALLOCATE PREPARE delete_word_progress_stmt;

-- 3. 按“子表 → 父表”顺序删除，解决 fk_word_book_item_word 外键阻止删除 word 的问题
DROP TABLE IF EXISTS word_option;
DROP TABLE IF EXISTS word_book_item;
DROP TABLE IF EXISTS word;

CREATE TABLE IF NOT EXISTS word_book (
  id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '词书ID',
  book_name VARCHAR(100) NOT NULL COMMENT '词书名称，例如 小学英语三年级上册',
  description VARCHAR(500) NULL COMMENT '词书说明',
  cover_url VARCHAR(500) NULL COMMENT '词书封面图片地址',
  word_count INT NOT NULL DEFAULT 0 COMMENT '词书单词总数，便于列表展示',
  status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE' COMMENT '词书状态：ACTIVE 启用，DISABLED 停用',
  created_at DATETIME NOT NULL COMMENT '创建时间',
  updated_at DATETIME NOT NULL COMMENT '更新时间',
  KEY idx_word_book_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='平台内置词书表';

CREATE TABLE IF NOT EXISTS word (
  id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '单词ID',
  word_text VARCHAR(100) NOT NULL COMMENT '英文单词内容',
  phonetic VARCHAR(100) NULL COMMENT '音标',
  correct_meaning VARCHAR(500) NOT NULL COMMENT '正确中文释义，学生答题判分依据',
  example_sentence VARCHAR(1000) NOT NULL COMMENT '英文例句',
  example_translation VARCHAR(1000) NOT NULL COMMENT '例句中文翻译',
  created_at DATETIME NOT NULL COMMENT '创建时间',
  updated_at DATETIME NOT NULL COMMENT '更新时间',
  UNIQUE KEY uk_word_text (word_text)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='单词基础数据表（手工录入）';

CREATE TABLE IF NOT EXISTS word_option (
  id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '单词选项ID',
  word_id BIGINT NOT NULL COMMENT '单词ID，关联 word.id',
  option_text VARCHAR(500) NOT NULL COMMENT '中文选项内容',
  is_correct TINYINT NOT NULL DEFAULT 0 COMMENT '是否正确答案：1 正确，0 错误（干扰项）',
  sort_order INT NOT NULL DEFAULT 0 COMMENT '选项排序；导入时写入，出题时可打乱',
  created_at DATETIME NOT NULL COMMENT '创建时间',
  updated_at DATETIME NOT NULL COMMENT '更新时间',
  KEY idx_word_option_word (word_id),
  KEY idx_word_option_correct (word_id, is_correct),
  CONSTRAINT fk_word_option_word
    FOREIGN KEY (word_id) REFERENCES word (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='单词中文选项表：1 个正确项 + 3 个干扰项，供四选一判分';

CREATE TABLE IF NOT EXISTS word_book_item (
  id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '词书单词关系ID',
  book_id BIGINT NOT NULL COMMENT '词书ID，关联 word_book.id',
  word_id BIGINT NOT NULL COMMENT '单词ID，关联 word.id',
  sort_order INT NOT NULL COMMENT '单词在词书中的排序',
  unit_name VARCHAR(100) NULL COMMENT '所属单元名称，例如 Unit 1',
  UNIQUE KEY uk_book_word (book_id, word_id),
  KEY idx_word_book_item_book_sort (book_id, sort_order),
  KEY idx_word_book_item_word (word_id),
  CONSTRAINT fk_word_book_item_book
    FOREIGN KEY (book_id) REFERENCES word_book (id),
  CONSTRAINT fk_word_book_item_word
    FOREIGN KEY (word_id) REFERENCES word (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='词书与单词关系表';

-- 4. 旧词书已无单词关联，重置缓存数量
UPDATE word_book
SET word_count = 0,
    updated_at = NOW();

-- 5. 恢复执行脚本前的外键检查状态
SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS;
