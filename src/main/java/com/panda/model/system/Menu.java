package com.panda.model.system;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

public class Menu implements Serializable {

    private String id;

    private Integer sortId;

    private String parentId;

    private String name;

    private String url;

    private Integer type;

    private Integer status;

    private String iconClass;

    private String createId;

    private Date createTime;

    private String modifyId;

    private Date modifyTime;

    private String description;

    private List<Menu> childMenuList;

    private List<String> permissionList;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Integer getSortId() {
        return sortId;
    }

    public void setSortId(Integer sortId) {
        this.sortId = sortId;
    }

    public String getParentId() {
        return parentId;
    }

    public void setParentId(String parentId) {
        this.parentId = parentId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getIconClass() {
        return iconClass;
    }

    public void setIconClass(String iconClass) {
        this.iconClass = iconClass;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public List<Menu> getChildMenuList(){
        return childMenuList;
    }

    public void setChildMenuList(List<Menu> childMenuList){
        this.childMenuList = childMenuList;
    }

    public List<String> getPermissionList(){
        return permissionList;
    }

    public void setPermissionList(List<String> permissionList){
        this.permissionList = permissionList;
    }
}