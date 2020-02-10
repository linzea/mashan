package com.panda.mapper.origin;

import com.panda.model.origin.EquipmentMaintain;
import com.panda.util.abs.AbstractMapper;

import java.util.List;
import java.util.Map;

public interface EquipmentMaintainMapper extends AbstractMapper<EquipmentMaintain>{

    /**
     * 获取设备维护保养记录
     * @param map
     * @return
     */
    List<Map> selectEquipmentMaintainDataList(Map map);

    /**
     * 获取设备维护，保养信息
     * @param id
     * @return
     */
    Map selectEquipmentMaintainDataItem(String id);
}