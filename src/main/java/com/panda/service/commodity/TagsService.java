package com.panda.service.commodity;

import com.panda.model.commodity.Tags;
import com.panda.util.abs.AbstractService;

import java.util.List;
import java.util.Map;

public interface TagsService extends AbstractService<Tags> {

    /**
     * 查询标签列表
     * @param map
     * @return
     */
    List<Map> selectTagsList(Map map);

    /**
     * 查询单条标签详情
     * @param id
     * @return
     */
    Map selectTagsItem(String id);

    /**
     * 成品库存增加时，减去标签库存数量
     * @return
     */
    Integer inventoryTagsReduction(Tags tags);
}
