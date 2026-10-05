-- 词书单词关系：unit_name 改为整数，并增加整数 week
-- 已有库执行本脚本；新库直接使用更新后的 03_word_book.sql 即可。
--
-- 现有字符串会按下面规则拆开，便于按 week、unit_name 整数排序：
--   'Week 10 Day 2' -> week = 10, unit_name = 2
--   'Unit 1'        -> week 保持空, unit_name = 1
-- 可重复执行：unit_name 已是整数时只补 week 和排序索引。

DROP PROCEDURE IF EXISTS migrate_word_book_item_week_unit;

DELIMITER $$

CREATE PROCEDURE migrate_word_book_item_week_unit()
BEGIN
    DECLARE unit_type VARCHAR(64);

    SELECT DATA_TYPE INTO unit_type
    FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE()
      AND TABLE_NAME = 'word_book_item'
      AND COLUMN_NAME = 'unit_name';

    IF unit_type IN ('varchar', 'char', 'text') THEN
        IF NOT EXISTS (
            SELECT 1
            FROM information_schema.COLUMNS
            WHERE TABLE_SCHEMA = DATABASE()
              AND TABLE_NAME = 'word_book_item'
              AND COLUMN_NAME = 'week'
        ) THEN
            ALTER TABLE word_book_item
                ADD COLUMN week INT NULL COMMENT '所属周次，按整数排序' AFTER sort_order;
        END IF;

        IF NOT EXISTS (
            SELECT 1
            FROM information_schema.COLUMNS
            WHERE TABLE_SCHEMA = DATABASE()
              AND TABLE_NAME = 'word_book_item'
              AND COLUMN_NAME = 'unit_no'
        ) THEN
            ALTER TABLE word_book_item
                ADD COLUMN unit_no INT NULL COMMENT '临时单元序号' AFTER week;
        END IF;

        UPDATE word_book_item
        SET week = CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(unit_name, ' ', 2), ' ', -1) AS UNSIGNED),
            unit_no = CAST(SUBSTRING_INDEX(unit_name, ' ', -1) AS UNSIGNED)
        WHERE unit_name LIKE 'Week % Day %';

        UPDATE word_book_item
        SET unit_no = CAST(SUBSTRING_INDEX(unit_name, ' ', -1) AS UNSIGNED)
        WHERE unit_name LIKE 'Unit %'
          AND unit_no IS NULL;

        UPDATE word_book_item
        SET unit_no = CAST(unit_name AS UNSIGNED)
        WHERE unit_no IS NULL
          AND unit_name REGEXP '^[0-9]+$';

        ALTER TABLE word_book_item DROP COLUMN unit_name;
        ALTER TABLE word_book_item
            CHANGE COLUMN unit_no unit_name INT NULL COMMENT '所属单元序号，按整数排序';
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM information_schema.COLUMNS
        WHERE TABLE_SCHEMA = DATABASE()
          AND TABLE_NAME = 'word_book_item'
          AND COLUMN_NAME = 'week'
    ) THEN
        ALTER TABLE word_book_item
            ADD COLUMN week INT NULL COMMENT '所属周次，按整数排序' AFTER sort_order;
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM information_schema.STATISTICS
        WHERE TABLE_SCHEMA = DATABASE()
          AND TABLE_NAME = 'word_book_item'
          AND INDEX_NAME = 'idx_word_book_item_book_week_unit'
    ) THEN
        ALTER TABLE word_book_item
            ADD INDEX idx_word_book_item_book_week_unit (book_id, week, unit_name, sort_order);
    END IF;
END$$

DELIMITER ;

CALL migrate_word_book_item_week_unit();

DROP PROCEDURE IF EXISTS migrate_word_book_item_week_unit;
