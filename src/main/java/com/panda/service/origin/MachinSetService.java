package com.panda.service.origin;

import com.panda.model.origin.MachinSet;
import com.panda.util.abs.AbstractService;

import java.util.List;
import java.util.Map;

/**
 * Created with IDEA.
 *
 * @AUTH: Alan
 * Date: 2017/11/28
 * Time: 22:20
 */
public interface MachinSetService extends AbstractService<MachinSet> {

    /**
     * 查询所有的设置记录返回 List列表 包含设置的字典数据 入参 Map
     * (dicMacType,dicTeaAttr,dicMacPro,dicTeaType,dicTeaGra,status)
     * @param map
     * @return
     */
    List<Map> selectMachinSetDataList(Map map);

    /**
     * 查询一条记录 返回 Map 包含设置的字典数据
     * @param id
     * @return
     */
    Map selectMachinSetDataByOne(String id);

    /**
     * 查询指定茶系的加工范围
     * @param id
     * @return
     */
    Integer countMachinSetDicTeaAttrNum(String id);
}
