package com.panda.controller.system.origin;

import com.alibaba.citrus.util.StringEscapeUtil;
import com.alibaba.fastjson.JSON;
import com.panda.model.commodity.Products;
import com.panda.model.origin.MachinTea;
import com.panda.model.origin.Quality;
import com.panda.model.origin.QualityInfo;
import com.panda.model.origin.QualitySet;
import com.panda.model.system.Dictionary;
import com.panda.model.system.Users;
import com.panda.service.commodity.ProductsService;
import com.panda.service.origin.HarvestRecordsService;
import com.panda.service.origin.MachinTeaService;
import com.panda.service.origin.QualityService;
import com.panda.service.origin.QualitySetService;
import com.panda.service.system.DictionaryService;
import com.panda.util.ResultMsgUtil;
import com.panda.util.ResultStateUtil;
import javafx.scene.chart.ValueAxis;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created with IDEA.
 * User: Alan
 * Date: 2017/12/4
 * Time: 15:24
 */
@Controller
@RequestMapping("/system/quality")
public class QualityController {

    private static final Logger logger = LoggerFactory.getLogger(QualityController.class);

    @Resource
    private QualityService qualityService;

    @Resource
    private DictionaryService dictionaryService;

    @Resource
    private QualitySetService qualitySetService;

    @Resource
    private MachinTeaService machinTeaService;

    @Resource
    private HarvestRecordsService harvestRecordsService;

    private static boolean message = false;
    private static Object  data    = null;

    /**
     * bootstart  date 注解 格式化页面上传过来的 String 日期
     * @param request
     * @param binder
     * @throws
     */
    @InitBinder
    protected void initBinder(HttpServletRequest request, ServletRequestDataBinder binder) throws Exception {
        DateFormat fmt = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        CustomDateEditor dateEditor = new CustomDateEditor(fmt, true);
        binder.registerCustomEditor(Date.class, dateEditor);
    }

    /**
     * 获取质检列表
     * @return
     */
    @RequestMapping(value = "/list",method= RequestMethod.GET)
    @RequiresPermissions("quality:view")//权限管理;
    public String getQualityList(HttpServletRequest request, Model model){
        Users user= (Users) SecurityUtils.getSubject().getPrincipal();
        Map map = new HashMap();
        map.put("statusNot",1);
        List<Dictionary> attestation = dictionaryService.selectDictionaryValueList("68d6888f-2b91-11e5-965c-000c29d7a3a0");//质检类型
        List<Dictionary> teaGrade = dictionaryService.selectDictionaryValueList("f63fe4f8-27ab-11e5-965c-000c29d7a3a0");//质检等级
        List<QualitySet> qualitySetList = qualitySetService.selectQualitySetParentAndChildList("10000000-0000-0000-0000-000000000000");//质检属性
        List<Map> harvestList = harvestRecordsService.selectHarvestRecordsListPickNum(map); //鲜叶批次
        model.addAttribute("qualitySetList",qualitySetList);
        model.addAttribute("teaGrade",teaGrade);
        model.addAttribute("attestation",attestation);
        model.addAttribute("harvestList",harvestList);
        model.addAttribute("menuList",user.getMenuList());
        model.addAttribute("user",user);
        return "system/origin/getQualityList";
    }

    /**
     * Ajax 获取取样数据
     * @param request
     * @return
     */
    @RequestMapping(value = "/getQualityDataList",method = RequestMethod.POST)
    @ResponseBody
    public Object getQualityDataList(HttpServletRequest request,String datatable){
        message = false;
        data    = null;
        try {
            Map query = new HashMap();
            if (datatable != null && !datatable.isEmpty()){
                String jsonStr = StringEscapeUtil.unescapeHtml(datatable);
                Map params = JSON.parseObject(jsonStr,Map.class);
                Map status = JSON.parseObject(params.get("query").toString(),Map.class);
                if (status.size() > 0 && status.get("productId") != ""){
                    query.put("productId",status.get("productId"));
                }
                if (status.size() > 0 && status.get("processBatchId") != ""){
                    query.put("processBatchId",status.get("processBatchId"));
                }
                if (status.size() > 0 && status.get("samplingId") != ""){
                    query.put("samplingId",status.get("samplingId"));
                }
            }
            List<Map> qualityList = qualityService.selectQualityDataList(query);
            if(qualityList.size() > 0){
                message = true;
                data = qualityList;
            }
        }catch (Exception e){
            e.printStackTrace();
            data    = ResultStateUtil.ERROR_DATABASE_OPERATION;
        }
        return ResultMsgUtil.getResultMsg(message,data);
    }

    /**
     * 获取单条记录详情
     * @param request
     * @param id
     * @return
     */
    @RequestMapping(value = "/getQualityItem")
    @ResponseBody
    public Object getQualityItem(HttpServletRequest request,String id){
        message = false;
        data    = null;
        try {
            if (!id.isEmpty()){
                Map qualityList = qualityService.selectQualityDataMap(id);
                if(qualityList.size() > 0){
                    message = true;
                    data = qualityList;
                }
            }else{
                data = ResultStateUtil.ERROR_PARAMETER_IS_EMPTY;
            }
        }catch (Exception e){
            e.printStackTrace();
            data    = ResultStateUtil.ERROR_DATABASE_OPERATION;
        }
        return ResultMsgUtil.getResultMsg(message,data);
    }

    /**
     * 保存
     * @param request
     * @param quality
     * @param save
     * @return
     */
    @RequestMapping(value = "/saveOrUpdateQuality",method = RequestMethod.POST)
    @ResponseBody
    public Object saveOrUpdateQuality(HttpServletRequest request, Quality quality , QualityInfo qualityInfo, String save,String qiId){
        Users user= (Users) SecurityUtils.getSubject().getPrincipal();
        message = false;
        data    = null;
        try{
            if (quality != null && (save.equals("add") || save.equals("edit"))){
                if (qiId != null && !qiId.isEmpty()){
                    qualityInfo.setId(qiId);
                }else{
                    qualityInfo.setId(null);
                }
                if (save.equals("add")){
                    quality.setId(null);
                    qualityInfo.setId(null);
                }
                Integer resultStatus = qualityService.saveOrUpdateQuality(quality,qualityInfo);
                switch (resultStatus){
                    case 101:
                        data    = ResultStateUtil.FAIL_ABNORMAL;
                        break;
                    case 200:
                        message = true;
                        data    = ResultStateUtil.SUCCESS_UPDATE;
                        break;
                    case 203 :
                        message = true;
                        data    = ResultStateUtil.SUCCESS_ADD;
                        break;
                    case 0:
                        data    = ResultStateUtil.ERROR_OPERATION;
                        break;
                }
            }else{
                data = ResultStateUtil.ERROR_PARAMETER_IS_EMPTY;
            }
        }catch (Exception e){
            e.printStackTrace();
            data  = ResultStateUtil.ERROR_DATABASE_OPERATION;
        }
        return ResultMsgUtil.getResultMsg(message,data);
    }

    /**
     * 刪除
     * @param request
     * @param id
     * @return
     */
    @RequestMapping(value="/delQualityItem",method = RequestMethod.GET)
    @ResponseBody
    public Object delQualityItem(HttpServletRequest request ,String id){
        message = false;
        data    = null;
        try{
            if (!id.isEmpty()){
                int i = qualityService.deleteByPrimaryKey(id);
                if(i > 0){
                    message = true;
                    data = ResultStateUtil.SUCCESS_DELETE;
                }else{
                    data = ResultStateUtil.ERROR_QUERY;
                }
            }else{
                data = ResultStateUtil.ERROR_PARAMETER_IS_EMPTY;
            }
        }catch (Exception e){
            e.printStackTrace();
            data = ResultStateUtil.ERROR_DATABASE_OPERATION;
        }
        return ResultMsgUtil.getResultMsg(message,data);
    }

    /**
     * 获取鲜叶批次加工时的茶系信息
     * @param harvestBatchId
     * @return
     */
    @RequestMapping(value = "/getDicTeaAttrData")
    @ResponseBody
    public Object getDicTeaAttrData(String harvestBatchId){
        message = false;
        data    = null;
        try{
            if (!harvestBatchId.isEmpty()){
                Map teaAttr = machinTeaService.getDicTeaAttrData(harvestBatchId);
                if(teaAttr != null && teaAttr.size() > 0){
                    message = true;
                    data = teaAttr.get("dic_tea_attr");
                }else{
                    data = ResultStateUtil.ERROR_QUERY;
                }
            }else{
                data = ResultStateUtil.ERROR_PARAMETER_IS_EMPTY;
            }
        }catch (Exception e){
            e.printStackTrace();
            data = ResultStateUtil.ERROR_DATABASE_OPERATION;
        }
        return ResultMsgUtil.getResultMsg(message,data);
    }
}
