package com.panda.util;

import java.io.Serializable;
/**
 * Created with IDEA Controller 返回的json结果
 * User: Alan
 * Date: 2017/11/14
 * Time: 17:28
 */
public class ResultMsgUtil implements Serializable {
    private Object message;
    private Object data;
    private Object code;

    public ResultMsgUtil() {
    }

    private ResultMsgUtil(Object message, Object data) {
        this.message = message;
        this.data = data;
    }

    private ResultMsgUtil(Object message, Object data, Object code) {
        this.message = message;
        this.data = data;
        this.code = code;
    }

    public static ResultMsgUtil getResult(Object data) {
        return getResultMsg(null, data);
    }

    public static ResultMsgUtil getResultMsg(Object message, Object data) {
        return new ResultMsgUtil(message, data);
    }

    public static ResultMsgUtil getResultMsg(Object message, Object code, Object data) {
        return new ResultMsgUtil(message, new ResultMsgUtil(code, data));
    }

    public Object getMessage() {
        return message;
    }

    public void setMessage(Object message) {
        this.message = message;
    }

    public Object getData() {
        return data;
    }

    public <T> T getData(Class<T> cls) {
        return (T) data;
    }

    public void setData(Object data) {
        this.data = data;
    }
}
