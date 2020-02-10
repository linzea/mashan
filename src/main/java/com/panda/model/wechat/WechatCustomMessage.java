package com.panda.model.wechat;

import java.io.Serializable;

public class WechatCustomMessage implements Serializable{

    private Integer id;

    private Integer uid;

    private String msg;

    private Short iswechat;

    private Integer sendTime;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Short getIswechat() {
        return iswechat;
    }

    public void setIswechat(Short iswechat) {
        this.iswechat = iswechat;
    }

    public Integer getSendTime() {
        return sendTime;
    }

    public void setSendTime(Integer sendTime) {
        this.sendTime = sendTime;
    }
}