-- 中考英语1600词 第101-400个单词
-- 写入 word，并关联到 word_book.id = 2
-- 可重复执行：单词按 word_text 去重；词书关系按 (book_id, word_id) 去重
-- 若 word 表中已有同名单词（如 cat/red/teacher），则跳过插入，仅做词书关联

SET NAMES utf8mb4;

-- 1. 确保存在 id=2 的词书
INSERT INTO word_book (id, book_name, description, cover_url, word_count, status, created_at, updated_at)
SELECT 2, '中考英语1600词', '中考英语1600词周计划表（第101-400词）', NULL, 0, 'ACTIVE', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM word_book WHERE id = 2);

-- 2. 插入单词（已存在相同 word_text 则跳过）
INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'generation', '/ˌdʒenəˈreɪʃn/', 'n.代，一代', 'People of my generation like this song.', '我们这一代人喜欢这首歌。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'generation');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'celebrate', '/ˈselɪbreɪt/', 'v.庆祝', 'We will celebrate her birthday tomorrow.', '我们明天要庆祝她的生日。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'celebrate');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'childhood', '/ˈtʃaɪldhʊd/', 'n.幼年时代，童年', 'I had a happy childhood in the countryside.', '我在乡下有一个快乐的童年。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'childhood');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'kick', '/kɪk/', 'v.& n.踢', 'Don''t kick the ball in the classroom.', '不要在教室里踢球。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'kick');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'listen', '/ˈlɪs(ə)n/', 'v.听，仔细听', 'Please listen to the teacher carefully.', '请仔细听老师讲。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'listen');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'volleyball', '/ˈvɒlibɔːl/', 'n.排球', 'They play volleyball after school.', '他们放学后打排球。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'volleyball');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'college', '/ˈkɒlɪdʒ/', 'n.学院', 'She wants to go to college next year.', '她想明年上大学。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'college');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'moment', '/ˈməʊmənt/', 'n.片刻；瞬间', 'Wait a moment, please.', '请稍等片刻。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'moment');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'repeat', '/rɪˈpiːt/', 'v.重复', 'Could you repeat the question?', '你能重复一下这个问题吗？', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'repeat');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'result', '/rɪˈzʌlt/', 'n.结果；成果', 'The exam result will come out tomorrow.', '考试结果明天公布。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'result');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'link', '/lɪŋk/', 'v.& n.连接；联系', 'This road links the two towns.', '这条路连接着两座城镇。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'link');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'tennis', '/ˈtenɪs/', 'n.网球', 'He plays tennis every weekend.', '他每个周末都打网球。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'tennis');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'key', '/kiː/', 'n.钥匙；答案；关键', 'I can''t find the key to my room.', '我找不到房间的钥匙。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'key');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'who', '/huː/', 'pron.谁', 'Who is standing at the door?', '谁站在门口？', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'who');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'interest', '/ˈɪntrəst/', 'n.兴趣；趣味', 'She has a great interest in music.', '她对音乐很有兴趣。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'interest');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'queen', '/kwiːn/', 'n.皇后；王后', 'The queen visited the city last year.', '王后去年访问了这座城市。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'queen');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'play', '/pleɪ/', 'v.玩；打(球)；演奏；扮演；播放 n.玩耍；戏剧；剧本', 'The children play in the park.', '孩子们在公园里玩。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'play');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'seldom', '/ˈseldəm/', 'adv.很少，不常', 'He seldom goes to bed late.', '他很少晚睡。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'seldom');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'relationship', '/rɪˈleɪʃnʃɪp/', 'n.关系', 'They have a close relationship.', '他们关系很亲密。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'relationship');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'damage', '/ˈdæmɪdʒ/', 'n.& v.破坏，损害', 'The storm may damage the houses.', '暴风雨可能会损坏房屋。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'damage');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'half', '/hɑːf/', 'adj.& n.半，一半，半个', 'I spent half an hour on homework.', '我花了半小时写作业。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'half');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'focus', '/ˈfəʊkəs/', 'v.集中', 'Please focus on your study.', '请把注意力集中在学习上。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'focus');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'upstairs', '/ˌʌpˈsteəz/', 'adv.在楼上；到楼上', 'My bedroom is upstairs.', '我的卧室在楼上。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'upstairs');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'call', '/kɔːl/', 'v.打电话给…；称呼；取名；呼唤 n.喊；叫；电话；通话', 'I will call you this evening.', '我今晚给你打电话。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'call');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'cabbage', '/ˈkæbɪdʒ/', 'n.卷心菜', 'She bought a cabbage at the market.', '她在市场上买了一棵卷心菜。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'cabbage');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'freedom', '/ˈfriːdəm/', 'n.自由', 'Everyone wants freedom and peace.', '每个人都想要自由与和平。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'freedom');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'pink', '/pɪŋk/', 'n.粉红 adj.粉红色的', 'She likes the pink dress.', '她喜欢那条粉红色连衣裙。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'pink');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'memory', '/ˈmeməri/', 'n.回忆，记忆', 'This photo brings back a sweet memory.', '这张照片带回一段甜蜜的回忆。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'memory');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'temperature', '/ˈtemprətʃə(r)/', 'n.温度', 'The temperature is high today.', '今天气温很高。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'temperature');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'charity', '/ˈtʃærəti/', 'n.慈善', 'They raised money for charity.', '他们为慈善筹款。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'charity');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'on', '/ɒn/', 'prep.在…之上；在…时刻；关于 adv.接通；进行下去 adj.在上映', 'The book is on the desk.', '书在桌子上。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'on');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'post', '/pəʊst/', 'n.邮政，邮寄，邮件 v.投寄；邮寄', 'Please post this letter for me.', '请帮我寄这封信。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'post');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'invention', '/ɪnˈvenʃn/', 'n.发明，创造', 'The computer is a great invention.', '电脑是一项伟大的发明。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'invention');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'theatre', '/ˈθɪətə(r)/', 'n.剧院，戏院', 'We watched a play at the theatre.', '我们在剧院看了一出戏。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'theatre');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'check', '/tʃek/', 'n.检查；批改；支票 v.核对；检查', 'Please check your answers again.', '请再核对一遍答案。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'check');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'publish', '/ˈpʌblɪʃ/', 'v.出版', 'The writer will publish a new book.', '这位作家将出版一本新书。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'publish');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'understand', '/ˌʌndəˈstænd/', 'v.明白；懂得；理解', 'Do you understand this sentence?', '你理解这个句子吗？', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'understand');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'library', '/ˈlaɪbrəri/', 'n.图书馆；图书室', 'I borrowed a book from the library.', '我从图书馆借了一本书。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'library');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'better', '/ˈbetə(r)/', 'adj.& adv.较好的，更好的；更好地 n.较好的事物', 'This idea is better than that one.', '这个主意比那个更好。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'better');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'sad', '/sæd/', 'adj.(使人)悲伤的', 'The ending of the story is sad.', '这个故事的结局很悲伤。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'sad');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'headache', '/ˈhedeɪk/', 'n.头痛', 'I have a bad headache today.', '我今天头疼得厉害。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'headache');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'January', '/ˈdʒænjuəri/', 'n.一月', 'School starts in January.', '学校一月开学。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'January');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'lazy', '/ˈleɪzi/', 'adj.懒惰的', 'Don''t be lazy; finish your work.', '别懒，把作业做完。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'lazy');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'pretty', '/ˈprɪti/', 'adj.漂亮的', 'What a pretty flower!', '多漂亮的花啊！', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'pretty');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'red', '/red/', 'n.红色 adj.红色的', 'She wore a red hat.', '她戴着一顶红帽子。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'red');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'cat', '/kæt/', 'n.猫', 'The cat is sleeping on the sofa.', '猫在沙发上睡觉。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'cat');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'own', '/əʊn/', 'adj.自己的 v.拥有', 'I have my own room.', '我有自己的房间。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'own');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'farmer', '/ˈfɑːmə(r)/', 'n.农民，农夫', 'The farmer works in the field.', '农民在田里干活。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'farmer');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'bite', '/baɪt/', 'v.咬；叮', 'Be careful. The dog may bite.', '小心，那只狗可能会咬人。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'bite');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'around', '/əˈraʊnd/', 'adv.在周围；环绕 prep.在…周围', 'There are many trees around the lake.', '湖周围有很多树。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'around');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'increase', '/ɪnˈkriːs/', 'v.& n.增加', 'The population will increase next year.', '人口明年将会增加。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'increase');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'empty', '/ˈempti/', 'adj.空的', 'The bottle is empty.', '瓶子是空的。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'empty');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'tall', '/tɔːl/', 'adj.高的', 'He is tall and strong.', '他又高又壮。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'tall');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'room', '/ruːm/', 'n.房间，室；空间；地方', 'There is a desk in my room.', '我房间里有一张书桌。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'room');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'fair', '/feə(r)/', 'adj.公平的；合理的；金色的', 'The teacher is always fair to us.', '老师对我们总是很公平。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'fair');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'pollute', '/pəˈluːt/', 'v.污染，弄脏', 'Factories should not pollute the river.', '工厂不应当污染河流。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'pollute');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'duck', '/dʌk/', 'n.鸭子', 'A duck is swimming in the pond.', '一只鸭子在池塘里游泳。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'duck');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'underground', '/ˌʌndəˈɡraʊnd/', 'adj.地下的 n.地铁', 'We went there by underground.', '我们坐地铁去那里。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'underground');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'fountain', '/ˈfaʊntən/', 'n.喷泉', 'There is a fountain in the park.', '公园里有一座喷泉。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'fountain');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'fill', '/fɪl/', 'v.填空；装满；充满', 'Please fill the glass with water.', '请把杯子装满水。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'fill');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'share', '/ʃeə(r)/', 'v.分享，共同使用', 'I will share my book with you.', '我会和你分享我的书。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'share');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'shape', '/ʃeɪp/', 'n.形状，外形，样子', 'The moon has a round shape tonight.', '今晚月亮是圆的。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'shape');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'water', '/ˈwɔːtə(r)/', 'n.水 v.浇水', 'Plants need water to grow.', '植物生长需要水。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'water');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'nationality', '/ˌnæʃəˈnæləti/', 'n.国籍', 'What is your nationality?', '你的国籍是什么？', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'nationality');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'success', '/səkˈses/', 'n.成功', 'Hard work is the key to success.', '努力是成功的关键。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'success');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'perhaps', '/pəˈhæps/', 'adv.可能；也许', 'Perhaps it will rain later.', '也许一会儿会下雨。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'perhaps');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'about', '/əˈbaʊt/', 'prep.关于 adv.大约；到处，四处', 'This book is about animals.', '这本书是关于动物的。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'about');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'know', '/nəʊ/', 'v.知道，了解；认识；懂得', 'I know the answer.', '我知道答案。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'know');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'custom', '/ˈkʌstəm/', 'n.习惯，习俗', 'It is a custom to eat dumplings at Spring Festival.', '春节吃饺子是一种习俗。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'custom');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'suppose', '/səˈpəʊz/', 'v.猜想，假定，料想', 'I suppose he is right.', '我想他是对的。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'suppose');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'noise', '/nɔɪz/', 'n.声音；噪声；响声', 'Don''t make so much noise.', '别发出那么大的噪声。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'noise');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'rubbish', '/ˈrʌbɪʃ/', 'n.垃圾；废物', 'Please throw the rubbish into the bin.', '请把垃圾扔进垃圾桶。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'rubbish');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'advantage', '/ədˈvɑːntɪdʒ/', 'n.有利条件；优势，优点', 'Speaking English is an advantage.', '会说英语是一个优势。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'advantage');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'fit', '/fɪt/', 'v.(使)适合，与…相配 adj.健康的，合适的', 'This coat does not fit me.', '这件外套不适合我。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'fit');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'as', '/æz/', 'conj.像…一样；因为；当…时 prep.作为 adv.同样地', 'She works as a nurse.', '她是一名护士。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'as');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'corner', '/ˈkɔːnə(r)/', 'n.角；角落；拐角', 'The shop is at the street corner.', '商店在街道拐角处。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'corner');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'part', '/pɑːt/', 'n.部分；角色；部件；零件', 'He played an important part in the play.', '他在剧中扮演了重要角色。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'part');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'ancient', '/ˈeɪnʃənt/', 'adj.古代的，古老的', 'We visited an ancient city.', '我们参观了一座古城。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'ancient');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'activity', '/ækˈtɪvəti/', 'n.活动', 'The school activity is interesting.', '学校的活动很有趣。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'activity');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'Britain', '/ˈbrɪtn/', 'n.英国；不列颠', 'London is the capital of Britain.', '伦敦是英国的首都。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'Britain');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'drink', '/drɪŋk/', 'v.喝；饮 n.饮料；喝酒', 'Would you like a drink of water?', '你想喝点水吗？', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'drink');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'tree', '/triː/', 'n.树', 'There is a tall tree in front of the house.', '房子前面有一棵高树。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'tree');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'enough', '/ɪˈnʌf/', 'adj.足够的；充分的 adv.足够地 n.足够；充分', 'We have enough time to finish it.', '我们有足够的时间完成它。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'enough');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'cheap', '/tʃiːp/', 'adj.便宜的', 'This T-shirt is cheap and nice.', '这件T恤又便宜又好看。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'cheap');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'between', '/bɪˈtwiːn/', 'prep.在(两者)之间；在…中间', 'The shop is between the bank and the school.', '商店在银行和学校之间。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'between');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'decide', '/dɪˈsaɪd/', 'v.决定；下决心', 'I decide to study harder.', '我决定更加努力学习。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'decide');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'write', '/raɪt/', 'v.写；写作；写信', 'Please write your name here.', '请在这里写下你的名字。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'write');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'can', '/kən; kæn/', 'aux.& v.可能；能够；可以；会 n.(美)罐头；罐子', 'I can swim very well.', '我游泳游得很好。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'can');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'tape', '/teɪp/', 'n.磁带；录音带', 'He listened to an English tape.', '他听了一盘英语磁带。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'tape');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'captain', '/ˈkæptɪn/', 'n.船长', 'The captain stood on the ship.', '船长站在船上。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'captain');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'middle', '/ˈmɪd(ə)l/', 'n.中间；当中；中部', 'He sat in the middle of the room.', '他坐在房间中间。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'middle');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'chair', '/tʃeə(r)/', 'n.椅子', 'Please sit on the chair.', '请坐在椅子上。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'chair');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'meal', '/miːl/', 'n.一餐(饭)', 'We have three meals a day.', '我们一天吃三顿饭。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'meal');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'heavily', '/ˈhevɪli/', 'adv.沉重地；大量地', 'It rained heavily last night.', '昨晚雨下得很大。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'heavily');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'beach', '/biːtʃ/', 'n.海滨，海滩', 'We walked on the beach.', '我们在海滩上散步。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'beach');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'like', '/laɪk/', 'v.喜欢；喜爱；想要 prep.像，跟…一样', 'I like reading English stories.', '我喜欢读英语故事。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'like');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'argue', '/ˈɑːɡjuː/', 'v.争论，争吵', 'Don''t argue with your parents.', '不要和父母争吵。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'argue');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'certainly', '/ˈsɜːt(ə)nli/', 'adv.当然；是的；一定；无疑', 'I will certainly help you.', '我当然会帮助你。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'certainly');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'Saturday', '/ˈsætədeɪ/', 'n.星期六', 'We have no classes on Saturday.', '我们星期六没有课。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'Saturday');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'food', '/fuːd/', 'n.食物，食品', 'The food in this restaurant is delicious.', '这家餐馆的食物很好吃。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'food');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'left', '/left/', 'adj.左边的 n.左，左边 adv.向左', 'Turn left at the next corner.', '在下一个拐角向左转。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'left');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'amusement', '/əˈmjuːzmənt/', 'n.娱乐；消遣；娱乐活动', 'The amusement park is full of people.', '游乐园里挤满了人。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'amusement');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'aim', '/eɪm/', 'n.目的；目标 v.打算；瞄准', 'My aim is to learn English well.', '我的目标是学好英语。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'aim');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'connect', '/kəˈnekt/', 'v.连接；把…联系起来', 'Please connect the computer to the printer.', '请把电脑连接到打印机。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'connect');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'May', '/meɪ/', 'n.五月', 'Labour Day is in May.', '劳动节在五月。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'May');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'basketball', '/ˈbɑːskɪtbɔːl/', 'n.篮球', 'He is good at basketball.', '他擅长打篮球。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'basketball');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'smell', '/smel/', 'v.嗅；闻到 n.气味', 'The flowers smell sweet.', '这些花闻起来很香。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'smell');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'dream', '/driːm/', 'n.& v.梦；梦想', 'Her dream is to be a doctor.', '她的梦想是成为医生。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'dream');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'hour', '/ˈaʊə(r)/', 'n.小时', 'The meeting lasted one hour.', '会议持续了一个小时。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'hour');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'litter', '/ˈlɪtə(r)/', 'n.废物，垃圾 v.乱丢杂物', 'Don''t litter in the park.', '不要在公园里乱扔垃圾。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'litter');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'fireman', '/ˈfaɪəmən/', 'n.消防队员', 'The fireman saved the little girl.', '消防队员救了那个小女孩。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'fireman');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'other', '/ˈʌðə(r)/', 'adj.其他的；另外的 pron.别人；别的东西', 'Do you have any other questions?', '你还有其他问题吗？', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'other');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'automatic', '/ˌɔːtəˈmætɪk/', 'adj.自动的', 'This is an automatic door.', '这是一扇自动门。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'automatic');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'pot', '/pɒt/', 'n.锅，壶，罐', 'There is some soup in the pot.', '锅里有一些汤。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'pot');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'outdoor', '/ˈaʊtdɔː(r)/', 'adj.室外的', 'We like outdoor sports.', '我们喜欢户外运动。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'outdoor');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'gentle', '/ˈdʒent(ə)l/', 'adj.温柔的，轻轻的', 'She has a gentle voice.', '她的声音很温柔。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'gentle');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'above', '/əˈbʌv/', 'prep.在…上面', 'There is a picture above the desk.', '书桌上方有一幅画。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'above');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'exam', '/ɪɡˈzæm/', 'n.考试，测试；检查', 'We will have an English exam tomorrow.', '我们明天有英语考试。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'exam');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'course', '/kɔːs/', 'n.过程；经过；课程', 'This English course is very useful.', '这门英语课程很有用。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'course');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'manner', '/ˈmænə(r)/', 'n.方式，态度，举止', 'He spoke in a polite manner.', '他说话态度很礼貌。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'manner');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'eat', '/iːt/', 'v.吃', 'We eat breakfast at seven.', '我们七点吃早餐。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'eat');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'news', '/njuːz/', 'n.新闻；消息', 'I heard the good news just now.', '我刚刚听到这个好消息。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'news');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'customer', '/ˈkʌstəmə(r)/', 'n.顾客；主顾', 'The shop assistant helped the customer.', '店员帮助了那位顾客。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'customer');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'tea', '/tiː/', 'n.茶；茶叶', 'Would you like a cup of tea?', '你想喝杯茶吗？', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'tea');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'close', '/kləʊz/', 'v.关，关闭 adj.亲密的；近的 adv.近；靠近', 'Please close the window.', '请把窗户关上。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'close');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'pearl', '/pɜːl/', 'n.珍珠', 'She wore a pearl necklace.', '她戴着一条珍珠项链。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'pearl');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'windy', '/ˈwɪndi/', 'adj.有风的；起风的', 'It is windy today.', '今天有风。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'windy');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'roast', '/rəʊst/', 'v.烤(肉)', 'Mum will roast a chicken for dinner.', '妈妈晚饭要烤一只鸡。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'roast');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'act', '/ækt/', 'v.表演，扮演(角色)；行动', 'He will act in the school play.', '他将在校园剧中演出。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'act');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'magazine', '/ˌmæɡəˈziːn/', 'n.杂志', 'I bought a science magazine.', '我买了一本科学杂志。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'magazine');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'general', '/ˈdʒen(ə)rəl/', 'adj.大体的，笼统的，总的', 'This is a general idea of the text.', '这是课文的大意。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'general');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'situation', '/ˌsɪtʃuˈeɪʃ(ə)n/', 'n.形势，情况；场面', 'The situation is getting better.', '情况正在好转。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'situation');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'create', '/kriˈeɪt/', 'v.创造；造成', 'Artists create beautiful pictures.', '艺术家创造出美丽的图画。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'create');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'weak', '/wiːk/', 'adj.弱的，差的，淡的', 'He felt weak after the long walk.', '走了很长的路后他感到虚弱。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'weak');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'sentence', '/ˈsentəns/', 'n.句子', 'Please make a sentence with this word.', '请用这个单词造一个句子。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'sentence');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'laugh', '/lɑːf/', 'v.& n.笑，大笑；嘲笑', 'The joke made us laugh.', '这个笑话让我们大笑。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'laugh');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'shirt', '/ʃɜːt/', 'n.男衬衫', 'He bought a white shirt.', '他买了一件白衬衫。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'shirt');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'golden', '/ˈɡəʊldən/', 'adj.金色的', 'The golden sun is rising.', '金色的太阳正在升起。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'golden');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'jeans', '/dʒiːnz/', 'n.牛仔裤', 'She likes wearing blue jeans.', '她喜欢穿蓝色牛仔裤。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'jeans');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'recent', '/ˈriːsnt/', 'adj.近来的，最近的', 'I saw a recent photo of her.', '我看到了她最近的一张照片。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'recent');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'lunch', '/lʌntʃ/', 'n.午餐，午饭', 'We have lunch at school.', '我们在学校吃午饭。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'lunch');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'luggage', '/ˈlʌɡɪdʒ/', 'n.行李', 'Please look after your luggage.', '请看好你的行李。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'luggage');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'block', '/blɒk/', 'n.一排房屋；街区；大块', 'The school is two blocks away.', '学校离这里有两个街区。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'block');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'pineapple', '/ˈpaɪnæp(ə)l/', 'n.菠萝', 'The pineapple tastes sweet.', '这个菠萝味道很甜。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'pineapple');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'market', '/ˈmɑːkɪt/', 'n.市场；集市', 'Mum went to the market this morning.', '妈妈今天早上去了市场。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'market');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'France', '/frɑːns/', 'n.法国', 'Paris is the capital of France.', '巴黎是法国的首都。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'France');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'clothes', '/kləʊðz/', 'n.衣服', 'She bought some new clothes.', '她买了一些新衣服。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'clothes');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'juice', '/dʒuːs/', 'n.果汁', 'I drink orange juice every morning.', '我每天早上喝橙汁。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'juice');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'survey', '/ˈsɜːveɪ/', 'v.＆ n.调查', 'We did a survey about reading habits.', '我们做了一项关于阅读习惯的调查。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'survey');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'precious', '/ˈpreʃəs/', 'adj.宝贵的，珍贵的', 'Time is precious.', '时间是宝贵的。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'precious');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'partner', '/ˈpɑːtnə(r)/', 'n.搭档，合作者', 'Tom is my partner in the game.', '汤姆是我比赛中的搭档。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'partner');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'boil', '/bɔɪl/', 'v.沸腾；煮', 'Please boil some water.', '请烧一些开水。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'boil');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'railway', '/ˈreɪlweɪ/', 'n.铁路；铁道', 'The railway station is near here.', '火车站就在附近。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'railway');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'reduce', '/rɪˈdjuːs/', 'v.减少；缩减', 'We should reduce air pollution.', '我们应该减少空气污染。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'reduce');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'few', '/fjuː/', 'pron.不多；少数 adj.不多的；少数的', 'Few students were late today.', '今天几乎没有学生迟到。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'few');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'angrily', '/ˈæŋɡrəli/', 'adv.生气地；愤怒地', 'He looked at me angrily.', '他生气地看着我。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'angrily');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'exercise', '/ˈeksəsaɪz/', 'n.锻炼；做操；练习；习题', 'We do exercise every morning.', '我们每天早上锻炼。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'exercise');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'sandwich', '/ˈsænwɪdʒ/', 'n.三明治', 'I had a sandwich for lunch.', '我午饭吃了一个三明治。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'sandwich');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'inside', '/ˌɪnˈsaɪd/', 'prep.在…里面 adv.在里面', 'It is warm inside the room.', '房间里面很暖和。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'inside');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'dollar', '/ˈdɒlə(r)/', 'n.元(美国、加拿大、澳大利亚等国货币单位)', 'This book costs ten dollars.', '这本书要十美元。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'dollar');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'Monday', '/ˈmʌndeɪ/', 'n.星期一', 'We have a meeting on Monday.', '我们星期一有会。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'Monday');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'similar', '/ˈsɪmələ(r)/', 'adj.相似的，像', 'The two pictures are similar.', '这两幅画很相似。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'similar');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'autumn', '/ˈɔːtəm/', 'n.秋天；秋季', 'Leaves fall in autumn.', '秋天树叶会落下。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'autumn');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'holiday', '/ˈhɒlədeɪ/', 'n.假日；假期', 'We will go travelling in the holiday.', '假期我们会去旅行。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'holiday');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'require', '/rɪˈkwaɪə(r)/', 'v.需要；要求', 'This job requires patience.', '这份工作需要耐心。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'require');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'forward', '/ˈfɔːwəd/', 'adv.向前，前进；今后', 'Please move forward a little.', '请往前挪一点。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'forward');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'bright', '/braɪt/', 'adj.明亮的；聪明的', 'The classroom is bright and clean.', '教室明亮又干净。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'bright');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'careful', '/ˈkeəf(ə)l/', 'adj.小心的；仔细的', 'Be careful when you cross the road.', '过马路时要小心。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'careful');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'visitor', '/ˈvɪzɪtə(r)/', 'n.参观者，访问者', 'Many visitors come to the museum.', '许多参观者来到博物馆。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'visitor');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'must', '/mʌst/', 'aux.v.必须；需要；应当；必定是，一定', 'You must finish your homework first.', '你必须先完成作业。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'must');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'twin', '/twɪn/', 'n.双胞胎之一', 'Lucy and Lily are twins.', '露西和莉莉是双胞胎。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'twin');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'point', '/pɔɪnt/', 'v.指；指向 n.点；分数；小数点', 'He pointed to the map.', '他指向地图。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'point');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'basket', '/ˈbɑːskɪt/', 'n.篮子', 'There are apples in the basket.', '篮子里有苹果。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'basket');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'conclusion', '/kənˈkluːʒn/', 'n.结论；结束，结局', 'We drew a conclusion from the facts.', '我们从事实中得出了结论。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'conclusion');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'stomachache', '/ˈstʌməkeɪk/', 'n.胃痛', 'He has a stomachache after lunch.', '午饭后他胃痛。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'stomachache');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'hurry', '/ˈhʌri/', 'v.赶快；急忙 n.赶紧；急忙', 'Hurry up, or we will be late.', '快点，否则我们要迟到了。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'hurry');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'Wednesday', '/ˈwenzdeɪ/', 'n.星期三', 'We have P.E. on Wednesday.', '我们星期三有体育课。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'Wednesday');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'conversation', '/ˌkɒnvəˈseɪʃ(ə)n/', 'n.会话；谈话', 'They had a long conversation.', '他们进行了一次长谈。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'conversation');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'leave', '/liːv/', 'v.离开；把…留下，剩下 n.准假', 'Don''t leave your bag on the bus.', '别把包落在公交车上。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'leave');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'wide', '/waɪd/', 'adj.宽的；广泛的', 'The river is very wide.', '这条河很宽。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'wide');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'interested', '/ˈɪntrəstɪd/', 'adj.感兴趣的', 'I am interested in science.', '我对科学感兴趣。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'interested');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'teacher', '/ˈtiːtʃə(r)/', 'n.教师', 'Our English teacher is very kind.', '我们的英语老师很和蔼。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'teacher');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'happily', '/ˈhæpɪli/', 'adv.幸福地；快乐地，高兴地', 'The children played happily.', '孩子们玩得很开心。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'happily');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'envelope', '/ˈenvələʊp/', 'n.信封', 'Put the letter into the envelope.', '把信放进信封里。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'envelope');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'light', '/laɪt/', 'n.光；灯光 adj.明亮的；轻的；浅色的', 'Turn on the light, please.', '请打开灯。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'light');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'September', '/sepˈtembə(r)/', 'n.九月', 'School begins in September.', '学校九月开学。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'September');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'settle', '/ˈset(ə)l/', 'v.安家，定居；解决', 'They settled in a small town.', '他们在一座小镇定居。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'settle');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'disappointed', '/ˌdɪsəˈpɔɪntɪd/', 'adj.失望的，沮丧的', 'He felt disappointed at the result.', '他对结果感到失望。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'disappointed');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'habit', '/ˈhæbɪt/', 'n.习惯', 'Reading is a good habit.', '阅读是一个好习惯。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'habit');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'pound', '/paʊnd/', 'n.磅(重量单位)；英镑', 'The bag costs twenty pounds.', '这个包要二十英镑。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'pound');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'bear', '/beə(r)/', 'n.熊', 'We saw a bear in the zoo.', '我们在动物园看到一只熊。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'bear');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'skate', '/skeɪt/', 'v.溜冰', 'Children skate on the ice in winter.', '冬天孩子们在冰上溜冰。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'skate');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'dress', '/dres/', 'n.女服，连衣裙；(统指)服装 v.穿衣；穿着', 'She wore a beautiful dress.', '她穿着一条漂亮的连衣裙。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'dress');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'safe', '/seɪf/', 'adj.安全的；平安的 n.保险柜', 'It is not safe to swim here.', '在这里游泳不安全。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'safe');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'leg', '/leɡ/', 'n.腿', 'He hurt his left leg.', '他伤了左腿。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'leg');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'wrong', '/rɒŋ/', 'adj.错误的；不正常的；有病的', 'You chose the wrong answer.', '你选了错误的答案。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'wrong');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'length', '/leŋkθ/', 'n.长度', 'What is the length of this river?', '这条河有多长？', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'length');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'but', '/bʌt; bət/', 'conj.但是', 'I was tired, but I kept working.', '我很累，但我继续工作。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'but');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'deliver', '/dɪˈlɪvə(r)/', 'v.投递(信件，邮包等)；传送', 'The postman delivers letters every day.', '邮递员每天送信。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'deliver');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'angry', '/ˈæŋɡri/', 'adj.生气的；愤怒的', 'Don''t be angry with me.', '别生我的气。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'angry');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'service', '/ˈsɜːvɪs/', 'n.服务；公用事业', 'The hotel offers good service.', '这家酒店提供很好的服务。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'service');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'spread', '/spred/', 'v.延伸；展开', 'Please spread the map on the table.', '请把地图摊在桌子上。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'spread');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'loudly', '/ˈlaʊdli/', 'adv.大声地', 'Don''t talk loudly in the library.', '不要在图书馆大声说话。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'loudly');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'toy', '/tɔɪ/', 'n.玩具', 'The little boy got a new toy.', '小男孩得到一个新玩具。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'toy');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'sightseeing', '/ˈsaɪtsiːɪŋ/', 'n.游览；观光', 'We went sightseeing in Beijing.', '我们在北京观光。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'sightseeing');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'cigarette', '/ˌsɪɡəˈret/', 'n.香烟', 'Smoking cigarettes is bad for health.', '吸烟对健康有害。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'cigarette');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'gently', '/ˈdʒentli/', 'adv.轻柔地', 'She closed the door gently.', '她轻轻地关上了门。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'gently');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'since', '/sɪns/', 'prep.从…以来；自从 conj.从…以来；由于；既然', 'I have lived here since 2020.', '从2020年起我就住在这里。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'since');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'pool', '/puːl/', 'n.水池，水塘', 'They swim in the pool in summer.', '他们夏天在游泳池游泳。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'pool');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'strong', '/strɒŋ/', 'adj.强(壮)的；坚固的；强烈的；坚强的', 'He is strong enough to carry the box.', '他足够强壮，能搬动这个箱子。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'strong');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'count', '/kaʊnt/', 'v.数', 'Count from one to ten, please.', '请从一数到十。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'count');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'dry', '/draɪ/', 'adj.干的；干燥的', 'The clothes are dry now.', '衣服现在干了。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'dry');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'comfortable', '/ˈkʌmftəbl; ˈkʌmfətəbl/', 'adj.舒服的', 'This chair is very comfortable.', '这把椅子很舒服。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'comfortable');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'while', '/waɪl/', 'conj.在…的时候；正当…时 n.一会儿', 'Don''t talk while you are eating.', '吃饭时不要说话。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'while');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'have', '/həv/', 'v.有；吃；喝；进行', 'I have a lot of homework today.', '我今天有很多作业。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'have');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'produce', '/prəˈdjuːs/', 'v.生产；产生；制造', 'This factory produces cars.', '这家工厂生产汽车。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'produce');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'baby', '/ˈbeɪbi/', 'n.婴儿', 'The baby is sleeping.', '婴儿正在睡觉。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'baby');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'allow', '/əˈlaʊ/', 'v.允许，准许', 'The teacher does not allow us to run here.', '老师不允许我们在这里跑。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'allow');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'freezing', '/ˈfriːzɪŋ/', 'adj.结冰的；极冷的', 'It is freezing outside.', '外面冷极了。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'freezing');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'choice', '/tʃɔɪs/', 'n.选择', 'You have no choice but to wait.', '你别无选择，只能等待。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'choice');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'little', '/ˈlɪt(ə)l/', 'adj.小的，少的 adv.很少地 n.没有多少，一点', 'There is little water in the bottle.', '瓶子里几乎没有水了。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'little');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'heat', '/hiːt/', 'n.热度，热量 v.加热', 'The heat of the sun is strong.', '太阳的热量很强。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'heat');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'friendship', '/ˈfrendʃɪp/', 'n.友谊', 'True friendship is important.', '真正的友谊很重要。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'friendship');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'discover', '/dɪˈskʌvə(r)/', 'v.发现；看出', 'Scientists discover new things every year.', '科学家每年都会发现新事物。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'discover');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'pencil', '/ˈpens(ə)l/', 'n.铅笔', 'I write with a pencil.', '我用铅笔写字。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'pencil');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'strange', '/streɪndʒ/', 'adj.奇怪的，奇特的，陌生的', 'I heard a strange noise.', '我听到一种奇怪的声音。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'strange');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'lesson', '/ˈlesn/', 'n.课；功课；教训', 'We have an English lesson this morning.', '我们今天上午有英语课。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'lesson');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'end', '/end/', 'n.末尾；终点；结束 v.结束，终止', 'The film will end at eight.', '电影八点结束。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'end');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'various', '/ˈveəriəs/', 'adj.各种各样的，不同的', 'There are various books in the library.', '图书馆里有各种各样的书。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'various');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'quick', '/kwɪk/', 'adj.快的；敏捷的；迅速的', 'He gave a quick answer.', '他很快给出了答案。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'quick');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'film', '/fɪlm/', 'n.电影；影片；胶卷', 'We watched a film last night.', '我们昨晚看了一部电影。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'film');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'owner', '/ˈəʊnə(r)/', 'n.拥有者；物主', 'Who is the owner of this bike?', '这辆自行车的主人是谁？', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'owner');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'debate', '/dɪˈbeɪt/', 'v.& n.争论，辩论；讨论', 'We had a debate about school uniforms.', '我们就校服问题进行了辩论。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'debate');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'brave', '/breɪv/', 'adj.勇敢的', 'The brave boy saved the cat.', '那个勇敢的男孩救了猫。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'brave');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'terrible', '/ˈterəb(ə)l/', 'adj.可怕的，糟糕的', 'The weather is terrible today.', '今天天气很糟糕。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'terrible');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'technology', '/tekˈnɒlədʒi/', 'n.技术', 'Modern technology makes life easier.', '现代技术让生活更便利。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'technology');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'once', '/wʌns/', 'adv.& conj.& n.一次；一度；从前', 'I have been to Shanghai once.', '我去过上海一次。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'once');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'education', '/ˌedʒuˈkeɪʃn/', 'n.教育', 'Education is important for everyone.', '教育对每个人都很重要。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'education');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'garden', '/ˈɡɑːdn/', 'n.花园，果园，菜园', 'There are many flowers in the garden.', '花园里有很多花。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'garden');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'detail', '/ˈdiːteɪl/', 'n.细节', 'Please tell me the detail of the plan.', '请告诉我计划的细节。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'detail');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'tour', '/tʊə(r)/', 'n.参观；观光；旅行', 'We went on a tour of the old city.', '我们参观了这座古城。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'tour');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'borrow', '/ˈbɒrəʊ/', 'v.(向别人)借用；借', 'May I borrow your dictionary?', '我可以借你的词典吗？', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'borrow');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'club', '/klʌb/', 'n.俱乐部', 'He joined the football club.', '他加入了足球俱乐部。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'club');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'educational', '/ˌedʒuˈkeɪʃən(ə)l/', 'adj.教育的', 'This is an educational TV programme.', '这是一个教育类电视节目。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'educational');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'sweet', '/swiːt/', 'adj.甜的；可爱的 n.甜食；糖果', 'The cake is too sweet.', '这块蛋糕太甜了。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'sweet');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'each', '/iːtʃ/', 'adj.& pron.每人；每个；每件', 'Each student has a book.', '每个学生都有一本书。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'each');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'cycle', '/ˈsaɪk(ə)l/', 'v.骑(自行)车', 'I cycle to school every day.', '我每天骑自行车上学。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'cycle');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'rain', '/reɪn/', 'n.雨；雨水 v.下雨', 'It may rain this afternoon.', '今天下午可能会下雨。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'rain');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'ever', '/ˈevə(r)/', 'adv.曾经；无论何时', 'Have you ever been to Beijing?', '你曾经去过北京吗？', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'ever');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'shout', '/ʃaʊt/', 'v.& n.喊；高声呼喊', 'Don''t shout in the classroom.', '不要在教室里喊叫。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'shout');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'umbrella', '/ʌmˈbrelə/', 'n.伞', 'Take an umbrella with you.', '带上雨伞。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'umbrella');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'impossible', '/ɪmˈpɒsəb(ə)l/', 'adj.不可能的', 'Nothing is impossible if you try.', '只要努力，没有什么是不可能的。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'impossible');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'dishonest', '/dɪsˈɒnɪst/', 'adj.不诚实的，欺骗性的', 'It is wrong to be dishonest.', '不诚实是不对的。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'dishonest');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'very', '/ˈveri/', 'adv.很；非常', 'The story is very interesting.', '这个故事非常有趣。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'very');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'add', '/æd/', 'v.添加，增加', 'Please add some sugar to the tea.', '请往茶里加一点糖。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'add');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'tooth', '/tuːθ/', 'n.牙齿', 'I brush my teeth twice a day.', '我每天刷两次牙。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'tooth');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'rice', '/raɪs/', 'n.稻；米；米饭', 'We eat rice every day.', '我们每天吃米饭。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'rice');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'illness', '/ˈɪlnəs/', 'n.疾病', 'He missed school because of illness.', '他因病没来上学。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'illness');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'beg', '/beɡ/', 'v.请求，乞求，乞讨', 'I beg you to help me.', '我请求你帮助我。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'beg');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'wear', '/weə(r)/', 'v.穿；戴', 'She wears a blue coat.', '她穿着一件蓝色外套。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'wear');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'joy', '/dʒɔɪ/', 'n.欢乐，高兴，乐趣', 'The good news filled us with joy.', '这个好消息让我们充满喜悦。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'joy');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'card', '/kɑːd/', 'n.卡片', 'I sent a birthday card to my friend.', '我给朋友寄了一张生日贺卡。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'card');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'always', '/ˈɔːlweɪz/', 'adv.总是；一直；永远', 'She always helps others.', '她总是帮助别人。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'always');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'deep', '/diːp/', 'adj.深', 'The lake is very deep.', '这个湖很深。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'deep');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'pioneer', '/ˌpaɪəˈnɪə(r)/', 'n.先锋，开拓者', 'He is a pioneer in this field.', '他是这个领域的开拓者。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'pioneer');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'accept', '/əkˈsept/', 'v.接受', 'I accept your invitation.', '我接受你的邀请。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'accept');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'way', '/weɪ/', 'n.路，路线，路途；方法，手段', 'This is the best way to the station.', '这是去车站最好的路。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'way');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'discussion', '/dɪˈskʌʃn/', 'n.讨论', 'We had a discussion about the problem.', '我们就这个问题进行了讨论。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'discussion');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'respect', '/rɪˈspekt/', 'v.慎重对待，尊重', 'We should respect our parents.', '我们应该尊重父母。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'respect');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'everywhere', '/ˈevriweə(r)/', 'adv.到处', 'There are flowers everywhere in spring.', '春天到处都是花。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'everywhere');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'within', '/wɪˈðɪn/', 'prep.在…范围之内', 'Please finish it within an hour.', '请在一小时内完成。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'within');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'animal', '/ˈænɪm(ə)l/', 'n.动物', 'The panda is a lovely animal.', '熊猫是一种可爱的动物。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'animal');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'nurse', '/nɜːs/', 'n.护士；保育员', 'The nurse looked after the patients.', '护士照顾病人。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'nurse');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'title', '/ˈtaɪt(ə)l/', 'n.标题，题目', 'What is the title of the book?', '这本书的标题是什么？', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'title');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'per', '/pə(r)/', 'prep.每，每一', 'The tickets cost ten yuan per person.', '票价每人十元。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'per');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'disturb', '/dɪˈstɜːb/', 'v.扰乱；打扰', 'Please don''t disturb me. I am studying.', '请不要打扰我，我在学习。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'disturb');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'beautifully', '/ˈbjuːtɪfli/', 'adv.优美地', 'She sings beautifully.', '她唱得很优美。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'beautifully');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'equal', '/ˈiːkwəl/', 'adj.平等的 v.等于', 'All students should have equal chances.', '所有学生都应有平等的机会。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'equal');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'immediately', '/ɪˈmiːdiətli/', 'adv.立即，马上', 'Please come here immediately.', '请马上过来。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'immediately');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'salad', '/ˈsæləd/', 'n.色拉', 'I had a fruit salad for lunch.', '我午饭吃了水果色拉。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'salad');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'ahead', '/əˈhed/', 'adv.在前，向前', 'Go ahead and I will follow you.', '你先走，我跟着你。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'ahead');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'goal', '/ɡəʊl/', 'n.目标', 'My goal is to pass the exam.', '我的目标是通过考试。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'goal');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'hard', '/hɑːd/', 'adj.硬的；困难的；艰难的 adv.努力地；使劲；猛烈地', 'You should work hard.', '你应该努力学习。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'hard');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'price', '/praɪs/', 'n.价格', 'The price of this coat is too high.', '这件外套的价格太高了。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'price');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'keep', '/kiːp/', 'v.保持；保存；继续不断；培养，饲养', 'Please keep the room clean.', '请保持房间干净。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'keep');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'nervous', '/ˈnɜːvəs/', 'adj.紧张的', 'She felt nervous before the exam.', '考试前她感到紧张。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'nervous');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'properly', '/ˈprɒpəli/', 'adv.适当地，合适地', 'Please put the books away properly.', '请把书放整齐。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'properly');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'kid', '/kɪd/', 'v.开玩笑 n.小孩', 'The kids are playing in the yard.', '孩子们在院子里玩。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'kid');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'through', '/θruː/', 'prep.穿(通)过；从始至终', 'We walked through the forest.', '我们穿过了森林。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'through');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'kitchen', '/ˈkɪtʃɪn/', 'n.厨房', 'Mum is cooking in the kitchen.', '妈妈正在厨房做饭。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'kitchen');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'land', '/lænd/', 'n.陆地；土地 v.登陆；降落', 'The plane will land soon.', '飞机很快就要降落。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'land');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'till', '/tɪl/', 'prep.& conj.直到；直到…为止', 'Wait here till I come back.', '在这里等到我回来。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'till');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'put', '/pʊt/', 'v.放，摆', 'Put the book on the desk.', '把书放在桌子上。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'put');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'wall', '/wɔːl/', 'n.墙', 'There is a map on the wall.', '墙上有一张地图。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'wall');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'fever', '/ˈfiːvə(r)/', 'n.发烧；发热', 'The boy has a high fever.', '这个男孩发高烧。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'fever');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'Mr', '/ˈmɪstə(r)/', 'n.先生', 'Mr Wang is our maths teacher.', '王先生是我们的数学老师。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'Mr');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'camera', '/ˈkæm(ə)rə/', 'n.照相机', 'He took a photo with his camera.', '他用照相机拍了一张照片。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'camera');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'patient', '/ˈpeɪʃ(ə)nt/', 'n.病人 adj.耐心的', 'The doctor is very patient with the patient.', '医生对病人非常有耐心。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'patient');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'inventor', '/ɪnˈventə(r)/', 'n.发明家，创造者', 'Edison was a great inventor.', '爱迪生是一位伟大的发明家。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'inventor');

INSERT INTO word (word_text, phonetic, correct_meaning, example_sentence, example_translation, created_at, updated_at)
SELECT 'there', '/ðeə(r)/', 'adv.在那里；往那里；(作引导词)表“存在”', 'There is a book on the table.', '桌子上有一本书。', NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM word w WHERE w.word_text = 'there');

-- 3. 关联到词书 id=2（sort_order 使用原表序号 101-400）
INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 101, 'Week 3 Day 1'
FROM word w
WHERE w.word_text = 'generation'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 102, 'Week 3 Day 1'
FROM word w
WHERE w.word_text = 'celebrate'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 103, 'Week 3 Day 1'
FROM word w
WHERE w.word_text = 'childhood'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 104, 'Week 3 Day 1'
FROM word w
WHERE w.word_text = 'kick'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 105, 'Week 3 Day 1'
FROM word w
WHERE w.word_text = 'listen'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 106, 'Week 3 Day 1'
FROM word w
WHERE w.word_text = 'volleyball'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 107, 'Week 3 Day 1'
FROM word w
WHERE w.word_text = 'college'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 108, 'Week 3 Day 1'
FROM word w
WHERE w.word_text = 'moment'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 109, 'Week 3 Day 1'
FROM word w
WHERE w.word_text = 'repeat'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 110, 'Week 3 Day 1'
FROM word w
WHERE w.word_text = 'result'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 111, 'Week 3 Day 2'
FROM word w
WHERE w.word_text = 'link'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 112, 'Week 3 Day 2'
FROM word w
WHERE w.word_text = 'tennis'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 113, 'Week 3 Day 2'
FROM word w
WHERE w.word_text = 'key'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 114, 'Week 3 Day 2'
FROM word w
WHERE w.word_text = 'who'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 115, 'Week 3 Day 2'
FROM word w
WHERE w.word_text = 'interest'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 116, 'Week 3 Day 2'
FROM word w
WHERE w.word_text = 'queen'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 117, 'Week 3 Day 2'
FROM word w
WHERE w.word_text = 'play'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 118, 'Week 3 Day 2'
FROM word w
WHERE w.word_text = 'seldom'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 119, 'Week 3 Day 2'
FROM word w
WHERE w.word_text = 'relationship'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 120, 'Week 3 Day 2'
FROM word w
WHERE w.word_text = 'damage'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 121, 'Week 3 Day 3'
FROM word w
WHERE w.word_text = 'half'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 122, 'Week 3 Day 3'
FROM word w
WHERE w.word_text = 'focus'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 123, 'Week 3 Day 3'
FROM word w
WHERE w.word_text = 'upstairs'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 124, 'Week 3 Day 3'
FROM word w
WHERE w.word_text = 'call'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 125, 'Week 3 Day 3'
FROM word w
WHERE w.word_text = 'cabbage'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 126, 'Week 3 Day 3'
FROM word w
WHERE w.word_text = 'freedom'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 127, 'Week 3 Day 3'
FROM word w
WHERE w.word_text = 'pink'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 128, 'Week 3 Day 3'
FROM word w
WHERE w.word_text = 'memory'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 129, 'Week 3 Day 3'
FROM word w
WHERE w.word_text = 'temperature'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 130, 'Week 3 Day 3'
FROM word w
WHERE w.word_text = 'charity'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 131, 'Week 3 Day 4'
FROM word w
WHERE w.word_text = 'on'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 132, 'Week 3 Day 4'
FROM word w
WHERE w.word_text = 'post'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 133, 'Week 3 Day 4'
FROM word w
WHERE w.word_text = 'invention'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 134, 'Week 3 Day 4'
FROM word w
WHERE w.word_text = 'theatre'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 135, 'Week 3 Day 4'
FROM word w
WHERE w.word_text = 'check'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 136, 'Week 3 Day 4'
FROM word w
WHERE w.word_text = 'publish'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 137, 'Week 3 Day 4'
FROM word w
WHERE w.word_text = 'understand'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 138, 'Week 3 Day 4'
FROM word w
WHERE w.word_text = 'library'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 139, 'Week 3 Day 4'
FROM word w
WHERE w.word_text = 'better'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 140, 'Week 3 Day 4'
FROM word w
WHERE w.word_text = 'sad'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 141, 'Week 3 Day 5'
FROM word w
WHERE w.word_text = 'headache'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 142, 'Week 3 Day 5'
FROM word w
WHERE w.word_text = 'January'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 143, 'Week 3 Day 5'
FROM word w
WHERE w.word_text = 'lazy'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 144, 'Week 3 Day 5'
FROM word w
WHERE w.word_text = 'pretty'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 145, 'Week 3 Day 5'
FROM word w
WHERE w.word_text = 'red'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 146, 'Week 3 Day 5'
FROM word w
WHERE w.word_text = 'cat'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 147, 'Week 3 Day 5'
FROM word w
WHERE w.word_text = 'own'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 148, 'Week 3 Day 5'
FROM word w
WHERE w.word_text = 'farmer'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 149, 'Week 3 Day 5'
FROM word w
WHERE w.word_text = 'bite'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 150, 'Week 3 Day 5'
FROM word w
WHERE w.word_text = 'around'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 151, 'Week 4 Day 1'
FROM word w
WHERE w.word_text = 'increase'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 152, 'Week 4 Day 1'
FROM word w
WHERE w.word_text = 'empty'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 153, 'Week 4 Day 1'
FROM word w
WHERE w.word_text = 'tall'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 154, 'Week 4 Day 1'
FROM word w
WHERE w.word_text = 'room'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 155, 'Week 4 Day 1'
FROM word w
WHERE w.word_text = 'fair'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 156, 'Week 4 Day 1'
FROM word w
WHERE w.word_text = 'pollute'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 157, 'Week 4 Day 1'
FROM word w
WHERE w.word_text = 'duck'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 158, 'Week 4 Day 1'
FROM word w
WHERE w.word_text = 'underground'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 159, 'Week 4 Day 1'
FROM word w
WHERE w.word_text = 'fountain'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 160, 'Week 4 Day 1'
FROM word w
WHERE w.word_text = 'fill'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 161, 'Week 4 Day 2'
FROM word w
WHERE w.word_text = 'share'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 162, 'Week 4 Day 2'
FROM word w
WHERE w.word_text = 'shape'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 163, 'Week 4 Day 2'
FROM word w
WHERE w.word_text = 'water'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 164, 'Week 4 Day 2'
FROM word w
WHERE w.word_text = 'nationality'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 165, 'Week 4 Day 2'
FROM word w
WHERE w.word_text = 'success'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 166, 'Week 4 Day 2'
FROM word w
WHERE w.word_text = 'perhaps'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 167, 'Week 4 Day 2'
FROM word w
WHERE w.word_text = 'about'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 168, 'Week 4 Day 2'
FROM word w
WHERE w.word_text = 'know'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 169, 'Week 4 Day 2'
FROM word w
WHERE w.word_text = 'custom'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 170, 'Week 4 Day 2'
FROM word w
WHERE w.word_text = 'suppose'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 171, 'Week 4 Day 3'
FROM word w
WHERE w.word_text = 'noise'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 172, 'Week 4 Day 3'
FROM word w
WHERE w.word_text = 'rubbish'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 173, 'Week 4 Day 3'
FROM word w
WHERE w.word_text = 'advantage'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 174, 'Week 4 Day 3'
FROM word w
WHERE w.word_text = 'fit'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 175, 'Week 4 Day 3'
FROM word w
WHERE w.word_text = 'as'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 176, 'Week 4 Day 3'
FROM word w
WHERE w.word_text = 'corner'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 177, 'Week 4 Day 3'
FROM word w
WHERE w.word_text = 'part'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 178, 'Week 4 Day 3'
FROM word w
WHERE w.word_text = 'ancient'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 179, 'Week 4 Day 3'
FROM word w
WHERE w.word_text = 'activity'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 180, 'Week 4 Day 3'
FROM word w
WHERE w.word_text = 'Britain'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 181, 'Week 4 Day 4'
FROM word w
WHERE w.word_text = 'drink'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 182, 'Week 4 Day 4'
FROM word w
WHERE w.word_text = 'tree'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 183, 'Week 4 Day 4'
FROM word w
WHERE w.word_text = 'enough'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 184, 'Week 4 Day 4'
FROM word w
WHERE w.word_text = 'cheap'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 185, 'Week 4 Day 4'
FROM word w
WHERE w.word_text = 'between'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 186, 'Week 4 Day 4'
FROM word w
WHERE w.word_text = 'decide'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 187, 'Week 4 Day 4'
FROM word w
WHERE w.word_text = 'write'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 188, 'Week 4 Day 4'
FROM word w
WHERE w.word_text = 'can'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 189, 'Week 4 Day 4'
FROM word w
WHERE w.word_text = 'tape'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 190, 'Week 4 Day 4'
FROM word w
WHERE w.word_text = 'captain'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 191, 'Week 4 Day 5'
FROM word w
WHERE w.word_text = 'middle'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 192, 'Week 4 Day 5'
FROM word w
WHERE w.word_text = 'chair'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 193, 'Week 4 Day 5'
FROM word w
WHERE w.word_text = 'meal'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 194, 'Week 4 Day 5'
FROM word w
WHERE w.word_text = 'heavily'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 195, 'Week 4 Day 5'
FROM word w
WHERE w.word_text = 'beach'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 196, 'Week 4 Day 5'
FROM word w
WHERE w.word_text = 'like'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 197, 'Week 4 Day 5'
FROM word w
WHERE w.word_text = 'argue'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 198, 'Week 4 Day 5'
FROM word w
WHERE w.word_text = 'certainly'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 199, 'Week 4 Day 5'
FROM word w
WHERE w.word_text = 'Saturday'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 200, 'Week 4 Day 5'
FROM word w
WHERE w.word_text = 'food'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 201, 'Week 5 Day 1'
FROM word w
WHERE w.word_text = 'left'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 202, 'Week 5 Day 1'
FROM word w
WHERE w.word_text = 'amusement'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 203, 'Week 5 Day 1'
FROM word w
WHERE w.word_text = 'aim'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 204, 'Week 5 Day 1'
FROM word w
WHERE w.word_text = 'connect'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 205, 'Week 5 Day 1'
FROM word w
WHERE w.word_text = 'May'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 206, 'Week 5 Day 1'
FROM word w
WHERE w.word_text = 'basketball'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 207, 'Week 5 Day 1'
FROM word w
WHERE w.word_text = 'smell'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 208, 'Week 5 Day 1'
FROM word w
WHERE w.word_text = 'dream'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 209, 'Week 5 Day 1'
FROM word w
WHERE w.word_text = 'hour'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 210, 'Week 5 Day 1'
FROM word w
WHERE w.word_text = 'litter'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 211, 'Week 5 Day 2'
FROM word w
WHERE w.word_text = 'fireman'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 212, 'Week 5 Day 2'
FROM word w
WHERE w.word_text = 'other'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 213, 'Week 5 Day 2'
FROM word w
WHERE w.word_text = 'automatic'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 214, 'Week 5 Day 2'
FROM word w
WHERE w.word_text = 'pot'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 215, 'Week 5 Day 2'
FROM word w
WHERE w.word_text = 'outdoor'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 216, 'Week 5 Day 2'
FROM word w
WHERE w.word_text = 'gentle'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 217, 'Week 5 Day 2'
FROM word w
WHERE w.word_text = 'above'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 218, 'Week 5 Day 2'
FROM word w
WHERE w.word_text = 'exam'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 219, 'Week 5 Day 2'
FROM word w
WHERE w.word_text = 'course'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 220, 'Week 5 Day 2'
FROM word w
WHERE w.word_text = 'manner'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 221, 'Week 5 Day 3'
FROM word w
WHERE w.word_text = 'eat'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 222, 'Week 5 Day 3'
FROM word w
WHERE w.word_text = 'news'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 223, 'Week 5 Day 3'
FROM word w
WHERE w.word_text = 'customer'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 224, 'Week 5 Day 3'
FROM word w
WHERE w.word_text = 'tea'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 225, 'Week 5 Day 3'
FROM word w
WHERE w.word_text = 'close'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 226, 'Week 5 Day 3'
FROM word w
WHERE w.word_text = 'pearl'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 227, 'Week 5 Day 3'
FROM word w
WHERE w.word_text = 'windy'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 228, 'Week 5 Day 3'
FROM word w
WHERE w.word_text = 'roast'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 229, 'Week 5 Day 3'
FROM word w
WHERE w.word_text = 'act'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 230, 'Week 5 Day 3'
FROM word w
WHERE w.word_text = 'magazine'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 231, 'Week 5 Day 4'
FROM word w
WHERE w.word_text = 'general'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 232, 'Week 5 Day 4'
FROM word w
WHERE w.word_text = 'situation'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 233, 'Week 5 Day 4'
FROM word w
WHERE w.word_text = 'create'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 234, 'Week 5 Day 4'
FROM word w
WHERE w.word_text = 'weak'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 235, 'Week 5 Day 4'
FROM word w
WHERE w.word_text = 'sentence'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 236, 'Week 5 Day 4'
FROM word w
WHERE w.word_text = 'laugh'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 237, 'Week 5 Day 4'
FROM word w
WHERE w.word_text = 'shirt'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 238, 'Week 5 Day 4'
FROM word w
WHERE w.word_text = 'golden'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 239, 'Week 5 Day 4'
FROM word w
WHERE w.word_text = 'jeans'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 240, 'Week 5 Day 4'
FROM word w
WHERE w.word_text = 'recent'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 241, 'Week 5 Day 5'
FROM word w
WHERE w.word_text = 'lunch'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 242, 'Week 5 Day 5'
FROM word w
WHERE w.word_text = 'luggage'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 243, 'Week 5 Day 5'
FROM word w
WHERE w.word_text = 'block'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 244, 'Week 5 Day 5'
FROM word w
WHERE w.word_text = 'pineapple'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 245, 'Week 5 Day 5'
FROM word w
WHERE w.word_text = 'market'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 246, 'Week 5 Day 5'
FROM word w
WHERE w.word_text = 'France'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 247, 'Week 5 Day 5'
FROM word w
WHERE w.word_text = 'clothes'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 248, 'Week 5 Day 5'
FROM word w
WHERE w.word_text = 'juice'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 249, 'Week 5 Day 5'
FROM word w
WHERE w.word_text = 'survey'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 250, 'Week 5 Day 5'
FROM word w
WHERE w.word_text = 'precious'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 251, 'Week 6 Day 1'
FROM word w
WHERE w.word_text = 'partner'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 252, 'Week 6 Day 1'
FROM word w
WHERE w.word_text = 'boil'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 253, 'Week 6 Day 1'
FROM word w
WHERE w.word_text = 'railway'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 254, 'Week 6 Day 1'
FROM word w
WHERE w.word_text = 'reduce'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 255, 'Week 6 Day 1'
FROM word w
WHERE w.word_text = 'few'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 256, 'Week 6 Day 1'
FROM word w
WHERE w.word_text = 'angrily'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 257, 'Week 6 Day 1'
FROM word w
WHERE w.word_text = 'exercise'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 258, 'Week 6 Day 1'
FROM word w
WHERE w.word_text = 'sandwich'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 259, 'Week 6 Day 1'
FROM word w
WHERE w.word_text = 'inside'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 260, 'Week 6 Day 1'
FROM word w
WHERE w.word_text = 'dollar'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 261, 'Week 6 Day 2'
FROM word w
WHERE w.word_text = 'Monday'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 262, 'Week 6 Day 2'
FROM word w
WHERE w.word_text = 'similar'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 263, 'Week 6 Day 2'
FROM word w
WHERE w.word_text = 'autumn'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 264, 'Week 6 Day 2'
FROM word w
WHERE w.word_text = 'holiday'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 265, 'Week 6 Day 2'
FROM word w
WHERE w.word_text = 'require'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 266, 'Week 6 Day 2'
FROM word w
WHERE w.word_text = 'forward'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 267, 'Week 6 Day 2'
FROM word w
WHERE w.word_text = 'bright'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 268, 'Week 6 Day 2'
FROM word w
WHERE w.word_text = 'careful'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 269, 'Week 6 Day 2'
FROM word w
WHERE w.word_text = 'visitor'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 270, 'Week 6 Day 2'
FROM word w
WHERE w.word_text = 'must'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 271, 'Week 6 Day 3'
FROM word w
WHERE w.word_text = 'twin'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 272, 'Week 6 Day 3'
FROM word w
WHERE w.word_text = 'point'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 273, 'Week 6 Day 3'
FROM word w
WHERE w.word_text = 'basket'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 274, 'Week 6 Day 3'
FROM word w
WHERE w.word_text = 'conclusion'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 275, 'Week 6 Day 3'
FROM word w
WHERE w.word_text = 'stomachache'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 276, 'Week 6 Day 3'
FROM word w
WHERE w.word_text = 'hurry'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 277, 'Week 6 Day 3'
FROM word w
WHERE w.word_text = 'Wednesday'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 278, 'Week 6 Day 3'
FROM word w
WHERE w.word_text = 'conversation'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 279, 'Week 6 Day 3'
FROM word w
WHERE w.word_text = 'leave'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 280, 'Week 6 Day 3'
FROM word w
WHERE w.word_text = 'wide'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 281, 'Week 6 Day 4'
FROM word w
WHERE w.word_text = 'interested'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 282, 'Week 6 Day 4'
FROM word w
WHERE w.word_text = 'teacher'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 283, 'Week 6 Day 4'
FROM word w
WHERE w.word_text = 'happily'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 284, 'Week 6 Day 4'
FROM word w
WHERE w.word_text = 'envelope'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 285, 'Week 6 Day 4'
FROM word w
WHERE w.word_text = 'light'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 286, 'Week 6 Day 4'
FROM word w
WHERE w.word_text = 'September'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 287, 'Week 6 Day 4'
FROM word w
WHERE w.word_text = 'settle'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 288, 'Week 6 Day 4'
FROM word w
WHERE w.word_text = 'disappointed'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 289, 'Week 6 Day 4'
FROM word w
WHERE w.word_text = 'habit'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 290, 'Week 6 Day 4'
FROM word w
WHERE w.word_text = 'pound'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 291, 'Week 6 Day 5'
FROM word w
WHERE w.word_text = 'bear'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 292, 'Week 6 Day 5'
FROM word w
WHERE w.word_text = 'skate'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 293, 'Week 6 Day 5'
FROM word w
WHERE w.word_text = 'dress'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 294, 'Week 6 Day 5'
FROM word w
WHERE w.word_text = 'safe'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 295, 'Week 6 Day 5'
FROM word w
WHERE w.word_text = 'leg'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 296, 'Week 6 Day 5'
FROM word w
WHERE w.word_text = 'wrong'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 297, 'Week 6 Day 5'
FROM word w
WHERE w.word_text = 'length'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 298, 'Week 6 Day 5'
FROM word w
WHERE w.word_text = 'but'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 299, 'Week 6 Day 5'
FROM word w
WHERE w.word_text = 'deliver'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 300, 'Week 6 Day 5'
FROM word w
WHERE w.word_text = 'angry'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 301, 'Week 7 Day 1'
FROM word w
WHERE w.word_text = 'service'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 302, 'Week 7 Day 1'
FROM word w
WHERE w.word_text = 'spread'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 303, 'Week 7 Day 1'
FROM word w
WHERE w.word_text = 'loudly'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 304, 'Week 7 Day 1'
FROM word w
WHERE w.word_text = 'toy'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 305, 'Week 7 Day 1'
FROM word w
WHERE w.word_text = 'sightseeing'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 306, 'Week 7 Day 1'
FROM word w
WHERE w.word_text = 'cigarette'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 307, 'Week 7 Day 1'
FROM word w
WHERE w.word_text = 'gently'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 308, 'Week 7 Day 1'
FROM word w
WHERE w.word_text = 'since'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 309, 'Week 7 Day 1'
FROM word w
WHERE w.word_text = 'pool'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 310, 'Week 7 Day 1'
FROM word w
WHERE w.word_text = 'strong'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 311, 'Week 7 Day 2'
FROM word w
WHERE w.word_text = 'count'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 312, 'Week 7 Day 2'
FROM word w
WHERE w.word_text = 'dry'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 313, 'Week 7 Day 2'
FROM word w
WHERE w.word_text = 'comfortable'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 314, 'Week 7 Day 2'
FROM word w
WHERE w.word_text = 'while'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 315, 'Week 7 Day 2'
FROM word w
WHERE w.word_text = 'have'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 316, 'Week 7 Day 2'
FROM word w
WHERE w.word_text = 'produce'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 317, 'Week 7 Day 2'
FROM word w
WHERE w.word_text = 'baby'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 318, 'Week 7 Day 2'
FROM word w
WHERE w.word_text = 'allow'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 319, 'Week 7 Day 2'
FROM word w
WHERE w.word_text = 'freezing'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 320, 'Week 7 Day 2'
FROM word w
WHERE w.word_text = 'choice'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 321, 'Week 7 Day 3'
FROM word w
WHERE w.word_text = 'little'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 322, 'Week 7 Day 3'
FROM word w
WHERE w.word_text = 'heat'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 323, 'Week 7 Day 3'
FROM word w
WHERE w.word_text = 'friendship'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 324, 'Week 7 Day 3'
FROM word w
WHERE w.word_text = 'discover'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 325, 'Week 7 Day 3'
FROM word w
WHERE w.word_text = 'pencil'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 326, 'Week 7 Day 3'
FROM word w
WHERE w.word_text = 'strange'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 327, 'Week 7 Day 3'
FROM word w
WHERE w.word_text = 'lesson'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 328, 'Week 7 Day 3'
FROM word w
WHERE w.word_text = 'end'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 329, 'Week 7 Day 3'
FROM word w
WHERE w.word_text = 'various'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 330, 'Week 7 Day 3'
FROM word w
WHERE w.word_text = 'quick'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 331, 'Week 7 Day 4'
FROM word w
WHERE w.word_text = 'film'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 332, 'Week 7 Day 4'
FROM word w
WHERE w.word_text = 'owner'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 333, 'Week 7 Day 4'
FROM word w
WHERE w.word_text = 'debate'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 334, 'Week 7 Day 4'
FROM word w
WHERE w.word_text = 'brave'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 335, 'Week 7 Day 4'
FROM word w
WHERE w.word_text = 'terrible'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 336, 'Week 7 Day 4'
FROM word w
WHERE w.word_text = 'technology'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 337, 'Week 7 Day 4'
FROM word w
WHERE w.word_text = 'once'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 338, 'Week 7 Day 4'
FROM word w
WHERE w.word_text = 'education'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 339, 'Week 7 Day 4'
FROM word w
WHERE w.word_text = 'garden'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 340, 'Week 7 Day 4'
FROM word w
WHERE w.word_text = 'detail'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 341, 'Week 7 Day 5'
FROM word w
WHERE w.word_text = 'tour'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 342, 'Week 7 Day 5'
FROM word w
WHERE w.word_text = 'borrow'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 343, 'Week 7 Day 5'
FROM word w
WHERE w.word_text = 'club'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 344, 'Week 7 Day 5'
FROM word w
WHERE w.word_text = 'educational'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 345, 'Week 7 Day 5'
FROM word w
WHERE w.word_text = 'sweet'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 346, 'Week 7 Day 5'
FROM word w
WHERE w.word_text = 'each'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 347, 'Week 7 Day 5'
FROM word w
WHERE w.word_text = 'cycle'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 348, 'Week 7 Day 5'
FROM word w
WHERE w.word_text = 'rain'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 349, 'Week 7 Day 5'
FROM word w
WHERE w.word_text = 'ever'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 350, 'Week 7 Day 5'
FROM word w
WHERE w.word_text = 'shout'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 351, 'Week 8 Day 1'
FROM word w
WHERE w.word_text = 'umbrella'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 352, 'Week 8 Day 1'
FROM word w
WHERE w.word_text = 'impossible'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 353, 'Week 8 Day 1'
FROM word w
WHERE w.word_text = 'dishonest'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 354, 'Week 8 Day 1'
FROM word w
WHERE w.word_text = 'very'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 355, 'Week 8 Day 1'
FROM word w
WHERE w.word_text = 'add'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 356, 'Week 8 Day 1'
FROM word w
WHERE w.word_text = 'tooth'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 357, 'Week 8 Day 1'
FROM word w
WHERE w.word_text = 'rice'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 358, 'Week 8 Day 1'
FROM word w
WHERE w.word_text = 'illness'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 359, 'Week 8 Day 1'
FROM word w
WHERE w.word_text = 'beg'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 360, 'Week 8 Day 1'
FROM word w
WHERE w.word_text = 'wear'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 361, 'Week 8 Day 2'
FROM word w
WHERE w.word_text = 'joy'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 362, 'Week 8 Day 2'
FROM word w
WHERE w.word_text = 'card'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 363, 'Week 8 Day 2'
FROM word w
WHERE w.word_text = 'always'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 364, 'Week 8 Day 2'
FROM word w
WHERE w.word_text = 'deep'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 365, 'Week 8 Day 2'
FROM word w
WHERE w.word_text = 'pioneer'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 366, 'Week 8 Day 2'
FROM word w
WHERE w.word_text = 'accept'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 367, 'Week 8 Day 2'
FROM word w
WHERE w.word_text = 'way'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 368, 'Week 8 Day 2'
FROM word w
WHERE w.word_text = 'discussion'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 369, 'Week 8 Day 2'
FROM word w
WHERE w.word_text = 'respect'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 370, 'Week 8 Day 2'
FROM word w
WHERE w.word_text = 'everywhere'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 371, 'Week 8 Day 3'
FROM word w
WHERE w.word_text = 'within'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 372, 'Week 8 Day 3'
FROM word w
WHERE w.word_text = 'animal'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 373, 'Week 8 Day 3'
FROM word w
WHERE w.word_text = 'nurse'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 374, 'Week 8 Day 3'
FROM word w
WHERE w.word_text = 'title'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 375, 'Week 8 Day 3'
FROM word w
WHERE w.word_text = 'per'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 376, 'Week 8 Day 3'
FROM word w
WHERE w.word_text = 'disturb'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 377, 'Week 8 Day 3'
FROM word w
WHERE w.word_text = 'beautifully'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 378, 'Week 8 Day 3'
FROM word w
WHERE w.word_text = 'equal'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 379, 'Week 8 Day 3'
FROM word w
WHERE w.word_text = 'immediately'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 380, 'Week 8 Day 3'
FROM word w
WHERE w.word_text = 'salad'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 381, 'Week 8 Day 4'
FROM word w
WHERE w.word_text = 'ahead'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 382, 'Week 8 Day 4'
FROM word w
WHERE w.word_text = 'goal'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 383, 'Week 8 Day 4'
FROM word w
WHERE w.word_text = 'hard'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 384, 'Week 8 Day 4'
FROM word w
WHERE w.word_text = 'price'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 385, 'Week 8 Day 4'
FROM word w
WHERE w.word_text = 'keep'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 386, 'Week 8 Day 4'
FROM word w
WHERE w.word_text = 'nervous'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 387, 'Week 8 Day 4'
FROM word w
WHERE w.word_text = 'properly'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 388, 'Week 8 Day 4'
FROM word w
WHERE w.word_text = 'kid'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 389, 'Week 8 Day 4'
FROM word w
WHERE w.word_text = 'through'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 390, 'Week 8 Day 4'
FROM word w
WHERE w.word_text = 'kitchen'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 391, 'Week 8 Day 5'
FROM word w
WHERE w.word_text = 'land'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 392, 'Week 8 Day 5'
FROM word w
WHERE w.word_text = 'till'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 393, 'Week 8 Day 5'
FROM word w
WHERE w.word_text = 'put'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 394, 'Week 8 Day 5'
FROM word w
WHERE w.word_text = 'wall'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 395, 'Week 8 Day 5'
FROM word w
WHERE w.word_text = 'fever'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 396, 'Week 8 Day 5'
FROM word w
WHERE w.word_text = 'Mr'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 397, 'Week 8 Day 5'
FROM word w
WHERE w.word_text = 'camera'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 398, 'Week 8 Day 5'
FROM word w
WHERE w.word_text = 'patient'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 399, 'Week 8 Day 5'
FROM word w
WHERE w.word_text = 'inventor'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

INSERT INTO word_book_item (book_id, word_id, sort_order, unit_name)
SELECT 2, w.id, 400, 'Week 8 Day 5'
FROM word w
WHERE w.word_text = 'there'
  AND NOT EXISTS (
      SELECT 1 FROM word_book_item i
      WHERE i.book_id = 2 AND i.word_id = w.id
  );

-- 4. 回写词书单词数量
UPDATE word_book
SET word_count = (SELECT COUNT(*) FROM word_book_item WHERE book_id = 2),
    updated_at = NOW()
WHERE id = 2;
