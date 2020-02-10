package com.panda.mapper.origin;

import com.panda.model.origin.OriginCode;
import com.panda.util.abs.AbstractMapper;

import java.util.List;
import java.util.Map;

public interface OriginCodeMapper extends AbstractMapper<OriginCode> {

    /**
     * 获取溯源码
     * @param map
     * @return
     */
    List<Map> selectOriginCodeDataList(Map map);

    /**
     * 通过溯源码找到对应的批次号
     * @param originCode
     * @return
     */
    List<Map> selectOriginCodeByInfoList(String originCode);

    /**
     * 查询溯源吗的批次ID
     * @param originCode
     * @return
     */
    String checkOriginCode(String  originCode);
}