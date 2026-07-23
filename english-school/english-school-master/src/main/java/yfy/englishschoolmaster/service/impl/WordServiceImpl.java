package yfy.englishschoolmaster.service.impl;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.StrUtil;
import com.mybatisflex.core.query.QueryWrapper;
import com.mybatisflex.spring.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import yfy.englishschoolmaster.exception.ErrorCode;
import yfy.englishschoolmaster.exception.ThrowUtils;
import yfy.englishschoolmaster.mapper.WordMapper;
import yfy.englishschoolmaster.model.dto.WordBook.WordImportItem;
import yfy.englishschoolmaster.model.entity.Word;
import yfy.englishschoolmaster.service.WordOptionService;
import yfy.englishschoolmaster.service.WordService;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

/**
 * 单词基础数据表 服务层实现（纯手工录入，无机器翻译）。
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
@Service
public class WordServiceImpl extends ServiceImpl<WordMapper, Word> implements WordService {

    private static final int WRONG_OPTION_COUNT = 3;

    private final WordOptionService wordOptionService;

    public WordServiceImpl(WordOptionService wordOptionService) {
        this.wordOptionService = wordOptionService;
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
}
