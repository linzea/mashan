package com.panda.model.commodity;

import java.io.Serializable;
import java.util.Date;

public class Products implements Serializable{
    private String id;

    private String productName;

    private String productType;

    private String dicTeaAttr;

    private String dicTeaType;

    private String imgUrl;

    private String teaGrade;

    private String packageId;

    private String tagsId;

    private String licenceId;

    private String standardId;

    private Integer status;

    private Integer speOne;

    private Integer speTwo;

    private Integer speThere;

    private String descriptin;

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

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getProductType() {
        return productType;
    }

    public void setProductType(String productType) {
        this.productType = productType;
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

    public String getTeaGrade() {
        return teaGrade;
    }

    public void setTeaGrade(String teaGrade) {
        this.teaGrade = teaGrade;
    }

    public String getPackageId() {
        return packageId;
    }

    public void setPackageId(String packageId) {
        this.packageId = packageId;
    }

    public String getTagsId() {
        return tagsId;
    }

    public void setTagsId(String tagsId) {
        this.tagsId = tagsId;
    }

    public String getLicenceId() {
        return licenceId;
    }

    public void setLicenceId(String licenceId) {
        this.licenceId = licenceId;
    }

    public String getStandardId() {
        return standardId;
    }

    public void setStandardId(String standardId) {
        this.standardId = standardId;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
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

    public String getDescriptin() {
        return descriptin;
    }

    public void setDescriptin(String descriptin) {
        this.descriptin = descriptin;
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