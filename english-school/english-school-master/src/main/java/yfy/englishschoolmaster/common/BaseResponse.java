package yfy.englishschoolmaster.common;

import lombok.Data;
import yfy.englishschoolmaster.exception.ErrorCode;

import java.io.Serializable;

/**
 * 通用响应类
 * 响应格式
 * {
 *     data:"",
 *     code:
 * }
 * @param <T>
 */
@Data
public class BaseResponse<T> implements Serializable {

    private int code;

    private T data;

    private String message;

    public BaseResponse(int code, T data, String message) {
        this.code = code;
        this.data = data;
        this.message = message;
    }

    public BaseResponse(int code, T data) {
        this(code, data, "");
    }

    public BaseResponse(ErrorCode errorCode) {
        this(errorCode.getCode(), null, errorCode.getMessage());
    }
}