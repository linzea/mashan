package com.panda.model.origin;

import java.io.Serializable;
import java.util.Date;

public class OriginCode implements Serializable{
    private String id;

    private String originBatchId;

    private String prefixVal;

    private String originCode;

    private Integer createStatus;

    private String createId;

    private Date createTime;

    private String modifyId;

    private Date modifyTime;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getOriginBatchId() {
        return originBatchId;
    }

    public void setOriginBatchId(String originBatchId) {
        this.originBatchId = originBatchId;
    }

    public String getPrefixVal() {
        return prefixVal;
    }

    public void setPrefixVal(String prefixVal) {
        this.prefixVal = prefixVal;
    }

    public String getOriginCode() {
        return originCode;
    }

    public void setOriginCode(String originCode) {
        this.originCode = originCode;
    }

    public Integer getCreateStatus() {
        return createStatus;
    }

    public void setCreateStatus(Integer createStatus) {
        this.createStatus = createStatus;
    }

    public String getCreateId() {
        return createId;
    }

    public void setCreateId(String createId) {
        this.createId = createId;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getModifyId() {
        return modifyId;
    }

    public void setModifyId(String modifyId) {
        this.modifyId = modifyId;
    }

    public Date getModifyTime() {
        return modifyTime;
    }

    public void setModifyTime(Date modifyTime) {
        this.modifyTime = modifyTime;
    }
}