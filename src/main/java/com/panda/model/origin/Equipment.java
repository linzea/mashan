package com.panda.model.origin;

import java.io.Serializable;
import java.util.Date;

public class Equipment implements Serializable{
    private String id;

    private String unitName;

    private String unitNo;

    private String unitUsage;

    private String unitType;

    private Integer unitCycle;

    private Integer unitStatus;

    private Integer unitClear;

    private String imgUrl;

    private Integer status;

    private String dicTeaAttr;

    private String description;

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

    public String getUnitName() {
        return unitName;
    }

    public void setUnitName(String unitName) {
        this.unitName = unitName;
    }

    public String getUnitNo() {
        return unitNo;
    }

    public void setUnitNo(String unitNo) {
        this.unitNo = unitNo;
    }

    public String getUnitUsage() {
        return unitUsage;
    }

    public void setUnitUsage(String unitUsage) {
        this.unitUsage = unitUsage;
    }

    public String getUnitType() {
        return unitType;
    }

    public void setUnitType(String unitType) {
        this.unitType = unitType;
    }

    public Integer getUnitCycle() {
        return unitCycle;
    }

    public void setUnitCycle(Integer unitCycle) {
        this.unitCycle = unitCycle;
    }

    public Integer getUnitStatus() {
        return unitStatus;
    }

    public void setUnitStatus(Integer unitStatus) {
        this.unitStatus = unitStatus;
    }

    public Integer getUnitClear() {
        return unitClear;
    }

    public void setUnitClear(Integer unitClear) {
        this.unitClear = unitClear;
    }

    public String getImgUrl() {
        return imgUrl;
    }

    public void setImgUrl(String imgUrl) {
        this.imgUrl = imgUrl;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getDicTeaAttr() {
        return dicTeaAttr;
    }

    public void setDicTeaAttr(String dicTeaAttr) {
        this.dicTeaAttr = dicTeaAttr;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
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