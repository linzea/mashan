package com.panda.service.impl.origin;

import com.panda.mapper.origin.EquipmentMapper;
import com.panda.model.origin.Equipment;
import com.panda.service.origin.EquipmentService;
import com.panda.util.abs.AbstractMapper;
import com.panda.util.abs.AbstractServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service
public class EquipmentServiceImpl extends AbstractServiceImpl<Equipment> implements EquipmentService {

    @Resource
    private EquipmentMapper equipmentMapper;

    @Override
    protected AbstractMapper<Equipment> getAbstractMapper() {
        return equipmentMapper;
    }

    /**
     * 获取设备信息
     * @param map
     * @return
     */
    @Override
    public List<Map> selectEquipmentDataList(Map map){
        return equipmentMapper.selectEquipmentDataList(map);
    }

    /**
     * 获取设备详细信息
     * @param id
     * @return
     */
    @Override
    public Map selectEquipmentItemByPrimaryKey(String id){
        return equipmentMapper.selectEquipmentItemByPrimaryKey(id);
    }

    /**
     * 二维码查看设备信息
     * @param map
     * @return
     */
    @Override
    public Map selectOriginEquipmentItemData(Map map){
        return equipmentMapper.selectOriginEquipmentItemData(map);
    }
}
