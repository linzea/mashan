package com.panda.mapper.origin;

import com.panda.model.origin.MachinSet;
import com.panda.util.abs.AbstractMapper;

import java.util.List;
import java.util.Map;

public interface MachinSetMapper extends AbstractMapper<MachinSet> {

    /**
     * 查询所有的设置记录返回 List列表 包含设置的字典数据 入参 Map
     * (dicMacType,dicTeaAttr,dicMacPro,dicTeaType,dicTeaGra,status)
     * @param map
     * @return
     */
    List<Map> selectMachinSetDataList(Map map);

    /**
     * 查询一条记录 返回 Map 包含设置的字典数据
     * @param id
     * @return
     */
    Map selectMachinSetDataByOne(String id);

    /**
     * 查询指定茶系的加工范围
     * @param id
     * @return
     */
    Integer countMachinSetDicTeaAttrNum(String id);
}