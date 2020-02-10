package com.panda.mapper.origin;

import com.panda.model.origin.OriginBatch;
import com.panda.util.abs.AbstractMapper;

import java.util.List;
import java.util.Map;

public interface OriginBatchMapper extends AbstractMapper<OriginBatch> {

    /**
     * 查询溯源批次数据
     * @param map
     * @return
     */
    List<Map> selectOriginBatchDataList(Map map);

    /**
     * 查询溯源批次
     * @param map
     * @return
     */
    List<OriginBatch> selectBatchList(Map map);

    /**
     * countAll
     * @return
     */
    Integer countAll();
}