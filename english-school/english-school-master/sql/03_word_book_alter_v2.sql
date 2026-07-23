-- 已有库升级脚本：单词表去掉音标/音频，改为正确释义 + 四选一选项表
-- 执行前请先备份数据。若表中已有 meaning 数据，会迁移到 correct_meaning。

-- 1. 调整 word 表字段
ALTER TABLE word
  ADD COLUMN correct_meaning VARCHAR(500) NULL COMMENT '正确中文释义，学生答题判分依据' AFTER word_text;

UPDATE word SET correct_meaning = meaning WHERE correct_meaning IS NULL AND meaning IS NOT NULL;

ALTER TABLE word
  MODIFY COLUMN correct_meaning VARCHAR(500) NOT NULL COMMENT '正确中文释义，学生答题判分依据';

ALTER TABLE word
  DROP COLUMN phonetic,
  DROP COLUMN meaning,
  DROP COLUMN audio_url;

use englishworddb;
-- 2. 新建选项表
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

-- 3. 将历史正确释义写入选项表（仅正确项；干扰项需重新导入或后台补齐）
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, w.correct_meaning, 1, 0, NOW(), NOW()
FROM word w
WHERE NOT EXISTS (
  SELECT 1 FROM word_option o WHERE o.word_id = w.id AND o.is_correct = 1
);
