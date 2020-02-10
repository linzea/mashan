package com.panda.model.origin;

import java.io.Serializable;
import java.util.Date;

public class MachinSet implements Serializable {

    private String id;

    private String dicMacType;

    private String dicTeaAttr;

    private String dicMacPro;

    private String dicRollType;

    private Integer temperature;

    private Integer humidity;

    private Integer macLoss;

    private Integer beginDuration;

    private Integer endDuration;

    private Integer durationType;

    private Integer status;

    private String description;

    private Integer rollStatus;

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

    public String getDicMacPro() {
        return dicMacPro;
    }

    public void setDicMacPro(String dicMacPro) {
        this.dicMacPro = dicMacPro;
    }

    public String getDicRollType() {
        return dicRollType;
    }

    public void setDicRollType(String dicRollType) {
        this.dicRollType = dicRollType;
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

    public Integer getBeginDuration() {
        return beginDuration;
    }

    public void setBeginDuration(Integer beginDuration) {
        this.beginDuration = beginDuration;
    }

    public Integer getEndDuration() {
        return endDuration;
    }

    public void setEndDuration(Integer endDuration) {
        this.endDuration = endDuration;
    }

    public Integer getDurationType() {
        return durationType;
    }

    public void setDurationType(Integer durationType) {
        this.durationType = durationType;
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

    public Integer getRollStatus() {
        return rollStatus;
    }

    public void setRollStatus(Integer rollStatus) {
        this.rollStatus = rollStatus;
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