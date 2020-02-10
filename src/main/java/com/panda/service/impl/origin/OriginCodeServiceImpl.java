package com.panda.service.impl.origin;

import com.panda.mapper.origin.OriginCodeMapper;
import com.panda.model.origin.OriginCode;
import com.panda.model.system.RoleMenu;
import com.panda.model.system.Users;
import com.panda.service.origin.OriginCodeService;
import com.panda.util.CreateBatchNoUtil;
import com.panda.util.abs.AbstractMapper;
import com.panda.util.abs.AbstractServiceImpl;
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
 * Date: 2017/12/7
 * Time: 10:54
 */
@Service
public class OriginCodeServiceImpl extends AbstractServiceImpl<OriginCode> implements OriginCodeService {

    private static final Logger logger = LoggerFactory.getLogger(OriginCodeServiceImpl.class);

    @Resource
    private OriginCodeMapper originCodeMapper;

    @Override
    protected AbstractMapper<OriginCode> getAbstractMapper() {
        return originCodeMapper;
    }

    /**
     * 获取溯源码
     * @param map
     * @return
     */
    @Override
    public List<Map> selectOriginCodeDataList(Map map){
        return originCodeMapper.selectOriginCodeDataList(map);
    }

    /**
     * 通过溯源码找到对应的批次号
     * @param originCode
     * @return
     */
    @Override
    public List<Map> selectOriginCodeByInfoList(String originCode){
        return originCodeMapper.selectOriginCodeByInfoList(originCode);
    }


    /**
     * 批量生成溯源码
     * @param prefixVal
     * @param createNum
     * @return
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackFor = {Exception.class})
    public Integer createOriginCodeList(String originBatchId,String prefixVal,Integer createNum){
        Integer resultStatus = 0;
        try {
            if (!prefixVal.isEmpty() && createNum > 0) {
                Users user = (Users) SecurityUtils.getSubject().getPrincipal();
                OriginCode originCode = new OriginCode();
                int i = 0;
                while(i < createNum)
                {
                    originCode.setId(UUID.randomUUID().toString());
                    originCode.setPrefixVal(prefixVal);
                    originCode.setOriginBatchId(originBatchId);
                    originCode.setOriginCode(prefixVal+ CreateBatchNoUtil.createBatchNo());
                    originCode.setCreateId(user.getId());
                    originCode.setCreateTime(new Date());
                    originCodeMapper.insertSelective(originCode);
                    i++;
                }
                resultStatus = 200;
            }else{
                resultStatus = 0;
            }
        } catch (Exception e) {
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            e.printStackTrace();
            logger.info("RoleMenuServiceImpl------>saveOrUpdateRoleMenu----->" + e.getMessage());
            resultStatus = 101;
        }
        return resultStatus;
    }

    /**
     * 查询溯源吗的批次ID
     * @param originCode
     * @return
     */
    public String checkOriginCode(String originCode){
        return originCodeMapper.checkOriginCode(originCode);
    }
}
