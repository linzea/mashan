package com.panda.service.impl.system;

import com.panda.model.system.RoleMenu;
import com.panda.model.system.Users;
import com.panda.util.abs.AbstractMapper;
import com.panda.util.abs.AbstractServiceImpl;
import com.panda.mapper.system.DictionaryMapper;
import com.panda.model.system.Dictionary;
import com.panda.service.system.DictionaryService;
import org.apache.shiro.SecurityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import javax.annotation.Resource;
import java.util.*;

/**
 * Created with IDEA.
 *
 * @AUTH: Alan
 * Date: 2017/10/21
 * Time: 18:25
 */
@Service
public class DictionaryServiceImpl extends AbstractServiceImpl<Dictionary> implements DictionaryService{

    private static final Logger logger = LoggerFactory.getLogger(DictionaryServiceImpl.class);

    @Resource
    private DictionaryMapper dictionaryMapper;

    @Override
    protected AbstractMapper<Dictionary> getAbstractMapper() {
        return dictionaryMapper;
    }

    /**
     * 获取当前字典的属性
     * @return
     */
    @Override
    public List<Dictionary> selectDictionaryValueList(String parentId){
        return dictionaryMapper.selectDictionaryValueList(parentId);
    }

    /**
     * 查询字典信息列表
     * @param map
     * @return
     */
    @Override
    public List<Map<String, Object>> selectDictionaryListMap(Map<String, Object> map) {
        return dictionaryMapper.selectDictionaryListMap(map);
    }

    /**
     * Group Count 字典的值
     * @param parentId
     * @return
     */
    @Override
    public String selectDictionaryGroupCountValueByParent(String parentId){
        return dictionaryMapper.selectDictionaryGroupCountValueByParent(parentId);
    }

    /**
     * Ajax 删除字典信息 包含子级时，将全部删除
     * @param id
     * @return
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackFor = {Exception.class})
    public Integer delDictionaryParentAndChild(String id){
        Integer resultStatus = 0;
        try {
            if (!id.isEmpty()) {
                int i = dictionaryMapper.delDictionaryParentAndChild(id);
                if (i > 0){
                    resultStatus = 200;
                }
            }
        } catch (Exception e) {
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            e.printStackTrace();
            resultStatus = 101;
        }
        return resultStatus;
    }
}
