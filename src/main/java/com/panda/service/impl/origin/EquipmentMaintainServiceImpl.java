package com.panda.service.impl.origin;

import com.panda.mapper.origin.EquipmentMaintainMapper;
import com.panda.model.origin.AssemblySet;
import com.panda.model.origin.EquipmentMaintain;
import com.panda.model.system.Users;
import com.panda.service.origin.EquipmentMaintainService;
import com.panda.util.abs.AbstractMapper;
import com.panda.util.abs.AbstractServiceImpl;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * Created with IDEA.
 * User: Alan
 * Date: 2017/12/25
 * Time: 11:44
 */
@Service
public class EquipmentMaintainServiceImpl extends AbstractServiceImpl<EquipmentMaintain> implements EquipmentMaintainService {

    @Resource
    private EquipmentMaintainMapper equipmentMaintainMapper;

    @Override
    protected AbstractMapper<EquipmentMaintain> getAbstractMapper() {
        return equipmentMaintainMapper;
    }

    /**
     * 获取设备维护保养记录
     * @param map
     * @return
     */
    @Override
    public List<Map> selectEquipmentMaintainDataList(Map map){
        return equipmentMaintainMapper.selectEquipmentMaintainDataList(map);
    }

    /**
     * 获取设备维护，保养信息
     * @param id
     * @return
     */
    @Override
    public Map selectEquipmentMaintainDataItem(String id){
        return equipmentMaintainMapper.selectEquipmentMaintainDataItem(id);
    }

    /**
     * 创建设备清洁保养记录
     * unitUsage 是加工设置表的 dic_mac_pro ID
     * @param assemblySet
     * @param unitUsage
     * @return
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackFor = {Exception.class})
    public Integer createEquipmentMaintainData(AssemblySet assemblySet, String unitUsage){
        Users user = (Users) SecurityUtils.getSubject().getPrincipal();
        Integer resultStatus = 0;
        try {
            if (assemblySet != null && !unitUsage.equals("")) {

            }else{
                resultStatus = 101;
            }
        } catch (Exception e) {
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            e.printStackTrace();
            resultStatus = 101;
        }
        return resultStatus;
    }
}
