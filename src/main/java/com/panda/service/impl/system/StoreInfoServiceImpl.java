package com.panda.service.impl.system;

import com.panda.mapper.system.StoreInfoMapper;
import com.panda.model.system.StoreInfo;
import com.panda.model.system.Users;
import com.panda.service.system.StoreInfoService;
import com.panda.service.system.UsersService;
import com.panda.util.abs.AbstractMapper;
import com.panda.util.abs.AbstractServiceImpl;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Service
public class StoreInfoServiceImpl extends AbstractServiceImpl<StoreInfo> implements StoreInfoService {
    @Resource
    private StoreInfoMapper storeInfoMapper;

    @Resource
    private StoreInfoService storeInfoService;

    @Resource
    private UsersService usersService;

    @Override
    protected AbstractMapper<StoreInfo> getAbstractMapper() {
        return storeInfoMapper;
    }


    /**
     * 获取门店信息列表
     * @param map
     * @return
     */
    @Override
    public List<Map> selectStoreInfoList(Map map){
        return storeInfoMapper.selectStoreInfoList(map);
    }


    /**
     * 获取门店详细信息
     * @param id
     * @return
     */
    @Override
    public Map selectStoreItemByPrimaryKey(String id){
        return storeInfoMapper.selectStoreItemByPrimaryKey(id);
    }


    /**
     * 添加门店信息和绑定门店用户
     * @param storeInfo
     * @return
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackFor = {Exception.class})
    public Integer insertSelectiveAndUser(StoreInfo storeInfo,Users storeUserInfo) {
        Users user = (Users) SecurityUtils.getSubject().getPrincipal();
        Integer resultStatus = 0;
        try {
            if(storeInfo != null && !storeInfo.getId().isEmpty() ){
                String uid = UUID.randomUUID().toString();
                storeInfo.setId(uid);
                storeInfo.setCreateId(user.getId());
                storeInfo.setCreateTime(new Date());
                storeInfo.setModifyId(user.getId());
                storeInfo.setModifyTime(new Date());
                storeInfo.setStatus(1);
                int insert = storeInfoService.insertSelective(storeInfo);
                if (insert > 0) {
                    storeUserInfo.setStoreId(uid);
                    int s = usersService.updateByPrimaryKey(storeUserInfo);
                    if(s>0){
                        resultStatus = 200;
                    }else{
                        TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                        resultStatus = 101;
                    }

                } else {
                    TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                    resultStatus = 101;
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
