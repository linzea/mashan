package com.panda.util;

/**
 * 上传图片的响应体
 * FILE: com.panda.wechat.vo.PhotoResult.java


 * DATE: 2017/4/21
 * TIME: 22:20
 */
public class PhotoResult {

    private boolean success;    //成功标准 0失败 1成功
    private String url;     //图片url
    private String message; //错误信息

    public PhotoResult() {
    }

    public PhotoResult(boolean success, String url, String message) {
        this.success = success;
        this.url = url;
        this.message = message;
    }

    public boolean getSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
