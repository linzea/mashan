package com.panda.service.impl.origin;

import com.panda.mapper.origin.OriginBatchMapper;
import com.panda.model.origin.OriginBatch;
import com.panda.service.origin.OriginBatchService;
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
 * Date: 2017/12/7
 * Time: 10:54
 */
@Service
public class OriginBatchServiceImpl extends AbstractServiceImpl<OriginBatch> implements OriginBatchService {

    @Resource
    private OriginBatchMapper originBatchMapper;

    @Override
    protected AbstractMapper<OriginBatch> getAbstractMapper() {
        return originBatchMapper;
    }

    /**
     * 查询溯源批次数据
     * @param map
     * @return
     */
    @Override
    public List<Map> selectOriginBatchDataList(Map map){
        return originBatchMapper.selectOriginBatchDataList(map);
    }

    /**
     * 查询溯源批次
     * @param map
     * @return
     */
    @Override
    public List<OriginBatch> selectBatchList(Map map){
        return originBatchMapper.selectBatchList(map);
    }

    /**
     * countAll
     * @return
     */
    public Integer countAll(){
        return originBatchMapper.countAll();
    }
}
