package yfy.englishschoolmaster.model.vo;

import lombok.Data;

import java.io.Serial;
import java.io.Serializable;

/**
 * 单词导入失败明细 VO
 */
@Data
public class WordImportFailVO implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 失败的英文单词
     */
    private String wordText;

    /**
     * 失败原因说明
     */
    private String reason;
}
