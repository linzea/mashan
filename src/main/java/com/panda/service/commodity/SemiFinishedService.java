package com.panda.service.commodity;

import com.panda.model.commodity.SemiFinished;
import com.panda.model.origin.MachinTea;
import com.panda.util.abs.AbstractService;

import java.util.List;
import java.util.Map;

/**
 * Created with IDEA.
 * User: Alan
 * Date: 2017/12/29
 * Time: 10:52
 */
public interface SemiFinishedService extends AbstractService<SemiFinished> {

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

    /**
     * 茶叶加工，筛选工序完成时。创建半成品入库数据
     * @param machinTea
     * @return
     */
    Integer createSemiFinishedData(MachinTea machinTea);

    /**
     * 半成品出库-加工成成品
     * 红茶-复烤
     * 绿茶-复炒
     * @return
     */
    Integer semiFinishedOut(String id);
}
