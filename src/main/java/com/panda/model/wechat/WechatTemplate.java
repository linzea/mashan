package com.panda.model.wechat;

import java.io.Serializable;

public class WechatTemplate implements Serializable {

    private Integer id;

    private String openId;

    private String templateId;

    private String contents;

    private String title;

    private Integer addTime;

    //private Byte switch;

    private String template;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getOpenId() {
        return openId;
    }

    public void setOpenId(String openId) {
        this.openId = openId;
    }

    public String getTemplateId() {
        return templateId;
    }

    public void setTemplateId(String templateId) {
        this.templateId = templateId;
    }

    public String getContents() {
        return contents;
    }

    public void setContents(String contents) {
        this.contents = contents;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Integer getAddTime() {
        return addTime;
    }

    public void setAddTime(Integer addTime) {
        this.addTime = addTime;
    }

//    public Byte getSwitch() {
//        return switch;
//    }
//
//    public void setSwitch(Byte switch) {
//        this.switch = switch;
//    }

    public String getTemplate() {
        return template;
    }

    public void setTemplate(String template) {
        this.template = template;
    }
}