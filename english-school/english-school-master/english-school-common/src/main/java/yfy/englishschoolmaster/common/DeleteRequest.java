package yfy.englishschoolmaster.common;

import lombok.Data;

import java.io.Serializable;

/**
 * 通用删除请求 DTO：
 * 封装待删除记录的主键 ID
 */
@Data
public class DeleteRequest implements Serializable {

    /**
     * 待删除记录 ID
     */
    private Long id;

    private static final long serialVersionUID = 1L;
}
