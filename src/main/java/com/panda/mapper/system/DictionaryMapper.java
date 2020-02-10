package com.panda.mapper.system;

import com.panda.util.abs.AbstractMapper;
import com.panda.model.system.Dictionary;

import java.util.List;
import java.util.Map;

public interface DictionaryMapper extends AbstractMapper<Dictionary>{

    /**
     * 获取当前字典的属性
     * @return
     */
    List<Dictionary> selectDictionaryValueList(String parentId);

    /**
     * 查询字典信息列表
     * @param map
     * @return
     */
    List<Map<String ,Object>> selectDictionaryListMap(Map<String,Object> map);

    /**
     * Group Count 字典的值
     * @param parentId
     * @return
     */
    String selectDictionaryGroupCountValueByParent(String parentId);

    /**
     * Ajax 删除字典信息 包含子级时，将全部删除
     * @param id
     * @return
     */
    Integer delDictionaryParentAndChild(String id);

}