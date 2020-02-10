package com.panda.mapper.origin;

import com.panda.model.origin.MachinTea;
import com.panda.util.abs.AbstractMapper;

import java.util.List;
import java.util.Map;

public interface MachinTeaMapper extends AbstractMapper<MachinTea> {

    /**
     * 查询所有的设置记录返回 List列表 包含设置的字典数据 入参 Map
     * (dicMacType,dicTeaAttr,dicMacPro,dicTeaType,dicTeaGra,status)
     * @param map
     * @return
     */
    List<Map> selectMachinTeaDataList(Map map);

    /**
     * 查询一条记录 返回 Map 包含设置的字典数据
     * @param id
     * @return
     */
    Map selectMachinTeaDataByOne(String id);

    /**
     * 根据加工批次号 获取该批次所用时间和产品名称
     * @param processBatchId
     * @return
     */
    Map selectMachinTimeAndMachinProduct(String processBatchId);

    /**
     * 查询当前批次下是否有多条记录
     * @param id
     * @return
     */
    Map checkOutHarvestBatchIdList(String id);

    /**
     * 查找揉捻最后一条记录
     * @param id
     * @return
     */
    List<MachinTea> selectMachinTeaGroupData(String id);

    /**
     * 获取制定批次的茶系信息
     * @param harvestBatchId
     * @return
     */
    Map getDicTeaAttrData(String harvestBatchId);

}