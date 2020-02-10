package com.panda.service.impl.origin;

import com.panda.mapper.origin.AssemblySetMapper;
import com.panda.model.origin.AssemblySet;
import com.panda.service.origin.AssemblySetService;
import com.panda.service.origin.EquipmentService;
import com.panda.util.abs.AbstractMapper;
import com.panda.util.abs.AbstractServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import com.panda.model.origin.Equipment;
import javax.annotation.Resource;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Service
public class AssemblySetServiceImpl extends AbstractServiceImpl<AssemblySet> implements AssemblySetService {

    @Resource
    private AssemblySetMapper assemblySetMapper;
    @Resource
    private EquipmentService equipmentService;
    @Override
    protected AbstractMapper<AssemblySet> getAbstractMapper() {
        return assemblySetMapper;
    }

    /**
     * 获取生产线信息
     * @param map
     * @return
     */
    @Override
    public List<Map> selectAssemblySetDataList(Map map){
        return assemblySetMapper.selectAssemblySetDataList(map);
    }


    /**
     * 查询绑定的设备信息
     * @param id
     * @return
     */
    @Override
    public Map selectAssemblyData(String id){
        return assemblySetMapper.selectAssemblyData(id);
    }

    /**
     * 新增，和编辑生产线设备，
     * @param assemblySet
     * @return
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackFor = {Exception.class})
    public Integer saveOrUpdateAssemblySet(AssemblySet assemblySet){
        Integer resultStatus = 0;
        try {
            Equipment equipment = new Equipment();
            if (assemblySet != null && !assemblySet.getId().isEmpty()) {
                AssemblySet old = assemblySetMapper.selectByPrimaryKey(assemblySet.getId());
                if (old.getMachineId().equals(assemblySet.getMachineId())){
                    assemblySetMapper.updateByPrimaryKeySelective(assemblySet);
                    resultStatus = 200;
                }else{
                    if (!old.getMachineId().isEmpty()) {
                        equipment.setId(old.getMachineId());
                        equipment.setUnitStatus(2);
                        int c = equipmentService.updateByPrimaryKeySelective(equipment);
                        if (c > 0){
                            int i = assemblySetMapper.updateByPrimaryKeySelective(assemblySet);
                            if (i > 0 && !assemblySet.getMachineId().isEmpty()) {
                                equipment.setId(assemblySet.getMachineId());
                                equipment.setUnitStatus(1);
                                equipmentService.updateByPrimaryKeySelective(equipment);
                            }
                            resultStatus = 200;
                        }
                    }
                }
            }else if (assemblySet.getId().isEmpty() && !assemblySet.getMachineId().isEmpty()){
                    assemblySet.setId(UUID.randomUUID().toString());
                int i = assemblySetMapper.insertSelective(assemblySet);
                if (i > 0) {
                    equipment.setId(assemblySet.getMachineId());
                    equipment.setUnitStatus(1);
                    equipmentService.updateByPrimaryKeySelective(equipment);
                    resultStatus = 200;
                }
            }
        } catch (Exception e) {
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            e.printStackTrace();
            resultStatus = 101;
        }
        return resultStatus;
    }

    /**
     * 删除绑定的设备，解除设备绑定关系
     * @param id
     * @return
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackFor = {Exception.class})
    public Integer delAssemblySetItem(String id){
        Integer resultStatus = 0;
        try {
            Equipment equipment = new Equipment();
            if (!id.isEmpty()) {
                AssemblySet old = assemblySetMapper.selectByPrimaryKey(id);
                if (old != null){
                    if (!old.getMachineId().isEmpty()){
                        equipment.setId(old.getMachineId());
                        equipment.setUnitStatus(2);//解除绑定设备
                        int i = equipmentService.updateByPrimaryKeySelective(equipment);
                        if (i > 0){
                            assemblySetMapper.deleteByPrimaryKey(old.getId());
                        }
                    }else{
                        assemblySetMapper.deleteByPrimaryKey(old.getId());
                    }
                    resultStatus = 200;
                }
            }else {
                resultStatus = 101;
            }
        } catch (Exception e) {
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            e.printStackTrace();
            resultStatus = 101;
        }
        return resultStatus;
    }


    /**
     * 获取生产线绑定的设备-生成二维码使用
     * @param query
     * @return
     */
    @Override
    public List<Map> createQrCodeGetEquipment(Map query){
        return assemblySetMapper.createQrCodeGetEquipment(query);
    }
}
