package com.panda.service.impl.commodity;

import com.panda.mapper.commodity.TagsMapper;
import com.panda.model.commodity.Tags;
import com.panda.model.system.Users;
import com.panda.service.commodity.TagsService;
import com.panda.util.abs.AbstractMapper;
import com.panda.util.abs.AbstractServiceImpl;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service
public class TagsServiceImpl extends AbstractServiceImpl<Tags> implements TagsService {

    @Resource
    private TagsMapper tagsMapper;

    @Override
    protected AbstractMapper<Tags> getAbstractMapper() {
        return tagsMapper;
    }

    /**
     * 查询标签列表
     * @param map
     * @return
     */
    @Override
    public List<Map> selectTagsList(Map map) {
        return tagsMapper.selectTagsList(map);
    }

    /**
     * 查询单条标签详情
     * @param id
     * @return
     */
    @Override
    public Map selectTagsItem(String id) {
        return tagsMapper.selectTagsItem(id);
    }

    /**
     * 成品库存增加时，减去标签库存数量
     * @return
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackFor = {Exception.class})
    public Integer inventoryTagsReduction(Tags tags){
        Users user = (Users) SecurityUtils.getSubject().getPrincipal();
        Integer resultStatus = 0;
        try {
            if (tags.getId() != null && !tags.getId().equals("") && tags.getTagUse() > 0) {
                Tags update = tagsMapper.selectByPrimaryKey(tags.getId());
                if ((update.getTagUse()+tags.getTagUse()) < update.getTagQuantity()){
                    update.setTagUse(update.getTagUse()+tags.getTagUse());
                    tagsMapper.updateByPrimaryKeySelective(update);
                    resultStatus = 200;
                }else{
                    resultStatus = 110;
                }
            }else{
                resultStatus = 001;
            }
        } catch (Exception e) {
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            e.printStackTrace();
            resultStatus = 101;
        }
        return resultStatus;

    }
}
