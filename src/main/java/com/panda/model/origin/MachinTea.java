package com.panda.model.origin;

import java.io.Serializable;
import java.util.Date;

public class MachinTea implements Serializable{
    private String id;

    private String dicMacType;

    private String dicTeaAttr;

    private String machinSetId;

    private String dicMacValue;

    private String dicTeaType;

    private String productId;

    private String harvestBatchId;

    private String assemblySetId;

    private String dicRollType;

    private Integer rollStatus;

    private Integer temperature;

    private Integer humidity;

    private Integer macLoss;

    private Double teaGradeOne;

    private Double teaGradeTwo;

    private Double teaGradeThree;

    private Date beginTime;

    private Date endTime;

    private Integer machinStatus;

    private Integer status;

    private String description;

    private String principal;

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

    public String getDicMacType() {
        return dicMacType;
    }

    public void setDicMacType(String dicMacType) {
        this.dicMacType = dicMacType;
    }

    public String getDicTeaAttr() {
        return dicTeaAttr;
    }

    public void setDicTeaAttr(String dicTeaAttr) {
        this.dicTeaAttr = dicTeaAttr;
    }

    public String getMachinSetId() {
        return machinSetId;
    }

    public void setMachinSetId(String machinSetId) {
        this.machinSetId = machinSetId;
    }

    public String getDicMacValue() {
        return dicMacValue;
    }

    public void setDicMacValue(String dicMacValue) {
        this.dicMacValue = dicMacValue;
    }

    public String getDicTeaType() {
        return dicTeaType;
    }

    public void setDicTeaType(String dicTeaType) {
        this.dicTeaType = dicTeaType;
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public String getHarvestBatchId() {
        return harvestBatchId;
    }

    public void setHarvestBatchId(String harvestBatchId) {
        this.harvestBatchId = harvestBatchId;
    }

    public String getAssemblySetId() {
        return assemblySetId;
    }

    public void setAssemblySetId(String assemblySetId) {
        this.assemblySetId = assemblySetId;
    }

    public String getDicRollType() {
        return dicRollType;
    }

    public void setDicRollType(String dicRollType) {
        this.dicRollType = dicRollType;
    }

    public Integer getRollStatus() {
        return rollStatus;
    }

    public void setRollStatus(Integer rollStatus) {
        this.rollStatus = rollStatus;
    }

    public Integer getTemperature() {
        return temperature;
    }

    public void setTemperature(Integer temperature) {
        this.temperature = temperature;
    }

    public Integer getHumidity() {
        return humidity;
    }

    public void setHumidity(Integer humidity) {
        this.humidity = humidity;
    }

    public Integer getMacLoss() {
        return macLoss;
    }

    public void setMacLoss(Integer macLoss) {
        this.macLoss = macLoss;
    }

    public Double getTeaGradeOne() {
        return teaGradeOne;
    }

    public void setTeaGradeOne(Double teaGradeOne) {
        this.teaGradeOne = teaGradeOne;
    }

    public Double getTeaGradeTwo() {
        return teaGradeTwo;
    }

    public void setTeaGradeTwo(Double teaGradeTwo) {
        this.teaGradeTwo = teaGradeTwo;
    }

    public Double getTeaGradeThree() {
        return teaGradeThree;
    }

    public void setTeaGradeThree(Double teaGradeThree) {
        this.teaGradeThree = teaGradeThree;
    }

    public Date getBeginTime() {
        return beginTime;
    }

    public void setBeginTime(Date beginTime) {
        this.beginTime = beginTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public Integer getMachinStatus() {
        return machinStatus;
    }

    public void setMachinStatus(Integer machinStatus) {
        this.machinStatus = machinStatus;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getPrincipal() {
        return principal;
    }

    public void setPrincipal(String principal) {
        this.principal = principal;
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