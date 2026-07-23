-- 已有库升级：去掉机器翻译依赖字段假设，补回音标；例句改为必填语义由应用层保证
-- 执行前请备份。

-- 1. 补回音标
ALTER TABLE word
  ADD COLUMN phonetic VARCHAR(100) NULL COMMENT '音标' AFTER word_text;

-- 2. 若尚无 correct_meaning，从旧 meaning 迁移（按需执行）
-- ALTER TABLE word ADD COLUMN correct_meaning VARCHAR(500) NULL COMMENT '正确中文释义' AFTER phonetic;
-- UPDATE word SET correct_meaning = meaning WHERE correct_meaning IS NULL AND meaning IS NOT NULL;
-- ALTER TABLE word MODIFY COLUMN correct_meaning VARCHAR(500) NOT NULL COMMENT '正确中文释义，学生答题判分依据';
