package com.panda.service.impl.commodity;

import com.panda.mapper.commodity.PackageMapper;
import com.panda.model.commodity.Package;
import com.panda.model.commodity.Tags;
import com.panda.model.system.Users;
import com.panda.service.commodity.PackageService;
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
public class PackageServiceImpl extends AbstractServiceImpl<Package> implements PackageService {
    @Resource
    private PackageMapper packageMapper;
    @Override
    protected AbstractMapper<Package> getAbstractMapper() {
        return packageMapper;
    }

    /**
     * 查询包材列表
     * @param map
     * @return
     */
    @Override
    public List<Map> selectPackageList(Map map) {
        return packageMapper.selectPackageList(map);
    }

    /**
     * 查询单条包材信息
     * @param id
     * @return
     */
    @Override
    public Map selectPackageItem(String id) {
        return packageMapper.selectPackageItem(id);
    }

    /**
     * 成品库存增加时，减去包材库存数量
     * @return
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackFor = {Exception.class})
    public Integer inventoryPackageReduction(Package pack){
        Users user = (Users) SecurityUtils.getSubject().getPrincipal();
        Integer resultStatus = 0;
        try {
            if (pack.getId() != null && !pack.getId().equals("") && pack.getPackageUse() > 0) {
                Package update = packageMapper.selectByPrimaryKey(pack.getId());
                if ((update.getPackageUse()+pack.getPackageUse()) < update.getPackageQuantity()){
                    update.setPackageUse(update.getPackageUse()+pack.getPackageUse());
                    packageMapper.updateByPrimaryKeySelective(update);
                    resultStatus = 200;
                }else{
                    //库存数量不足
                    resultStatus = 111;
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
