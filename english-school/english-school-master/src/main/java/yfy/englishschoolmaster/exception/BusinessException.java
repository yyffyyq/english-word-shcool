package yfy.englishschoolmaster.exception;

import lombok.Getter;

/**
 * 自定义业务异常：
 * 携带业务状态码，由 GlobalExceptionHandler 统一捕获并返回
 */
@Getter
public class BusinessException extends RuntimeException {

    /**
     * 业务状态码
     */
    private final int code;

    /**
     * 自定义状态码与提示信息
     *
     * @param code    状态码
     * @param message 提示信息
     */
    public BusinessException(int code, String message) {
        super(message);
        this.code = code;
    }

    /**
     * 根据错误码枚举构造异常
     *
     * @param errorCode 错误码枚举
     */
    public BusinessException(ErrorCode errorCode) {
        super(errorCode.getMessage());
        this.code = errorCode.getCode();
    }

    /**
     * 根据错误码枚举构造异常，覆盖默认提示信息
     *
     * @param errorCode 错误码枚举
     * @param message   自定义提示信息
     */
    public BusinessException(ErrorCode errorCode, String message) {
        super(message);
        this.code = errorCode.getCode();
    }
}
