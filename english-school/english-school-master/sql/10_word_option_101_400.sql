-- 中考英语1600词 第101-400个单词的四选一中文选项
-- 每个单词：1 个正确项 + 3 个同类但可明确区分的干扰项
-- 通过 word.word_text 关联 word_id，不写死主键
-- 若该单词已有选项（如测试词书中的 cat/red/teacher），则跳过，避免重复

SET NAMES utf8mb4;

-- generation
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '一代' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '世纪', 0, 1
  UNION ALL SELECT '季节', 0, 2
  UNION ALL SELECT '年龄', 0, 3
) t
WHERE w.word_text = 'generation'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- celebrate
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '庆祝' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '取消', 0, 1
  UNION ALL SELECT '抱怨', 0, 2
  UNION ALL SELECT '忘记', 0, 3
) t
WHERE w.word_text = 'celebrate'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- childhood
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '童年' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '成年', 0, 1
  UNION ALL SELECT '老年', 0, 2
  UNION ALL SELECT '未来', 0, 3
) t
WHERE w.word_text = 'childhood'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- kick
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '踢' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '拍', 0, 1
  UNION ALL SELECT '扔', 0, 2
  UNION ALL SELECT '抱', 0, 3
) t
WHERE w.word_text = 'kick'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- listen
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '听' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '说', 0, 1
  UNION ALL SELECT '看', 0, 2
  UNION ALL SELECT '写', 0, 3
) t
WHERE w.word_text = 'listen'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- volleyball
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '排球' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '篮球', 0, 1
  UNION ALL SELECT '足球', 0, 2
  UNION ALL SELECT '乒乓球', 0, 3
) t
WHERE w.word_text = 'volleyball'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- college
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '学院' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '医院', 0, 1
  UNION ALL SELECT '工厂', 0, 2
  UNION ALL SELECT '商店', 0, 3
) t
WHERE w.word_text = 'college'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- moment
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '片刻' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '一年', 0, 1
  UNION ALL SELECT '世纪', 0, 2
  UNION ALL SELECT '永远', 0, 3
) t
WHERE w.word_text = 'moment'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- repeat
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '重复' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '停止', 0, 1
  UNION ALL SELECT '开始', 0, 2
  UNION ALL SELECT '删除', 0, 3
) t
WHERE w.word_text = 'repeat'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- result
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '结果' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '原因', 0, 1
  UNION ALL SELECT '过程', 0, 2
  UNION ALL SELECT '计划', 0, 3
) t
WHERE w.word_text = 'result'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- link
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '连接' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '分开', 0, 1
  UNION ALL SELECT '打断', 0, 2
  UNION ALL SELECT '隐藏', 0, 3
) t
WHERE w.word_text = 'link'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- tennis
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '网球' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '排球', 0, 1
  UNION ALL SELECT '羽毛球', 0, 2
  UNION ALL SELECT '高尔夫', 0, 3
) t
WHERE w.word_text = 'tennis'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- key
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '钥匙' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '锁', 0, 1
  UNION ALL SELECT '门', 0, 2
  UNION ALL SELECT '窗户', 0, 3
) t
WHERE w.word_text = 'key'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- who
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '谁' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '什么', 0, 1
  UNION ALL SELECT '哪里', 0, 2
  UNION ALL SELECT '何时', 0, 3
) t
WHERE w.word_text = 'who'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- interest
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '兴趣' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '讨厌', 0, 1
  UNION ALL SELECT '害怕', 0, 2
  UNION ALL SELECT '疲劳', 0, 3
) t
WHERE w.word_text = 'interest'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- queen
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '王后' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '国王', 0, 1
  UNION ALL SELECT '王子', 0, 2
  UNION ALL SELECT '公主', 0, 3
) t
WHERE w.word_text = 'queen'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- play
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '玩耍' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '睡觉', 0, 1
  UNION ALL SELECT '工作', 0, 2
  UNION ALL SELECT '吃饭', 0, 3
) t
WHERE w.word_text = 'play'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- seldom
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '很少' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '总是', 0, 1
  UNION ALL SELECT '经常', 0, 2
  UNION ALL SELECT '通常', 0, 3
) t
WHERE w.word_text = 'seldom'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- relationship
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '关系' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '距离', 0, 1
  UNION ALL SELECT '方向', 0, 2
  UNION ALL SELECT '形状', 0, 3
) t
WHERE w.word_text = 'relationship'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- damage
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '损害' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '修理', 0, 1
  UNION ALL SELECT '保护', 0, 2
  UNION ALL SELECT '建造', 0, 3
) t
WHERE w.word_text = 'damage'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- half
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '一半' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '全部', 0, 1
  UNION ALL SELECT '没有', 0, 2
  UNION ALL SELECT '两倍', 0, 3
) t
WHERE w.word_text = 'half'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- focus
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '集中' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '分散', 0, 1
  UNION ALL SELECT '放弃', 0, 2
  UNION ALL SELECT '忽略', 0, 3
) t
WHERE w.word_text = 'focus'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- upstairs
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '在楼上' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '在楼下', 0, 1
  UNION ALL SELECT '在门外', 0, 2
  UNION ALL SELECT '在地下', 0, 3
) t
WHERE w.word_text = 'upstairs'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- call
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '打电话' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '写信', 0, 1
  UNION ALL SELECT '见面', 0, 2
  UNION ALL SELECT '等待', 0, 3
) t
WHERE w.word_text = 'call'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- cabbage
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '卷心菜' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '菠菜', 0, 1
  UNION ALL SELECT '西红柿', 0, 2
  UNION ALL SELECT '黄瓜', 0, 3
) t
WHERE w.word_text = 'cabbage'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- freedom
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '自由' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '束缚', 0, 1
  UNION ALL SELECT '惩罚', 0, 2
  UNION ALL SELECT '规则', 0, 3
) t
WHERE w.word_text = 'freedom'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- pink
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '粉红色的' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '蓝色的', 0, 1
  UNION ALL SELECT '绿色的', 0, 2
  UNION ALL SELECT '黑色的', 0, 3
) t
WHERE w.word_text = 'pink'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- memory
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '记忆' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '遗忘', 0, 1
  UNION ALL SELECT '想象', 0, 2
  UNION ALL SELECT '梦想', 0, 3
) t
WHERE w.word_text = 'memory'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- temperature
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '温度' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '速度', 0, 1
  UNION ALL SELECT '重量', 0, 2
  UNION ALL SELECT '长度', 0, 3
) t
WHERE w.word_text = 'temperature'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- charity
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '慈善' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '商业', 0, 1
  UNION ALL SELECT '战争', 0, 2
  UNION ALL SELECT '比赛', 0, 3
) t
WHERE w.word_text = 'charity'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- on
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '在…上面' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '在…下面', 0, 1
  UNION ALL SELECT '在…里面', 0, 2
  UNION ALL SELECT '在…后面', 0, 3
) t
WHERE w.word_text = 'on'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- post
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '邮寄' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '购买', 0, 1
  UNION ALL SELECT '收藏', 0, 2
  UNION ALL SELECT '撕毁', 0, 3
) t
WHERE w.word_text = 'post'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- invention
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '发明' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '抄袭', 0, 1
  UNION ALL SELECT '破坏', 0, 2
  UNION ALL SELECT '丢失', 0, 3
) t
WHERE w.word_text = 'invention'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- theatre
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '剧院' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '电影院', 0, 1
  UNION ALL SELECT '博物馆', 0, 2
  UNION ALL SELECT '图书馆', 0, 3
) t
WHERE w.word_text = 'theatre'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- check
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '检查' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '忽略', 0, 1
  UNION ALL SELECT '猜测', 0, 2
  UNION ALL SELECT '隐藏', 0, 3
) t
WHERE w.word_text = 'check'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- publish
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '出版' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '阅读', 0, 1
  UNION ALL SELECT '翻译', 0, 2
  UNION ALL SELECT '删除', 0, 3
) t
WHERE w.word_text = 'publish'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- understand
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '理解' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '误解', 0, 1
  UNION ALL SELECT '忘记', 0, 2
  UNION ALL SELECT '忽略', 0, 3
) t
WHERE w.word_text = 'understand'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- library
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '图书馆' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '书店', 0, 1
  UNION ALL SELECT '教室', 0, 2
  UNION ALL SELECT '实验室', 0, 3
) t
WHERE w.word_text = 'library'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- better
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '更好的' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '更差的', 0, 1
  UNION ALL SELECT '一样的', 0, 2
  UNION ALL SELECT '更慢的', 0, 3
) t
WHERE w.word_text = 'better'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- sad
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '悲伤的' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '高兴的', 0, 1
  UNION ALL SELECT '生气的', 0, 2
  UNION ALL SELECT '平静的', 0, 3
) t
WHERE w.word_text = 'sad'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- headache
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '头痛' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '胃痛', 0, 1
  UNION ALL SELECT '牙痛', 0, 2
  UNION ALL SELECT '发烧', 0, 3
) t
WHERE w.word_text = 'headache'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- January
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '一月' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '二月', 0, 1
  UNION ALL SELECT '三月', 0, 2
  UNION ALL SELECT '十二月', 0, 3
) t
WHERE w.word_text = 'January'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- lazy
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '懒惰的' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '勤奋的', 0, 1
  UNION ALL SELECT '聪明的', 0, 2
  UNION ALL SELECT '勇敢的', 0, 3
) t
WHERE w.word_text = 'lazy'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- pretty
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '漂亮的' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '丑陋的', 0, 1
  UNION ALL SELECT '便宜的', 0, 2
  UNION ALL SELECT '沉重的', 0, 3
) t
WHERE w.word_text = 'pretty'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- red
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '红色的' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '蓝色的', 0, 1
  UNION ALL SELECT '绿色的', 0, 2
  UNION ALL SELECT '黄色的', 0, 3
) t
WHERE w.word_text = 'red'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- cat
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '猫' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '狗', 0, 1
  UNION ALL SELECT '鸟', 0, 2
  UNION ALL SELECT '鱼', 0, 3
) t
WHERE w.word_text = 'cat'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- own
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '自己的' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '别人的', 0, 1
  UNION ALL SELECT '公共的', 0, 2
  UNION ALL SELECT '借来的', 0, 3
) t
WHERE w.word_text = 'own'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- farmer
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '农民' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '工人', 0, 1
  UNION ALL SELECT '医生', 0, 2
  UNION ALL SELECT '司机', 0, 3
) t
WHERE w.word_text = 'farmer'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- bite
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '咬' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '舔', 0, 1
  UNION ALL SELECT '闻', 0, 2
  UNION ALL SELECT '摸', 0, 3
) t
WHERE w.word_text = 'bite'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- around
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '在…周围' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '在…中间', 0, 1
  UNION ALL SELECT '在…对面', 0, 2
  UNION ALL SELECT '在…里面', 0, 3
) t
WHERE w.word_text = 'around'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- increase
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '增加' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '减少', 0, 1
  UNION ALL SELECT '保持', 0, 2
  UNION ALL SELECT '停止', 0, 3
) t
WHERE w.word_text = 'increase'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- empty
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '空的' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '满的', 0, 1
  UNION ALL SELECT '脏的', 0, 2
  UNION ALL SELECT '新的', 0, 3
) t
WHERE w.word_text = 'empty'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- tall
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '高的' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '矮的', 0, 1
  UNION ALL SELECT '胖的', 0, 2
  UNION ALL SELECT '瘦的', 0, 3
) t
WHERE w.word_text = 'tall'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- room
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '房间' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '厨房', 0, 1
  UNION ALL SELECT '花园', 0, 2
  UNION ALL SELECT '街道', 0, 3
) t
WHERE w.word_text = 'room'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- fair
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '公平的' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '不公平的', 0, 1
  UNION ALL SELECT '随便的', 0, 2
  UNION ALL SELECT '秘密的', 0, 3
) t
WHERE w.word_text = 'fair'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- pollute
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '污染' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '净化', 0, 1
  UNION ALL SELECT '保护', 0, 2
  UNION ALL SELECT '种植', 0, 3
) t
WHERE w.word_text = 'pollute'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- duck
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '鸭子' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '鸡', 0, 1
  UNION ALL SELECT '鹅', 0, 2
  UNION ALL SELECT '鸽子', 0, 3
) t
WHERE w.word_text = 'duck'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- underground
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '地铁' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '公交车', 0, 1
  UNION ALL SELECT '出租车', 0, 2
  UNION ALL SELECT '自行车', 0, 3
) t
WHERE w.word_text = 'underground'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- fountain
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '喷泉' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '河流', 0, 1
  UNION ALL SELECT '湖泊', 0, 2
  UNION ALL SELECT '水井', 0, 3
) t
WHERE w.word_text = 'fountain'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- fill
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '装满' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '倒空', 0, 1
  UNION ALL SELECT '打碎', 0, 2
  UNION ALL SELECT '关上', 0, 3
) t
WHERE w.word_text = 'fill'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- share
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '分享' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '独占', 0, 1
  UNION ALL SELECT '隐藏', 0, 2
  UNION ALL SELECT '扔掉', 0, 3
) t
WHERE w.word_text = 'share'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- shape
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '形状' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '颜色', 0, 1
  UNION ALL SELECT '味道', 0, 2
  UNION ALL SELECT '声音', 0, 3
) t
WHERE w.word_text = 'shape'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- water
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '水' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '牛奶', 0, 1
  UNION ALL SELECT '果汁', 0, 2
  UNION ALL SELECT '茶', 0, 3
) t
WHERE w.word_text = 'water'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- nationality
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '国籍' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '姓名', 0, 1
  UNION ALL SELECT '年龄', 0, 2
  UNION ALL SELECT '职业', 0, 3
) t
WHERE w.word_text = 'nationality'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- success
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '成功' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '失败', 0, 1
  UNION ALL SELECT '努力', 0, 2
  UNION ALL SELECT '机会', 0, 3
) t
WHERE w.word_text = 'success'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- perhaps
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '也许' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '一定', 0, 1
  UNION ALL SELECT '从不', 0, 2
  UNION ALL SELECT '已经', 0, 3
) t
WHERE w.word_text = 'perhaps'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- about
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '关于' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '反对', 0, 1
  UNION ALL SELECT '除了', 0, 2
  UNION ALL SELECT '代替', 0, 3
) t
WHERE w.word_text = 'about'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- know
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '知道' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '忘记', 0, 1
  UNION ALL SELECT '猜测', 0, 2
  UNION ALL SELECT '怀疑', 0, 3
) t
WHERE w.word_text = 'know'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- custom
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '习俗' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '法律', 0, 1
  UNION ALL SELECT '发明', 0, 2
  UNION ALL SELECT '天气', 0, 3
) t
WHERE w.word_text = 'custom'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- suppose
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '猜想' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '证明', 0, 1
  UNION ALL SELECT '决定', 0, 2
  UNION ALL SELECT '拒绝', 0, 3
) t
WHERE w.word_text = 'suppose'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- noise
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '噪声' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '音乐', 0, 1
  UNION ALL SELECT '光线', 0, 2
  UNION ALL SELECT '气味', 0, 3
) t
WHERE w.word_text = 'noise'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- rubbish
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '垃圾' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '礼物', 0, 1
  UNION ALL SELECT '食物', 0, 2
  UNION ALL SELECT '衣服', 0, 3
) t
WHERE w.word_text = 'rubbish'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- advantage
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '优点' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '缺点', 0, 1
  UNION ALL SELECT '问题', 0, 2
  UNION ALL SELECT '危险', 0, 3
) t
WHERE w.word_text = 'advantage'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- fit
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '适合' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '损坏', 0, 1
  UNION ALL SELECT '拒绝', 0, 2
  UNION ALL SELECT '丢失', 0, 3
) t
WHERE w.word_text = 'fit'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- as
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '作为' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '反对', 0, 1
  UNION ALL SELECT '没有', 0, 2
  UNION ALL SELECT '超过', 0, 3
) t
WHERE w.word_text = 'as'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- corner
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '角落' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '中心', 0, 1
  UNION ALL SELECT '门口', 0, 2
  UNION ALL SELECT '屋顶', 0, 3
) t
WHERE w.word_text = 'corner'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- part
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '部分' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '全部', 0, 1
  UNION ALL SELECT '开头', 0, 2
  UNION ALL SELECT '结尾', 0, 3
) t
WHERE w.word_text = 'part'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- ancient
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '古代的' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '现代的', 0, 1
  UNION ALL SELECT '未来的', 0, 2
  UNION ALL SELECT '临时的', 0, 3
) t
WHERE w.word_text = 'ancient'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- activity
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '活动' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '休息', 0, 1
  UNION ALL SELECT '睡眠', 0, 2
  UNION ALL SELECT '等待', 0, 3
) t
WHERE w.word_text = 'activity'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- Britain
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '英国' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '法国', 0, 1
  UNION ALL SELECT '德国', 0, 2
  UNION ALL SELECT '美国', 0, 3
) t
WHERE w.word_text = 'Britain'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- drink
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '喝' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '吃', 0, 1
  UNION ALL SELECT '睡', 0, 2
  UNION ALL SELECT '跑', 0, 3
) t
WHERE w.word_text = 'drink'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- tree
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '树' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '花', 0, 1
  UNION ALL SELECT '草', 0, 2
  UNION ALL SELECT '石头', 0, 3
) t
WHERE w.word_text = 'tree'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- enough
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '足够的' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '缺少的', 0, 1
  UNION ALL SELECT '空的', 0, 2
  UNION ALL SELECT '破碎的', 0, 3
) t
WHERE w.word_text = 'enough'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- cheap
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '便宜的' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '昂贵的', 0, 1
  UNION ALL SELECT '免费的', 0, 2
  UNION ALL SELECT '破旧的', 0, 3
) t
WHERE w.word_text = 'cheap'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- between
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '在两者之间' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '在外面', 0, 1
  UNION ALL SELECT '在上面', 0, 2
  UNION ALL SELECT '在后面', 0, 3
) t
WHERE w.word_text = 'between'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- decide
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '决定' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '犹豫', 0, 1
  UNION ALL SELECT '放弃', 0, 2
  UNION ALL SELECT '忘记', 0, 3
) t
WHERE w.word_text = 'decide'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- write
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '写' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '读', 0, 1
  UNION ALL SELECT '听', 0, 2
  UNION ALL SELECT '说', 0, 3
) t
WHERE w.word_text = 'write'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- can
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '能够' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '必须', 0, 1
  UNION ALL SELECT '禁止', 0, 2
  UNION ALL SELECT '应该', 0, 3
) t
WHERE w.word_text = 'can'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- tape
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '磁带' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '光盘', 0, 1
  UNION ALL SELECT '书本', 0, 2
  UNION ALL SELECT '报纸', 0, 3
) t
WHERE w.word_text = 'tape'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- captain
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '船长' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '司机', 0, 1
  UNION ALL SELECT '飞行员', 0, 2
  UNION ALL SELECT '士兵', 0, 3
) t
WHERE w.word_text = 'captain'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- middle
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '中间' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '开头', 0, 1
  UNION ALL SELECT '结尾', 0, 2
  UNION ALL SELECT '旁边', 0, 3
) t
WHERE w.word_text = 'middle'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- chair
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '椅子' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '桌子', 0, 1
  UNION ALL SELECT '沙发', 0, 2
  UNION ALL SELECT '床', 0, 3
) t
WHERE w.word_text = 'chair'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- meal
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '一餐' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '零食', 0, 1
  UNION ALL SELECT '饮料', 0, 2
  UNION ALL SELECT '药品', 0, 3
) t
WHERE w.word_text = 'meal'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- heavily
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '大量地' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '轻轻地', 0, 1
  UNION ALL SELECT '慢慢地', 0, 2
  UNION ALL SELECT '突然地', 0, 3
) t
WHERE w.word_text = 'heavily'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- beach
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '海滩' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '山脉', 0, 1
  UNION ALL SELECT '森林', 0, 2
  UNION ALL SELECT '沙漠', 0, 3
) t
WHERE w.word_text = 'beach'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- like
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '喜欢' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '讨厌', 0, 1
  UNION ALL SELECT '害怕', 0, 2
  UNION ALL SELECT '忘记', 0, 3
) t
WHERE w.word_text = 'like'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- argue
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '争吵' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '和解', 0, 1
  UNION ALL SELECT '称赞', 0, 2
  UNION ALL SELECT '邀请', 0, 3
) t
WHERE w.word_text = 'argue'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- certainly
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '当然' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '也许', 0, 1
  UNION ALL SELECT '从不', 0, 2
  UNION ALL SELECT '偶尔', 0, 3
) t
WHERE w.word_text = 'certainly'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- Saturday
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '星期六' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '星期日', 0, 1
  UNION ALL SELECT '星期一', 0, 2
  UNION ALL SELECT '星期五', 0, 3
) t
WHERE w.word_text = 'Saturday'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- food
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '食物' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '饮料', 0, 1
  UNION ALL SELECT '衣服', 0, 2
  UNION ALL SELECT '玩具', 0, 3
) t
WHERE w.word_text = 'food'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- left
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '左边的' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '右边的', 0, 1
  UNION ALL SELECT '前面的', 0, 2
  UNION ALL SELECT '后面的', 0, 3
) t
WHERE w.word_text = 'left'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- amusement
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '娱乐' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '工作', 0, 1
  UNION ALL SELECT '考试', 0, 2
  UNION ALL SELECT '劳动', 0, 3
) t
WHERE w.word_text = 'amusement'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- aim
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '目标' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '起点', 0, 1
  UNION ALL SELECT '借口', 0, 2
  UNION ALL SELECT '障碍', 0, 3
) t
WHERE w.word_text = 'aim'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- connect
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '连接' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '断开', 0, 1
  UNION ALL SELECT '丢掉', 0, 2
  UNION ALL SELECT '隐藏', 0, 3
) t
WHERE w.word_text = 'connect'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- May
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '五月' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '三月', 0, 1
  UNION ALL SELECT '四月', 0, 2
  UNION ALL SELECT '六月', 0, 3
) t
WHERE w.word_text = 'May'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- basketball
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '篮球' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '足球', 0, 1
  UNION ALL SELECT '排球', 0, 2
  UNION ALL SELECT '乒乓球', 0, 3
) t
WHERE w.word_text = 'basketball'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- smell
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '闻' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '看', 0, 1
  UNION ALL SELECT '听', 0, 2
  UNION ALL SELECT '尝', 0, 3
) t
WHERE w.word_text = 'smell'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- dream
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '梦想' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '现实', 0, 1
  UNION ALL SELECT '计划', 0, 2
  UNION ALL SELECT '记忆', 0, 3
) t
WHERE w.word_text = 'dream'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- hour
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '小时' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '分钟', 0, 1
  UNION ALL SELECT '秒钟', 0, 2
  UNION ALL SELECT '星期', 0, 3
) t
WHERE w.word_text = 'hour'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- litter
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '乱扔垃圾' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '打扫', 0, 1
  UNION ALL SELECT '种植', 0, 2
  UNION ALL SELECT '收集', 0, 3
) t
WHERE w.word_text = 'litter'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- fireman
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '消防队员' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '警察', 0, 1
  UNION ALL SELECT '医生', 0, 2
  UNION ALL SELECT '教师', 0, 3
) t
WHERE w.word_text = 'fireman'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- other
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '其他的' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '同样的', 0, 1
  UNION ALL SELECT '全部的', 0, 2
  UNION ALL SELECT '唯一的', 0, 3
) t
WHERE w.word_text = 'other'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- automatic
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '自动的' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '手动的', 0, 1
  UNION ALL SELECT '损坏的', 0, 2
  UNION ALL SELECT '缓慢的', 0, 3
) t
WHERE w.word_text = 'automatic'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- pot
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '锅' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '盘子', 0, 1
  UNION ALL SELECT '碗', 0, 2
  UNION ALL SELECT '杯子', 0, 3
) t
WHERE w.word_text = 'pot'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- outdoor
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '室外的' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '室内的', 0, 1
  UNION ALL SELECT '地下的', 0, 2
  UNION ALL SELECT '水下的', 0, 3
) t
WHERE w.word_text = 'outdoor'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- gentle
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '温柔的' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '粗鲁的', 0, 1
  UNION ALL SELECT '大声的', 0, 2
  UNION ALL SELECT '匆忙的', 0, 3
) t
WHERE w.word_text = 'gentle'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- above
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '在…上面' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '在…下面', 0, 1
  UNION ALL SELECT '在…里面', 0, 2
  UNION ALL SELECT '在…旁边', 0, 3
) t
WHERE w.word_text = 'above'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- exam
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '考试' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '作业', 0, 1
  UNION ALL SELECT '游戏', 0, 2
  UNION ALL SELECT '会议', 0, 3
) t
WHERE w.word_text = 'exam'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- course
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '课程' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '假期', 0, 1
  UNION ALL SELECT '比赛', 0, 2
  UNION ALL SELECT '晚会', 0, 3
) t
WHERE w.word_text = 'course'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- manner
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '态度' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '外貌', 0, 1
  UNION ALL SELECT '声音', 0, 2
  UNION ALL SELECT '速度', 0, 3
) t
WHERE w.word_text = 'manner'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- eat
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '吃' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '喝', 0, 1
  UNION ALL SELECT '睡', 0, 2
  UNION ALL SELECT '走', 0, 3
) t
WHERE w.word_text = 'eat'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- news
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '新闻' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '小说', 0, 1
  UNION ALL SELECT '广告', 0, 2
  UNION ALL SELECT '日记', 0, 3
) t
WHERE w.word_text = 'news'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- customer
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '顾客' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '店员', 0, 1
  UNION ALL SELECT '老板', 0, 2
  UNION ALL SELECT '司机', 0, 3
) t
WHERE w.word_text = 'customer'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- tea
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '茶' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '咖啡', 0, 1
  UNION ALL SELECT '牛奶', 0, 2
  UNION ALL SELECT '果汁', 0, 3
) t
WHERE w.word_text = 'tea'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- close
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '关闭' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '打开', 0, 1
  UNION ALL SELECT '举起', 0, 2
  UNION ALL SELECT '推开', 0, 3
) t
WHERE w.word_text = 'close'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- pearl
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '珍珠' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '钻石', 0, 1
  UNION ALL SELECT '黄金', 0, 2
  UNION ALL SELECT '石头', 0, 3
) t
WHERE w.word_text = 'pearl'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- windy
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '有风的' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '晴朗的', 0, 1
  UNION ALL SELECT '下雪的', 0, 2
  UNION ALL SELECT '有雾的', 0, 3
) t
WHERE w.word_text = 'windy'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- roast
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '烤' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '煮', 0, 1
  UNION ALL SELECT '炸', 0, 2
  UNION ALL SELECT '蒸', 0, 3
) t
WHERE w.word_text = 'roast'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- act
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '表演' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '观看', 0, 1
  UNION ALL SELECT '写作', 0, 2
  UNION ALL SELECT '绘画', 0, 3
) t
WHERE w.word_text = 'act'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- magazine
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '杂志' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '报纸', 0, 1
  UNION ALL SELECT '字典', 0, 2
  UNION ALL SELECT '小说', 0, 3
) t
WHERE w.word_text = 'magazine'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- general
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '大体的' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '详细的', 0, 1
  UNION ALL SELECT '特殊的', 0, 2
  UNION ALL SELECT '错误的', 0, 3
) t
WHERE w.word_text = 'general'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- situation
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '情况' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '地点', 0, 1
  UNION ALL SELECT '人物', 0, 2
  UNION ALL SELECT '时间', 0, 3
) t
WHERE w.word_text = 'situation'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- create
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '创造' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '破坏', 0, 1
  UNION ALL SELECT '复制', 0, 2
  UNION ALL SELECT '隐藏', 0, 3
) t
WHERE w.word_text = 'create'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- weak
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '弱的' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '强壮的', 0, 1
  UNION ALL SELECT '聪明的', 0, 2
  UNION ALL SELECT '忙碌的', 0, 3
) t
WHERE w.word_text = 'weak'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- sentence
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '句子' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '单词', 0, 1
  UNION ALL SELECT '段落', 0, 2
  UNION ALL SELECT '文章', 0, 3
) t
WHERE w.word_text = 'sentence'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- laugh
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '笑' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '哭', 0, 1
  UNION ALL SELECT '喊', 0, 2
  UNION ALL SELECT '睡', 0, 3
) t
WHERE w.word_text = 'laugh'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- shirt
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '衬衫' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '裤子', 0, 1
  UNION ALL SELECT '裙子', 0, 2
  UNION ALL SELECT '外套', 0, 3
) t
WHERE w.word_text = 'shirt'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- golden
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '金色的' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '银色的', 0, 1
  UNION ALL SELECT '黑色的', 0, 2
  UNION ALL SELECT '白色的', 0, 3
) t
WHERE w.word_text = 'golden'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- jeans
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '牛仔裤' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '西装', 0, 1
  UNION ALL SELECT '裙子', 0, 2
  UNION ALL SELECT '短裤', 0, 3
) t
WHERE w.word_text = 'jeans'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- recent
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '最近的' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '古代的', 0, 1
  UNION ALL SELECT '未来的', 0, 2
  UNION ALL SELECT '永久的', 0, 3
) t
WHERE w.word_text = 'recent'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- lunch
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '午餐' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '早餐', 0, 1
  UNION ALL SELECT '晚餐', 0, 2
  UNION ALL SELECT '夜宵', 0, 3
) t
WHERE w.word_text = 'lunch'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- luggage
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '行李' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '家具', 0, 1
  UNION ALL SELECT '衣服', 0, 2
  UNION ALL SELECT '食物', 0, 3
) t
WHERE w.word_text = 'luggage'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- block
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '街区' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '城市', 0, 1
  UNION ALL SELECT '国家', 0, 2
  UNION ALL SELECT '村庄', 0, 3
) t
WHERE w.word_text = 'block'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- pineapple
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '菠萝' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '西瓜', 0, 1
  UNION ALL SELECT '香蕉', 0, 2
  UNION ALL SELECT '苹果', 0, 3
) t
WHERE w.word_text = 'pineapple'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- market
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '市场' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '学校', 0, 1
  UNION ALL SELECT '医院', 0, 2
  UNION ALL SELECT '银行', 0, 3
) t
WHERE w.word_text = 'market'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- France
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '法国' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '英国', 0, 1
  UNION ALL SELECT '德国', 0, 2
  UNION ALL SELECT '日本', 0, 3
) t
WHERE w.word_text = 'France'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- clothes
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '衣服' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '鞋子', 0, 1
  UNION ALL SELECT '帽子', 0, 2
  UNION ALL SELECT '书包', 0, 3
) t
WHERE w.word_text = 'clothes'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- juice
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '果汁' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '牛奶', 0, 1
  UNION ALL SELECT '茶', 0, 2
  UNION ALL SELECT '水', 0, 3
) t
WHERE w.word_text = 'juice'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- survey
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '调查' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '猜测', 0, 1
  UNION ALL SELECT '想象', 0, 2
  UNION ALL SELECT '通知', 0, 3
) t
WHERE w.word_text = 'survey'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- precious
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '珍贵的' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '普通的', 0, 1
  UNION ALL SELECT '便宜的', 0, 2
  UNION ALL SELECT '无用的', 0, 3
) t
WHERE w.word_text = 'precious'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- partner
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '搭档' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '对手', 0, 1
  UNION ALL SELECT '观众', 0, 2
  UNION ALL SELECT '裁判', 0, 3
) t
WHERE w.word_text = 'partner'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- boil
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '煮沸' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '冷冻', 0, 1
  UNION ALL SELECT '烘干', 0, 2
  UNION ALL SELECT '切开', 0, 3
) t
WHERE w.word_text = 'boil'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- railway
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '铁路' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '公路', 0, 1
  UNION ALL SELECT '航线', 0, 2
  UNION ALL SELECT '桥梁', 0, 3
) t
WHERE w.word_text = 'railway'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- reduce
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '减少' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '增加', 0, 1
  UNION ALL SELECT '保持', 0, 2
  UNION ALL SELECT '加倍', 0, 3
) t
WHERE w.word_text = 'reduce'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- few
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '很少的' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '很多的', 0, 1
  UNION ALL SELECT '全部的', 0, 2
  UNION ALL SELECT '足够的', 0, 3
) t
WHERE w.word_text = 'few'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- angrily
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '生气地' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '高兴地', 0, 1
  UNION ALL SELECT '平静地', 0, 2
  UNION ALL SELECT '礼貌地', 0, 3
) t
WHERE w.word_text = 'angrily'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- exercise
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '锻炼' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '休息', 0, 1
  UNION ALL SELECT '睡眠', 0, 2
  UNION ALL SELECT '吃饭', 0, 3
) t
WHERE w.word_text = 'exercise'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- sandwich
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '三明治' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '汉堡', 0, 1
  UNION ALL SELECT '披萨', 0, 2
  UNION ALL SELECT '面条', 0, 3
) t
WHERE w.word_text = 'sandwich'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- inside
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '在里面' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '在外面', 0, 1
  UNION ALL SELECT '在上面', 0, 2
  UNION ALL SELECT '在旁边', 0, 3
) t
WHERE w.word_text = 'inside'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- dollar
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '美元' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '人民币', 0, 1
  UNION ALL SELECT '日元', 0, 2
  UNION ALL SELECT '英镑', 0, 3
) t
WHERE w.word_text = 'dollar'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- Monday
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '星期一' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '星期二', 0, 1
  UNION ALL SELECT '星期三', 0, 2
  UNION ALL SELECT '星期日', 0, 3
) t
WHERE w.word_text = 'Monday'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- similar
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '相似的' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '不同的', 0, 1
  UNION ALL SELECT '相反的', 0, 2
  UNION ALL SELECT '独特的', 0, 3
) t
WHERE w.word_text = 'similar'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- autumn
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '秋天' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '春天', 0, 1
  UNION ALL SELECT '夏天', 0, 2
  UNION ALL SELECT '冬天', 0, 3
) t
WHERE w.word_text = 'autumn'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- holiday
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '假期' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '工作日', 0, 1
  UNION ALL SELECT '上课', 0, 2
  UNION ALL SELECT '加班', 0, 3
) t
WHERE w.word_text = 'holiday'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- require
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '需要' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '拒绝', 0, 1
  UNION ALL SELECT '放弃', 0, 2
  UNION ALL SELECT '赠送', 0, 3
) t
WHERE w.word_text = 'require'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- forward
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '向前' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '向后', 0, 1
  UNION ALL SELECT '向左', 0, 2
  UNION ALL SELECT '向下', 0, 3
) t
WHERE w.word_text = 'forward'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- bright
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '明亮的' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '昏暗的', 0, 1
  UNION ALL SELECT '潮湿的', 0, 2
  UNION ALL SELECT '狭窄的', 0, 3
) t
WHERE w.word_text = 'bright'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- careful
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '小心的' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '粗心的', 0, 1
  UNION ALL SELECT '匆忙的', 0, 2
  UNION ALL SELECT '懒惰的', 0, 3
) t
WHERE w.word_text = 'careful'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- visitor
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '参观者' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '主人', 0, 1
  UNION ALL SELECT '工人', 0, 2
  UNION ALL SELECT '士兵', 0, 3
) t
WHERE w.word_text = 'visitor'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- must
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '必须' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '可以', 0, 1
  UNION ALL SELECT '也许', 0, 2
  UNION ALL SELECT '不必', 0, 3
) t
WHERE w.word_text = 'must'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- twin
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '双胞胎' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '同学', 0, 1
  UNION ALL SELECT '邻居', 0, 2
  UNION ALL SELECT '朋友', 0, 3
) t
WHERE w.word_text = 'twin'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- point
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '指向' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '躲开', 0, 1
  UNION ALL SELECT '抓住', 0, 2
  UNION ALL SELECT '扔掉', 0, 3
) t
WHERE w.word_text = 'point'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- basket
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '篮子' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '箱子', 0, 1
  UNION ALL SELECT '袋子', 0, 2
  UNION ALL SELECT '瓶子', 0, 3
) t
WHERE w.word_text = 'basket'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- conclusion
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '结论' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '开头', 0, 1
  UNION ALL SELECT '问题', 0, 2
  UNION ALL SELECT '例子', 0, 3
) t
WHERE w.word_text = 'conclusion'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- stomachache
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '胃痛' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '头痛', 0, 1
  UNION ALL SELECT '牙痛', 0, 2
  UNION ALL SELECT '发烧', 0, 3
) t
WHERE w.word_text = 'stomachache'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- hurry
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '赶快' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '等待', 0, 1
  UNION ALL SELECT '休息', 0, 2
  UNION ALL SELECT '放弃', 0, 3
) t
WHERE w.word_text = 'hurry'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- Wednesday
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '星期三' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '星期一', 0, 1
  UNION ALL SELECT '星期五', 0, 2
  UNION ALL SELECT '星期日', 0, 3
) t
WHERE w.word_text = 'Wednesday'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- conversation
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '谈话' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '演讲', 0, 1
  UNION ALL SELECT '写信', 0, 2
  UNION ALL SELECT '唱歌', 0, 3
) t
WHERE w.word_text = 'conversation'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- leave
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '离开' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '到达', 0, 1
  UNION ALL SELECT '进入', 0, 2
  UNION ALL SELECT '停留', 0, 3
) t
WHERE w.word_text = 'leave'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- wide
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '宽的' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '窄的', 0, 1
  UNION ALL SELECT '高的', 0, 2
  UNION ALL SELECT '深的', 0, 3
) t
WHERE w.word_text = 'wide'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- interested
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '感兴趣的' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '无聊的', 0, 1
  UNION ALL SELECT '忙碌的', 0, 2
  UNION ALL SELECT '疲倦的', 0, 3
) t
WHERE w.word_text = 'interested'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- teacher
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '教师' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '学生', 0, 1
  UNION ALL SELECT '医生', 0, 2
  UNION ALL SELECT '警察', 0, 3
) t
WHERE w.word_text = 'teacher'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- happily
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '高兴地' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '伤心地', 0, 1
  UNION ALL SELECT '生气地', 0, 2
  UNION ALL SELECT '害怕地', 0, 3
) t
WHERE w.word_text = 'happily'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- envelope
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '信封' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '信纸', 0, 1
  UNION ALL SELECT '邮票', 0, 2
  UNION ALL SELECT '明信片', 0, 3
) t
WHERE w.word_text = 'envelope'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- light
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '光' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '声音', 0, 1
  UNION ALL SELECT '热量', 0, 2
  UNION ALL SELECT '影子', 0, 3
) t
WHERE w.word_text = 'light'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- September
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '九月' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '八月', 0, 1
  UNION ALL SELECT '十月', 0, 2
  UNION ALL SELECT '十一月', 0, 3
) t
WHERE w.word_text = 'September'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- settle
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '定居' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '离开', 0, 1
  UNION ALL SELECT '旅行', 0, 2
  UNION ALL SELECT '参观', 0, 3
) t
WHERE w.word_text = 'settle'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- disappointed
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '失望的' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '满意的', 0, 1
  UNION ALL SELECT '兴奋的', 0, 2
  UNION ALL SELECT '平静的', 0, 3
) t
WHERE w.word_text = 'disappointed'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- habit
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '习惯' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '意外', 0, 1
  UNION ALL SELECT '命令', 0, 2
  UNION ALL SELECT '计划', 0, 3
) t
WHERE w.word_text = 'habit'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- pound
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '英镑' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '美元', 0, 1
  UNION ALL SELECT '欧元', 0, 2
  UNION ALL SELECT '人民币', 0, 3
) t
WHERE w.word_text = 'pound'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- bear
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '熊' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '老虎', 0, 1
  UNION ALL SELECT '狮子', 0, 2
  UNION ALL SELECT '狼', 0, 3
) t
WHERE w.word_text = 'bear'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- skate
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '溜冰' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '跑步', 0, 1
  UNION ALL SELECT '游泳', 0, 2
  UNION ALL SELECT '骑车', 0, 3
) t
WHERE w.word_text = 'skate'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- dress
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '连衣裙' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '衬衫', 0, 1
  UNION ALL SELECT '裤子', 0, 2
  UNION ALL SELECT '外套', 0, 3
) t
WHERE w.word_text = 'dress'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- safe
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '安全的' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '危险的', 0, 1
  UNION ALL SELECT '忙碌的', 0, 2
  UNION ALL SELECT '吵闹的', 0, 3
) t
WHERE w.word_text = 'safe'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- leg
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '腿' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '手臂', 0, 1
  UNION ALL SELECT '头', 0, 2
  UNION ALL SELECT '脖子', 0, 3
) t
WHERE w.word_text = 'leg'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- wrong
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '错误的' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '正确的', 0, 1
  UNION ALL SELECT '完整的', 0, 2
  UNION ALL SELECT '清楚的', 0, 3
) t
WHERE w.word_text = 'wrong'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- length
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '长度' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '宽度', 0, 1
  UNION ALL SELECT '高度', 0, 2
  UNION ALL SELECT '重量', 0, 3
) t
WHERE w.word_text = 'length'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- but
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '但是' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '而且', 0, 1
  UNION ALL SELECT '因为', 0, 2
  UNION ALL SELECT '所以', 0, 3
) t
WHERE w.word_text = 'but'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- deliver
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '投递' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '收取', 0, 1
  UNION ALL SELECT '打开', 0, 2
  UNION ALL SELECT '扔掉', 0, 3
) t
WHERE w.word_text = 'deliver'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- angry
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '生气的' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '高兴的', 0, 1
  UNION ALL SELECT '平静的', 0, 2
  UNION ALL SELECT '害怕的', 0, 3
) t
WHERE w.word_text = 'angry'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- service
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '服务' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '商品', 0, 1
  UNION ALL SELECT '价格', 0, 2
  UNION ALL SELECT '广告', 0, 3
) t
WHERE w.word_text = 'service'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- spread
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '展开' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '折叠', 0, 1
  UNION ALL SELECT '收起', 0, 2
  UNION ALL SELECT '卷起', 0, 3
) t
WHERE w.word_text = 'spread'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- loudly
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '大声地' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '小声地', 0, 1
  UNION ALL SELECT '安静地', 0, 2
  UNION ALL SELECT '慢慢地', 0, 3
) t
WHERE w.word_text = 'loudly'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- toy
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '玩具' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '工具', 0, 1
  UNION ALL SELECT '文具', 0, 2
  UNION ALL SELECT '家具', 0, 3
) t
WHERE w.word_text = 'toy'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- sightseeing
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '观光' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '工作', 0, 1
  UNION ALL SELECT '学习', 0, 2
  UNION ALL SELECT '睡觉', 0, 3
) t
WHERE w.word_text = 'sightseeing'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- cigarette
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '香烟' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '糖果', 0, 1
  UNION ALL SELECT '药品', 0, 2
  UNION ALL SELECT '茶叶', 0, 3
) t
WHERE w.word_text = 'cigarette'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- gently
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '轻轻地' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '用力地', 0, 1
  UNION ALL SELECT '快速地', 0, 2
  UNION ALL SELECT '突然地', 0, 3
) t
WHERE w.word_text = 'gently'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- since
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '自从' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '直到', 0, 1
  UNION ALL SELECT '在…之前', 0, 2
  UNION ALL SELECT '除了', 0, 3
) t
WHERE w.word_text = 'since'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- pool
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '水池' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '河流', 0, 1
  UNION ALL SELECT '大海', 0, 2
  UNION ALL SELECT '水井', 0, 3
) t
WHERE w.word_text = 'pool'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- strong
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '强壮的' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '虚弱的', 0, 1
  UNION ALL SELECT '瘦小的', 0, 2
  UNION ALL SELECT '疲倦的', 0, 3
) t
WHERE w.word_text = 'strong'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- count
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '数' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '写', 0, 1
  UNION ALL SELECT '画', 0, 2
  UNION ALL SELECT '读', 0, 3
) t
WHERE w.word_text = 'count'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- dry
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '干燥的' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '潮湿的', 0, 1
  UNION ALL SELECT '热的', 0, 2
  UNION ALL SELECT '冷的', 0, 3
) t
WHERE w.word_text = 'dry'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- comfortable
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '舒服的' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '难受的', 0, 1
  UNION ALL SELECT '危险的', 0, 2
  UNION ALL SELECT '嘈杂的', 0, 3
) t
WHERE w.word_text = 'comfortable'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- while
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '当…时' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '在…之后', 0, 1
  UNION ALL SELECT '在…之前', 0, 2
  UNION ALL SELECT '除了', 0, 3
) t
WHERE w.word_text = 'while'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- have
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '有' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '没有', 0, 1
  UNION ALL SELECT '需要', 0, 2
  UNION ALL SELECT '寻找', 0, 3
) t
WHERE w.word_text = 'have'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- produce
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '生产' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '购买', 0, 1
  UNION ALL SELECT '销售', 0, 2
  UNION ALL SELECT '销毁', 0, 3
) t
WHERE w.word_text = 'produce'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- baby
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '婴儿' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '少年', 0, 1
  UNION ALL SELECT '成人', 0, 2
  UNION ALL SELECT '老人', 0, 3
) t
WHERE w.word_text = 'baby'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- allow
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '允许' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '禁止', 0, 1
  UNION ALL SELECT '强迫', 0, 2
  UNION ALL SELECT '忽略', 0, 3
) t
WHERE w.word_text = 'allow'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- freezing
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '极冷的' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '炎热的', 0, 1
  UNION ALL SELECT '温暖的', 0, 2
  UNION ALL SELECT '凉爽的', 0, 3
) t
WHERE w.word_text = 'freezing'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- choice
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '选择' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '命令', 0, 1
  UNION ALL SELECT '机会', 0, 2
  UNION ALL SELECT '借口', 0, 3
) t
WHERE w.word_text = 'choice'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- little
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '少的' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '多的', 0, 1
  UNION ALL SELECT '全部的', 0, 2
  UNION ALL SELECT '足够的', 0, 3
) t
WHERE w.word_text = 'little'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- heat
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '热量' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '冷气', 0, 1
  UNION ALL SELECT '风力', 0, 2
  UNION ALL SELECT '雨水', 0, 3
) t
WHERE w.word_text = 'heat'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- friendship
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '友谊' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '仇恨', 0, 1
  UNION ALL SELECT '竞争', 0, 2
  UNION ALL SELECT '争吵', 0, 3
) t
WHERE w.word_text = 'friendship'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- discover
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '发现' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '丢失', 0, 1
  UNION ALL SELECT '隐藏', 0, 2
  UNION ALL SELECT '忘记', 0, 3
) t
WHERE w.word_text = 'discover'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- pencil
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '铅笔' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '钢笔', 0, 1
  UNION ALL SELECT '尺子', 0, 2
  UNION ALL SELECT '橡皮', 0, 3
) t
WHERE w.word_text = 'pencil'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- strange
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '奇怪的' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '平常的', 0, 1
  UNION ALL SELECT '熟悉的', 0, 2
  UNION ALL SELECT '简单的', 0, 3
) t
WHERE w.word_text = 'strange'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- lesson
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '课' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '作业', 0, 1
  UNION ALL SELECT '考试', 0, 2
  UNION ALL SELECT '假期', 0, 3
) t
WHERE w.word_text = 'lesson'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- end
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '结束' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '开始', 0, 1
  UNION ALL SELECT '继续', 0, 2
  UNION ALL SELECT '暂停', 0, 3
) t
WHERE w.word_text = 'end'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- various
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '各种各样的' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '单一的', 0, 1
  UNION ALL SELECT '相同的', 0, 2
  UNION ALL SELECT '空的', 0, 3
) t
WHERE w.word_text = 'various'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- quick
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '快的' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '慢的', 0, 1
  UNION ALL SELECT '懒的', 0, 2
  UNION ALL SELECT '安静的', 0, 3
) t
WHERE w.word_text = 'quick'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- film
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '电影' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '歌曲', 0, 1
  UNION ALL SELECT '戏剧', 0, 2
  UNION ALL SELECT '广播', 0, 3
) t
WHERE w.word_text = 'film'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- owner
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '物主' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '客人', 0, 1
  UNION ALL SELECT '邻居', 0, 2
  UNION ALL SELECT '顾客', 0, 3
) t
WHERE w.word_text = 'owner'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- debate
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '辩论' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '闲聊', 0, 1
  UNION ALL SELECT '唱歌', 0, 2
  UNION ALL SELECT '沉默', 0, 3
) t
WHERE w.word_text = 'debate'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- brave
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '勇敢的' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '胆小的', 0, 1
  UNION ALL SELECT '懒惰的', 0, 2
  UNION ALL SELECT '粗心的', 0, 3
) t
WHERE w.word_text = 'brave'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- terrible
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '糟糕的' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '精彩的', 0, 1
  UNION ALL SELECT '普通的', 0, 2
  UNION ALL SELECT '有趣的', 0, 3
) t
WHERE w.word_text = 'terrible'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- technology
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '技术' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '艺术', 0, 1
  UNION ALL SELECT '历史', 0, 2
  UNION ALL SELECT '体育', 0, 3
) t
WHERE w.word_text = 'technology'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- once
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '一次' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '两次', 0, 1
  UNION ALL SELECT '多次', 0, 2
  UNION ALL SELECT '从不', 0, 3
) t
WHERE w.word_text = 'once'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- education
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '教育' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '娱乐', 0, 1
  UNION ALL SELECT '商业', 0, 2
  UNION ALL SELECT '旅行', 0, 3
) t
WHERE w.word_text = 'education'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- garden
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '花园' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '森林', 0, 1
  UNION ALL SELECT '农场', 0, 2
  UNION ALL SELECT '操场', 0, 3
) t
WHERE w.word_text = 'garden'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- detail
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '细节' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '大纲', 0, 1
  UNION ALL SELECT '标题', 0, 2
  UNION ALL SELECT '封面', 0, 3
) t
WHERE w.word_text = 'detail'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- tour
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '旅行' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '搬家', 0, 1
  UNION ALL SELECT '上班', 0, 2
  UNION ALL SELECT '上课', 0, 3
) t
WHERE w.word_text = 'tour'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- borrow
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '借入' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '借出', 0, 1
  UNION ALL SELECT '购买', 0, 2
  UNION ALL SELECT '归还', 0, 3
) t
WHERE w.word_text = 'borrow'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- club
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '俱乐部' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '班级', 0, 1
  UNION ALL SELECT '家庭', 0, 2
  UNION ALL SELECT '商店', 0, 3
) t
WHERE w.word_text = 'club'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- educational
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '教育的' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '娱乐的', 0, 1
  UNION ALL SELECT '商业的', 0, 2
  UNION ALL SELECT '军事的', 0, 3
) t
WHERE w.word_text = 'educational'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- sweet
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '甜的' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '苦的', 0, 1
  UNION ALL SELECT '酸的', 0, 2
  UNION ALL SELECT '咸的', 0, 3
) t
WHERE w.word_text = 'sweet'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- each
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '每个' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '全部', 0, 1
  UNION ALL SELECT '没有', 0, 2
  UNION ALL SELECT '少数', 0, 3
) t
WHERE w.word_text = 'each'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- cycle
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '骑自行车' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '开车', 0, 1
  UNION ALL SELECT '步行', 0, 2
  UNION ALL SELECT '跑步', 0, 3
) t
WHERE w.word_text = 'cycle'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- rain
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '下雨' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '下雪', 0, 1
  UNION ALL SELECT '刮风', 0, 2
  UNION ALL SELECT '出太阳', 0, 3
) t
WHERE w.word_text = 'rain'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- ever
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '曾经' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '从不', 0, 1
  UNION ALL SELECT '刚刚', 0, 2
  UNION ALL SELECT '马上', 0, 3
) t
WHERE w.word_text = 'ever'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- shout
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '喊' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '低语', 0, 1
  UNION ALL SELECT '微笑', 0, 2
  UNION ALL SELECT '点头', 0, 3
) t
WHERE w.word_text = 'shout'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- umbrella
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '雨伞' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '帽子', 0, 1
  UNION ALL SELECT '雨衣', 0, 2
  UNION ALL SELECT '手套', 0, 3
) t
WHERE w.word_text = 'umbrella'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- impossible
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '不可能的' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '可能的', 0, 1
  UNION ALL SELECT '容易的', 0, 2
  UNION ALL SELECT '必要的', 0, 3
) t
WHERE w.word_text = 'impossible'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- dishonest
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '不诚实的' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '诚实的', 0, 1
  UNION ALL SELECT '勇敢的', 0, 2
  UNION ALL SELECT '礼貌的', 0, 3
) t
WHERE w.word_text = 'dishonest'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- very
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '非常' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '稍微', 0, 1
  UNION ALL SELECT '从不', 0, 2
  UNION ALL SELECT '刚刚', 0, 3
) t
WHERE w.word_text = 'very'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- add
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '增加' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '减少', 0, 1
  UNION ALL SELECT '删除', 0, 2
  UNION ALL SELECT '保持', 0, 3
) t
WHERE w.word_text = 'add'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- tooth
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '牙齿' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '舌头', 0, 1
  UNION ALL SELECT '嘴唇', 0, 2
  UNION ALL SELECT '鼻子', 0, 3
) t
WHERE w.word_text = 'tooth'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- rice
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '米饭' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '面条', 0, 1
  UNION ALL SELECT '面包', 0, 2
  UNION ALL SELECT '饺子', 0, 3
) t
WHERE w.word_text = 'rice'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- illness
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '疾病' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '健康', 0, 1
  UNION ALL SELECT '疲劳', 0, 2
  UNION ALL SELECT '饥饿', 0, 3
) t
WHERE w.word_text = 'illness'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- beg
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '乞求' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '命令', 0, 1
  UNION ALL SELECT '拒绝', 0, 2
  UNION ALL SELECT '赠送', 0, 3
) t
WHERE w.word_text = 'beg'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- wear
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '穿戴' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '脱掉', 0, 1
  UNION ALL SELECT '清洗', 0, 2
  UNION ALL SELECT '购买', 0, 3
) t
WHERE w.word_text = 'wear'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- joy
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '欢乐' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '悲伤', 0, 1
  UNION ALL SELECT '愤怒', 0, 2
  UNION ALL SELECT '恐惧', 0, 3
) t
WHERE w.word_text = 'joy'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- card
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '卡片' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '信件', 0, 1
  UNION ALL SELECT '报纸', 0, 2
  UNION ALL SELECT '海报', 0, 3
) t
WHERE w.word_text = 'card'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- always
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '总是' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '从不', 0, 1
  UNION ALL SELECT '偶尔', 0, 2
  UNION ALL SELECT '很少', 0, 3
) t
WHERE w.word_text = 'always'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- deep
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '深的' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '浅的', 0, 1
  UNION ALL SELECT '高的', 0, 2
  UNION ALL SELECT '宽的', 0, 3
) t
WHERE w.word_text = 'deep'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- pioneer
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '开拓者' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '跟随者', 0, 1
  UNION ALL SELECT '观众', 0, 2
  UNION ALL SELECT '顾客', 0, 3
) t
WHERE w.word_text = 'pioneer'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- accept
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '接受' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '拒绝', 0, 1
  UNION ALL SELECT '归还', 0, 2
  UNION ALL SELECT '丢失', 0, 3
) t
WHERE w.word_text = 'accept'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- way
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '道路' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '墙壁', 0, 1
  UNION ALL SELECT '桥梁', 0, 2
  UNION ALL SELECT '屋顶', 0, 3
) t
WHERE w.word_text = 'way'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- discussion
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '讨论' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '沉默', 0, 1
  UNION ALL SELECT '命令', 0, 2
  UNION ALL SELECT '通知', 0, 3
) t
WHERE w.word_text = 'discussion'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- respect
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '尊重' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '嘲笑', 0, 1
  UNION ALL SELECT '忽视', 0, 2
  UNION ALL SELECT '欺负', 0, 3
) t
WHERE w.word_text = 'respect'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- everywhere
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '到处' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '无处', 0, 1
  UNION ALL SELECT '这里', 0, 2
  UNION ALL SELECT '家里', 0, 3
) t
WHERE w.word_text = 'everywhere'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- within
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '在…之内' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '在…之外', 0, 1
  UNION ALL SELECT '超过', 0, 2
  UNION ALL SELECT '远离', 0, 3
) t
WHERE w.word_text = 'within'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- animal
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '动物' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '植物', 0, 1
  UNION ALL SELECT '矿物', 0, 2
  UNION ALL SELECT '机器', 0, 3
) t
WHERE w.word_text = 'animal'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- nurse
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '护士' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '医生', 0, 1
  UNION ALL SELECT '病人', 0, 2
  UNION ALL SELECT '教师', 0, 3
) t
WHERE w.word_text = 'nurse'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- title
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '标题' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '作者', 0, 1
  UNION ALL SELECT '页码', 0, 2
  UNION ALL SELECT '目录', 0, 3
) t
WHERE w.word_text = 'title'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- per
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '每一' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '全部', 0, 1
  UNION ALL SELECT '总共', 0, 2
  UNION ALL SELECT '大约', 0, 3
) t
WHERE w.word_text = 'per'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- disturb
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '打扰' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '帮助', 0, 1
  UNION ALL SELECT '邀请', 0, 2
  UNION ALL SELECT '保护', 0, 3
) t
WHERE w.word_text = 'disturb'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- beautifully
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '优美地' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '糟糕地', 0, 1
  UNION ALL SELECT '大声地', 0, 2
  UNION ALL SELECT '匆忙地', 0, 3
) t
WHERE w.word_text = 'beautifully'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- equal
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '平等的' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '不平等的', 0, 1
  UNION ALL SELECT '特殊的', 0, 2
  UNION ALL SELECT '额外的', 0, 3
) t
WHERE w.word_text = 'equal'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- immediately
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '立即' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '稍后', 0, 1
  UNION ALL SELECT '从不', 0, 2
  UNION ALL SELECT '慢慢地', 0, 3
) t
WHERE w.word_text = 'immediately'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- salad
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '色拉' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '汤', 0, 1
  UNION ALL SELECT '米饭', 0, 2
  UNION ALL SELECT '面条', 0, 3
) t
WHERE w.word_text = 'salad'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- ahead
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '向前' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '向后', 0, 1
  UNION ALL SELECT '向左', 0, 2
  UNION ALL SELECT '向下', 0, 3
) t
WHERE w.word_text = 'ahead'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- goal
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '目标' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '起点', 0, 1
  UNION ALL SELECT '障碍', 0, 2
  UNION ALL SELECT '借口', 0, 3
) t
WHERE w.word_text = 'goal'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- hard
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '困难的' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '容易的', 0, 1
  UNION ALL SELECT '有趣的', 0, 2
  UNION ALL SELECT '简单的', 0, 3
) t
WHERE w.word_text = 'hard'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- price
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '价格' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '重量', 0, 1
  UNION ALL SELECT '尺寸', 0, 2
  UNION ALL SELECT '颜色', 0, 3
) t
WHERE w.word_text = 'price'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- keep
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '保持' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '丢掉', 0, 1
  UNION ALL SELECT '改变', 0, 2
  UNION ALL SELECT '忘记', 0, 3
) t
WHERE w.word_text = 'keep'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- nervous
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '紧张的' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '放松的', 0, 1
  UNION ALL SELECT '勇敢的', 0, 2
  UNION ALL SELECT '平静的', 0, 3
) t
WHERE w.word_text = 'nervous'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- properly
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '适当地' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '错误地', 0, 1
  UNION ALL SELECT '随便地', 0, 2
  UNION ALL SELECT '匆忙地', 0, 3
) t
WHERE w.word_text = 'properly'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- kid
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '小孩' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '大人', 0, 1
  UNION ALL SELECT '老人', 0, 2
  UNION ALL SELECT '婴儿', 0, 3
) t
WHERE w.word_text = 'kid'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- through
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '穿过' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '绕过', 0, 1
  UNION ALL SELECT '停在', 0, 2
  UNION ALL SELECT '离开', 0, 3
) t
WHERE w.word_text = 'through'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- kitchen
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '厨房' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '卧室', 0, 1
  UNION ALL SELECT '客厅', 0, 2
  UNION ALL SELECT '卫生间', 0, 3
) t
WHERE w.word_text = 'kitchen'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- land
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '降落' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '起飞', 0, 1
  UNION ALL SELECT '飞行', 0, 2
  UNION ALL SELECT '停车', 0, 3
) t
WHERE w.word_text = 'land'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- till
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '直到' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '自从', 0, 1
  UNION ALL SELECT '在…之前', 0, 2
  UNION ALL SELECT '除了', 0, 3
) t
WHERE w.word_text = 'till'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- put
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '放' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '拿', 0, 1
  UNION ALL SELECT '扔', 0, 2
  UNION ALL SELECT '藏', 0, 3
) t
WHERE w.word_text = 'put'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- wall
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '墙' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '门', 0, 1
  UNION ALL SELECT '窗', 0, 2
  UNION ALL SELECT '地板', 0, 3
) t
WHERE w.word_text = 'wall'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- fever
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '发烧' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '咳嗽', 0, 1
  UNION ALL SELECT '牙痛', 0, 2
  UNION ALL SELECT '扭伤', 0, 3
) t
WHERE w.word_text = 'fever'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- Mr
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '先生' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '夫人', 0, 1
  UNION ALL SELECT '小姐', 0, 2
  UNION ALL SELECT '医生', 0, 3
) t
WHERE w.word_text = 'Mr'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- camera
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '照相机' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '电话', 0, 1
  UNION ALL SELECT '电脑', 0, 2
  UNION ALL SELECT '电视', 0, 3
) t
WHERE w.word_text = 'camera'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- patient
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '耐心的' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '急躁的', 0, 1
  UNION ALL SELECT '粗心的', 0, 2
  UNION ALL SELECT '懒惰的', 0, 3
) t
WHERE w.word_text = 'patient'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- inventor
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '发明家' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '教师', 0, 1
  UNION ALL SELECT '作家', 0, 2
  UNION ALL SELECT '画家', 0, 3
) t
WHERE w.word_text = 'inventor'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);

-- there
INSERT INTO word_option (word_id, option_text, is_correct, sort_order, created_at, updated_at)
SELECT w.id, t.option_text, t.is_correct, t.sort_order, NOW(), NOW()
FROM word w
JOIN (
  SELECT '在那里' AS option_text, 1 AS is_correct, 0 AS sort_order
  UNION ALL SELECT '在这里', 0, 1
  UNION ALL SELECT '在家里', 0, 2
  UNION ALL SELECT '在学校', 0, 3
) t
WHERE w.word_text = 'there'
  AND NOT EXISTS (SELECT 1 FROM word_option o WHERE o.word_id = w.id);
