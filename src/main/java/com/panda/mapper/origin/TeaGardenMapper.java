package com.panda.mapper.origin;

import com.panda.model.origin.TeaGarden;
import com.panda.util.abs.AbstractMapper;

import java.util.List;
import java.util.Map;

public interface TeaGardenMapper extends AbstractMapper<TeaGarden> {
    /**
     * 获取茶园信息列表
     * @param map
     * @return
     */
    List<Map> selectTeaGardenList(Map map);

    /**
     * 查询茶园名称和ID 茶园日志使用
     * @param map
     * @return
     */
    List<Map> selectTeaGardenNameAndId(Map map);

    /**
     * 根据茶园ID获取对应批次号信息
     * @param teaGardenId
     * @return
     */
    List<Map> selectTeaGardenBatch(String teaGardenId);

}