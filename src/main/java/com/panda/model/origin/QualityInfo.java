package com.panda.model.origin;

import java.io.Serializable;
import java.util.Date;

public class QualityInfo implements Serializable{
    private String id;

    private String qualityId;

    private Double netContent;

    private Double teaCrumble;

    private Double waterContent;

    private String setTeaSoup;

    private String setTenderness;

    private String setBalanceDegree;

    private String setIncense;

    private String setSweetness;

    private String setConcentration;

    private String setDepth;

    private String setPurity;

    private String setTheFresh;

    private String imgUrl;

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

    public String getQualityId() {
        return qualityId;
    }

    public void setQualityId(String qualityId) {
        this.qualityId = qualityId;
    }

    public Double getNetContent() {
        return netContent;
    }

    public void setNetContent(Double netContent) {
        this.netContent = netContent;
    }

    public Double getTeaCrumble() {
        return teaCrumble;
    }

    public void setTeaCrumble(Double teaCrumble) {
        this.teaCrumble = teaCrumble;
    }

    public Double getWaterContent() {
        return waterContent;
    }

    public void setWaterContent(Double waterContent) {
        this.waterContent = waterContent;
    }

    public String getSetTeaSoup() {
        return setTeaSoup;
    }

    public void setSetTeaSoup(String setTeaSoup) {
        this.setTeaSoup = setTeaSoup;
    }

    public String getSetTenderness() {
        return setTenderness;
    }

    public void setSetTenderness(String setTenderness) {
        this.setTenderness = setTenderness;
    }

    public String getSetBalanceDegree() {
        return setBalanceDegree;
    }

    public void setSetBalanceDegree(String setBalanceDegree) {
        this.setBalanceDegree = setBalanceDegree;
    }

    public String getSetIncense() {
        return setIncense;
    }

    public void setSetIncense(String setIncense) {
        this.setIncense = setIncense;
    }

    public String getSetSweetness() {
        return setSweetness;
    }

    public void setSetSweetness(String setSweetness) {
        this.setSweetness = setSweetness;
    }

    public String getSetConcentration() {
        return setConcentration;
    }

    public void setSetConcentration(String setConcentration) {
        this.setConcentration = setConcentration;
    }

    public String getSetDepth() {
        return setDepth;
    }

    public void setSetDepth(String setDepth) {
        this.setDepth = setDepth;
    }

    public String getSetPurity() {
        return setPurity;
    }

    public void setSetPurity(String setPurity) {
        this.setPurity = setPurity;
    }

    public String getSetTheFresh() {
        return setTheFresh;
    }

    public void setSetTheFresh(String setTheFresh) {
        this.setTheFresh = setTheFresh;
    }

    public String getImgUrl() {
        return imgUrl;
    }

    public void setImgUrl(String imgUrl) {
        this.imgUrl = imgUrl;
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