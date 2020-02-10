package com.panda.mapper.commodity;

import com.panda.model.commodity.Package;
import com.panda.util.abs.AbstractMapper;

import java.util.List;
import java.util.Map;

public interface PackageMapper extends AbstractMapper<Package>{

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

}