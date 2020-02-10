package com.panda.service.impl.origin;


import com.panda.controller.system.origin.WitherController;
import com.panda.mapper.origin.MachinTeaMapper;
import com.panda.model.commodity.*;
import com.panda.model.commodity.Package;
import com.panda.model.origin.*;
import com.panda.model.system.Users;
import com.panda.service.commodity.*;
import com.panda.service.origin.*;
import com.panda.util.CombineBeansUtil;
import com.panda.util.DateUtil;
import com.panda.util.abs.AbstractMapper;
import com.panda.util.abs.AbstractServiceImpl;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import javax.annotation.Resource;
import java.util.*;

/**
 * Created with IDEA.
 *
 * @AUTH: Alan
 * Date: 2017/11/28
 * Time: 22:21
 */
@Service
public class MachinTeaServiceImpl extends AbstractServiceImpl<MachinTea> implements MachinTeaService {
    //茶叶加工设置
    @Resource
    private MachinSetService machinSetService;
    //茶叶加工
    @Resource
    private MachinTeaMapper machinTeaMapper;
    //生产线
    @Resource
    private AssemblySetService assemblySetService;
    //鲜叶批次
    @Resource
    private HarvestRecordsService harvestRecordsService;
    //质检
    @Resource
    private QualityService qualityService;
    //半成品库
    @Resource
    private SemiFinishedService semiFinishedService;
    //QC标签
    @Resource
    private TagsService tagsService;
    //包材
    @Resource
    private PackageService packageService;
    //成品
    @Resource
    private FinishedService finishedService;
    //产品管理
    @Resource
    private ProductsService productsService;
    //设备清洁和保养
    @Resource
    private EquipmentMaintainService equipmentMaintainService;
    //计算时间差公用方法
    @Autowired
    private WitherController witherController;

    @Override
    protected AbstractMapper<MachinTea> getAbstractMapper() {
        return machinTeaMapper;
    }

    /**
     * 查询所有的设置记录返回 List列表 包含设置的字典数据 入参 Map
     * (dicMacType,dicTeaAttr,dicMacPro,dicTeaType,dicTeaGra,status)
     *
     * @param map
     * @return
     */
    @Override
    public List<Map> selectMachinTeaDataList(Map map) {
        return machinTeaMapper.selectMachinTeaDataList(map);
    }

    /**
     * 查询一条记录 返回 Map 包含设置的字典数据
     *
     * @param id
     * @return
     */
    @Override
    public Map selectMachinTeaDataByOne(String id) {
        return machinTeaMapper.selectMachinTeaDataByOne(id);
    }

    /**
     * 根据加工批次号 获取该批次所用时间和产品名称
     *
     * @param processBatchId
     * @return
     */
    @Override
    public Map selectMachinTimeAndMachinProduct(String processBatchId) {
        return machinTeaMapper.selectMachinTimeAndMachinProduct(processBatchId);
    }

    /**
     * 新增和编辑萎凋工序数据
     * 萎凋完成时，自动创建杀青数据
     *
     * @param machinTea
     * @return
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackFor = {Exception.class})
    public Integer saveOrUpdateWither(MachinTea machinTea) {
        Users user = (Users) SecurityUtils.getSubject().getPrincipal();
        Integer resultStatus = 0;
        try {
            if (machinTea != null && !machinTea.getId().isEmpty()) {
                if (machinTea.getMachinStatus() != null && machinTea.getMachinStatus() == 2) {
                    MachinTea createKillOut = null;
                    Integer rollStatus = 0;
                    List<MachinTea> rollingList = machinTeaMapper.selectMachinTeaGroupData(machinTea.getId());
                    if (rollingList != null && rollingList.size() > 0 && rollingList.get(0).getStatus() == 1) {
                        for (MachinTea item : rollingList) {
                            if (item.getRollStatus() > rollStatus) {
                                rollStatus = item.getRollStatus();
                                createKillOut = item;
                            }
                            item.setMachinStatus(2);
                            item.setStatus(2);
                            item.setModifyId(user.getId());
                            item.setModifyTime(new Date());
                            machinTeaMapper.updateByPrimaryKeySelective(item);
                        }
                        if (createKillOut.getDicMacValue().equals("wither")) {
                            //绿茶 创建杀青数据
                            if (createKillOut.getDicTeaAttr().equals("4c23ef06-e0b5-49ae-947b-bb1ff3af9118")) {
                                Map data = witherController.sumMachinSetTime("68b1f56c-82df-4afe-bc06-d26017c891a1");
                                if (data != null && data.size() > 0) {
                                    createKillOut.setId(UUID.randomUUID().toString());
                                    createKillOut.setDicMacType(data.get("dicMacType").toString());
                                    createKillOut.setDicMacValue(data.get("dicMacValue").toString());
                                    createKillOut.setBeginTime(DateUtil.stringToDate(data.get("beginTime").toString(), "yyyy-MM-dd HH:mm:ss"));
                                    createKillOut.setEndTime(DateUtil.stringToDate(data.get("endTime").toString(), "yyyy-MM-dd HH:mm:ss"));
                                    createKillOut.setRollStatus(Integer.valueOf(data.get("roll_status").toString()));
                                    createKillOut.setTemperature(Integer.valueOf(data.get("temperature").toString()));
                                    createKillOut.setHumidity(Integer.valueOf(data.get("humidity").toString()));
                                    createKillOut.setCreateId(user.getId());
                                    createKillOut.setCreateTime(new Date());
                                    createKillOut.setMachinSetId(data.get("id").toString());//杀青设置ID
                                    createKillOut.setMachinStatus(1);
                                    createKillOut.setStatus(1);
                                    int s = machinTeaMapper.insertSelective(createKillOut);
                                    if (s > 0) {
                                        resultStatus = 200;
                                    } else {
                                        TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                                        resultStatus = 101;
                                    }
                                } else {
                                    TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                                    resultStatus = 101;
                                }
                            } else if (createKillOut.getDicTeaAttr().equals("8a3e0d08-ca66-48b7-9924-b98d98fd193d")) {
                                //红茶 创建揉捻数据
                                Map query = new HashMap();
                                query.put("dicTeaAttr", createKillOut.getDicTeaAttr());
                                query.put("dicMacPro", "8aa97837-a152-49be-98b8-47a11c3b1de4");
                                List<Map> macSetList = machinSetService.selectMachinSetDataList(query);
                                if (macSetList != null && macSetList.size() > 0) {
                                    for (Map item : macSetList) {
                                        // 四次揉捻
                                        Map data = witherController.sumMachinSetTime(item.get("id").toString());
                                        if (data != null && data.size() > 0) {
                                            createKillOut.setId(UUID.randomUUID().toString());
                                            createKillOut.setDicMacType(data.get("dicMacType").toString());
                                            createKillOut.setDicMacValue(data.get("dicMacValue").toString());
                                            createKillOut.setBeginTime(DateUtil.stringToDate(data.get("beginTime").toString(), "yyyy-MM-dd HH:mm:ss"));
                                            createKillOut.setEndTime(DateUtil.stringToDate(data.get("endTime").toString(), "yyyy-MM-dd HH:mm:ss"));
                                            createKillOut.setRollStatus(Integer.valueOf(data.get("roll_status").toString()));
                                            createKillOut.setTemperature(Integer.valueOf(data.get("temperature").toString()));
                                            createKillOut.setDicRollType(item.get("rollTypeId").toString());
                                            createKillOut.setHumidity(Integer.valueOf(data.get("humidity").toString()));
                                            createKillOut.setCreateId(user.getId());
                                            createKillOut.setDescription(item.get("description").toString());
                                            createKillOut.setCreateTime(new Date());
                                            createKillOut.setMachinSetId(data.get("id").toString());//设置ID
                                            createKillOut.setMachinStatus(1);
                                            createKillOut.setStatus(1);
                                            int s = machinTeaMapper.insertSelective(createKillOut);
                                            if (s > 0) {
                                                resultStatus = 200;
                                            }
                                        } else {
                                            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                                        }
                                    }
                                    //创建设备维护记录
//                                    AssemblySet assemblySet = assemblySetService.selectByPrimaryKey(createKillOut.getAssemblySetId());
//                                    if (assemblySet.getRunNum() == assemblySet.getMaintainClear() || assemblySet.getRunNum() == assemblySet.getMaintainCycle()){
//                                        equipmentMaintainService.createEquipmentMaintainData(assemblySet,"8aa97837-a152-49be-98b8-47a11c3b1de4");
//                                    }
                                } else {
                                    TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                                }
                            }
                        } else {
                            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                            resultStatus = 101;
                        }
                    }else{
                        machinTeaMapper.updateByPrimaryKeySelective(machinTea);
                        resultStatus = 200;
                    }
                }else{
                    machinTeaMapper.updateByPrimaryKeySelective(machinTea);
                    resultStatus = 200;
                }
            } else if (machinTea.getId().isEmpty()) {
                machinTea.setId(UUID.randomUUID().toString());
                machinTea.setStatus(1);
                machinTea.setMachinStatus(1);
                int i = machinTeaMapper.insertSelective(machinTea);
                if (i > 0) {
                    //更新鲜叶批次为在加工
                    HarvestRecords harvestRecords = new HarvestRecords();
                    harvestRecords.setId(machinTea.getHarvestBatchId());
                    harvestRecords.setStatus(1);
                    int h = harvestRecordsService.updateByPrimaryKeySelective(harvestRecords);
                    if (h > 0) {
                        //更新生产线运行次数
                        AssemblySet assemblySet = assemblySetService.selectByPrimaryKey(machinTea.getAssemblySetId());
                        assemblySet.setRunNum(assemblySet.getRunNum()+1);
                        assemblySet.setAllRunNum(assemblySet.getAllRunNum()+1);
                        int c = assemblySetService.updateByPrimaryKeySelective(assemblySet);
                        resultStatus = 200;
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
     * 查询当前批次下是否有多条记录
     *
     * @param id
     * @return
     */
    @Override
    public Map checkOutHarvestBatchIdList(String id) {
        return machinTeaMapper.checkOutHarvestBatchIdList(id);
    }

    /**
     * 删除萎凋数据时 判断有无下级数据，有，不可删，无，删除并还原鲜叶批次
     * 检查当前删除的记录是否为当前批次的最后一次添加的记录,不是最后一条时，删除失败
     *
     * @param id
     * @return
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackFor = {Exception.class})
    public Integer delWitherItem(String id, String type) {
        Integer resultStatus = 0;
        try {
            if (!id.isEmpty()) {
                Map lastItem = machinTeaMapper.checkOutHarvestBatchIdList(id);
                if (lastItem != null && lastItem.size() > 0 && lastItem.get("id").equals(id)) {
                    if (lastItem.get("dic_mac_value").equals(type)) {
                        int i = machinTeaMapper.deleteByPrimaryKey(id);
                        if (type.equals("wither") && i > 0) {
                            HarvestRecords harvestRecords = new HarvestRecords();
                            harvestRecords.setId(lastItem.get("harvest_batch_id").toString());
                            harvestRecords.setStatus(2);
                            harvestRecordsService.updateByPrimaryKeySelective(harvestRecords);
                        }
                        resultStatus = 200;
                    } else {
                        TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                        resultStatus = 101;
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
     * 编辑杀青数据，杀青完成时，主动创建揉捻数据
     *
     * @param machinTea
     * @return
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackFor = {Exception.class})
    public Integer saveOrUpdateKillOut(MachinTea machinTea) {
        Users user = (Users) SecurityUtils.getSubject().getPrincipal();
        Integer resultStatus = 0;
        try {
            if (machinTea != null && !machinTea.getId().isEmpty()) {
                if (machinTea.getMachinStatus() != null && machinTea.getMachinStatus() == 2) {
                    MachinTea createRollData = null;
                    Integer rollStatus = 0;
                    List<MachinTea> rollingList = machinTeaMapper.selectMachinTeaGroupData(machinTea.getId());
                    if (rollingList != null && rollingList.size() > 0 && rollingList.get(0).getStatus() == 1) {
                        for (MachinTea item : rollingList) {
                            if (item.getRollStatus() > rollStatus) {
                                rollStatus = item.getRollStatus();
                                createRollData = item;
                            }
                            item.setMachinStatus(2);
                            item.setStatus(2);
                            item.setModifyId(user.getId());
                            item.setModifyTime(new Date());
                            machinTeaMapper.updateByPrimaryKeySelective(item);
                        }
                        if (createRollData != null && createRollData.getDicMacValue().equals("killOut")) {
                            Map query = new HashMap();
                            query.put("dicTeaAttr", createRollData.getDicTeaAttr());
                            query.put("dicMacPro", "8aa97837-a152-49be-98b8-47a11c3b1de4");
                            List<Map> macSetList = machinSetService.selectMachinSetDataList(query);
                            if (macSetList != null && macSetList.size() > 0) {
                                for (Map item : macSetList) {
                                    //创建揉捻数据 四次揉捻
                                    Map data = witherController.sumMachinSetTime(item.get("id").toString());
                                    if (data != null && data.size() > 0) {
                                        createRollData.setId(UUID.randomUUID().toString());
                                        createRollData.setDicMacType(data.get("dicMacType").toString());
                                        createRollData.setDicMacValue(data.get("dicMacValue").toString());
                                        createRollData.setBeginTime(DateUtil.stringToDate(data.get("beginTime").toString(), "yyyy-MM-dd HH:mm:ss"));
                                        createRollData.setEndTime(DateUtil.stringToDate(data.get("endTime").toString(), "yyyy-MM-dd HH:mm:ss"));
                                        createRollData.setRollStatus(Integer.valueOf(data.get("roll_status").toString()));
                                        createRollData.setTemperature(Integer.valueOf(data.get("temperature").toString()));
                                        createRollData.setDicRollType(item.get("rollTypeId").toString());
                                        createRollData.setHumidity(Integer.valueOf(data.get("humidity").toString()));
                                        createRollData.setCreateId(user.getId());
                                        createRollData.setDescription(item.get("description").toString());
                                        createRollData.setCreateTime(new Date());
                                        createRollData.setMachinSetId(data.get("id").toString());//杀青设置ID
                                        createRollData.setMachinStatus(1);
                                        createRollData.setStatus(1);
                                        int s = machinTeaMapper.insertSelective(createRollData);
                                        if (s > 0) {
                                            resultStatus = 200;
                                        }
                                    } else {
                                        TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                                    }
                                }
                            } else {
                                TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                            }
                        }
                    } else {
                        //表示已经生成过数据
                        machinTeaMapper.updateByPrimaryKeySelective(machinTea);
                        resultStatus = 200;
                    }
                } else {
                    machinTeaMapper.updateByPrimaryKeySelective(machinTea);
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
     * 揉捻完成，更新全部揉捻数据，主动创建数据
     * 绿茶，炒干
     * 红茶，发酵
     *
     * @param machinTea
     * @return
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackFor = {Exception.class})
    public Integer saveOrUpdateRolling(MachinTea machinTea) {
        Users user = (Users) SecurityUtils.getSubject().getPrincipal();
        Integer resultStatus = 0;
        try {
            if (machinTea != null && !machinTea.getId().isEmpty()) {
                if (machinTea.getMachinStatus() != null && machinTea.getMachinStatus() == 2) {
                    MachinTea createDryTeaData = null;
                    Integer rollStatus = 0;
                    List<MachinTea> rollingList = machinTeaMapper.selectMachinTeaGroupData(machinTea.getId());
                    if (rollingList != null && rollingList.size() > 0  && rollingList.get(0).getStatus() == 1) {
                        for (MachinTea item : rollingList) {
                            if (item.getRollStatus() > rollStatus) {
                                rollStatus = item.getRollStatus();
                                createDryTeaData = item;
                            }
                            item.setMachinStatus(2);
                            item.setStatus(2);
                            item.setModifyId(user.getId());
                            item.setModifyTime(new Date());
                            machinTeaMapper.updateByPrimaryKeySelective(item);
                        }
                        if (createDryTeaData != null && createDryTeaData.getDicMacValue().equals("rolling")) {
                            //绿茶 炒干
                            if (createDryTeaData.getDicTeaAttr().equals("4c23ef06-e0b5-49ae-947b-bb1ff3af9118")) {
                                Map query = new HashMap();
                                query.put("dicTeaAttr", createDryTeaData.getDicTeaAttr());
                                query.put("dicMacPro", "c307d686-7dce-4b2f-9efb-16fbeb348de6");//炒茶 2次
                                List<Map> macSetList = machinSetService.selectMachinSetDataList(query);
                                if (macSetList != null && macSetList.size() > 0) {
                                    for (Map item : macSetList) {
                                        //创建炒干数据 2次炒干
                                        Map data = witherController.sumMachinSetTime(item.get("id").toString());
                                        if (data != null && data.size() > 0) {
                                            createDryTeaData.setId(UUID.randomUUID().toString());
                                            createDryTeaData.setDicMacType(data.get("dicMacType").toString());
                                            createDryTeaData.setDicMacValue(data.get("dicMacValue").toString());
                                            createDryTeaData.setBeginTime(DateUtil.stringToDate(data.get("beginTime").toString(), "yyyy-MM-dd HH:mm:ss"));
                                            createDryTeaData.setEndTime(DateUtil.stringToDate(data.get("endTime").toString(), "yyyy-MM-dd HH:mm:ss"));
                                            createDryTeaData.setRollStatus(Integer.valueOf(data.get("roll_status").toString()));
                                            createDryTeaData.setTemperature(Integer.valueOf(data.get("temperature").toString()));
                                            createDryTeaData.setHumidity(Integer.valueOf(data.get("humidity").toString()));
                                            createDryTeaData.setCreateId(user.getId());
                                            createDryTeaData.setDicRollType(null);
                                            createDryTeaData.setDescription(item.get("description").toString());
                                            createDryTeaData.setCreateTime(new Date());
                                            createDryTeaData.setMachinSetId(data.get("id").toString());//步骤设置ID
                                            createDryTeaData.setMachinStatus(1);
                                            createDryTeaData.setStatus(1);
                                            int s = machinTeaMapper.insertSelective(createDryTeaData);
                                            if (s > 0) {
                                                resultStatus = 200;
                                            }
                                        } else {
                                            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                                        }
                                    }
                                } else {
                                    TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                                }
                            } else if (createDryTeaData.getDicTeaAttr().equals("8a3e0d08-ca66-48b7-9924-b98d98fd193d")) {
                                //红茶 发酵
                                Map query = new HashMap();
                                query.put("dicTeaAttr", createDryTeaData.getDicTeaAttr());
                                query.put("dicMacPro", "9fd1943d-b955-4921-a1cd-76d60126e114");
                                List<Map> macSetList = machinSetService.selectMachinSetDataList(query);
                                if (macSetList != null && macSetList.size() > 0) {
                                    for (Map item : macSetList) {
                                        //创建发酵数据 1次发酵
                                        Map data = witherController.sumMachinSetTime(item.get("id").toString());
                                        if (data != null && data.size() > 0) {
                                            createDryTeaData.setId(UUID.randomUUID().toString());
                                            createDryTeaData.setDicMacType(data.get("dicMacType").toString());
                                            createDryTeaData.setDicMacValue(data.get("dicMacValue").toString());
                                            createDryTeaData.setBeginTime(DateUtil.stringToDate(data.get("beginTime").toString(), "yyyy-MM-dd HH:mm:ss"));
                                            createDryTeaData.setEndTime(DateUtil.stringToDate(data.get("endTime").toString(), "yyyy-MM-dd HH:mm:ss"));
                                            createDryTeaData.setRollStatus(Integer.valueOf(data.get("roll_status").toString()));
                                            createDryTeaData.setTemperature(Integer.valueOf(data.get("temperature").toString()));
                                            createDryTeaData.setHumidity(Integer.valueOf(data.get("humidity").toString()));
                                            createDryTeaData.setCreateId(user.getId());
                                            createDryTeaData.setDicRollType(null);
                                            createDryTeaData.setDescription(item.get("description").toString());
                                            createDryTeaData.setCreateTime(new Date());
                                            createDryTeaData.setMachinSetId(data.get("id").toString());//步骤设置ID
                                            createDryTeaData.setMachinStatus(1);
                                            createDryTeaData.setStatus(1);
                                            int s = machinTeaMapper.insertSelective(createDryTeaData);
                                            if (s > 0) {
                                                resultStatus = 200;
                                            }
                                        } else {
                                            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                                        }
                                    }
                                } else {
                                    TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                                }
                            } else {
                                TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                                resultStatus = 101;
                            }
                        }
                    }else{
                        machinTeaMapper.updateByPrimaryKeySelective(machinTea);
                        resultStatus = 200;
                    }
                } else {
                    machinTeaMapper.updateByPrimaryKeySelective(machinTea);
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
     * 获取同一组数据
     *
     * @param id
     * @return
     */
    @Override
    public List<MachinTea> selectMachinTeaGroupData(String id) {
        return machinTeaMapper.selectMachinTeaGroupData(id);
    }

    /**
     * 批量更新炒干，创建筛选数据
     * 绿茶 2次炒干-筛选
     * 红茶 1次炒干-筛选
     *
     * @param machinTea
     * @return
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackFor = {Exception.class})
    public Integer saveOrUpdateDryTea(MachinTea machinTea) {
        Users user = (Users) SecurityUtils.getSubject().getPrincipal();
        Integer resultStatus = 0;
        try {
            if (machinTea != null && !machinTea.getId().isEmpty()) {
                if (machinTea.getMachinStatus() != null && machinTea.getMachinStatus() == 2) {
                    Map query = new HashMap(2);
                    MachinTea createDryTeaData = null;
                    Integer rollStatus = 0;
                    List<MachinTea> rollingList = machinTeaMapper.selectMachinTeaGroupData(machinTea.getId());
                    if (rollingList != null && rollingList.size() > 0  && rollingList.get(0).getStatus() == 1) {
                        for (MachinTea item : rollingList) {
                            if (item.getRollStatus() > rollStatus) {
                                rollStatus = item.getRollStatus();
                                createDryTeaData = item;
                            }
                            if (createDryTeaData.getDicMacValue().equals("dryTea")){
                                //创建抽检数据 -- 绿茶 01b33909-73b8-45d9-af2e-5f57a22895c1
                                int i = qualityService.createQualityData(item);
                                if (i != 200){
                                    TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                                }
                            }
                            item.setMachinStatus(2);
                            item.setStatus(2);
                            item.setModifyId(user.getId());
                            item.setModifyTime(new Date());
                            machinTeaMapper.updateByPrimaryKeySelective(item);
                        }
                        if (createDryTeaData != null && createDryTeaData.getDicMacValue().equals("dryTea")) {
                            /**
                             * 红茶 一次炒干 - 筛选 - 质检- 复炒 为一次炒干后 10 天进行
                             * 9fd1943d-b955-4921-a1cd-76d60126e114 发酵
                             * c307d686-7dce-4b2f-9efb-16fbeb348de6 炒干
                             * f9e96bed-6103-4a14-9135-e69b7392dc78 复炒
                             */

                            query.put("dicTeaAttr", createDryTeaData.getDicTeaAttr());
                            query.put("dicMacPro", "590b26ce-356c-4a4f-82f3-b02aca313238");
                            List<Map> macSetList = machinSetService.selectMachinSetDataList(query);
                            if (macSetList != null && macSetList.size() > 0) {
                                for (Map item : macSetList) {
                                    //创建筛选数据
                                    Map data = witherController.sumMachinSetTime(item.get("id").toString());
                                    if (data != null && data.size() > 0) {
                                        createDryTeaData.setId(UUID.randomUUID().toString());
                                        createDryTeaData.setDicMacType(data.get("dicMacType").toString());
                                        createDryTeaData.setDicMacValue(data.get("dicMacValue").toString());
                                        createDryTeaData.setBeginTime(DateUtil.stringToDate(data.get("beginTime").toString(), "yyyy-MM-dd HH:mm:ss"));
                                        createDryTeaData.setEndTime(DateUtil.stringToDate(data.get("endTime").toString(), "yyyy-MM-dd HH:mm:ss"));
                                        createDryTeaData.setRollStatus(Integer.valueOf(data.get("roll_status").toString()));
                                        createDryTeaData.setTemperature(Integer.valueOf(data.get("temperature").toString()));
                                        createDryTeaData.setHumidity(Integer.valueOf(data.get("humidity").toString()));
                                        createDryTeaData.setCreateId(user.getId());
                                        createDryTeaData.setDicRollType(null);
                                        createDryTeaData.setDescription(item.get("description").toString());
                                        createDryTeaData.setCreateTime(new Date());
                                        createDryTeaData.setMachinSetId(data.get("id").toString());
                                        createDryTeaData.setMachinStatus(1);
                                        createDryTeaData.setStatus(1);
                                        int s = machinTeaMapper.insertSelective(createDryTeaData);
                                        if (s > 0) {
                                            resultStatus = 200;
                                        }
                                    } else {
                                        TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                                    }
                                }
                            } else {
                                TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                            }
                        } else {
                            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                            resultStatus = 101;
                        }
                    }else{
                        machinTeaMapper.updateByPrimaryKeySelective(machinTea);
                        resultStatus = 200;
                    }
                } else {
                    machinTeaMapper.updateByPrimaryKeySelective(machinTea);
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
     * 红茶发酵后炒干 只操作发酵后的流程
     *
     * @param machinTea
     * @return
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackFor = {Exception.class})
    public Integer saveOrUpdateFermentation(MachinTea machinTea) {
        Users user = (Users) SecurityUtils.getSubject().getPrincipal();
        Integer resultStatus = 0;
        try {
            if (machinTea != null && !machinTea.getId().isEmpty()) {
                if (machinTea.getMachinStatus() != null && machinTea.getMachinStatus() == 2) {
                    MachinTea createDryTeaData = null;
                    Integer rollStatus = 0;
                    List<MachinTea> rollingList = machinTeaMapper.selectMachinTeaGroupData(machinTea.getId());
                    if (rollingList != null && rollingList.size() > 0  && rollingList.get(0).getStatus() == 1) {
                        for (MachinTea item : rollingList) {
                            if (item.getRollStatus() > rollStatus) {
                                rollStatus = item.getRollStatus();
                                createDryTeaData = item;
                            }
                            item.setMachinStatus(2);
                            item.setStatus(2);
                            item.setModifyId(user.getId());
                            item.setModifyTime(new Date());
                            machinTeaMapper.updateByPrimaryKeySelective(item);
                        }
                        if (createDryTeaData != null && createDryTeaData.getDicMacValue().equals("fermentation")) {
                            //红茶 炒干 1次
                            if (createDryTeaData.getDicTeaAttr().equals("8a3e0d08-ca66-48b7-9924-b98d98fd193d")) {
                                Map query = new HashMap(2);
                                query.put("dicTeaAttr", createDryTeaData.getDicTeaAttr());
                                query.put("dicMacPro", "c307d686-7dce-4b2f-9efb-16fbeb348de6");
                                List<Map> macSetList = machinSetService.selectMachinSetDataList(query);
                                if (macSetList != null && macSetList.size() > 0) {
                                    for (Map item : macSetList) {
                                        //创建炒干数据 1次炒干
                                        Map data = witherController.sumMachinSetTime(item.get("id").toString());
                                        if (data != null && data.size() > 0) {
                                            createDryTeaData.setId(UUID.randomUUID().toString());
                                            createDryTeaData.setDicMacType(data.get("dicMacType").toString());
                                            createDryTeaData.setDicMacValue(data.get("dicMacValue").toString());
                                            createDryTeaData.setBeginTime(DateUtil.stringToDate(data.get("beginTime").toString(), "yyyy-MM-dd HH:mm:ss"));
                                            createDryTeaData.setEndTime(DateUtil.stringToDate(data.get("endTime").toString(), "yyyy-MM-dd HH:mm:ss"));
                                            createDryTeaData.setRollStatus(Integer.valueOf(data.get("roll_status").toString()));
                                            createDryTeaData.setTemperature(Integer.valueOf(data.get("temperature").toString()));
                                            createDryTeaData.setHumidity(Integer.valueOf(data.get("humidity").toString()));
                                            createDryTeaData.setCreateId(user.getId());
                                            createDryTeaData.setDicRollType(null);
                                            createDryTeaData.setDescription(item.get("description").toString());
                                            createDryTeaData.setCreateTime(new Date());
                                            createDryTeaData.setMachinSetId(data.get("id").toString());
                                            createDryTeaData.setMachinStatus(1);
                                            createDryTeaData.setStatus(1);
                                            int s = machinTeaMapper.insertSelective(createDryTeaData);
                                            if (s > 0) {
                                                resultStatus = 200;
                                            }
                                        } else {
                                            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                                        }
                                    }
                                } else {
                                    TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                                }
                            } else {
                                TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                                resultStatus = 101;
                            }
                        } else {
                            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                            resultStatus = 101;
                        }
                    }else{
                        machinTeaMapper.updateByPrimaryKeySelective(machinTea);
                        resultStatus = 200;
                    }
                } else {
                    machinTeaMapper.updateByPrimaryKeySelective(machinTea);
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
     * 筛选工序 完成，半成品入库 红茶-绿茶
     * 绿茶-半成品入库
     * 红茶-半成品入库-复烤 十天以后
     * @param machinTea
     * @return
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackFor = {Exception.class})
    public Integer saveOrUpdateFiltrate(MachinTea machinTea) {
        Users user = (Users) SecurityUtils.getSubject().getPrincipal();
        Integer resultStatus = 0;
        try {
            if (machinTea != null && !machinTea.getId().isEmpty()) {
                if (machinTea.getMachinStatus() != null && machinTea.getMachinStatus() == 2) {
                    MachinTea createSemiFinishedData = null;
                    Integer rollStatus = 0;
                    List<MachinTea> rollingList = machinTeaMapper.selectMachinTeaGroupData(machinTea.getId());
                    if (rollingList != null && rollingList.size() > 0  && rollingList.get(0).getStatus() == 1) {
                        for (MachinTea item : rollingList) {
                            if (item.getRollStatus() > rollStatus) {
                                rollStatus = item.getRollStatus();
                                createSemiFinishedData = item;
                            }
                        }
                        if (createSemiFinishedData != null && createSemiFinishedData.getDicMacValue().equals("filtrate") && createSemiFinishedData.getStatus() == 1) {
                            //合并2个对象
                            CombineBeansUtil.combineSydwCore(machinTea, createSemiFinishedData);
                            //半成品入库
                            int i = semiFinishedService.createSemiFinishedData(createSemiFinishedData);
                            if (i != 200){
                                TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                                resultStatus = 101;
                            }else{
                                //更新记录 筛选记录
                                createSemiFinishedData.setStatus(2);
                                machinTeaMapper.updateByPrimaryKeySelective(createSemiFinishedData);
                                resultStatus = 200;
                            }
                        } else {
                            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                            resultStatus = 101;
                        }
                    }else{
                        machinTeaMapper.updateByPrimaryKeySelective(machinTea);
                        resultStatus = 200;
                    }
                } else {
                    machinTeaMapper.updateByPrimaryKeySelective(machinTea);
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
     * 获取制定批次的茶系信息
     * @param harvestBatchId
     * @return
     */
    @Override
    public Map getDicTeaAttrData(String harvestBatchId){
        return machinTeaMapper.getDicTeaAttrData(harvestBatchId);
    }

    /**
     * 半成品出库-创建复炒，数据记录。
     * 绿茶复炒
     * 红茶复烤
     * 数据来源。加工记录-筛选-和出库记录
     * @param semi
     * @return
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackFor = {Exception.class})
    public Integer createRoastingData(SemiFinished semi){
        Users user = (Users) SecurityUtils.getSubject().getPrincipal();
        Integer resultStatus = 0;
        try {
            if (semi.getMachinTeaId() != null && !semi.getMachinTeaId().equals("")) {
                MachinTea roastData = machinTeaMapper.selectByPrimaryKey(semi.getMachinTeaId());
                if (roastData.getDicMacValue().equals("filtrate") && roastData.getStatus() == 2) {
                    Map query = new HashMap(2);
                    query.put("dicTeaAttr", roastData.getDicTeaAttr());
                    query.put("dicMacPro", "f9e96bed-6103-4a14-9135-e69b7392dc78");
                    List<Map> macSetList = machinSetService.selectMachinSetDataList(query);
                    if (macSetList != null && macSetList.size() > 0) {
                        for (Map item : macSetList) {
                            //创建 复炒，复烤数据
                            Map data = witherController.sumMachinSetTime(item.get("id").toString());
                            if (data != null && data.size() > 0) {
                                roastData.setId(UUID.randomUUID().toString());
                                roastData.setDicMacType(data.get("dicMacType").toString());
                                roastData.setDicMacValue(data.get("dicMacValue").toString());
                                roastData.setBeginTime(DateUtil.stringToDate(data.get("beginTime").toString(), "yyyy-MM-dd HH:mm:ss"));
                                roastData.setEndTime(DateUtil.stringToDate(data.get("endTime").toString(), "yyyy-MM-dd HH:mm:ss"));
                                roastData.setRollStatus(Integer.valueOf(data.get("roll_status").toString()));
                                roastData.setTemperature(Integer.valueOf(data.get("temperature").toString()));
                                roastData.setHumidity(Integer.valueOf(data.get("humidity").toString()));
                                roastData.setCreateId(user.getId());
                                roastData.setDescription(item.get("description").toString());
                                roastData.setDicRollType(null);
                                roastData.setCreateTime(new Date());
                                roastData.setMachinSetId(data.get("id").toString());
                                roastData.setMachinStatus(1);
                                roastData.setStatus(1);
                                int s = machinTeaMapper.insertSelective(roastData);
                                if (s > 0) {
                                    resultStatus = 200;
                                }
                            } else {
                                resultStatus = 101;
                            }
                        }
                    } else {
                        resultStatus = 101;
                    }
                }
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

    /**
     * 复炒完成--创建提香数据
     * 提香类型ID -- 9d9438d9-7746-4b14-adb7-d29136b1778a
     * @param machinTea
     * @return
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackFor = {Exception.class})
    public Integer saveOrUpdateRoasting(MachinTea machinTea){
        Users user = (Users) SecurityUtils.getSubject().getPrincipal();
        Integer resultStatus = 0;
        try {
            if (machinTea.getId() != null && !machinTea.getId().equals("")) {
                MachinTea titianData = machinTeaMapper.selectByPrimaryKey(machinTea.getId());
                if (titianData != null) {
                    //红茶抽检--二次抽检--创建数据
                    if (titianData.getDicMacValue().equals("roasting") && titianData.getDicTeaAttr().equals("8a3e0d08-ca66-48b7-9924-b98d98fd193d")) {
                        int i = qualityService.createQualityData(titianData);
                        if (i != 200){
                            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                        }
                    }
                    if (titianData.getDicMacValue().equals("roasting") && titianData.getStatus() == 1) {
                        Map query = new HashMap(2);
                        query.put("dicTeaAttr", titianData.getDicTeaAttr());
                        query.put("dicMacPro", "9d9438d9-7746-4b14-adb7-d29136b1778a");
                        List<Map> macSetList = machinSetService.selectMachinSetDataList(query);
                        if (macSetList != null && macSetList.size() > 0) {
                            for (Map item : macSetList) {
                                //创建 提香数据
                                Map data = witherController.sumMachinSetTime(item.get("id").toString());
                                if (data != null && data.size() > 0) {
                                    titianData.setId(UUID.randomUUID().toString());
                                    titianData.setDicMacType(data.get("dicMacType").toString());
                                    titianData.setDicMacValue(data.get("dicMacValue").toString());
                                    titianData.setBeginTime(DateUtil.stringToDate(data.get("beginTime").toString(), "yyyy-MM-dd HH:mm:ss"));
                                    titianData.setEndTime(DateUtil.stringToDate(data.get("endTime").toString(), "yyyy-MM-dd HH:mm:ss"));
                                    titianData.setRollStatus(Integer.valueOf(data.get("roll_status").toString()));
                                    titianData.setTemperature(Integer.valueOf(data.get("temperature").toString()));
                                    titianData.setHumidity(Integer.valueOf(data.get("humidity").toString()));
                                    titianData.setCreateId(user.getId());
                                    titianData.setDicRollType(null);
                                    titianData.setDescription(item.get("description").toString());
                                    titianData.setCreateTime(new Date());
                                    titianData.setMachinSetId(data.get("id").toString());
                                    titianData.setMachinStatus(1);
                                    titianData.setStatus(1);
                                    titianData.setTeaGradeOne(machinTea.getTeaGradeOne());
                                    titianData.setTeaGradeTwo(machinTea.getTeaGradeTwo());
                                    int s = machinTeaMapper.insertSelective(titianData);
                                    if (s > 0) {
                                        resultStatus = 200;
                                    }
                                } else {
                                    resultStatus = 101;
                                }
                            }
                            machinTea.setStatus(2);
                            machinTeaMapper.updateByPrimaryKeySelective(machinTea);
                            resultStatus = 200;
                        } else {
                            resultStatus = 101;
                        }
                    }else{
                        machinTeaMapper.updateByPrimaryKeySelective(machinTea);
                        //TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                        resultStatus = 200;
                    }
                }
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

    /**
     * 提香完成--包装数据创建
     * @param machinTea
     * @return
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackFor = {Exception.class})
    public Integer saveOrUpdateTitian(MachinTea machinTea){
        Users user = (Users) SecurityUtils.getSubject().getPrincipal();
        Integer resultStatus = 0;
        try {
            if (machinTea.getId() != null && !machinTea.getId().equals("")) {
                MachinTea titianData = machinTeaMapper.selectByPrimaryKey(machinTea.getId());
                if (titianData != null) {
                    if (titianData.getDicMacValue().equals("titian") && titianData.getStatus() == 1) {
                        Map query = new HashMap(2);
                        query.put("dicTeaAttr", titianData.getDicTeaAttr());
                        query.put("dicMacPro", "aaf83ae9-8e7e-4b55-be3d-d36f822d0b6a");
                        List<Map> macSetList = machinSetService.selectMachinSetDataList(query);
                        if (macSetList != null && macSetList.size() > 0) {
                            for (Map item : macSetList) {
                                //创建 包装数据
                                Map data = witherController.sumMachinSetTime(item.get("id").toString());
                                if (data != null && data.size() > 0) {
                                    titianData.setId(UUID.randomUUID().toString());
                                    titianData.setDicMacType(data.get("dicMacType").toString());
                                    titianData.setDicMacValue(data.get("dicMacValue").toString());
                                    titianData.setBeginTime(DateUtil.stringToDate(data.get("beginTime").toString(), "yyyy-MM-dd HH:mm:ss"));
                                    titianData.setEndTime(DateUtil.stringToDate(data.get("endTime").toString(), "yyyy-MM-dd HH:mm:ss"));
                                    titianData.setRollStatus(Integer.valueOf(data.get("roll_status").toString()));
                                    titianData.setTemperature(Integer.valueOf(data.get("temperature").toString()));
                                    titianData.setHumidity(Integer.valueOf(data.get("humidity").toString()));
                                    titianData.setCreateId(user.getId());
                                    titianData.setDicRollType(null);
                                    titianData.setDescription(item.get("description").toString());
                                    titianData.setCreateTime(new Date());
                                    titianData.setMachinSetId(data.get("id").toString());
                                    titianData.setMachinStatus(1);
                                    titianData.setStatus(1);
                                    titianData.setTeaGradeOne(machinTea.getTeaGradeOne());
                                    titianData.setTeaGradeTwo(machinTea.getTeaGradeTwo());
                                    int s = machinTeaMapper.insertSelective(titianData);
                                    if (s > 0) {
                                        resultStatus = 200;
                                    }
                                } else {
                                    resultStatus = 101;
                                }
                            }
                            machinTea.setStatus(2);
                            machinTeaMapper.updateByPrimaryKeySelective(machinTea);
                        } else {
                            resultStatus = 101;
                        }
                    }else{
                        machinTeaMapper.updateByPrimaryKeySelective(machinTea);
                        resultStatus = 200;
                    }
                }
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

    /**
     * 包装完成-成品入库
     * 当事务传播被设置PROPAGATION_REQUIRED的时候 将多个事物合并成一个来处理
     * propagation = Propagation.REQUIRED,
     * @param machinTea
     * @return
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackFor = {Exception.class})
    public Integer saveOrUpdatePackageing(MachinTea machinTea,List<Map<String,String>> params){
        Users user = (Users) SecurityUtils.getSubject().getPrincipal();
        Integer resultStatus = 0;
        Integer reStatusAllSum = 0;
        try {
            if (params.size() > 0 && machinTea.getId() != null && !machinTea.getId().equals("") && machinTea.getMachinStatus()!=null) {
                MachinTea packageing = machinTeaMapper.selectByPrimaryKey(machinTea.getId());
                if (params.size() > 0 && packageing != null && packageing.getStatus() == 1){
                    CombineBeansUtil.combineSydwCore(machinTea,packageing);
                    Tags tags    = new Tags();
                    Package pack = new Package();
                    Finished fin = new Finished();
                    for (Map item : params){
                        if (item.get("priductIdOne") !=null && !item.get("priductIdOne").equals("") && !item.get("finishedQuantityOne").equals("") && !item.get("tagIdOne").equals("")){
                            Products proItem = productsService.selectByPrimaryKey(item.get("priductIdOne").toString());
                            if (proItem != null && proItem.getId().equals(item.get("priductIdOne")+"")){
                                Integer allQuan = Integer.valueOf(item.get("finishedQuantityOne")+"");
                                //标签数组
                                String[] tagArr = item.get("tagIdOne").toString().split(",");
                                if (tagArr.length > 0 && allQuan > 0){
                                    //取余
                                    Integer rem = allQuan%tagArr.length;
                                    Integer average = (allQuan-rem)/tagArr.length;
                                    for (int i=0;i<tagArr.length; i++){
                                        //减去标签库存
                                        tags.setId(tagArr[i]);
                                        if (i+1 == tagArr.length){
                                            tags.setTagUse(average+rem);
                                        }else{
                                            tags.setTagUse(average);
                                        }
                                        int inTag = tagsService.inventoryTagsReduction(tags);
                                        if (inTag != 200){
                                            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                                            resultStatus = inTag;
                                            break;
                                        }
                                    }
                                    //包材更新数量 减去包材库存
                                    pack.setId(proItem.getPackageId());
                                    pack.setPackageUse(allQuan);
                                    int inpac = packageService.inventoryPackageReduction(pack);
                                    if (inpac != 200){
                                        TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                                        resultStatus = inpac;
                                        break;
                                    }
                                    if (resultStatus == 0){
                                        //成品入库
                                        fin.setId(UUID.randomUUID().toString());
                                        fin.setHarvestBatchId(packageing.getHarvestBatchId());
                                        fin.setDicTeaAttr(packageing.getDicTeaAttr());
                                        fin.setDicTeaType(packageing.getDicTeaType());
                                        fin.setPriductId(proItem.getId());
                                        fin.setPackaingId(proItem.getPackageId());
                                        fin.setPrincipal(user.getChineseName());
                                        fin.setFinishedType(proItem.getProductType());
                                        fin.setFinishedName(proItem.getProductName());
                                        fin.setFinishedQuantity(allQuan);
                                        fin.setLastQuantity(Double.valueOf(item.get("lastQuantityOne").toString()));
                                        fin.setStatus(1);
                                        fin.setTagId(item.get("tagIdOne").toString());
                                        fin.setCreateId(user.getId());
                                        fin.setCreateTime(new Date());
                                        int infin = finishedService.createFinishedData(fin);
                                        if (infin == 200) {
                                            reStatusAllSum ++;
                                        }else{
                                            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                                            resultStatus = 101;
                                            break;
                                        }
                                    }
                                }
                            }else{
                                resultStatus = 101;
                                break;
                            }
                        }
                        if (item.get("priductIdTwo") !=null && !item.get("priductIdTwo").equals("") && !item.get("finishedQuantityTwo").equals("") && !item.get("tagIdTwo").equals("")){
                            Products proItem = productsService.selectByPrimaryKey(item.get("priductIdTwo").toString());
                            if (proItem != null && proItem.getId().equals(item.get("priductIdTwo")+"")){
                                Integer allQuan = Integer.valueOf(item.get("finishedQuantityTwo")+"");
                                //标签数组
                                String[] tagArr = item.get("tagIdTwo").toString().split(",");
                                if (tagArr.length > 0 && allQuan > 0){
                                    //取余
                                    Integer rem = allQuan%tagArr.length;
                                    Integer average = (allQuan-rem)/tagArr.length;
                                    for (int i=0;i<tagArr.length; i++){
                                        //减去标签库存
                                        tags.setId(tagArr[i]);
                                        if (i+1 == tagArr.length){
                                            tags.setTagUse(average+rem);
                                        }else{
                                            tags.setTagUse(average);
                                        }
                                        int inTag = tagsService.inventoryTagsReduction(tags);
                                        if (inTag != 200){
                                            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                                            resultStatus = inTag;
                                            break;
                                        }
                                    }
                                    //包材更新数量 减去包材库存
                                    pack.setId(proItem.getPackageId());
                                    pack.setPackageUse(allQuan);
                                    int inpac = packageService.inventoryPackageReduction(pack);
                                    if (inpac != 200){
                                        TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                                        resultStatus = inpac;
                                        break;
                                    }
                                    if (resultStatus == 0){
                                        //成品入库
                                        fin.setId(UUID.randomUUID().toString());
                                        fin.setHarvestBatchId(packageing.getHarvestBatchId());
                                        fin.setDicTeaAttr(packageing.getDicTeaAttr());
                                        fin.setDicTeaType(packageing.getDicTeaType());
                                        fin.setPriductId(proItem.getId());
                                        fin.setFinishedType(proItem.getProductType());
                                        fin.setFinishedName(proItem.getProductName());
                                        fin.setFinishedQuantity(allQuan);
                                        fin.setLastQuantity(Double.valueOf(item.get("lastQuantityTwo").toString()));
                                        fin.setStatus(1);
                                        fin.setPackaingId(proItem.getPackageId());
                                        fin.setPrincipal(user.getChineseName());
                                        fin.setTagId(item.get("tagIdTwo").toString());
                                        fin.setCreateId(user.getId());
                                        fin.setCreateTime(new Date());
                                        int infin = finishedService.createFinishedData(fin);
                                        if (infin == 200) {
                                            reStatusAllSum ++;
                                        }else{
                                            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                                            resultStatus = 101;
                                            break;
                                        }
                                    }
                                }
                            }else{
                                resultStatus = 101;
                                break;
                            }
                        }
                        if (item.get("priductIdThree") !=null && !item.get("priductIdThree").equals("") && !item.get("finishedQuantityThree").equals("") && !item.get("tagIdThree").equals("")){
                            Products proItem = productsService.selectByPrimaryKey(item.get("priductIdThree").toString());
                            if (proItem != null && proItem.getId().equals(item.get("priductIdThree")+"")){
                                Integer allQuan = Integer.valueOf(item.get("finishedQuantityThree")+"");
                                //标签数组
                                String[] tagArr = item.get("tagIdThree").toString().split(",");
                                if (tagArr.length > 0 && allQuan > 0){
                                    //取余
                                    Integer rem = allQuan%tagArr.length;
                                    Integer average = (allQuan-rem)/tagArr.length;
                                    for (int i=0;i<tagArr.length; i++){
                                        //减去标签库存
                                        tags.setId(tagArr[i]);
                                        if (i+1 == tagArr.length){
                                            tags.setTagUse(average+rem);
                                        }else{
                                            tags.setTagUse(average);
                                        }
                                        int inTag = tagsService.inventoryTagsReduction(tags);
                                        if (inTag != 200){
                                            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                                            resultStatus = inTag;
                                            break;
                                        }
                                    }
                                    //包材更新数量 减去包材库存
                                    pack.setId(proItem.getPackageId());
                                    pack.setPackageUse(allQuan);
                                    int inpac = packageService.inventoryPackageReduction(pack);
                                    if (inpac != 200){
                                        TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                                        resultStatus = inpac;
                                        break;
                                    }
                                    if (resultStatus == 0){
                                        //成品入库
                                        fin.setId(UUID.randomUUID().toString());
                                        fin.setHarvestBatchId(packageing.getHarvestBatchId());
                                        fin.setDicTeaAttr(packageing.getDicTeaAttr());
                                        fin.setDicTeaType(packageing.getDicTeaType());
                                        fin.setPriductId(proItem.getId());
                                        fin.setFinishedType(proItem.getProductType());
                                        fin.setFinishedName(proItem.getProductName());
                                        fin.setFinishedQuantity(allQuan);
                                        fin.setLastQuantity(Double.valueOf(item.get("lastQuantityThree").toString()));
                                        fin.setStatus(1);
                                        fin.setPackaingId(proItem.getPackageId());
                                        fin.setPrincipal(user.getChineseName());
                                        fin.setTagId(item.get("tagIdThree").toString());
                                        fin.setCreateId(user.getId());
                                        fin.setCreateTime(new Date());
                                        int infin = finishedService.createFinishedData(fin);
                                        if (infin == 200) {
                                            reStatusAllSum ++;
                                        }else{
                                            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                                            resultStatus = 101;
                                            break;
                                        }
                                    }
                                }
                            }else{
                                resultStatus = 101;
                                break;
                            }
                        }
                    }
                    if (resultStatus == 0 && reStatusAllSum == params.size()){
                        packageing.setStatus(2);
                        int i = machinTeaMapper.updateByPrimaryKeySelective(packageing);
                        //更新鲜叶状态为加工完成
                        if (i > 0){
                            HarvestRecords harvestRecords = new HarvestRecords();
                            harvestRecords.setId(packageing.getHarvestBatchId());
                            harvestRecords.setStatus(3);
                            int h = harvestRecordsService.updateByPrimaryKeySelective(harvestRecords);
                            resultStatus = 200;
                        }
                    }
                }else{
                    machinTeaMapper.updateByPrimaryKeySelective(packageing);
                    resultStatus = 200;
                }
            }else{
                resultStatus = 403;
            }
        } catch (Exception e) {
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            e.printStackTrace();
            resultStatus = 101;
        }
        return resultStatus;
    }
}
