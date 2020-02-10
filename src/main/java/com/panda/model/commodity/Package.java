package com.panda.model.commodity;

import java.io.Serializable;
import java.util.Date;

public class Package implements Serializable{
    private String id;

    private String packageName;

    private Integer packageQuantity;

    private Integer packageLow;

    private Integer packageUse;

    private String dicTeaAttr;

    private String dicTeaType;

    private String imgUrl;

    private Integer speOne;

    private Integer speTwo;

    private Integer speThere;

    private Integer speFour;

    private Integer status;

    private String principal;

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

    public String getPackageName() {
        return packageName;
    }

    public void setPackageName(String packageName) {
        this.packageName = packageName;
    }

    public Integer getPackageQuantity() {
        return packageQuantity;
    }

    public void setPackageQuantity(Integer packageQuantity) {
        this.packageQuantity = packageQuantity;
    }

    public Integer getPackageLow() {
        return packageLow;
    }

    public void setPackageLow(Integer packageLow) {
        this.packageLow = packageLow;
    }

    public Integer getPackageUse() {
        return packageUse;
    }

    public void setPackageUse(Integer packageUse) {
        this.packageUse = packageUse;
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

    public String getImgUrl() {
        return imgUrl;
    }

    public void setImgUrl(String imgUrl) {
        this.imgUrl = imgUrl;
    }

    public Integer getSpeOne() {
        return speOne;
    }

    public void setSpeOne(Integer speOne) {
        this.speOne = speOne;
    }

    public Integer getSpeTwo() {
        return speTwo;
    }

    public void setSpeTwo(Integer speTwo) {
        this.speTwo = speTwo;
    }

    public Integer getSpeThere() {
        return speThere;
    }

    public void setSpeThere(Integer speThere) {
        this.speThere = speThere;
    }

    public Integer getSpeFour() {
        return speFour;
    }

    public void setSpeFour(Integer speFour) {
        this.speFour = speFour;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getPrincipal() {
        return principal;
    }

    public void setPrincipal(String principal) {
        this.principal = principal;
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