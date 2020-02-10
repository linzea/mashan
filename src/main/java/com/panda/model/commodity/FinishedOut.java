package com.panda.model.commodity;

import java.io.Serializable;
import java.util.Date;

public class FinishedOut implements Serializable{
    private String id;

    private String harvestBatchId;

    private String finishedId;

    private Integer outQuantity;

    private String outUser;

    private String dicTeaAttr;

    private String dicTeaType;

    private String principal;

    private Integer qualityReport;

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

    public String getHarvestBatchId() {
        return harvestBatchId;
    }

    public void setHarvestBatchId(String harvestBatchId) {
        this.harvestBatchId = harvestBatchId;
    }

    public String getFinishedId() {
        return finishedId;
    }

    public void setFinishedId(String finishedId) {
        this.finishedId = finishedId;
    }

    public Integer getOutQuantity() {
        return outQuantity;
    }

    public void setOutQuantity(Integer outQuantity) {
        this.outQuantity = outQuantity;
    }

    public String getOutUser() {
        return outUser;
    }

    public void setOutUser(String outUser) {
        this.outUser = outUser;
    }

    public String getDicTeaAttr() {
        return dicTeaAttr;
    }

    public void setDicTeaAttr(String dicTeaAttr) {
        this.dicTeaAttr = dicTeaAttr;
    }

    public String getDicTeaType() {
        return dicTeaType;
    }

    public void setDicTeaType(String dicTeaType) {
        this.dicTeaType = dicTeaType;
    }

    public String getPrincipal() {
        return principal;
    }

    public void setPrincipal(String principal) {
        this.principal = principal;
    }

    public Integer getQualityReport() {
        return qualityReport;
    }

    public void setQualityReport(Integer qualityReport) {
        this.qualityReport = qualityReport;
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