package com.panda.model.wechat;

import java.io.Serializable;

public class Wechat implements Serializable{

    private Integer id;

    private String name;

    private String orgid;

    private String weixin;

    private String token;

    private String appid;

    private String appsecret;

    private Integer type;

    private Boolean oauthStatus;

    private String oauthName;

    private String oauthRedirecturi;

    private Integer oauthCount;

    private Integer time;

    private Integer sort;

    private Integer status;

    private Integer defaultWx;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getOrgid() {
        return orgid;
    }

    public void setOrgid(String orgid) {
        this.orgid = orgid;
    }

    public String getWeixin() {
        return weixin;
    }

    public void setWeixin(String weixin) {
        this.weixin = weixin;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public String getAppid() {
        return appid;
    }

    public void setAppid(String appid) {
        this.appid = appid;
    }

    public String getAppsecret() {
        return appsecret;
    }

    public void setAppsecret(String appsecret) {
        this.appsecret = appsecret;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public Boolean getOauthStatus() {
        return oauthStatus;
    }

    public void setOauthStatus(Boolean oauthStatus) {
        this.oauthStatus = oauthStatus;
    }

    public String getOauthName() {
        return oauthName;
    }

    public void setOauthName(String oauthName) {
        this.oauthName = oauthName;
    }

    public String getOauthRedirecturi() {
        return oauthRedirecturi;
    }

    public void setOauthRedirecturi(String oauthRedirecturi) {
        this.oauthRedirecturi = oauthRedirecturi;
    }

    public Integer getOauthCount() {
        return oauthCount;
    }

    public void setOauthCount(Integer oauthCount) {
        this.oauthCount = oauthCount;
    }

    public Integer getTime() {
        return time;
    }

    public void setTime(Integer time) {
        this.time = time;
    }

    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getDefaultWx() {
        return defaultWx;
    }

    public void setDefaultWx(Integer defaultWx) {
        this.defaultWx = defaultWx;
    }
}