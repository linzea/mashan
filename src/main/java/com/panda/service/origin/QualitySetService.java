package com.panda.service.origin;

import com.panda.model.origin.QualitySet;
import com.panda.util.abs.AbstractService;

import java.util.List;
import java.util.Map;

/**
 * Created with IDEA.
 * User: Alan
 * Date: 2017/12/27
 * Time: 17:50
 */
public interface QualitySetService extends AbstractService<QualitySet> {

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

    /**
     * 获取当前启用的所有属性集合
     * @return
     */
    List<QualitySet> selectQualitySetParentAndChildList(String parentId);
}
