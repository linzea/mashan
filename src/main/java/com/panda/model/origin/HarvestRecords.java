package com.panda.model.origin;

import java.io.Serializable;
import java.util.Date;

public class HarvestRecords implements Serializable{
    private String id;

    private String teaGardenId;

    private String dicStandard;

    private Double recQuantity;

    private String pickNumber;

    private String pickBatchNo;

    private String pickArea;

    private Integer pickTime;

    private String operatorId;

    private String description;

    private String principal;

    private Integer status;

    private String createId;

    private Date createTime;

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

    public String getDicStandard() {
        return dicStandard;
    }

    public void setDicStandard(String dicStandard) {
        this.dicStandard = dicStandard;
    }

    public Double getRecQuantity() {
        return recQuantity;
    }

    public void setRecQuantity(Double recQuantity) {
        this.recQuantity = recQuantity;
    }

    public String getPickNumber() {
        return pickNumber;
    }

    public void setPickNumber(String pickNumber) {
        this.pickNumber = pickNumber;
    }

    public String getPickBatchNo() {
        return pickBatchNo;
    }

    public void setPickBatchNo(String pickBatchNo) {
        this.pickBatchNo = pickBatchNo;
    }

    public String getPickArea() {
        return pickArea;
    }

    public void setPickArea(String pickArea) {
        this.pickArea = pickArea;
    }

    public Integer getPickTime() {
        return pickTime;
    }

    public void setPickTime(Integer pickTime) {
        this.pickTime = pickTime;
    }

    public String getOperatorId() {
        return operatorId;
    }

    public void setOperatorId(String operatorId) {
        this.operatorId = operatorId;
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

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
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
}