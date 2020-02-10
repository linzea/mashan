package com.panda.service.impl.commodity;

import com.panda.mapper.commodity.SemiFinishedMapper;
import com.panda.model.commodity.SemiFinished;
import com.panda.model.origin.MachinTea;
import com.panda.model.origin.Quality;
import com.panda.model.system.Users;
import com.panda.service.commodity.SemiFinishedService;
import com.panda.service.origin.MachinTeaService;
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

/**
 * Created with IDEA.
 * User: Alan
 * Date: 2017/12/29
 * Time: 10:53
 */
@Service
public class SemiFinishedServiceImpl extends AbstractServiceImpl<SemiFinished> implements SemiFinishedService {

    @Resource
    private SemiFinishedMapper semiFinishedMapper;

    @Resource
    private MachinTeaService machinTeaService;

    @Override
    protected AbstractMapper<SemiFinished> getAbstractMapper() {
        return semiFinishedMapper;
    }

    /**
     * 获取半成品库入存记录
     * @param map
     * @return
     */
    @Override
    public List<Map> selectSemiFinishedDataList(Map map){
        return semiFinishedMapper.selectSemiFinishedDataList(map);
    }

    /**
     * 查询单条出入库详情
     * @param id
     * @return
     */
    @Override
    public Map selectSemiFinishedDataItem(String id){
        return semiFinishedMapper.selectSemiFinishedDataItem(id);
    }

    /**
     * 茶叶加工，筛选工序完成时。创建半成品入库数据
     * @param machinTea
     * @return
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackFor = {Exception.class})
    public Integer createSemiFinishedData(MachinTea machinTea){
        Users user = (Users) SecurityUtils.getSubject().getPrincipal();
        Integer resultStatus = 0;
        try {
            if (machinTea != null && !machinTea.getId().isEmpty() && machinTea.getStatus() == 1) {
                SemiFinished semi = new SemiFinished();
                semi.setId(UUID.randomUUID().toString());
                semi.setMachinTeaId(machinTea.getId());
                semi.setHarvestBatchId(machinTea.getHarvestBatchId());
                semi.setDicTeaAttr(machinTea.getDicTeaAttr());
                semi.setDicTeaType(machinTea.getDicTeaType());
                semi.setTeaGradeOne(machinTea.getTeaGradeOne());
                semi.setTeaGradeTwo(machinTea.getTeaGradeTwo());
                semi.setTeaGradeThree(machinTea.getTeaGradeThree());
                semi.setPrincipal(user.getChineseName());
                semi.setCreateId(user.getId());
                semi.setCreateTime(new Date());
                semi.setStatus(1);// 默认为1 ，生存复炒后为2
                int i = semiFinishedMapper.insertSelective(semi);
                if (i > 0){
                    resultStatus = 200;
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
     * 半成品出库-加工成成品
     * 红茶-复烤
     * 绿茶-复炒
     * @return
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackFor = {Exception.class})
    public Integer semiFinishedOut(String id){
        Users user = (Users) SecurityUtils.getSubject().getPrincipal();
        Integer resultStatus = 0;
        try {
            if (!id.isEmpty()) {
                SemiFinished semiOut = semiFinishedMapper.selectByPrimaryKey(id);
                if (semiOut != null){
                    /**
                     * 创建复炒数据
                     */
                    Integer status = machinTeaService.createRoastingData(semiOut);
                    if (status != 200){
                        resultStatus = status;
                    }else{
                        semiOut.setSemiOneOut(semiOut.getTeaGradeOne());
                        semiOut.setSemiTwoOut(semiOut.getTeaGradeTwo());
                        semiOut.setSemiThreeOut(semiOut.getTeaGradeThree());
                        semiOut.setModifyId(user.getId());
                        semiOut.setModifyTime(new Date());
                        semiOut.setStatus(2);
                        semiFinishedMapper.updateByPrimaryKeySelective(semiOut);
                        resultStatus = 200;
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
}
