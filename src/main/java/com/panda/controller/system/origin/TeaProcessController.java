package com.panda.controller.system.origin;

import com.alibaba.citrus.util.StringEscapeUtil;
import com.alibaba.fastjson.JSON;
import com.panda.model.commodity.Finished;
import com.panda.model.commodity.SemiFinished;
import com.panda.model.origin.MachinTea;
import com.panda.model.origin.Quality;
import com.panda.model.origin.TeaGardenLog;
import com.panda.service.commodity.FinishedService;
import com.panda.service.commodity.SemiFinishedService;
import com.panda.service.origin.*;
import com.panda.service.system.DictionaryService;
import com.panda.util.DateUtil;
import com.panda.util.ResultMsgUtil;
import com.panda.util.ResultStateUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/system/teaProcess")
public class TeaProcessController {

    @Resource
    private TeaGardenService teaGardenService;

    @Resource
    private QualityService qualityService;

    @Resource
    private TeaGardenLogService teaGardenLogService;

    @Resource
    private MachinTeaService machinTeaService;

    @Resource
    private SemiFinishedService semiFinishedService;

    @Resource
    private FinishedService finishedService;

    @Resource
    private HarvestRecordsService harvestRecordsService;

    private static boolean message = false;
    private static Object data = null;

    @RequestMapping(value = "/getTeaProcess",method = RequestMethod.POST)
    @ResponseBody
    public Object getTeaProcess(HttpServletRequest request,String id,String queryType){
        message = false;
        data = null;
        String teaGardenLogId = "";
        try {
            List<Map> result = new ArrayList<>();
            Map query = new HashMap();
            if (!id.isEmpty() && !queryType.isEmpty()){
                //鲜叶节点
                if (queryType.equals("harvest")){
                    //茶园和管理批次信息
                    Map harvestMap = harvestRecordsService.selectTeaGardenAndManagerBatch(id);
                    if ( harvestMap != null && harvestMap.size()>0 ){
                        result.add(harvestMap);
                        teaGardenLogId = harvestMap.get("mBatchId").toString();
                        query.put("batchNum",teaGardenLogId);
                        //茶园日志
                        List<Map> logList = teaGardenLogService.selectTeaGardenLogList(query);
                        if (logList != null && logList.size() > 0){
                            result.addAll(logList);
                            data = result;
                        }
                        message = true;
                    }
                }
                //加工节点
                if (queryType.equals("machinTea")){
                    MachinTea ma = machinTeaService.selectByPrimaryKey(id);
                    if (ma != null){
                        //茶园和管理批次数据
                        Map harvestMap = harvestRecordsService.selectTeaGardenAndManagerBatch(ma.getHarvestBatchId());
                        if ( harvestMap != null && harvestMap.size()>0 ){
                            result.add(harvestMap);
                            teaGardenLogId = harvestMap.get("mBatchId").toString();
                            query.put("batchNum",teaGardenLogId);
                            //茶园日志数据
                            List<Map> logList = teaGardenLogService.selectTeaGardenLogList(query);
                            if (logList != null && logList.size() > 0){
                                result.addAll(logList);
                            }
                        }
                        //加入质检数据
                        query.put("harvestBatchId",ma.getHarvestBatchId());
                        List<Map> qualityList = qualityService.selectQualityDataList(query);
                        //计算耗时
                        if (qualityList != null && qualityList.size() > 0){
                            result.addAll(qualityList);
                        }

                        List<Map> semiFinishedList = semiFinishedService.selectSemiFinishedDataList(query);
                        //加入半成品库存
                        if (semiFinishedList != null && semiFinishedList.size() > 0){
                            result.addAll(semiFinishedList);
                            data = result;
                            message = true;
                        }
                        //加入加工数据
                        query.put("rollStatus",ma.getRollStatus());

                        List<Map> machinTeaList = machinTeaService.selectMachinTeaDataList(query);
                        //计算耗时
                        if (machinTeaList != null && machinTeaList.size() > 0){
                            for (Map item : machinTeaList) {
                                String time = DateUtil.calculationSecond(item.get("begin_time").toString(),item.get("end_time").toString());
                                item.put("lostTime",time);
                            }
                            result.addAll(machinTeaList);
                            data = result;
                            message = true;
                        }
                    }
                }
                //质检节点
                if (queryType.equals("productQuality")){
                    Quality quality = qualityService.selectByPrimaryKey(id);
                    if (quality != null){
                        //茶园和管理批次数据
                        Map harvestMap = harvestRecordsService.selectTeaGardenAndManagerBatch(quality.getHarvestBatchId());
                        if ( harvestMap != null && harvestMap.size()>0 ){
                            result.add(harvestMap);
                            teaGardenLogId = harvestMap.get("mBatchId").toString();
                            query.put("batchNum",teaGardenLogId);
                            //茶园日志数据
                            List<Map> logList = teaGardenLogService.selectTeaGardenLogList(query);
                            if (logList != null && logList.size() > 0){
                                result.addAll(logList);
                            }
                        }
                        //加入加工数据
                        query.put("harvestBatchId",quality.getHarvestBatchId());
                        List<Map> machinTeaList = machinTeaService.selectMachinTeaDataList(query);
                        //计算耗时
                        if (machinTeaList != null && machinTeaList.size() > 0){
                            for (Map item : machinTeaList) {
                                String time = DateUtil.calculationSecond(item.get("begin_time").toString(),item.get("end_time").toString());
                                item.put("lostTime",time);
                            }
                            result.addAll(machinTeaList);
                        }

                        //加入质检数据
                        List<Map> qualityList = qualityService.selectQualityDataList(query);
                        //计算耗时
                        if (qualityList != null && qualityList.size() > 0){
                            result.addAll(qualityList);
                            data = result;
                            message = true;
                        }
                    }
                }
                //半成品节点
                if (queryType.equals("semiFinished")){
                    SemiFinished semiFinished = semiFinishedService.selectByPrimaryKey(id);
                    if (semiFinished != null){
                        //茶园和管理批次数据
                        Map harvestMap = harvestRecordsService.selectTeaGardenAndManagerBatch(semiFinished.getHarvestBatchId());
                        if ( harvestMap != null && harvestMap.size()>0 ){
                            result.add(harvestMap);
                            teaGardenLogId = harvestMap.get("mBatchId").toString();
                            query.put("batchNum",teaGardenLogId);
                            //茶园日志数据
                            List<Map> logList = teaGardenLogService.selectTeaGardenLogList(query);
                            if (logList != null && logList.size() > 0){
                                result.addAll(logList);
                            }
                        }
                        //加入加工数据
                        query.put("harvestBatchId",semiFinished.getHarvestBatchId());
                        List<Map> machinTeaList = machinTeaService.selectMachinTeaDataList(query);
                        //计算耗时
                        if (machinTeaList != null && machinTeaList.size() > 0){
                            for (Map item : machinTeaList) {
                                String time = DateUtil.calculationSecond(item.get("begin_time").toString(),item.get("end_time").toString());
                                item.put("lostTime",time);
                            }
                            result.addAll(machinTeaList);
                        }

                        //加入质检数据
                        List<Map> qualityList = qualityService.selectQualityDataList(query);
                        //计算耗时
                        if (qualityList != null && qualityList.size() > 0){
                            result.addAll(qualityList);
                        }

                        List<Map> semiFinishedList = semiFinishedService.selectSemiFinishedDataList(query);
                        //加入半成品库存
                        if (semiFinishedList != null && semiFinishedList.size() > 0){
                            result.addAll(semiFinishedList);
                            data = result;
                            message = true;
                        }
                    }
                }
                //成品节点
                if (queryType.equals("finishedInOrOut")){
                    Finished finished = finishedService.selectByPrimaryKey(id);
                    if (finished != null){
                        //茶园和管理批次数据
                        Map harvestMap = harvestRecordsService.selectTeaGardenAndManagerBatch(finished.getHarvestBatchId());
                        if ( harvestMap != null && harvestMap.size()>0 ){
                            result.add(harvestMap);
                            teaGardenLogId = harvestMap.get("mBatchId").toString();
                            query.put("batchNum",teaGardenLogId);
                            //茶园日志数据
                            List<Map> logList = teaGardenLogService.selectTeaGardenLogList(query);
                            if (logList != null && logList.size() > 0){
                                result.addAll(logList);
                            }
                        }
                        //加入加工数据
                        query.put("harvestBatchId",finished.getHarvestBatchId());
                        List<Map> machinTeaList = machinTeaService.selectMachinTeaDataList(query);
                        //计算耗时
                        if (machinTeaList != null && machinTeaList.size() > 0){
                            for (Map item : machinTeaList) {
                                String time = DateUtil.calculationSecond(item.get("begin_time").toString(),item.get("end_time").toString());
                                item.put("lostTime",time);
                            }
                            result.addAll(machinTeaList);
                        }

                        //加入质检数据
                        List<Map> qualityList = qualityService.selectQualityDataList(query);
                        //计算耗时
                        if (qualityList != null && qualityList.size() > 0){
                            result.addAll(qualityList);
                        }

                        List<Map> semiFinishedList = semiFinishedService.selectSemiFinishedDataList(query);
                        //加入半成品库存
                        if (semiFinishedList != null && semiFinishedList.size() > 0){
                            result.addAll(semiFinishedList);
                        }

                        List<Map> finishedList = finishedService.selectFinishedList(query);
                        //加入成品库存
                        if (finishedList != null && finishedList.size() > 0){
                            result.addAll(finishedList);
                            message = true;
                            data = result;
                        }
                    }
                }
            }else{
                data = ResultStateUtil.ERROR_PARAMETER_IS_EMPTY;
            }
        } catch (Exception e) {
            e.printStackTrace();
            data = ResultStateUtil.ERROR_DATABASE_OPERATION;
        }
        return ResultMsgUtil.getResultMsg(message, data);
    }
}
