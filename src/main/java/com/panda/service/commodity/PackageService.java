package com.panda.service.commodity;

import com.panda.model.commodity.Tags;
import com.panda.util.abs.AbstractService;
import com.panda.model.commodity.Package;

import java.util.List;
import java.util.Map;

public interface PackageService extends AbstractService<Package> {

    /**
     * 查询包材列表
     * @param map
     * @return
     */
    List<Map> selectPackageList(Map map);

    /**
     * 查询单条包材信息
     * @param id
     * @return
     */
    Map selectPackageItem(String id);

    /**
     * 成品库存增加时，减去包材库存数量
     * @return
     */
    Integer inventoryPackageReduction(Package pack);
}
