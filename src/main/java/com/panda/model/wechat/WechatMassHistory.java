package com.panda.model.wechat;

import java.io.Serializable;

public class WechatMassHistory implements Serializable {

    private Integer id;

    private Integer mediaId;

    private String type;

    private String status;

    private Integer sendTime;

    private String msgId;

    private Integer totalcount;

    private Integer filtercount;

    private Integer sentcount;

    private Integer errorcount;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getMediaId() {
        return mediaId;
    }

    public void setMediaId(Integer mediaId) {
        this.mediaId = mediaId;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Integer getSendTime() {
        return sendTime;
    }

    public void setSendTime(Integer sendTime) {
        this.sendTime = sendTime;
    }

    public String getMsgId() {
        return msgId;
    }

    public void setMsgId(String msgId) {
        this.msgId = msgId;
    }

    public Integer getTotalcount() {
        return totalcount;
    }

    public void setTotalcount(Integer totalcount) {
        this.totalcount = totalcount;
    }

    public Integer getFiltercount() {
        return filtercount;
    }

    public void setFiltercount(Integer filtercount) {
        this.filtercount = filtercount;
    }

    public Integer getSentcount() {
        return sentcount;
    }

    public void setSentcount(Integer sentcount) {
        this.sentcount = sentcount;
    }

    public Integer getErrorcount() {
        return errorcount;
    }

    public void setErrorcount(Integer errorcount) {
        this.errorcount = errorcount;
    }
}