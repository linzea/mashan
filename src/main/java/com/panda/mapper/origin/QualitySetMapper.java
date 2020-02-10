package com.panda.mapper.origin;

import com.panda.model.origin.QualitySet;
import com.panda.util.abs.AbstractMapper;

import java.util.List;
import java.util.Map;

public interface QualitySetMapper extends AbstractMapper<QualitySet>{
    /**
     * 获取当前的属性
     * @return
     */
    List<QualitySet> selectQualitySetValueList(String parentId);

    /**
     * 查询信息列表
     * @param map
     * @return
     */
    List<Map<String ,Object>> selectQualitySetListMap(Map<String,Object> map);

    /**
     * Group Count 的值
     * @param parentId
     * @return
     */
    String selectQualitySetGroupCountValueByParent(String parentId);

    /**
     * Ajax 删除信息 包含子级时，将全部删除
     * @param id
     * @return
     */
    Integer delQualitySetParentAndChild(String id);
}