package com.panda.service.origin;

import com.panda.model.origin.OriginBatch;
import com.panda.util.abs.AbstractService;

import java.util.List;
import java.util.Map;

/**
 * Created with IDEA.
 *
 * @AUTH: Alan
 * Date: 2017/12/7
 * Time: 10:53
 */
public interface OriginBatchService extends AbstractService<OriginBatch> {

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
