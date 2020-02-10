package com.panda.service.origin;

import com.panda.model.origin.OriginInfo;
import com.panda.util.abs.AbstractService;

import java.util.List;
import java.util.Map;

/**
 * Created with IDEA.
 *
 * @AUTH: Alan
 * Date: 2017/12/7
 * Time: 10:53
 */
public interface OriginInfoService extends AbstractService<OriginInfo> {

    /**
     * 查询溯源信息列表
     * @param map
     * @return
     */
    List<Map> selectOriginInfoDataList(Map map);
}
