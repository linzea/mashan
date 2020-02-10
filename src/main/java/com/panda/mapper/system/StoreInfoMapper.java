package com.panda.mapper.system;

import com.panda.model.system.StoreInfo;
import com.panda.util.abs.AbstractMapper;

import java.util.List;
import java.util.Map;

public interface StoreInfoMapper extends AbstractMapper<StoreInfo> {
    /**
     * 获取门店信息列表
     * @param map
     * @return
     */
    List<Map> selectStoreInfoList(Map map);

    /**
     * 获取门店详细信息
     * @param id
     * @return
     */
    Map selectStoreItemByPrimaryKey(String id);

}