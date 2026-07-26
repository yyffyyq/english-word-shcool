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

-- ============================================================================
-- 6. 测试数据：为单词本 id=1 插入 50 个英文单词（含四选一选项与词书关联）
--    可重复执行：先清理旧测试数据，再重新插入
-- ============================================================================

-- 6.0 清理旧测试数据，避免主键冲突（1062 Duplicate entry）
DELETE FROM word_option WHERE word_id BETWEEN 1 AND 50;
DELETE FROM word_book_item WHERE book_id = 1 AND word_id BETWEEN 1 AND 50;
DELETE FROM word WHERE id BETWEEN 1 AND 50;

-- 6.1 若尚无 id=1 的词书，则补一条测试词书
INSERT INTO word_book (id, book_name, description, cover_url, word_count, status, created_at, updated_at)
SELECT 1, '小学英语测试词书', '用于接口联调的 50 词测试词书', NULL, 0, 'ACTIVE', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM word_book WHERE id = 1);

-- 6.2 插入 50 个单词
INSERT INTO word (id, word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at) VALUES
(1,  'apple',      '/ˈæpl/',          '苹果',     'I eat an apple every day.',              '我每天吃一个苹果。', NOW(), NOW()),
(2,  'banana',     '/bəˈnɑːnə/',       '香蕉',     'The banana is yellow.',                   '香蕉是黄色的。', NOW(), NOW()),
(3,  'cat',        '/kæt/',            '猫',       'The cat is sleeping on the sofa.',        '猫在沙发上睡觉。', NOW(), NOW()),
(4,  'dog',        '/dɒɡ/',            '狗',       'My dog likes to run in the park.',        '我的狗喜欢在公园跑步。', NOW(), NOW()),
(5,  'book',       '/bʊk/',            '书',       'This book is very interesting.',          '这本书非常有趣。', NOW(), NOW()),
(6,  'pen',        '/pen/',            '钢笔',     'Please write with a pen.',                '请用钢笔写字。', NOW(), NOW()),
(7,  'school',     '/skuːl/',          '学校',     'We go to school every morning.',          '我们每天早上去学校。', NOW(), NOW()),
(8,  'teacher',    '/ˈtiːtʃə(r)/',     '老师',     'Our teacher is kind and patient.',        '我们的老师既和蔼又有耐心。', NOW(), NOW()),
(9,  'student',    '/ˈstjuːdnt/',      '学生',     'She is a hard-working student.',          '她是一个勤奋的学生。', NOW(), NOW()),
(10, 'water',      '/ˈwɔːtə(r)/',      '水',       'Please drink more water.',                '请多喝水。', NOW(), NOW()),
(11, 'milk',       '/mɪlk/',           '牛奶',     'I drink milk for breakfast.',             '我早餐喝牛奶。', NOW(), NOW()),
(12, 'bread',      '/bred/',           '面包',     'He bought a loaf of bread.',              '他买了一条面包。', NOW(), NOW()),
(13, 'happy',      '/ˈhæpi/',          '快乐的',   'The children look very happy.',           '孩子们看起来非常快乐。', NOW(), NOW()),
(14, 'sad',        '/sæd/',            '伤心的',   'Why do you look so sad today?',           '你今天为什么看起来这么伤心？', NOW(), NOW()),
(15, 'run',        '/rʌn/',            '跑',       'I run every morning in the park.',        '我每天早上在公园跑步。', NOW(), NOW()),
(16, 'walk',       '/wɔːk/',           '走',       'Let us walk to the library.',             '我们走去图书馆吧。', NOW(), NOW()),
(17, 'big',        '/bɪɡ/',            '大的',     'That is a big house.',                    '那是一座大房子。', NOW(), NOW()),
(18, 'small',      '/smɔːl/',          '小的',     'I have a small bag.',                     '我有一个小书包。', NOW(), NOW()),
(19, 'red',        '/red/',            '红色的',   'She wears a red dress.',                  '她穿着一条红色连衣裙。', NOW(), NOW()),
(20, 'blue',       '/bluː/',           '蓝色的',   'The sky is blue today.',                  '今天天空是蓝色的。', NOW(), NOW()),
(21, 'green',      '/ɡriːn/',          '绿色的',   'The grass is green in spring.',           '春天草地是绿色的。', NOW(), NOW()),
(22, 'yellow',     '/ˈjeləʊ/',         '黄色的',   'I like yellow flowers.',                  '我喜欢黄色的花。', NOW(), NOW()),
(23, 'mother',     '/ˈmʌðə(r)/',       '母亲',     'My mother cooks dinner for us.',          '妈妈为我们做晚饭。', NOW(), NOW()),
(24, 'father',     '/ˈfɑːðə(r)/',      '父亲',     'My father works in a hospital.',          '我父亲在医院工作。', NOW(), NOW()),
(25, 'sister',     '/ˈsɪstə(r)/',      '姐妹',     'I have one younger sister.',              '我有一个妹妹。', NOW(), NOW()),
(26, 'brother',    '/ˈbrʌðə(r)/',      '兄弟',     'My brother is good at football.',         '我哥哥擅长踢足球。', NOW(), NOW()),
(27, 'friend',     '/frend/',          '朋友',     'Tom is my best friend.',                  '汤姆是我最好的朋友。', NOW(), NOW()),
(28, 'family',     '/ˈfæməli/',        '家庭',     'I love my family very much.',             '我非常爱我的家人。', NOW(), NOW()),
(29, 'home',       '/həʊm/',           '家',       'I want to go home now.',                  '我现在想回家。', NOW(), NOW()),
(30, 'desk',       '/desk/',           '书桌',     'There is a book on the desk.',            '书桌上有一本书。', NOW(), NOW()),
(31, 'chair',      '/tʃeə(r)/',        '椅子',     'Please sit on the chair.',                '请坐在椅子上。', NOW(), NOW()),
(32, 'bag',        '/bæɡ/',            '包',       'My bag is full of books.',                '我的包里装满了书。', NOW(), NOW()),
(33, 'fish',       '/fɪʃ/',            '鱼',       'There are many fish in the river.',       '河里有很多鱼。', NOW(), NOW()),
(34, 'bird',       '/bɜːd/',           '鸟',       'A bird is singing in the tree.',          '一只鸟在树上唱歌。', NOW(), NOW()),
(35, 'horse',      '/hɔːs/',           '马',       'The horse runs very fast.',               '这匹马跑得非常快。', NOW(), NOW()),
(36, 'orange',     '/ˈɒrɪndʒ/',        '橙子',     'I want to eat an orange.',                '我想吃一个橙子。', NOW(), NOW()),
(37, 'grape',      '/ɡreɪp/',          '葡萄',     'These grapes are sweet.',                 '这些葡萄很甜。', NOW(), NOW()),
(38, 'peach',      '/piːtʃ/',          '桃子',     'The peach tastes delicious.',             '这个桃子味道很好。', NOW(), NOW()),
(39, 'egg',        '/eɡ/',             '鸡蛋',     'I had an egg for breakfast.',             '我早餐吃了一个鸡蛋。', NOW(), NOW()),
(40, 'rice',       '/raɪs/',           '米饭',     'We eat rice every day.',                  '我们每天吃米饭。', NOW(), NOW()),
(41, 'jump',       '/dʒʌmp/',          '跳',       'The kids jump on the playground.',        '孩子们在操场上跳。', NOW(), NOW()),
(42, 'swim',       '/swɪm/',           '游泳',     'I can swim in the pool.',                 '我会在游泳池游泳。', NOW(), NOW()),
(43, 'read',       '/riːd/',           '阅读',     'I like to read story books.',             '我喜欢读故事书。', NOW(), NOW()),
(44, 'write',      '/raɪt/',           '写',       'Please write your name here.',            '请在这里写下你的名字。', NOW(), NOW()),
(45, 'long',       '/lɒŋ/',            '长的',     'This is a long river.',                   '这是一条长河。', NOW(), NOW()),
(46, 'short',      '/ʃɔːt/',           '短的',     'He has short hair.',                      '他留着短发。', NOW(), NOW()),
(47, 'new',        '/njuː/',           '新的',     'I bought a new bike.',                    '我买了一辆新自行车。', NOW(), NOW()),
(48, 'old',        '/əʊld/',           '旧的',     'This is an old photo.',                   '这是一张旧照片。', NOW(), NOW()),
(49, 'black',      '/blæk/',           '黑色的',   'He wears a black hat.',                   '他戴着一顶黑色帽子。', NOW(), NOW()),
(50, 'white',      '/waɪt/',           '白色的',   'The snow is white.',                      '雪是白色的。', NOW(), NOW());

-- 6.3 为每个单词插入 1 个正确选项 + 3 个错误选项
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at) VALUES
-- apple
(1, '苹果', 1, 0, NOW(), NOW()), (1, '香蕉', 0, 1, NOW(), NOW()), (1, '橙子', 0, 2, NOW(), NOW()), (1, '葡萄', 0, 3, NOW(), NOW()),
-- banana
(2, '香蕉', 1, 0, NOW(), NOW()), (2, '苹果', 0, 1, NOW(), NOW()), (2, '桃子', 0, 2, NOW(), NOW()), (2, '西瓜', 0, 3, NOW(), NOW()),
-- cat
(3, '猫', 1, 0, NOW(), NOW()), (3, '狗', 0, 1, NOW(), NOW()), (3, '鸟', 0, 2, NOW(), NOW()), (3, '鱼', 0, 3, NOW(), NOW()),
-- dog
(4, '狗', 1, 0, NOW(), NOW()), (4, '猫', 0, 1, NOW(), NOW()), (4, '马', 0, 2, NOW(), NOW()), (4, '兔子', 0, 3, NOW(), NOW()),
-- book
(5, '书', 1, 0, NOW(), NOW()), (5, '笔', 0, 1, NOW(), NOW()), (5, '包', 0, 2, NOW(), NOW()), (5, '桌子', 0, 3, NOW(), NOW()),
-- pen
(6, '钢笔', 1, 0, NOW(), NOW()), (6, '铅笔', 0, 1, NOW(), NOW()), (6, '尺子', 0, 2, NOW(), NOW()), (6, '橡皮', 0, 3, NOW(), NOW()),
-- school
(7, '学校', 1, 0, NOW(), NOW()), (7, '医院', 0, 1, NOW(), NOW()), (7, '公园', 0, 2, NOW(), NOW()), (7, '商店', 0, 3, NOW(), NOW()),
-- teacher
(8, '老师', 1, 0, NOW(), NOW()), (8, '学生', 0, 1, NOW(), NOW()), (8, '医生', 0, 2, NOW(), NOW()), (8, '警察', 0, 3, NOW(), NOW()),
-- student
(9, '学生', 1, 0, NOW(), NOW()), (9, '老师', 0, 1, NOW(), NOW()), (9, '工人', 0, 2, NOW(), NOW()), (9, '司机', 0, 3, NOW(), NOW()),
-- water
(10, '水', 1, 0, NOW(), NOW()), (10, '牛奶', 0, 1, NOW(), NOW()), (10, '果汁', 0, 2, NOW(), NOW()), (10, '茶', 0, 3, NOW(), NOW()),
-- milk
(11, '牛奶', 1, 0, NOW(), NOW()), (11, '水', 0, 1, NOW(), NOW()), (11, '咖啡', 0, 2, NOW(), NOW()), (11, '豆浆', 0, 3, NOW(), NOW()),
-- bread
(12, '面包', 1, 0, NOW(), NOW()), (12, '米饭', 0, 1, NOW(), NOW()), (12, '面条', 0, 2, NOW(), NOW()), (12, '蛋糕', 0, 3, NOW(), NOW()),
-- happy
(13, '快乐的', 1, 0, NOW(), NOW()), (13, '伤心的', 0, 1, NOW(), NOW()), (13, '生气的', 0, 2, NOW(), NOW()), (13, '疲倦的', 0, 3, NOW(), NOW()),
-- sad
(14, '伤心的', 1, 0, NOW(), NOW()), (14, '快乐的', 0, 1, NOW(), NOW()), (14, '兴奋的', 0, 2, NOW(), NOW()), (14, '平静的', 0, 3, NOW(), NOW()),
-- run
(15, '跑', 1, 0, NOW(), NOW()), (15, '走', 0, 1, NOW(), NOW()), (15, '跳', 0, 2, NOW(), NOW()), (15, '坐', 0, 3, NOW(), NOW()),
-- walk
(16, '走', 1, 0, NOW(), NOW()), (16, '跑', 0, 1, NOW(), NOW()), (16, '飞', 0, 2, NOW(), NOW()), (16, '游', 0, 3, NOW(), NOW()),
-- big
(17, '大的', 1, 0, NOW(), NOW()), (17, '小的', 0, 1, NOW(), NOW()), (17, '高的', 0, 2, NOW(), NOW()), (17, '矮的', 0, 3, NOW(), NOW()),
-- small
(18, '小的', 1, 0, NOW(), NOW()), (18, '大的', 0, 1, NOW(), NOW()), (18, '长的', 0, 2, NOW(), NOW()), (18, '短的', 0, 3, NOW(), NOW()),
-- red
(19, '红色的', 1, 0, NOW(), NOW()), (19, '蓝色的', 0, 1, NOW(), NOW()), (19, '绿色的', 0, 2, NOW(), NOW()), (19, '黄色的', 0, 3, NOW(), NOW()),
-- blue
(20, '蓝色的', 1, 0, NOW(), NOW()), (20, '红色的', 0, 1, NOW(), NOW()), (20, '黑色的', 0, 2, NOW(), NOW()), (20, '白色的', 0, 3, NOW(), NOW()),
-- green
(21, '绿色的', 1, 0, NOW(), NOW()), (21, '黄色的', 0, 1, NOW(), NOW()), (21, '紫色的', 0, 2, NOW(), NOW()), (21, '橙色的', 0, 3, NOW(), NOW()),
-- yellow
(22, '黄色的', 1, 0, NOW(), NOW()), (22, '绿色的', 0, 1, NOW(), NOW()), (22, '红色的', 0, 2, NOW(), NOW()), (22, '蓝色的', 0, 3, NOW(), NOW()),
-- mother
(23, '母亲', 1, 0, NOW(), NOW()), (23, '父亲', 0, 1, NOW(), NOW()), (23, '姐姐', 0, 2, NOW(), NOW()), (23, '奶奶', 0, 3, NOW(), NOW()),
-- father
(24, '父亲', 1, 0, NOW(), NOW()), (24, '母亲', 0, 1, NOW(), NOW()), (24, '叔叔', 0, 2, NOW(), NOW()), (24, '爷爷', 0, 3, NOW(), NOW()),
-- sister
(25, '姐妹', 1, 0, NOW(), NOW()), (25, '兄弟', 0, 1, NOW(), NOW()), (25, '朋友', 0, 2, NOW(), NOW()), (25, '同学', 0, 3, NOW(), NOW()),
-- brother
(26, '兄弟', 1, 0, NOW(), NOW()), (26, '姐妹', 0, 1, NOW(), NOW()), (26, '老师', 0, 2, NOW(), NOW()), (26, '邻居', 0, 3, NOW(), NOW()),
-- friend
(27, '朋友', 1, 0, NOW(), NOW()), (27, '敌人', 0, 1, NOW(), NOW()), (27, '陌生人', 0, 2, NOW(), NOW()), (27, '亲戚', 0, 3, NOW(), NOW()),
-- family
(28, '家庭', 1, 0, NOW(), NOW()), (28, '学校', 0, 1, NOW(), NOW()), (28, '班级', 0, 2, NOW(), NOW()), (28, '公司', 0, 3, NOW(), NOW()),
-- home
(29, '家', 1, 0, NOW(), NOW()), (29, '学校', 0, 1, NOW(), NOW()), (29, '公园', 0, 2, NOW(), NOW()), (29, '商店', 0, 3, NOW(), NOW()),
-- desk
(30, '书桌', 1, 0, NOW(), NOW()), (30, '椅子', 0, 1, NOW(), NOW()), (30, '床', 0, 2, NOW(), NOW()), (30, '柜子', 0, 3, NOW(), NOW()),
-- chair
(31, '椅子', 1, 0, NOW(), NOW()), (31, '书桌', 0, 1, NOW(), NOW()), (31, '沙发', 0, 2, NOW(), NOW()), (31, '凳子', 0, 3, NOW(), NOW()),
-- bag
(32, '包', 1, 0, NOW(), NOW()), (32, '盒子', 0, 1, NOW(), NOW()), (32, '瓶子', 0, 2, NOW(), NOW()), (32, '篮子', 0, 3, NOW(), NOW()),
-- fish
(33, '鱼', 1, 0, NOW(), NOW()), (33, '鸟', 0, 1, NOW(), NOW()), (33, '虾', 0, 2, NOW(), NOW()), (33, '螃蟹', 0, 3, NOW(), NOW()),
-- bird
(34, '鸟', 1, 0, NOW(), NOW()), (34, '鱼', 0, 1, NOW(), NOW()), (34, '蝴蝶', 0, 2, NOW(), NOW()), (34, '蜜蜂', 0, 3, NOW(), NOW()),
-- horse
(35, '马', 1, 0, NOW(), NOW()), (35, '牛', 0, 1, NOW(), NOW()), (35, '羊', 0, 2, NOW(), NOW()), (35, '猪', 0, 3, NOW(), NOW()),
-- orange
(36, '橙子', 1, 0, NOW(), NOW()), (36, '苹果', 0, 1, NOW(), NOW()), (36, '香蕉', 0, 2, NOW(), NOW()), (36, '柠檬', 0, 3, NOW(), NOW()),
-- grape
(37, '葡萄', 1, 0, NOW(), NOW()), (37, '草莓', 0, 1, NOW(), NOW()), (37, '樱桃', 0, 2, NOW(), NOW()), (37, '西瓜', 0, 3, NOW(), NOW()),
-- peach
(38, '桃子', 1, 0, NOW(), NOW()), (38, '梨', 0, 1, NOW(), NOW()), (38, '苹果', 0, 2, NOW(), NOW()), (38, '芒果', 0, 3, NOW(), NOW()),
-- egg
(39, '鸡蛋', 1, 0, NOW(), NOW()), (39, '牛奶', 0, 1, NOW(), NOW()), (39, '面包', 0, 2, NOW(), NOW()), (39, '米饭', 0, 3, NOW(), NOW()),
-- rice
(40, '米饭', 1, 0, NOW(), NOW()), (40, '面条', 0, 1, NOW(), NOW()), (40, '面包', 0, 2, NOW(), NOW()), (40, '饺子', 0, 3, NOW(), NOW()),
-- jump
(41, '跳', 1, 0, NOW(), NOW()), (41, '跑', 0, 1, NOW(), NOW()), (41, '走', 0, 2, NOW(), NOW()), (41, '爬', 0, 3, NOW(), NOW()),
-- swim
(42, '游泳', 1, 0, NOW(), NOW()), (42, '跑步', 0, 1, NOW(), NOW()), (42, '骑车', 0, 2, NOW(), NOW()), (42, '跳舞', 0, 3, NOW(), NOW()),
-- read
(43, '阅读', 1, 0, NOW(), NOW()), (43, '写作', 0, 1, NOW(), NOW()), (43, '绘画', 0, 2, NOW(), NOW()), (43, '唱歌', 0, 3, NOW(), NOW()),
-- write
(44, '写', 1, 0, NOW(), NOW()), (44, '读', 0, 1, NOW(), NOW()), (44, '听', 0, 2, NOW(), NOW()), (44, '说', 0, 3, NOW(), NOW()),
-- long
(45, '长的', 1, 0, NOW(), NOW()), (45, '短的', 0, 1, NOW(), NOW()), (45, '宽的', 0, 2, NOW(), NOW()), (45, '窄的', 0, 3, NOW(), NOW()),
-- short
(46, '短的', 1, 0, NOW(), NOW()), (46, '长的', 0, 1, NOW(), NOW()), (46, '高的', 0, 2, NOW(), NOW()), (46, '矮的', 0, 3, NOW(), NOW()),
-- new
(47, '新的', 1, 0, NOW(), NOW()), (47, '旧的', 0, 1, NOW(), NOW()), (47, '坏的', 0, 2, NOW(), NOW()), (47, '好的', 0, 3, NOW(), NOW()),
-- old
(48, '旧的', 1, 0, NOW(), NOW()), (48, '新的', 0, 1, NOW(), NOW()), (48, '年轻的', 0, 2, NOW(), NOW()), (48, '漂亮的', 0, 3, NOW(), NOW()),
-- black
(49, '黑色的', 1, 0, NOW(), NOW()), (49, '白色的', 0, 1, NOW(), NOW()), (49, '灰色的', 0, 2, NOW(), NOW()), (49, '棕色的', 0, 3, NOW(), NOW()),
-- white
(50, '白色的', 1, 0, NOW(), NOW()), (50, '黑色的', 0, 1, NOW(), NOW()), (50, '红色的', 0, 2, NOW(), NOW()), (50, '蓝色的', 0, 3, NOW(), NOW());

-- 6.4 关联到单词本 id=1（Unit 1 / Unit 2 各 25 词）
INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name) VALUES
(1, 1,  1,  'Unit 1'), (1, 2,  2,  'Unit 1'), (1, 3,  3,  'Unit 1'), (1, 4,  4,  'Unit 1'), (1, 5,  5,  'Unit 1'),
(1, 6,  6,  'Unit 1'), (1, 7,  7,  'Unit 1'), (1, 8,  8,  'Unit 1'), (1, 9,  9,  'Unit 1'), (1, 10, 10, 'Unit 1'),
(1, 11, 11, 'Unit 1'), (1, 12, 12, 'Unit 1'), (1, 13, 13, 'Unit 1'), (1, 14, 14, 'Unit 1'), (1, 15, 15, 'Unit 1'),
(1, 16, 16, 'Unit 1'), (1, 17, 17, 'Unit 1'), (1, 18, 18, 'Unit 1'), (1, 19, 19, 'Unit 1'), (1, 20, 20, 'Unit 1'),
(1, 21, 21, 'Unit 1'), (1, 22, 22, 'Unit 1'), (1, 23, 23, 'Unit 1'), (1, 24, 24, 'Unit 1'), (1, 25, 25, 'Unit 1'),
(1, 26, 26, 'Unit 2'), (1, 27, 27, 'Unit 2'), (1, 28, 28, 'Unit 2'), (1, 29, 29, 'Unit 2'), (1, 30, 30, 'Unit 2'),
(1, 31, 31, 'Unit 2'), (1, 32, 32, 'Unit 2'), (1, 33, 33, 'Unit 2'), (1, 34, 34, 'Unit 2'), (1, 35, 35, 'Unit 2'),
(1, 36, 36, 'Unit 2'), (1, 37, 37, 'Unit 2'), (1, 38, 38, 'Unit 2'), (1, 39, 39, 'Unit 2'), (1, 40, 40, 'Unit 2'),
(1, 41, 41, 'Unit 2'), (1, 42, 42, 'Unit 2'), (1, 43, 43, 'Unit 2'), (1, 44, 44, 'Unit 2'), (1, 45, 45, 'Unit 2'),
(1, 46, 46, 'Unit 2'), (1, 47, 47, 'Unit 2'), (1, 48, 48, 'Unit 2'), (1, 49, 49, 'Unit 2'), (1, 50, 50, 'Unit 2');

-- 6.5 回写词书单词数量
UPDATE word_book
SET word_count = 50,
    updated_at = NOW()
WHERE id = 1;
