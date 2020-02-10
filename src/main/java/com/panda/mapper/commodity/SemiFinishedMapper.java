package com.panda.mapper.commodity;

import com.panda.model.commodity.SemiFinished;
import com.panda.util.abs.AbstractMapper;

import java.util.List;
import java.util.Map;

public interface SemiFinishedMapper extends AbstractMapper<SemiFinished>{

    /**
     * 获取半成品库入存记录
     * @param map
     * @return
     */
    List<Map> selectSemiFinishedDataList(Map map);

    /**
     * 查询单条出入库详情
     * @param id
     * @return
     */
    Map selectSemiFinishedDataItem(String id);

}