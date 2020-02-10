package com.panda.mapper.origin;

import com.panda.model.origin.HarvestRecords;
import com.panda.util.abs.AbstractMapper;

import java.util.List;
import java.util.Map;

public interface HarvestRecordsMapper extends AbstractMapper<HarvestRecords> {

    /**
     * 获取茶青采摘记录
     * @param map
     * @return
     */
    List<Map> selectHarvestRecordsList(Map map);

    /**
     * 获取茶青采摘记录编号 和 Id
     * @param map
     * @return
     */
    List<Map> selectHarvestRecordsListPickNum(Map map);

    /**
     * 获取当前编辑项详细信息
     * @param id
     * @return
     */
    Map selectHarvestRecordsItem(String id);

    /**
     * 获取采鲜叶批次的茶叶品种
     * @param id
     * @return
     */
    Map selectHarvestCultivarName(String id);

    /**
     * 鲜叶环节查看茶园信息和管理批次信息
     * @param id
     * @return
     */
    Map selectTeaGardenAndManagerBatch(String id);

    /**
     * 查询鲜叶采摘数量统计图
     * @param map
     * @return
     */
    List<Map> getHarvestQuality(Map map);

    /**
     * 查询加工完成率统计图
     * @param map
     * @return
     */
    List<Map> getHarvestMachin(Map map);
}