package yfy.englishschoolmaster.common;

import lombok.Data;

/**
 * 分页查询请求基类：
 * 封装页码、页大小及排序参数，
 *       供各业务分页接口继承复用
 */
@Data
public class PageRequest {

    /**
     * 当前页号
     */
    private int pageNum = 1;

    /**
     * 页面大小
     */
    private int pageSize = 10;

    /**
     * 排序字段
     */
    private String sortField;

    /**
     * 排序顺序（默认降序）
     */
    private String sortOrder = "descend";
}