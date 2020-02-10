package com.panda.service.impl.commodity;

import com.panda.mapper.commodity.FinishedOutMapper;
import com.panda.model.commodity.FinishedOut;
import com.panda.service.commodity.FinishedOutService;
import com.panda.util.abs.AbstractMapper;
import com.panda.util.abs.AbstractServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service
public class FinishedOutServiceImpl extends AbstractServiceImpl<FinishedOut> implements FinishedOutService{
    @Resource
    private FinishedOutMapper finishedOutMapper;

    @Override
    protected AbstractMapper<FinishedOut> getAbstractMapper() {
        return finishedOutMapper;
    }

    /**
     * 查询出库记录
     * @param map
     * @return
     */
    @Override
    public List<Map> selectFinishedOutList(Map map){
        return finishedOutMapper.selectFinishedOutList(map);
    }

    /**
     * 查询单条出库记录详情
     * @param id
     * @return
     */
    @Override
    public Map selectFinishedOutItem(String id){
        return finishedOutMapper.selectFinishedOutItem(id);
    }

    /**
     * 编辑和保存出库记录
     * @param finishedOut
     * @return
     */
    @Override
    public Integer saveOrUpdateFinishedOut(FinishedOut finishedOut){
        return finishedOut.getOutQuantity();
    }

    /**
     * 统计某一时间段内，成品出货数量
     * @param map
     * @return
     */
    public List<Map<String, Object>> getFinishedOutGroupByStore(Map map){
        return finishedOutMapper.getFinishedOutGroupByStore(map);
    }

    /**
     * 查询某一门店，指定日期出货情况
     * @param map
     * @return
     */
    @Override
    public String selectStoreFinishedOutTeaType(Map map){
        return finishedOutMapper.selectStoreFinishedOutTeaType(map);
    }
}
