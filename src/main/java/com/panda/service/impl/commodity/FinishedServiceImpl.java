package com.panda.service.impl.commodity;

import com.panda.mapper.commodity.FinishedMapper;
import com.panda.model.commodity.Finished;
import com.panda.model.commodity.FinishedOut;
import com.panda.model.origin.MachinTea;
import com.panda.model.system.Users;
import com.panda.service.commodity.FinishedOutService;
import com.panda.service.commodity.FinishedService;
import com.panda.util.DateUtil;
import com.panda.util.abs.AbstractMapper;
import com.panda.util.abs.AbstractServiceImpl;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import javax.annotation.Resource;
import java.util.*;

@Service
public class FinishedServiceImpl extends AbstractServiceImpl<Finished> implements FinishedService {
    @Resource
    private FinishedMapper finishedMapper;

    @Resource
    private FinishedOutService finishedOutService;

    @Override
    protected AbstractMapper<Finished> getAbstractMapper() {
        return finishedMapper;
    }

    /**
     * 获取成品列表
     * @param map
     * @return
     */
    @Override
    public List<Map> selectFinishedList(Map map) {
        return finishedMapper.selectFinishedList(map);
    }

    /**
     * 查看单挑成品信息详情
     * @param id
     * @return
     */

    @Override
    public Map selectFinishedItem(String id) {
        return finishedMapper.selectFinishedItem(id);
    }

    /**
     * 编辑和更新成品记录，
     * 出库等,减少库存，写入出库信息等
     * @param finished
     * @return
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackFor = {Exception.class})
    public Integer saveOrUpdateFinishedOut(Finished finished, FinishedOut finishedOut){
        Users user = (Users) SecurityUtils.getSubject().getPrincipal();
        Integer resultStatus = 0;
        try {
            if (finishedOut != null && finishedOut.getOutQuantity() > 0 && finished.getId() != null && !finished.getId().equals("")) {
                Finished createFinishedOut = finishedMapper.selectByPrimaryKey(finished.getId());
                if (createFinishedOut != null){
                    finishedOut.setId(UUID.randomUUID().toString());
                    finishedOut.setHarvestBatchId(createFinishedOut.getHarvestBatchId());
                    finishedOut.setFinishedId(createFinishedOut.getId());
                    finishedOut.setDicTeaAttr(createFinishedOut.getDicTeaAttr());
                    finishedOut.setDicTeaType(createFinishedOut.getDicTeaType());
                    finishedOut.setCreateId(user.getId());
                    finishedOut.setCreateTime(new Date());
                    int i = finishedOutService.insertSelective(finishedOut);
                    if (i > 0){
                        createFinishedOut.setFinishedOut(createFinishedOut.getFinishedOut()+finishedOut.getOutQuantity());
                        int res = finishedMapper.updateByPrimaryKeySelective(createFinishedOut);
                        if (res > 0){
                            resultStatus = 200;
                        }else{
                            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                            resultStatus = 101;
                        }
                    }
                }
            }else{
                resultStatus = 101;
            }
        } catch (Exception e) {
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            e.printStackTrace();
            resultStatus = 101;
        }
        return resultStatus;
    }

    /**
     * 创建成品库存数据
     * @param finished
     * @return
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackFor = {Exception.class})
    public Integer createFinishedData(Finished finished){
        Users user = (Users) SecurityUtils.getSubject().getPrincipal();
        Integer resultStatus = 0;
        try {
            int i = finishedMapper.insertSelective(finished);
            if (i > 0) {
                resultStatus = 200;
            }
        }catch (Exception e){
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            e.printStackTrace();
            e.getMessage();
        }
        return resultStatus;
    }

    /**
     * 成品出库获取质检报告和其他报告
     * @param id
     * @return
     */
    @Override
    public List<Map> finishedOutDownloadFileList(String id){
        return finishedMapper.finishedOutDownloadFileList(id);
    }
}
