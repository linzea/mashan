package com.panda.service.origin;

import com.panda.model.origin.ManageBatch;
import com.panda.util.abs.AbstractService;

import java.util.List;
import java.util.Map;

public interface ManageBatchService extends AbstractService<ManageBatch> {

    /**
     * 获取茶园管理批次列表
     * @param map
     * @return
     */
    List<Map> selectManageBatchList(Map map);
}
