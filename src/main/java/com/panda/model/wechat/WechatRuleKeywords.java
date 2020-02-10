package com.panda.model.wechat;

import java.io.Serializable;

public class WechatRuleKeywords implements Serializable {

    private Integer id;

    private Integer rid;

    private String ruleKeywords;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getRid() {
        return rid;
    }

    public void setRid(Integer rid) {
        this.rid = rid;
    }

    public String getRuleKeywords() {
        return ruleKeywords;
    }

    public void setRuleKeywords(String ruleKeywords) {
        this.ruleKeywords = ruleKeywords;
    }
}