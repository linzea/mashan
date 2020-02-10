package com.panda.mapper.commodity;

import com.panda.model.commodity.Finished;
import com.panda.util.abs.AbstractMapper;

import java.util.List;
import java.util.Map;

public interface FinishedMapper extends AbstractMapper<Finished>{

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
     * 成品出库获取质检报告和其他报告
     * @param id
     * @return
     */
    List<Map> finishedOutDownloadFileList(String id);
}