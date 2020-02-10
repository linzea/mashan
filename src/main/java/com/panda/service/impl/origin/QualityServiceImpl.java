package com.panda.service.impl.origin;

import com.panda.mapper.origin.QualityInfoMapper;
import com.panda.mapper.origin.QualityMapper;
import com.panda.model.origin.MachinTea;
import com.panda.model.origin.Quality;
import com.panda.model.origin.QualityInfo;
import com.panda.model.system.Users;
import com.panda.service.origin.HarvestRecordsService;
import com.panda.service.origin.MachinSetService;
import com.panda.service.origin.MachinTeaService;
import com.panda.service.origin.QualityService;
import com.panda.util.DateUtil;
import com.panda.util.abs.AbstractMapper;
import com.panda.util.abs.AbstractServiceImpl;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import javax.annotation.Resource;
import java.util.*;

/**
 * Created with IDEA.
 * User: Alan
 * Date: 2017/12/4
 * Time: 15:16
 */
@Service
public class QualityServiceImpl extends AbstractServiceImpl<Quality> implements QualityService {

    @Resource
    private QualityMapper qualityMapper;
    @Resource
    private QualityInfoMapper qualityInfoMapper;
    @Resource
    private MachinTeaService machinTeaService;
    @Resource
    private MachinSetService machinSetService;
    @Override
    protected AbstractMapper<Quality> getAbstractMapper() {
        return qualityMapper;
    }

    /**
     * 获取质检列表
     * @param map
     * @return
     */
    @Override
    public List<Map> selectQualityDataList(Map map){
        return qualityMapper.selectQualityDataList(map);
    }

    /**
     * 获取单条质检记录
     * @param id
     * @return
     */
    @Override
    public Map selectQualityDataMap(String id){
        return qualityMapper.selectQualityDataMap(id);
    }


    /**
     * 创建质检数据
     * @param quality,qualityInfo
     * @return
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackFor = {Exception.class})
    public Integer saveOrUpdateQuality(Quality quality,QualityInfo qualityInfo){
        Users user = (Users) SecurityUtils.getSubject().getPrincipal();
        Integer resultStatus = 0;
        try {
            //新增质检-
            if (quality != null && quality.getId() == null && quality.getHarvestBatchId() != null && !quality.getHarvestBatchId().isEmpty()) {
                Map machinTea = machinTeaService.getDicTeaAttrData(quality.getHarvestBatchId());
                if (machinTea != null && machinTea.size() > 0){
                    quality.setId(UUID.randomUUID().toString());
                    quality.setDicTeaAttr(machinTea.get("dic_tea_attr").toString());
                    quality.setDicTeaType(machinTea.get("dic_tea_type").toString());
                    quality.setCreateId(user.getId());
                    quality.setCreateTime(new Date());
                    int i = qualityMapper.insertSelective(quality);
                    if (i > 0){
                        qualityInfo.setQualityId(quality.getId());
                        qualityInfo.setId(UUID.randomUUID().toString());
                        qualityInfo.setCreateId(user.getId());
                        qualityInfo.setCreateTime(new Date());
                        int m = qualityInfoMapper.insertSelective(qualityInfo);
                        if (m > 0){
                            resultStatus = 200;
                        }
                    }
                }
            }else{
                quality.setModifyId(user.getId());
                quality.setModifyTime(new Date());
                int i = qualityMapper.updateByPrimaryKeySelective(quality);
                if (i > 0){
                    if (qualityInfo.getId() == null || qualityInfo.getId().equals("")){
                        qualityInfo.setId(UUID.randomUUID().toString());
                        qualityInfo.setQualityId(quality.getId());
                        qualityInfo.setCreateId(user.getId());
                        qualityInfo.setCreateTime(new Date());
                        qualityInfoMapper.insertSelective(qualityInfo);
                    }else{
                        qualityInfo.setModifyId(user.getId());
                        qualityInfo.setModifyTime(new Date());
                        qualityInfoMapper.updateByPrimaryKeySelective(qualityInfo);
                    }
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
     * 创建抽检数据
     * @return
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackFor = {Exception.class})
    public Integer createQualityData(MachinTea machinTea){
        Users user = (Users) SecurityUtils.getSubject().getPrincipal();
        Integer resultStatus = 0;
        try {
            if (machinTea != null && machinTea.getStatus() == 1) {
                Map query = new HashMap(3);
                query.put("dicTeaAttr", machinTea.getDicTeaAttr());
                query.put("dicMacPro", "01b33909-73b8-45d9-af2e-5f57a22895c1");
                query.put("rollStatus",machinTea.getRollStatus()+1);
                List<Map> macSetList = machinSetService.selectMachinSetDataList(query);
                if (macSetList != null && macSetList.size() == 1) {
                    for (Map item : macSetList) {
                        Quality quality = new Quality();
                        quality.setId(UUID.randomUUID().toString());
                        quality.setSampleNumber(Integer.valueOf(item.get("humidity").toString()));
                        quality.setSamplingBase(Double.valueOf(item.get("temperature").toString()));
                        quality.setHarvestBatchId(machinTea.getHarvestBatchId());
                        quality.setQualityStage(machinTea.getMachinSetId());
                        quality.setDicQualityType("1301e136-8d75-4e05-9fa3-06cbdcad1eea");
                        quality.setDicTeaAttr(machinTea.getDicTeaAttr());//茶系
                        quality.setDicTeaType(machinTea.getDicTeaType());//品种
                        quality.setCreateId(user.getId());
                        quality.setCreateTime(new Date());
                        quality.setQualityTime(new Date());
                        int i = qualityMapper.insertSelective(quality);
                        if (i > 0) {
                            resultStatus = 200;
                        }
                    }
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
     * 获取当前批次质检完成，并且未绑定溯源批次
     * @param harvestBatchId
     * @return
     */
    @Override
    public List<Map> selectMachinOverQualityNotBindOrigin(String harvestBatchId){
        return qualityMapper.selectMachinOverQualityNotBindOrigin(harvestBatchId);
    }
}
