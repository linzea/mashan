package com.panda.service.impl.origin;

import com.panda.mapper.origin.MachinSetMapper;
import com.panda.model.origin.MachinSet;
import com.panda.model.origin.MachinTea;
import com.panda.service.origin.MachinSetService;
import com.panda.util.abs.AbstractMapper;
import com.panda.util.abs.AbstractServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * Created with IDEA.
 *
 * @AUTH: Alan
 * Date: 2017/11/28
 * Time: 22:21
 */
@Service
public class MachinSetServiceImpl extends AbstractServiceImpl<MachinSet> implements MachinSetService {

    @Resource
    private MachinSetMapper machinSetMapper;

    @Override
    protected AbstractMapper<MachinSet> getAbstractMapper() {
        return machinSetMapper;
    }

    /**
     * 查询所有的设置记录返回 List列表 包含设置的字典数据 入参 Map
     * (dicMacType,dicTeaAttr,dicMacPro,dicTeaType,dicTeaGra,status)
     * @param map
     * @return
     */
    @Override
    public List<Map> selectMachinSetDataList(Map map) {
        return machinSetMapper.selectMachinSetDataList(map);
    }
    /**
     * 查询一条记录 返回 Map 包含设置的字典数据
     * @param id
     * @return
     */
    @Override
    public Map selectMachinSetDataByOne(String id) {
        return machinSetMapper.selectMachinSetDataByOne(id);
    }


    /**
     * 查询指定茶系的加工范围
     * @param id
     * @return
     */
    @Override
    public Integer countMachinSetDicTeaAttrNum(String id){
        return machinSetMapper.countMachinSetDicTeaAttrNum(id);
    }
}
