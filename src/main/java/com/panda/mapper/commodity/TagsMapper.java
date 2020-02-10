package com.panda.mapper.commodity;

import com.panda.model.commodity.Tags;
import com.panda.util.abs.AbstractMapper;

import java.util.List;
import java.util.Map;

public interface TagsMapper extends AbstractMapper<Tags>{

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

}