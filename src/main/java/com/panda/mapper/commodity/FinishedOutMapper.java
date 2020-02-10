package com.panda.mapper.commodity;

import com.panda.model.commodity.FinishedOut;
import com.panda.util.abs.AbstractMapper;

import java.util.List;
import java.util.Map;

public interface FinishedOutMapper extends AbstractMapper<FinishedOut>{

    /**
     * 查询出库记录
     * @param map
     * @return
     */
    List<Map> selectFinishedOutList(Map map);

    /**
     * 查询单条出库记录详情
     * @param id
     * @return
     */
    Map selectFinishedOutItem(String id);

    /**
     * 统计某一时间段内，成品出货数量
     * @param map
     * @return
     */
    List<Map<String, Object>> getFinishedOutGroupByStore(Map map);

    /**
     * 查询某一门店，指定日期出货情况
     * @param map
     * @return
     */
    String selectStoreFinishedOutTeaType(Map map);

}