-- 词书与单词模块
-- 说明：存放平台内置词书、单词基础数据，以及词书和单词的关系。

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
  meaning VARCHAR(500) NOT NULL COMMENT '中文释义',
  example_sentence VARCHAR(1000) NULL COMMENT '英文例句',
  example_translation VARCHAR(1000) NULL COMMENT '例句中文翻译',
  image_url VARCHAR(500) NULL COMMENT '单词图片 OSS 地址',
  audio_url VARCHAR(500) NULL COMMENT '单词音频 OSS 地址',
  created_at DATETIME NOT NULL COMMENT '创建时间',
  updated_at DATETIME NOT NULL COMMENT '更新时间',
  UNIQUE KEY uk_word_text (word_text)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='单词基础数据表';

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
