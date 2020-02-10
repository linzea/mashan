package com.panda.mapper.origin;

import com.panda.model.origin.Quality;
import com.panda.util.abs.AbstractMapper;

import java.util.List;
import java.util.Map;

public interface QualityMapper extends AbstractMapper<Quality> {

    /**
     * 获取质检列表
     * @param map
     * @return
     */
    List<Map> selectQualityDataList(Map map);

    /**
     * 获取单条质检记录
     * @param id
     * @return
     */
    Map selectQualityDataMap(String id);

    /**
     * 创建抽检数据
     * @param quality
     * @return
     */
    Integer createQualityData(Quality quality);

    /**
     * 获取当前批次质检完成，并且未绑定溯源批次
     * @param harvestBatchId
     * @return
     */
    List<Map> selectMachinOverQualityNotBindOrigin(String harvestBatchId);
}