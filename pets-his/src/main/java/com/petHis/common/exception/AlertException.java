package com.petHis.common.exception;

/**
 * @author xiongyh 389222105@qq.com
 * @date 2024-04-12
 */
public class AlertException extends RuntimeException {
    private static final long serialVersionUID = 1L;

    private Integer code;

    private final String message;

    public AlertException(String message) {
        this.message = message;
    }

    public AlertException(String message, Integer code) {
        this.message = message;
        this.code = code;
    }

    public AlertException(String message, Throwable e) {
        super(message, e);
        this.message = message;
    }

    @Override
    public String getMessage() {
        return message;
    }

    public Integer getCode() {
        return code;
    }
}
