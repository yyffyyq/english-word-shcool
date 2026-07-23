package yfy.englishschoolmaster.service.impl;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.StrUtil;
import com.mybatisflex.core.query.QueryWrapper;
import com.mybatisflex.spring.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import yfy.englishschoolmaster.exception.ErrorCode;
import yfy.englishschoolmaster.exception.ThrowUtils;
import yfy.englishschoolmaster.mapper.WordOptionMapper;
import yfy.englishschoolmaster.model.entity.WordOption;
import yfy.englishschoolmaster.service.WordOptionService;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * 单词中文选项表 服务层实现。
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
@Service
public class WordOptionServiceImpl extends ServiceImpl<WordOptionMapper, WordOption>
        implements WordOptionService {

    private static final int CORRECT_FLAG = 1;
    private static final int WRONG_FLAG = 0;
    private static final int WRONG_OPTION_COUNT = 3;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void replaceOptions(Long wordId, String correctMeaning, List<String> wrongMeanings) {
        ThrowUtils.throwIf(wordId == null || wordId <= 0, ErrorCode.PARAMS_ERROR, "单词ID不合法");
        ThrowUtils.throwIf(StrUtil.isBlank(correctMeaning), ErrorCode.PARAMS_ERROR, "正确中文释义不能为空");
        ThrowUtils.throwIf(CollUtil.isEmpty(wrongMeanings) || wrongMeanings.size() != WRONG_OPTION_COUNT,
                ErrorCode.PARAMS_ERROR, "需要恰好 3 个错误中文释义");

        this.remove(QueryWrapper.create().eq(WordOption::getWordId, wordId));

        LocalDateTime now = LocalDateTime.now();
        List<WordOption> options = new ArrayList<>(4);
        options.add(WordOption.builder()
                .wordId(wordId)
                .optionText(correctMeaning.trim())
                .isCorrect(CORRECT_FLAG)
                .sortOrder(0)
                .createdAt(now)
                .updatedAt(now)
                .build());

        int sort = 1;
        for (String wrong : wrongMeanings) {
            ThrowUtils.throwIf(StrUtil.isBlank(wrong), ErrorCode.PARAMS_ERROR, "错误中文释义不能为空");
            String text = wrong.trim();
            ThrowUtils.throwIf(text.equals(correctMeaning.trim()), ErrorCode.PARAMS_ERROR, "错误释义不能与正确释义相同");
            options.add(WordOption.builder()
                    .wordId(wordId)
                    .optionText(text)
                    .isCorrect(WRONG_FLAG)
                    .sortOrder(sort++)
                    .createdAt(now)
                    .updatedAt(now)
                    .build());
        }

        boolean saved = this.saveBatch(options);
        ThrowUtils.throwIf(!saved, ErrorCode.OPERATION_ERROR, "保存单词选项失败");
    }

    @Override
    public List<WordOption> listByWordId(Long wordId) {
        return this.list(QueryWrapper.create()
                .eq(WordOption::getWordId, wordId)
                .orderBy(WordOption::getSortOrder, true));
    }

    @Override
    public boolean hasCompleteOptions(Long wordId) {
        List<WordOption> options = listByWordId(wordId);
        if (options.size() != 4) {
            return false;
        }
        long correctCount = options.stream().filter(o -> CORRECT_FLAG == o.getIsCorrect()).count();
        long wrongCount = options.stream().filter(o -> WRONG_FLAG == o.getIsCorrect()).count();
        return correctCount == 1 && wrongCount == 3;
    }
}
