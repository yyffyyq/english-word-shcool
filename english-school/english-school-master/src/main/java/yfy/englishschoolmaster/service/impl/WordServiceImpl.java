package yfy.englishschoolmaster.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.StrUtil;
import com.mybatisflex.core.query.QueryWrapper;
import com.mybatisflex.spring.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import yfy.englishschoolmaster.constant.UserConstant;
import yfy.englishschoolmaster.exception.ErrorCode;
import yfy.englishschoolmaster.exception.ThrowUtils;
import yfy.englishschoolmaster.mapper.WordBookMapper;
import yfy.englishschoolmaster.mapper.WordMapper;
import yfy.englishschoolmaster.model.dto.Word.WordUpdateRequest;
import yfy.englishschoolmaster.model.dto.WordBook.WordImportItem;
import yfy.englishschoolmaster.model.entity.Word;
import yfy.englishschoolmaster.model.entity.WordBook;
import yfy.englishschoolmaster.model.entity.WordBookItem;
import yfy.englishschoolmaster.model.entity.WordOption;
import yfy.englishschoolmaster.model.vo.UserAccountVO;
import yfy.englishschoolmaster.model.vo.WordOptionVO;
import yfy.englishschoolmaster.model.vo.WordVO;
import yfy.englishschoolmaster.service.WordBookItemService;
import yfy.englishschoolmaster.service.WordOptionService;
import yfy.englishschoolmaster.service.WordService;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * 单词基础数据表 服务层实现（纯手工录入，无机器翻译）。
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
@Service
public class WordServiceImpl extends ServiceImpl<WordMapper, Word> implements WordService {

    private static final int WRONG_OPTION_COUNT = 3;

    private final WordOptionService wordOptionService;
    private final WordBookItemService wordBookItemService;
    private final WordBookMapper wordBookMapper;

    public WordServiceImpl(WordOptionService wordOptionService,
                           WordBookItemService wordBookItemService,
                           WordBookMapper wordBookMapper) {
        this.wordOptionService = wordOptionService;
        this.wordBookItemService = wordBookItemService;
        this.wordBookMapper = wordBookMapper;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Word enrichAndSave(WordImportItem item) {
        // 1. 参数校验
        ThrowUtils.throwIf(item == null, ErrorCode.PARAMS_ERROR, "单词条目为空");
        ThrowUtils.throwIf(StrUtil.isBlank(item.getWordText()), ErrorCode.PARAMS_ERROR, "英文单词不能为空");
        ThrowUtils.throwIf(StrUtil.isBlank(item.getPhonetic()), ErrorCode.PARAMS_ERROR, "音标不能为空");
        ThrowUtils.throwIf(StrUtil.isBlank(item.getCorrectMeaning()), ErrorCode.PARAMS_ERROR, "正确中文释义不能为空");
        ThrowUtils.throwIf(StrUtil.isBlank(item.getExampleSentence()), ErrorCode.PARAMS_ERROR, "英文例句不能为空");
        ThrowUtils.throwIf(StrUtil.isBlank(item.getExampleTranslation()), ErrorCode.PARAMS_ERROR, "例句中文翻译不能为空");

        List<String> wrongMeanings = normalizeWrongMeanings(item.getWrongMeanings(), item.getCorrectMeaning().trim());

        String wordText = normalizeWordText(item.getWordText());
        String phonetic = item.getPhonetic().trim();
        String correctMeaning = item.getCorrectMeaning().trim();
        String exampleSentence = item.getExampleSentence().trim();
        String exampleTranslation = item.getExampleTranslation().trim();

        // 2. 按英文单词查询是否已存在
        Word word = this.getOne(QueryWrapper.create().eq(Word::getWordText, wordText));
        LocalDateTime now = LocalDateTime.now();

        if (word == null) {
            // 3a. 新词落库
            word = Word.builder()
                    .wordText(wordText)
                    .phonetic(phonetic)
                    .correctMeaning(correctMeaning)
                    .exampleSentence(exampleSentence)
                    .exampleTranslation(exampleTranslation)
                    .createdAt(now)
                    .updatedAt(now)
                    .build();
            boolean saved = this.save(word);
            ThrowUtils.throwIf(!saved, ErrorCode.OPERATION_ERROR, "保存单词失败");
            wordOptionService.replaceOptions(word.getId(), correctMeaning, wrongMeanings);
            return word;
        }

        // 3b. 已存在：只补齐缺失字段，不覆盖已有内容
        boolean dirty = false;
        if (StrUtil.isBlank(word.getPhonetic())) {
            word.setPhonetic(phonetic);
            dirty = true;
        }
        if (StrUtil.isBlank(word.getCorrectMeaning())) {
            word.setCorrectMeaning(correctMeaning);
            dirty = true;
        }
        if (StrUtil.isBlank(word.getExampleSentence())) {
            word.setExampleSentence(exampleSentence);
            dirty = true;
        }
        if (StrUtil.isBlank(word.getExampleTranslation())) {
            word.setExampleTranslation(exampleTranslation);
            dirty = true;
        }
        if (dirty) {
            word.setUpdatedAt(now);
            boolean updated = this.updateById(word);
            ThrowUtils.throwIf(!updated, ErrorCode.OPERATION_ERROR, "更新单词失败");
        }

        // 4. 选项不完整时写入四选一
        if (!wordOptionService.hasCompleteOptions(word.getId())) {
            String meaning = StrUtil.blankToDefault(word.getCorrectMeaning(), correctMeaning);
            wordOptionService.replaceOptions(word.getId(), meaning, wrongMeanings);
        }
        return word;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public WordVO updateWord(WordUpdateRequest request, UserAccountVO loginUser) {
        // 1. 参数与权限校验
        checkTeacherOrAdmin(loginUser);
        ThrowUtils.throwIf(request == null, ErrorCode.PARAMS_ERROR, "修改单词请求为空");
        ThrowUtils.throwIf(request.getId() == null || request.getId() <= 0, ErrorCode.PARAMS_ERROR, "单词ID不合法");

        // 2. 查询原单词
        Word word = this.getById(request.getId());
        ThrowUtils.throwIf(word == null, ErrorCode.NOT_FOUND_ERROR, "单词不存在");

        // 3. 按需更新字段
        boolean dirty = false;
        if (StrUtil.isNotBlank(request.getWordText())) {
            String wordText = normalizeWordText(request.getWordText());
            Word existWord = this.getOne(QueryWrapper.create()
                    .eq(Word::getWordText, wordText)
                    .ne(Word::getId, request.getId()));
            ThrowUtils.throwIf(existWord != null, ErrorCode.OPERATION_ERROR, "英文单词已存在");
            word.setWordText(wordText);
            dirty = true;
        }
        if (StrUtil.isNotBlank(request.getPhonetic())) {
            word.setPhonetic(request.getPhonetic().trim());
            dirty = true;
        }
        if (StrUtil.isNotBlank(request.getCorrectMeaning())) {
            word.setCorrectMeaning(request.getCorrectMeaning().trim());
            dirty = true;
        }
        if (StrUtil.isNotBlank(request.getExampleSentence())) {
            word.setExampleSentence(request.getExampleSentence().trim());
            dirty = true;
        }
        if (StrUtil.isNotBlank(request.getExampleTranslation())) {
            word.setExampleTranslation(request.getExampleTranslation().trim());
            dirty = true;
        }

        boolean replaceOptions = CollUtil.isNotEmpty(request.getWrongMeanings())
                || StrUtil.isNotBlank(request.getCorrectMeaning());
        if (replaceOptions) {
            // 覆盖选项时：正确释义以当前单词最终值为准，错误项必须传满 3 个
            ThrowUtils.throwIf(CollUtil.isEmpty(request.getWrongMeanings()),
                    ErrorCode.PARAMS_ERROR, "更新选项时需同时传入 3 个错误中文释义");
            List<String> wrongMeanings = normalizeWrongMeanings(
                    request.getWrongMeanings(),
                    word.getCorrectMeaning()
            );
            wordOptionService.replaceOptions(word.getId(), word.getCorrectMeaning(), wrongMeanings);
        }

        if (dirty) {
            word.setUpdatedAt(LocalDateTime.now());
            boolean updated = this.updateById(word);
            ThrowUtils.throwIf(!updated, ErrorCode.OPERATION_ERROR, "修改单词失败");
        }

        return toWordVO(word);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean deleteWordPhysically(Long id, UserAccountVO loginUser) {
        // 1. 参数与权限校验
        checkTeacherOrAdmin(loginUser);
        ThrowUtils.throwIf(id == null || id <= 0, ErrorCode.PARAMS_ERROR, "单词ID不合法");

        Word word = this.getById(id);
        ThrowUtils.throwIf(word == null, ErrorCode.NOT_FOUND_ERROR, "单词不存在");

        // 2. 记录受影响词书，便于删除关联后回写 word_count
        List<WordBookItem> relatedItems = wordBookItemService.list(QueryWrapper.create()
                .eq(WordBookItem::getWordId, id));
        Set<Long> affectedBookIds = relatedItems.stream()
                .map(WordBookItem::getBookId)
                .filter(Objects::nonNull)
                .collect(Collectors.toSet());

        // 3. 物理删除：选项 → 词书关联 → 单词主表（WordMapper.xml）
        this.getMapper().deleteWordOptionsByWordId(id);
        this.getMapper().deleteWordBookItemsByWordId(id);
        int deleted = this.getMapper().deleteWordById(id);
        ThrowUtils.throwIf(deleted <= 0, ErrorCode.OPERATION_ERROR, "删除单词失败");

        // 4. 回写受影响词书的单词数量
        LocalDateTime now = LocalDateTime.now();
        for (Long bookId : affectedBookIds) {
            WordBook wordBook = wordBookMapper.selectOneById(bookId);
            if (wordBook == null) {
                continue;
            }
            long count = wordBookItemService.countByBookId(bookId);
            wordBook.setWordCount((int) count);
            wordBook.setUpdatedAt(now);
            wordBookMapper.update(wordBook);
        }
        return true;
    }

    /**
     * 校验当前用户为教师或管理员
     */
    private void checkTeacherOrAdmin(UserAccountVO loginUser) {
        ThrowUtils.throwIf(loginUser == null || loginUser.getId() == null, ErrorCode.NOT_LOGIN_ERROR, "未登录");
        String role = loginUser.getRole();
        boolean isAdmin = UserConstant.ADMIN_ROLE.equalsIgnoreCase(role);
        boolean isTeacher = UserConstant.TEACHER_ROLE.equalsIgnoreCase(role);
        ThrowUtils.throwIf(!isAdmin && !isTeacher, ErrorCode.NO_AUTH_ERROR, "仅教师或管理员可操作单词");
    }

    /**
     * 校验并规范化 3 个错误中文释义。
     */
    private List<String> normalizeWrongMeanings(List<String> requestWrong, String correctMeaning) {
        ThrowUtils.throwIf(CollUtil.isEmpty(requestWrong), ErrorCode.PARAMS_ERROR, "错误中文释义不能为空");
        Set<String> result = new LinkedHashSet<>();
        for (String wrong : requestWrong) {
            ThrowUtils.throwIf(StrUtil.isBlank(wrong), ErrorCode.PARAMS_ERROR, "错误中文释义不能为空");
            String text = wrong.trim();
            ThrowUtils.throwIf(text.equals(correctMeaning), ErrorCode.PARAMS_ERROR, "错误释义不能与正确释义相同");
            result.add(text);
        }
        ThrowUtils.throwIf(result.size() != WRONG_OPTION_COUNT,
                ErrorCode.PARAMS_ERROR, "需要恰好提供 " + WRONG_OPTION_COUNT + " 个互不相同的错误中文释义");
        return new ArrayList<>(result);
    }

    /**
     * 单词文本标准化：trim 并转小写，避免同一单词因大小写重复入库。
     */
    private static String normalizeWordText(String wordText) {
        return wordText.trim().toLowerCase();
    }

    private WordVO toWordVO(Word word) {
        WordVO wordVO = new WordVO();
        BeanUtil.copyProperties(word, wordVO);
        List<WordOption> options = wordOptionService.listByWordId(word.getId());
        if (CollUtil.isEmpty(options)) {
            wordVO.setOptions(Collections.emptyList());
            return wordVO;
        }
        List<WordOptionVO> optionVOList = options.stream().map(option -> {
            WordOptionVO optionVO = new WordOptionVO();
            BeanUtil.copyProperties(option, optionVO);
            return optionVO;
        }).toList();
        wordVO.setOptions(optionVOList);
        return wordVO;
    }
}
