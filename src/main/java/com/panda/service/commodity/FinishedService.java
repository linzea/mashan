package com.panda.service.commodity;

import com.panda.model.commodity.Finished;
import com.panda.model.commodity.FinishedOut;
import com.panda.model.origin.MachinTea;
import com.panda.util.abs.AbstractService;

import java.util.List;
import java.util.Map;

public interface FinishedService extends AbstractService<Finished> {

    /**
     * 获取成品列表
     * @param map
     * @return
     */
    List<Map> selectFinishedList(Map map);

    /**
     * 查看单挑成品信息详情
     * @param id
     * @return
     */
    Map selectFinishedItem(String id);

    /**
     * 编辑和更新成品记录，出库等
     * @param finished
     * @return
     */
    Integer saveOrUpdateFinishedOut(Finished finished, FinishedOut finishedOut);

    /**
     * 创建成品库存数据
     * @param finished
     * @return
     */
    Integer createFinishedData(Finished finished);

    /**
     * 成品出库获取质检报告和其他报告
     * @param id
     * @return
     */
    List<Map> finishedOutDownloadFileList(String id);
}
