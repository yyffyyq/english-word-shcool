-- 学生每日学习计划：按个人进度结转未完成单词并补足到每日额度
-- 已有库执行本脚本；新库直接执行更新后的 07_daily_assign.sql 即可。

-- 1. 明细表增加 student_id
SET @ADD_STUDENT_ID_SQL = IF(
  EXISTS(
    SELECT 1
    FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE()
      AND TABLE_NAME = 'class_daily_assignment_word'
      AND COLUMN_NAME = 'student_id'
  ),
  'SELECT 1',
  'ALTER TABLE class_daily_assignment_word ADD COLUMN student_id BIGINT NULL COMMENT ''学生ID；按学生补足每日学习词表。历史全班分配可为空'' AFTER assignment_id'
);
PREPARE add_student_id_stmt FROM @ADD_STUDENT_ID_SQL;
EXECUTE add_student_id_stmt;
DEALLOCATE PREPARE add_student_id_stmt;

-- 2. 先加上「按学生 + 单词」唯一约束（其首列 assignment_id 可承接外键索引）
SET @ADD_NEW_UK_SQL = IF(
  EXISTS(
    SELECT 1
    FROM information_schema.STATISTICS
    WHERE TABLE_SCHEMA = DATABASE()
      AND TABLE_NAME = 'class_daily_assignment_word'
      AND INDEX_NAME = 'uk_class_daily_assignment_word_student'
  ),
  'SELECT 1',
  'ALTER TABLE class_daily_assignment_word ADD UNIQUE KEY uk_class_daily_assignment_word_student (assignment_id, student_id, word_id)'
);
PREPARE add_new_uk_stmt FROM @ADD_NEW_UK_SQL;
EXECUTE add_new_uk_stmt;
DEALLOCATE PREPARE add_new_uk_stmt;

-- 3. 再去掉「全班一份词表」唯一约束（必须先有 assignment_id 索引，否则外键会拦住 DROP）
SET @DROP_OLD_UK_SQL = IF(
  EXISTS(
    SELECT 1
    FROM information_schema.STATISTICS
    WHERE TABLE_SCHEMA = DATABASE()
      AND TABLE_NAME = 'class_daily_assignment_word'
      AND INDEX_NAME = 'uk_class_daily_assignment_word'
  ),
  'ALTER TABLE class_daily_assignment_word DROP INDEX uk_class_daily_assignment_word',
  'SELECT 1'
);
PREPARE drop_old_uk_stmt FROM @DROP_OLD_UK_SQL;
EXECUTE drop_old_uk_stmt;
DEALLOCATE PREPARE drop_old_uk_stmt;

-- 4. 学生 + 日期查询索引
SET @ADD_STUDENT_DATE_IDX_SQL = IF(
  EXISTS(
    SELECT 1
    FROM information_schema.STATISTICS
    WHERE TABLE_SCHEMA = DATABASE()
      AND TABLE_NAME = 'class_daily_assignment_word'
      AND INDEX_NAME = 'idx_class_daily_assignment_word_student_date'
  ),
  'SELECT 1',
  'ALTER TABLE class_daily_assignment_word ADD KEY idx_class_daily_assignment_word_student_date (student_id, assign_date)'
);
PREPARE add_student_date_idx_stmt FROM @ADD_STUDENT_DATE_IDX_SQL;
EXECUTE add_student_date_idx_stmt;
DEALLOCATE PREPARE add_student_date_idx_stmt;

-- 5. 学生外键
SET @ADD_STUDENT_FK_SQL = IF(
  EXISTS(
    SELECT 1
    FROM information_schema.TABLE_CONSTRAINTS
    WHERE TABLE_SCHEMA = DATABASE()
      AND TABLE_NAME = 'class_daily_assignment_word'
      AND CONSTRAINT_NAME = 'fk_class_daily_assignment_word_student'
  ),
  'SELECT 1',
  'ALTER TABLE class_daily_assignment_word ADD CONSTRAINT fk_class_daily_assignment_word_student FOREIGN KEY (student_id) REFERENCES user_account (id)'
);
PREPARE add_student_fk_stmt FROM @ADD_STUDENT_FK_SQL;
EXECUTE add_student_fk_stmt;
DEALLOCATE PREPARE add_student_fk_stmt;
