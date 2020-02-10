package com.panda.service.commodity;

import com.panda.model.commodity.FinishedOut;
import com.panda.util.abs.AbstractService;

import java.util.List;
import java.util.Map;

public interface FinishedOutService extends AbstractService<FinishedOut> {

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
     * 编辑和保存出库记录
     * @param finishedOut
     * @return
     */
    Integer saveOrUpdateFinishedOut(FinishedOut finishedOut);

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
