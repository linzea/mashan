package com.panda.mapper.origin;

import com.panda.model.origin.TeaGardenLog;
import com.panda.util.abs.AbstractMapper;

import java.util.List;
import java.util.Map;

public interface TeaGardenLogMapper extends AbstractMapper<TeaGardenLog> {
    /**
     * 获取茶园管理信息
     * @param map
     * @return
     */
    List<Map> selectTeaGardenLogList(Map map);

    /**
     * 根据茶园日志ID 查询 日志详情
     * @param id
     * @return
     */
    Map selectTeaGardenLogItem(String id);
}