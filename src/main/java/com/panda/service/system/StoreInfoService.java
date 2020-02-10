package com.panda.service.system;

import com.panda.model.system.StoreInfo;
import com.panda.model.system.Users;
import com.panda.util.abs.AbstractService;

import java.util.List;
import java.util.Map;

public interface StoreInfoService extends AbstractService<StoreInfo> {
    /**
     * 获取茶园信息列表
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

    /**
     * 新增门店信息和绑定门店商户
     * @param storeInfo
     * @return
     */
    Integer insertSelectiveAndUser(StoreInfo storeInfo,Users storeUserInfo);

}
