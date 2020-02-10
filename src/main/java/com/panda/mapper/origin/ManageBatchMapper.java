package com.panda.mapper.origin;

import com.panda.model.origin.ManageBatch;
import com.panda.util.abs.AbstractMapper;

import java.util.List;
import java.util.Map;

public interface ManageBatchMapper extends AbstractMapper<ManageBatch> {
    /**
     * 获取茶园管理批次列表
     * @param map
     * @return
     */
    List<Map> selectManageBatchList(Map map);
}