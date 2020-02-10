package com.panda.service.impl.origin;

import com.panda.mapper.origin.ManageBatchMapper;
import com.panda.model.origin.ManageBatch;
import com.panda.service.origin.ManageBatchService;
import com.panda.util.abs.AbstractMapper;
import com.panda.util.abs.AbstractServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service
public class ManageBatchServiceImpl extends AbstractServiceImpl<ManageBatch> implements ManageBatchService {
    @Resource
    private ManageBatchMapper manageBatchMapper;
    @Override
    protected AbstractMapper<ManageBatch> getAbstractMapper() {
        return manageBatchMapper;
    }

    /**
     * 获取茶园管理批次列表
     * @param map
     * @return
     */
    @Override
    public List<Map> selectManageBatchList(Map map){
        return manageBatchMapper.selectManageBatchList(map);
    }

}
