package com.panda.model.origin;

import java.io.Serializable;
import java.util.Date;

public class Quality implements Serializable{
    private String id;

    private String harvestBatchId;

    private String qualityStage;

    private Double samplingBase;

    private Integer sampleNumber;

    private String sampleTea;

    private String dicTeaAttr;

    private String dicTeaType;

    private String dicQualityType;

    private Integer verifyQuality;

    private String verifyUser;

    private Date verifyTime;

    private Integer qualityStatus;

    private String qualityUser;

    private Date qualityTime;

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

    public String getQualityStage() {
        return qualityStage;
    }

    public void setQualityStage(String qualityStage) {
        this.qualityStage = qualityStage;
    }

    public Double getSamplingBase() {
        return samplingBase;
    }

    public void setSamplingBase(Double samplingBase) {
        this.samplingBase = samplingBase;
    }

    public Integer getSampleNumber() {
        return sampleNumber;
    }

    public void setSampleNumber(Integer sampleNumber) {
        this.sampleNumber = sampleNumber;
    }

    public String getSampleTea() {
        return sampleTea;
    }

    public void setSampleTea(String sampleTea) {
        this.sampleTea = sampleTea;
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

    public String getDicQualityType() {
        return dicQualityType;
    }

    public void setDicQualityType(String dicQualityType) {
        this.dicQualityType = dicQualityType;
    }

    public Integer getVerifyQuality() {
        return verifyQuality;
    }

    public void setVerifyQuality(Integer verifyQuality) {
        this.verifyQuality = verifyQuality;
    }

    public String getVerifyUser() {
        return verifyUser;
    }

    public void setVerifyUser(String verifyUser) {
        this.verifyUser = verifyUser;
    }

    public Date getVerifyTime() {
        return verifyTime;
    }

    public void setVerifyTime(Date verifyTime) {
        this.verifyTime = verifyTime;
    }

    public Integer getQualityStatus() {
        return qualityStatus;
    }

    public void setQualityStatus(Integer qualityStatus) {
        this.qualityStatus = qualityStatus;
    }

    public String getQualityUser() {
        return qualityUser;
    }

    public void setQualityUser(String qualityUser) {
        this.qualityUser = qualityUser;
    }

    public Date getQualityTime() {
        return qualityTime;
    }

    public void setQualityTime(Date qualityTime) {
        this.qualityTime = qualityTime;
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