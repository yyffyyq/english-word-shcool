package yfy.englishschoolmaster.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.StrUtil;
import com.mybatisflex.core.paginate.Page;
import com.mybatisflex.core.query.QueryWrapper;
import com.mybatisflex.spring.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import yfy.englishschoolmaster.constant.UserConstant;
import yfy.englishschoolmaster.exception.ErrorCode;
import yfy.englishschoolmaster.exception.ThrowUtils;
import yfy.englishschoolmaster.mapper.WordBookMapper;
import yfy.englishschoolmaster.model.dto.WordBook.WordBookAddRequest;
import yfy.englishschoolmaster.model.dto.WordBook.WordBookImportRequest;
import yfy.englishschoolmaster.model.dto.WordBook.WordBookQueryRequest;
import yfy.englishschoolmaster.model.dto.WordBook.WordBookUpdateRequest;
import yfy.englishschoolmaster.model.dto.WordBook.WordImportItem;
import yfy.englishschoolmaster.model.entity.Word;
import yfy.englishschoolmaster.model.entity.WordBook;
import yfy.englishschoolmaster.model.vo.UserAccountVO;
import yfy.englishschoolmaster.model.vo.WordBookImportResultVO;
import yfy.englishschoolmaster.model.vo.WordBookVO;
import yfy.englishschoolmaster.model.vo.WordImportFailVO;
import yfy.englishschoolmaster.service.WordBookItemService;
import yfy.englishschoolmaster.service.WordBookService;
import yfy.englishschoolmaster.service.WordService;

import java.time.LocalDateTime;
import java.util.Set;

/**
 * 平台内置词书表 服务层实现。
 *
 * @author <a href="https://github.com/yyffyyq">代码制造者yfy</a>
 */
@Service
public class WordBookServiceImpl extends ServiceImpl<WordBookMapper, WordBook> implements WordBookService {

    private static final String STATUS_ACTIVE = "ACTIVE";
    private static final String STATUS_DISABLED = "DISABLED";
    private static final Set<String> STATUS_SET = Set.of(STATUS_ACTIVE, STATUS_DISABLED);
    private static final Set<String> SORT_FIELDS = Set.of("createdAt", "updatedAt", "bookName", "status", "wordCount");
    private static final int IMPORT_MAX_SIZE = 50;

    private final WordService wordService;
    private final WordBookItemService wordBookItemService;

    public WordBookServiceImpl(WordService wordService, WordBookItemService wordBookItemService) {
        this.wordService = wordService;
        this.wordBookItemService = wordBookItemService;
    }

    @Override
    public WordBookVO createWordBook(WordBookAddRequest request, UserAccountVO loginUser) {
        // 1. 参数与权限校验
        ThrowUtils.throwIf(request == null, ErrorCode.PARAMS_ERROR, "创建词书请求为空");
        checkTeacherOrAdmin(loginUser);
        ThrowUtils.throwIf(StrUtil.isBlank(request.getBookName()), ErrorCode.PARAMS_ERROR, "词书名称不能为空");

        String bookName = request.getBookName().trim();
        String description = StrUtil.isBlank(request.getDescription()) ? null : request.getDescription().trim();
        String coverUrl = StrUtil.isBlank(request.getCoverUrl()) ? null : request.getCoverUrl().trim();

        // 2. 同名校验
        WordBook existBook = this.getOne(QueryWrapper.create().eq(WordBook::getBookName, bookName));
        ThrowUtils.throwIf(existBook != null, ErrorCode.OPERATION_ERROR, "词书名称已存在");

        // 3. 落库
        LocalDateTime now = LocalDateTime.now();
        WordBook wordBook = WordBook.builder()
                .bookName(bookName)
                .description(description)
                .coverUrl(coverUrl)
                .wordCount(0)
                .status(STATUS_ACTIVE)
                .createdAt(now)
                .updatedAt(now)
                .build();

        boolean saved = this.save(wordBook);
        ThrowUtils.throwIf(!saved, ErrorCode.OPERATION_ERROR, "创建词书失败");

        return toWordBookVO(wordBook);
    }

    @Override
    public Page<WordBookVO> listWordBookByPage(WordBookQueryRequest request, UserAccountVO loginUser) {
        // 1. 参数与权限校验
        ThrowUtils.throwIf(request == null, ErrorCode.PARAMS_ERROR, "查询请求为空");
        checkTeacherOrAdmin(loginUser);

        int pageNum = request.getPageNum() <= 0 ? 1 : request.getPageNum();
        int pageSize = request.getPageSize() <= 0 ? 10 : request.getPageSize();

        // 2. 组装查询条件
        QueryWrapper queryWrapper = QueryWrapper.create();
        if (StrUtil.isNotBlank(request.getBookName())) {
            queryWrapper.like(WordBook::getBookName, request.getBookName().trim());
        }
        if (StrUtil.isNotBlank(request.getStatus())) {
            queryWrapper.eq(WordBook::getStatus, request.getStatus().trim().toUpperCase());
        }

        applySort(queryWrapper, request.getSortField(), request.getSortOrder());

        // 3. 分页查询并转换 VO
        Page<WordBook> page = this.page(Page.of(pageNum, pageSize), queryWrapper);
        return page.map(this::toWordBookVO);
    }

    @Override
    public WordBookVO updateWordBook(WordBookUpdateRequest request, UserAccountVO loginUser) {
        // 1. 参数与权限校验
        ThrowUtils.throwIf(request == null, ErrorCode.PARAMS_ERROR, "修改词书请求为空");
        checkTeacherOrAdmin(loginUser);
        ThrowUtils.throwIf(request.getId() == null || request.getId() <= 0, ErrorCode.PARAMS_ERROR, "词书ID不合法");

        // 2. 查询原词书
        WordBook wordBook = this.getById(request.getId());
        ThrowUtils.throwIf(wordBook == null, ErrorCode.NOT_FOUND_ERROR, "词书不存在");

        // 3. 按需更新字段
        if (StrUtil.isNotBlank(request.getBookName())) {
            String bookName = request.getBookName().trim();
            WordBook existBook = this.getOne(QueryWrapper.create()
                    .eq(WordBook::getBookName, bookName)
                    .ne(WordBook::getId, request.getId()));
            ThrowUtils.throwIf(existBook != null, ErrorCode.OPERATION_ERROR, "词书名称已存在");
            wordBook.setBookName(bookName);
        }
        if (request.getDescription() != null) {
            wordBook.setDescription(StrUtil.isBlank(request.getDescription()) ? null : request.getDescription().trim());
        }
        if (request.getCoverUrl() != null) {
            wordBook.setCoverUrl(StrUtil.isBlank(request.getCoverUrl()) ? null : request.getCoverUrl().trim());
        }
        if (StrUtil.isNotBlank(request.getStatus())) {
            String status = request.getStatus().trim().toUpperCase();
            ThrowUtils.throwIf(!STATUS_SET.contains(status), ErrorCode.PARAMS_ERROR, "词书状态仅支持 ACTIVE 或 DISABLED");
            wordBook.setStatus(status);
        }

        wordBook.setUpdatedAt(LocalDateTime.now());
        boolean updated = this.updateById(wordBook);
        ThrowUtils.throwIf(!updated, ErrorCode.OPERATION_ERROR, "修改词书失败");

        return toWordBookVO(wordBook);
    }

    @Override
    public boolean deleteWordBook(Long id, UserAccountVO loginUser) {
        // 1. 参数与权限校验
        checkTeacherOrAdmin(loginUser);
        ThrowUtils.throwIf(id == null || id <= 0, ErrorCode.PARAMS_ERROR, "词书ID不合法");

        // 2. 查询原词书
        WordBook wordBook = this.getById(id);
        ThrowUtils.throwIf(wordBook == null, ErrorCode.NOT_FOUND_ERROR, "词书不存在");
        ThrowUtils.throwIf(STATUS_DISABLED.equals(wordBook.getStatus()), ErrorCode.OPERATION_ERROR, "词书已删除");

        // 3. 软删除：将状态置为 DISABLED（避免外键约束导致物理删除失败）
        wordBook.setStatus(STATUS_DISABLED);
        wordBook.setUpdatedAt(LocalDateTime.now());
        boolean updated = this.updateById(wordBook);
        ThrowUtils.throwIf(!updated, ErrorCode.OPERATION_ERROR, "删除词书失败");
        return true;
    }

    @Override
    public WordBookImportResultVO importWords(Long bookId, WordBookImportRequest request, UserAccountVO loginUser) {
        // 1. 参数与权限校验
        checkTeacherOrAdmin(loginUser);
        ThrowUtils.throwIf(bookId == null || bookId <= 0, ErrorCode.PARAMS_ERROR, "词书ID不合法");
        ThrowUtils.throwIf(request == null, ErrorCode.PARAMS_ERROR, "导入请求为空");
        ThrowUtils.throwIf(CollUtil.isEmpty(request.getWords()), ErrorCode.PARAMS_ERROR, "单词列表不能为空");
        ThrowUtils.throwIf(request.getWords().size() > IMPORT_MAX_SIZE,
                ErrorCode.PARAMS_ERROR, "单次最多导入 " + IMPORT_MAX_SIZE + " 个单词");

        WordBook wordBook = this.getById(bookId);
        ThrowUtils.throwIf(wordBook == null, ErrorCode.NOT_FOUND_ERROR, "词书不存在");
        ThrowUtils.throwIf(STATUS_DISABLED.equals(wordBook.getStatus()), ErrorCode.OPERATION_ERROR, "词书已停用，无法导入");

        // 2. 逐条处理：单条失败不影响整批
        String unitName = request.getUnitName();
        int nextSort = wordBookItemService.getMaxSortOrder(bookId) + 1;
        WordBookImportResultVO result = new WordBookImportResultVO();

        for (WordImportItem item : request.getWords()) {
            String displayWord = item == null || item.getWordText() == null ? "" : item.getWordText().trim();
            try {
                Word word = wordService.enrichAndSave(item);
                boolean linked = wordBookItemService.linkIfAbsent(bookId, word.getId(), nextSort, unitName);
                if (linked) {
                    nextSort++;
                }
                result.setSuccessCount(result.getSuccessCount() + 1);
            } catch (Exception e) {
                WordImportFailVO failVO = new WordImportFailVO();
                failVO.setWordText(displayWord);
                failVO.setReason(StrUtil.blankToDefault(e.getMessage(), "导入失败"));
                result.getFailList().add(failVO);
                result.setFailCount(result.getFailCount() + 1);
            }
        }

        // 3. 回写词书单词数
        long count = wordBookItemService.countByBookId(bookId);
        wordBook.setWordCount((int) count);
        wordBook.setUpdatedAt(LocalDateTime.now());
        this.updateById(wordBook);
        result.setWordCount((int) count);
        return result;
    }

    /**
     * 校验当前用户为教师或管理员
     */
    private void checkTeacherOrAdmin(UserAccountVO loginUser) {
        ThrowUtils.throwIf(loginUser == null || loginUser.getId() == null, ErrorCode.NOT_LOGIN_ERROR, "未登录");
        String role = loginUser.getRole();
        boolean isAdmin = UserConstant.ADMIN_ROLE.equalsIgnoreCase(role);
        boolean isTeacher = UserConstant.TEACHER_ROLE.equalsIgnoreCase(role);
        ThrowUtils.throwIf(!isAdmin && !isTeacher, ErrorCode.NO_AUTH_ERROR, "仅教师或管理员可操作词书");
    }

    private void applySort(QueryWrapper queryWrapper, String sortField, String sortOrder) {
        boolean isAsc = "ascend".equalsIgnoreCase(sortOrder);
        if (StrUtil.isNotBlank(sortField) && SORT_FIELDS.contains(sortField)) {
            switch (sortField) {
                case "updatedAt" -> queryWrapper.orderBy(WordBook::getUpdatedAt, isAsc);
                case "bookName" -> queryWrapper.orderBy(WordBook::getBookName, isAsc);
                case "status" -> queryWrapper.orderBy(WordBook::getStatus, isAsc);
                case "wordCount" -> queryWrapper.orderBy(WordBook::getWordCount, isAsc);
                default -> queryWrapper.orderBy(WordBook::getCreatedAt, isAsc);
            }
            return;
        }
        queryWrapper.orderBy(WordBook::getCreatedAt, false);
    }

    private WordBookVO toWordBookVO(WordBook wordBook) {
        WordBookVO wordBookVO = new WordBookVO();
        BeanUtil.copyProperties(wordBook, wordBookVO);
        return wordBookVO;
    }
}
