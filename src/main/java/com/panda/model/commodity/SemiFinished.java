package com.panda.model.commodity;

import java.io.Serializable;
import java.util.Date;

public class SemiFinished implements Serializable{
    private String id;

    private String harvestBatchId;

    private String machinTeaId;

    private String dicTeaAttr;

    private String dicTeaType;

    private Double recQuantity;

    private Double teaGradeOne;

    private Double teaGradeTwo;

    private Double teaGradeThree;

    private Double semiOneOut;

    private Double semiTwoOut;

    private Double semiThreeOut;

    private String principal;

    private Integer status;

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

    public String getMachinTeaId() {
        return machinTeaId;
    }

    public void setMachinTeaId(String machinTeaId) {
        this.machinTeaId = machinTeaId;
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

    public Double getRecQuantity() {
        return recQuantity;
    }

    public void setRecQuantity(Double recQuantity) {
        this.recQuantity = recQuantity;
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

    public Double getSemiOneOut() {
        return semiOneOut;
    }

    public void setSemiOneOut(Double semiOneOut) {
        this.semiOneOut = semiOneOut;
    }

    public Double getSemiTwoOut() {
        return semiTwoOut;
    }

    public void setSemiTwoOut(Double semiTwoOut) {
        this.semiTwoOut = semiTwoOut;
    }

    public Double getSemiThreeOut() {
        return semiThreeOut;
    }

    public void setSemiThreeOut(Double semiThreeOut) {
        this.semiThreeOut = semiThreeOut;
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