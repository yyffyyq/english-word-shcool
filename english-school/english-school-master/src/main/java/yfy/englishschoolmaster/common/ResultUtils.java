package yfy.englishschoolmaster.common;


import yfy.englishschoolmaster.exception.ErrorCode;

/**
 * 统一响应构造工具类：
 * 封装成功与失败两种 BaseResponse 的快速创建
 */
public class ResultUtils {

    /**
     * 构造成功响应：
     * 状态码为 0，消息为 ok
     *
     * @param data 业务数据
     * @param <T>  数据类型
     * @return 成功响应
     */
    public static <T> BaseResponse<T> success(T data) {
        return new BaseResponse<>(0, data, "ok");
    }

    /**
     * 构造失败响应：
     * 使用 ErrorCode 中的默认提示信息
     *
     * @param errorCode 错误码枚举
     * @return 失败响应
     */
    public static BaseResponse<?> error(ErrorCode errorCode) {
        return new BaseResponse<>(errorCode);
    }

    /**
     * 构造失败响应：
     * 自定义状态码与提示信息
     *
     * @param code    状态码
     * @param message 提示信息
     * @return 失败响应
     */
    public static BaseResponse<?> error(int code, String message) {
        return new BaseResponse<>(code, null, message);
    }

    /**
     * 构造失败响应：
     * 使用 ErrorCode 状态码，覆盖默认提示信息
     *
     * @param errorCode 错误码枚举
     * @param message   自定义提示信息
     * @return 失败响应
     */
    public static BaseResponse<?> error(ErrorCode errorCode, String message) {
        return new BaseResponse<>(errorCode.getCode(), null, message);
    }
}