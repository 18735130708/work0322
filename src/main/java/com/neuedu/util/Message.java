package com.neuedu.util;

import lombok.Data;

/**
 * Created by Administrator on 2019/3/25.
 */
@Data
public class Message {
    private Integer code;
    private Object message;

    public Message(Integer code, Object message) {
        this.code = code;
        this.message = message;
    }
}
