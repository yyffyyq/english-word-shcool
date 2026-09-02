package yfy.englishschoolmaster.exception;

/**
 * 条件抛异常工具类：
 * 在业务校验失败时快速抛出 BusinessException 或自定义运行时异常
 */
public class ThrowUtils {

    /**
     * 条件成立则抛出指定运行时异常
     *
     * @param condition        触发条件，为 true 时抛异常
     * @param runtimeException 待抛出的运行时异常
     */
    public static void throwIf(boolean condition, RuntimeException runtimeException) {
        if (condition) {
            throw runtimeException;
        }
    }

    /**
     * 条件成立则抛出业务异常：
     * 使用 ErrorCode 中的默认提示信息
     *
     * @param condition 触发条件，为 true 时抛异常
     * @param errorCode 错误码枚举
     */
    public static void throwIf(boolean condition, ErrorCode errorCode) {
        throwIf(condition, new BusinessException(errorCode));
    }

    /**
     * 条件成立则抛出业务异常：
     * 使用 ErrorCode 状态码，覆盖默认提示信息
     *
     * @param condition 触发条件，为 true 时抛异常
     * @param errorCode 错误码枚举
     * @param message   自定义提示信息
     */
    public static void throwIf(boolean condition, ErrorCode errorCode, String message) {
        throwIf(condition, new BusinessException(errorCode, message));
    }
}
