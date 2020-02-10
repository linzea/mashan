package com.panda.model.origin;

import java.io.Serializable;
import java.util.Date;

public class TeaGardenLog implements Serializable{
    private String id;

    private String teaGardenId;

    private String farmTypeId;

    private Double farmQuantity;

    private Date farmTime;

    private String farmPattern;

    private String fertVariety;

    private String cultivarId;

    private String batchNum;

    private String operatorId;

    private Integer status;

    private String description;

    private Date endTime;

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

    public String getTeaGardenId() {
        return teaGardenId;
    }

    public void setTeaGardenId(String teaGardenId) {
        this.teaGardenId = teaGardenId;
    }

    public String getFarmTypeId() {
        return farmTypeId;
    }

    public void setFarmTypeId(String farmTypeId) {
        this.farmTypeId = farmTypeId;
    }

    public Double getFarmQuantity() {
        return farmQuantity;
    }

    public void setFarmQuantity(Double farmQuantity) {
        this.farmQuantity = farmQuantity;
    }

    public Date getFarmTime() {
        return farmTime;
    }

    public void setFarmTime(Date farmTime) {
        this.farmTime = farmTime;
    }

    public String getFarmPattern() {
        return farmPattern;
    }

    public void setFarmPattern(String farmPattern) {
        this.farmPattern = farmPattern;
    }

    public String getFertVariety() {
        return fertVariety;
    }

    public void setFertVariety(String fertVariety) {
        this.fertVariety = fertVariety;
    }

    public String getCultivarId() {
        return cultivarId;
    }

    public void setCultivarId(String cultivarId) {
        this.cultivarId = cultivarId;
    }

    public String getBatchNum() {
        return batchNum;
    }

    public void setBatchNum(String batchNum) {
        this.batchNum = batchNum;
    }

    public String getOperatorId() {
        return operatorId;
    }

    public void setOperatorId(String operatorId) {
        this.operatorId = operatorId;
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

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
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