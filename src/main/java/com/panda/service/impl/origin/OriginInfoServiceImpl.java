package com.panda.service.impl.origin;

import com.panda.mapper.origin.OriginInfoMapper;
import com.panda.model.origin.OriginCode;
import com.panda.model.origin.OriginInfo;
import com.panda.service.origin.OriginCodeService;
import com.panda.service.origin.OriginInfoService;
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
public class OriginInfoServiceImpl extends AbstractServiceImpl<OriginInfo> implements OriginInfoService {

    @Resource
    private OriginInfoMapper originInfoMapper;

    @Override
    protected AbstractMapper<OriginInfo> getAbstractMapper() {
        return originInfoMapper;
    }

    /**
     * 查询溯源信息列表
     * @param map
     * @return
     */
    @Override
    public List<Map> selectOriginInfoDataList(Map map){
        return originInfoMapper.selectOriginInfoDataList(map);
    }
}
