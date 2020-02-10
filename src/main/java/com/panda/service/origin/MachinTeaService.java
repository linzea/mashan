package com.panda.service.origin;

import com.panda.model.commodity.SemiFinished;
import com.panda.model.origin.MachinTea;
import com.panda.util.abs.AbstractService;

import java.util.List;
import java.util.Map;

/**
 * Created with IDEA.
 *
 * @AUTH: Alan
 * Date: 2017/11/28
 * Time: 22:21
 */
public interface MachinTeaService extends AbstractService<MachinTea> {
    /**
     * 查询所有的设置记录返回 List列表 包含设置的字典数据 入参 Map
     * (dicMacType,dicTeaAttr,dicMacPro,dicTeaType,dicTeaGra,status)
     * @param map
     * @return
     */
    List<Map> selectMachinTeaDataList(Map map);

    /**
     * 查询一条记录 返回 Map 包含设置的字典数据
     * @param id
     * @return
     */
    Map selectMachinTeaDataByOne(String id);

    /**
     * 根据加工批次号 获取该批次所用时间和产品名称
     * @param processBatchId
     * @return
     */
    Map selectMachinTimeAndMachinProduct(String processBatchId);

    /**
     * 新增和编辑萎凋工序数据
     * @param machinTea
     * @return
     */
    Integer saveOrUpdateWither(MachinTea machinTea);

    /**
     * 删除萎凋数据时
     * @param id
     * @return
     */
    Integer delWitherItem(String id,String type);

    /**
     * 查询当前批次下是否有多条记录
     * @param id
     * @return
     */
    Map checkOutHarvestBatchIdList(String id);

    /**
     * 编辑杀青数据，杀青完成时，主动创建揉捻数据
     * @param machinTea
     * @return
     */
    Integer saveOrUpdateKillOut(MachinTea machinTea);

    /**
     * 批量更新揉捻完成，主动创建数据
     * 绿茶，炒干
     * 红茶，发酵
     * @param machinTea
     * @return
     */
    Integer saveOrUpdateRolling(MachinTea machinTea);

    /**
     * 查找同一组加工数据，
     * @param id
     * @return
     */
    List<MachinTea> selectMachinTeaGroupData(String id);

    /**
     * 批量更新炒干，创建下一步数据
     * @param machinTea
     * @return
     */
    Integer saveOrUpdateDryTea(MachinTea machinTea);

    /**
     * 红茶发酵后炒干，
     * @param machinTea
     * @return
     */
    Integer saveOrUpdateFermentation(MachinTea machinTea);

    /**
     * 筛选工序，
     * @param machinTea
     * @return
     */
    Integer saveOrUpdateFiltrate(MachinTea machinTea);

    /**
     * 获取制定批次的茶系信息
     * @param harvestBatchId
     * @return
     */
    Map getDicTeaAttrData(String harvestBatchId);

    /**
     * 半成品出库-创建复炒，数据记录。
     * 绿茶复炒
     * 红茶复烤
     * 数据来源。加工记录-筛选-和出库记录
     * @param semi
     * @return
     */
    Integer createRoastingData(SemiFinished semi);

    /**
     * 复炒完成--创建提香数据
     * @param machinTea
     * @return
     */
    Integer saveOrUpdateRoasting(MachinTea machinTea);


    /**
     * 提香完成--成品入库--包装
     * @param machinTea
     * @return
     */
    Integer saveOrUpdateTitian(MachinTea machinTea);

    /**
     * 包装完成-成品入库
     * @param machinTea
     * @return
     */
    Integer saveOrUpdatePackageing(MachinTea machinTea,List<Map<String,String>> params);

}
