package yfy.englishschoolmaster.common;

import lombok.Data;
import yfy.englishschoolmaster.exception.ErrorCode;

import java.io.Serializable;

/**
 * 统一 API 响应封装类：
 * 所有接口返回格式为 { code, data, message }
 *
 * @param <T> 业务数据类型
 */
@Data
public class BaseResponse<T> implements Serializable {

    private int code;

    private T data;

    private String message;

    /**
     * 全参构造
     *
     * @param code    状态码
     * @param data    业务数据
     * @param message 提示信息
     */
    public BaseResponse(int code, T data, String message) {
        this.code = code;
        this.data = data;
        this.message = message;
    }

    /**
     * 构造响应（无提示信息）
     *
     * @param code 状态码
     * @param data 业务数据
     */
    public BaseResponse(int code, T data) {
        this(code, data, "");
    }

    /**
     * 根据错误码枚举构造失败响应
     *
     * @param errorCode 错误码枚举
     */
    public BaseResponse(ErrorCode errorCode) {
        this(errorCode.getCode(), null, errorCode.getMessage());
    }
}