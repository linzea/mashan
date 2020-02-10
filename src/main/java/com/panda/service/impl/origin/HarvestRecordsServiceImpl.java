package com.panda.service.impl.origin;

import com.panda.mapper.origin.HarvestRecordsMapper;
import com.panda.model.origin.HarvestRecords;
import com.panda.service.origin.HarvestRecordsService;
import com.panda.service.origin.MachinTeaService;
import com.panda.util.abs.AbstractMapper;
import com.panda.util.abs.AbstractServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created with IDEA.
 * User: Alan
 * Date: 2017/12/21
 * Time: 17:48
 */
@Service
public class HarvestRecordsServiceImpl extends AbstractServiceImpl<HarvestRecords> implements HarvestRecordsService {

    @Resource
    private HarvestRecordsMapper harvestRecordsMapper;

    @Resource
    private MachinTeaService machinTeaService;

    @Override
    protected AbstractMapper<HarvestRecords> getAbstractMapper() {
        return harvestRecordsMapper;
    }

    /**
     * 获取茶青采摘记录
     * @param map
     * @return
     */
    @Override
    public List<Map> selectHarvestRecordsList(Map map){
        return harvestRecordsMapper.selectHarvestRecordsList(map);
    }

    /**
     * 获取茶青采摘记录编号 和 Id
     * @param map
     * @return
     */
    @Override
    public List<Map> selectHarvestRecordsListPickNum(Map map){
        return harvestRecordsMapper.selectHarvestRecordsListPickNum(map);
    }

    /**
     * 获取当前编辑项详细信息
     * @param id
     * @return
     */
    @Override
    public Map selectHarvestRecordsItem(String id){
        return harvestRecordsMapper.selectHarvestRecordsItem(id);
    }


    /**
     * 获取采鲜叶批次的茶叶品种
     * @param id
     * @return
     */
    @Override
    public Map selectHarvestCultivarName(String id){
        return harvestRecordsMapper.selectHarvestCultivarName(id);
    }

    /**
     * 删除鲜叶批次
     * 查询是否有加工记录，存在加工记录时,不可删除
     * @param id
     * @return
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackFor = {Exception.class})
    public Integer delHarvestItem(String id){
        Integer resultStatus = 0;
        try {
            if (!id.isEmpty()) {
                Map map = new HashMap(1);
                map.put("harvestBatchId",id);
                List<Map> list = machinTeaService.selectMachinTeaDataList(map);
                if (list != null && list.size() == 0) {
                    int i = harvestRecordsMapper.deleteByPrimaryKey(id);
                    if (i > 0 ) {
                        resultStatus = 200;
                    }
                }else{
                    resultStatus = 101;
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
     * 鲜叶环节查看茶园信息和管理批次信息
     * @param id
     * @return
     */
    @Override
    public Map selectTeaGardenAndManagerBatch(String id){
        return harvestRecordsMapper.selectTeaGardenAndManagerBatch(id);
    }

    /**
     * 查询鲜叶采摘数量统计图
     * @param map
     * @return
     */
    @Override
    public List<Map> getHarvestQuality(Map map){
        return harvestRecordsMapper.getHarvestQuality(map);
    }

    /**
     * 查询加工完成率统计图
     * @param map
     * @return
     */
    public List<Map> getHarvestMachin(Map map){
        return harvestRecordsMapper.getHarvestMachin(map);
    }
}
