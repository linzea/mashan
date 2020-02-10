package com.panda.service.impl.origin;

import com.panda.mapper.origin.TeaGardenMapper;
import com.panda.model.origin.TeaGarden;
import com.panda.service.origin.TeaGardenService;
import com.panda.util.abs.AbstractMapper;
import com.panda.util.abs.AbstractServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service
public class TeaGardenServiceImpl extends AbstractServiceImpl<TeaGarden> implements TeaGardenService {

    @Resource
    private TeaGardenMapper teaGardenMapper;

    @Override
    protected AbstractMapper<TeaGarden> getAbstractMapper() {
        return teaGardenMapper;
    }

    /**
     * 获取茶园信息列表
     * @param map
     * @return
     */
    @Override
    public List<Map> selectTeaGardenList(Map map){
        return teaGardenMapper.selectTeaGardenList(map);
    }

    /**
     * 查询茶园名称和ID 茶园日志使用
     * @param map
     * @return
     */
    @Override
    public List<Map> selectTeaGardenNameAndId(Map map){
        return teaGardenMapper.selectTeaGardenNameAndId(map);
    }

    /**
     * 根据茶园ID获取对应批次号信息
     * @param teaGardenId
     * @return
     */
    @Override
    public  List<Map> selectTeaGardenBatch(String teaGardenId){
        return teaGardenMapper.selectTeaGardenBatch(teaGardenId);
    }
}
