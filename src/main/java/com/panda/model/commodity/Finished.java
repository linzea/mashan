package com.panda.model.commodity;

import java.io.Serializable;
import java.util.Date;

public class Finished implements Serializable{
    private String id;

    private String harvestBatchId;

    private String priductId;

    private String packaingId;

    private String tagId;

    private String finishedType;

    private Double lastQuantity;

    private String finishedName;

    private Integer finishedQuantity;

    private Integer finishedLow;

    private Integer finishedOut;

    private String dicTeaAttr;

    private String dicTeaType;

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

    public String getHarvestBatchId() {
        return harvestBatchId;
    }

    public void setHarvestBatchId(String harvestBatchId) {
        this.harvestBatchId = harvestBatchId;
    }

    public String getPriductId() {
        return priductId;
    }

    public void setPriductId(String priductId) {
        this.priductId = priductId;
    }

    public String getPackaingId() {
        return packaingId;
    }

    public void setPackaingId(String packaingId) {
        this.packaingId = packaingId;
    }

    public String getTagId() {
        return tagId;
    }

    public void setTagId(String tagId) {
        this.tagId = tagId;
    }

    public String getFinishedType() {
        return finishedType;
    }

    public void setFinishedType(String finishedType) {
        this.finishedType = finishedType;
    }

    public Double getLastQuantity() {
        return lastQuantity;
    }

    public void setLastQuantity(Double lastQuantity) {
        this.lastQuantity = lastQuantity;
    }

    public String getFinishedName() {
        return finishedName;
    }

    public void setFinishedName(String finishedName) {
        this.finishedName = finishedName;
    }

    public Integer getFinishedQuantity() {
        return finishedQuantity;
    }

    public void setFinishedQuantity(Integer finishedQuantity) {
        this.finishedQuantity = finishedQuantity;
    }

    public Integer getFinishedLow() {
        return finishedLow;
    }

    public void setFinishedLow(Integer finishedLow) {
        this.finishedLow = finishedLow;
    }

    public Integer getFinishedOut() {
        return finishedOut;
    }

    public void setFinishedOut(Integer finishedOut) {
        this.finishedOut = finishedOut;
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