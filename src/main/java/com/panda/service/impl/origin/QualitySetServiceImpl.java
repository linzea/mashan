package com.panda.service.impl.origin;

import com.panda.mapper.origin.QualitySetMapper;
import com.panda.model.origin.QualitySet;
import com.panda.model.system.Menu;
import com.panda.service.origin.QualitySetService;
import com.panda.util.abs.AbstractMapper;
import com.panda.util.abs.AbstractServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created with IDEA.
 * User: Alan
 * Date: 2017/12/27
 * Time: 17:50
 */
@Service
public class QualitySetServiceImpl extends AbstractServiceImpl<QualitySet> implements QualitySetService {

    @Resource
    private QualitySetMapper qualitySetMapper;

    @Override
    protected AbstractMapper<QualitySet> getAbstractMapper() {
        return qualitySetMapper;
    }
    /**
     * 获取当前的属性
     * @return
     */
    @Override
    public List<QualitySet> selectQualitySetValueList(String parentId) {
        return qualitySetMapper.selectQualitySetValueList(parentId);
    }
    /**
     * 查询信息列表
     * @param map
     * @return
     */
    @Override
    public List<Map<String, Object>> selectQualitySetListMap(Map<String, Object> map) {
        return qualitySetMapper.selectQualitySetListMap(map);
    }
    /**
     * Group Count 的值
     * @param parentId
     * @return
     */
    @Override
    public String selectQualitySetGroupCountValueByParent(String parentId) {
        return qualitySetMapper.selectQualitySetGroupCountValueByParent(parentId);
    }
    /**
     * Ajax 删除信息 包含子级时，将全部删除
     * @param id
     * @return
     */
    @Override
    public Integer delQualitySetParentAndChild(String id) {
        return qualitySetMapper.delQualitySetParentAndChild(id);
    }

    /**
     * 获取当前启用的所有属性集合
     * @return
     */
    @Override
    public List<QualitySet> selectQualitySetParentAndChildList(String parentId){
        List<QualitySet> resultList = null;
        try {
            List<QualitySet> qualitySetList = qualitySetMapper.selectQualitySetValueList(parentId);
            if(qualitySetList != null && qualitySetList.size() > 0){
                for (QualitySet q: qualitySetList) {
                    List<QualitySet> lastList = qualitySetMapper.selectQualitySetValueList(q.getId());
                    if (lastList != null && lastList.size() > 0) {
                        q.setChildQualitySetList(lastList);
                    }
                }
                resultList = qualitySetList;
            }
        }catch (Exception e){
            e.printStackTrace();

        }
        return resultList;
    }
}
