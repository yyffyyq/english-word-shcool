package yfy.englishschoolmaster.model.vo;

import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * 词书单词导入结果 VO：
 * 批量导入完成后返回，
 *       汇总成功/失败数量及失败明细
 */
@Data
public class WordBookImportResultVO implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 成功导入条数
     */
    private int successCount;

    /**
     * 失败条数
     */
    private int failCount;

    /**
     * 导入完成后词书单词总数
     */
    private int wordCount;

    /**
     * 失败明细列表
     */
    private List<WordImportFailVO> failList = new ArrayList<>();
}
