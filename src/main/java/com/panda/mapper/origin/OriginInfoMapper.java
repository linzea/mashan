package com.panda.mapper.origin;

import com.panda.model.origin.OriginInfo;
import com.panda.util.abs.AbstractMapper;

import java.util.List;
import java.util.Map;

public interface OriginInfoMapper extends AbstractMapper<OriginInfo> {

    /**
     * 查询溯源信息列表
     * @param map
     * @return
     */
    List<Map> selectOriginInfoDataList(Map map);
}