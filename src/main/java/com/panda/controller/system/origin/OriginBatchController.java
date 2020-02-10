package com.panda.controller.system.origin;

import com.alibaba.citrus.util.StringEscapeUtil;
import com.alibaba.fastjson.JSON;
import com.panda.controller.system.index.ExportFileController;
import com.panda.model.origin.OriginBatch;
import com.panda.model.system.Dictionary;
import com.panda.model.system.Users;
import com.panda.service.commodity.ProductsService;
import com.panda.service.origin.*;
import com.panda.service.system.DictionaryService;
import com.panda.util.CreateBatchNoUtil;
import com.panda.util.ResultMsgUtil;
import com.panda.util.ResultStateUtil;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

/**
 * Created with IDEA.
 *
 * @AUTH: Alan
 * Date: 2017/12/7
 * Time: 11:01
 */
@Controller
@RequestMapping("/system/originBatch")
public class OriginBatchController {
    @Resource
    private HarvestRecordsService harvestRecordsService;

    @Resource
    private OriginBatchService originBatchService;

    @Resource
    private OriginCodeService originCodeService;

    @Resource
    private ProductsService productsService;

    @Autowired
    private ExportFileController exportFileController;

    @Resource
    private DictionaryService dictionaryService;

    @Resource
    private QualityService qualityService;

    @Resource
    private TeaGardenService teaGardenService;
    private static boolean message = false;
    private static Object  data    = null;

    /**
     * 列表页面
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/list",method= RequestMethod.GET)
    @RequiresPermissions("originBatch:view")//权限管理;
    public String getOriginBatchList(HttpServletRequest request, Model model){
        Users user= (Users) SecurityUtils.getSubject().getPrincipal();
        List<Dictionary> teaArrt = dictionaryService.selectDictionaryValueList("31783870-956f-469f-b43e-9fefd905afca");//茶系
        Map query = new HashMap(1);
        query.put("status",3);
        List<Map> harvestList = harvestRecordsService.selectHarvestRecordsList(query);
        query.put("status",1);
        List<Map> teaGarList = teaGardenService.selectTeaGardenList(query);
        model.addAttribute("menuList",user.getMenuList());
        model.addAttribute("harvestList",harvestList);
        model.addAttribute("teaGarList",teaGarList);
        model.addAttribute("teaArrt", teaArrt);
        model.addAttribute("user",user);
        return "system/origin/getOriginBatchList";
    }

    /**
     * Ajax 获取信息列表
     * @param request
     * @return
     */
    @RequestMapping(value = "/getOriginBatchDataList",method = RequestMethod.POST)
    @ResponseBody
    public Object getOriginBatchDataList(HttpServletRequest request,String datatable){
        message = false;
        data    = null;
        List<Map> originBatchList = null;
        try {
            Map query = new HashMap();
            if (datatable != null && !datatable.isEmpty()){
                String jsonStr = StringEscapeUtil.unescapeHtml(datatable);
                Map params = JSON.parseObject(jsonStr,Map.class);
                Map status = JSON.parseObject(params.get("query").toString(),Map.class);
                if (status.size() > 0 && status.get("dicMacType") != ""){
                    query.put("dicMacType",status.get("dicMacType"));
                }
                if (status.size() > 0 && status.get("dicTeaAttr") != ""){
                    query.put("dicTeaAttr",status.get("dicTeaAttr"));
                }
                if (status.size() > 0 && status.get("dicMacPro") != ""){
                    query.put("dicMacPro",status.get("dicMacPro"));
                }
                if (status.size() > 0 && status.get("productId") != ""){
                    query.put("productId",status.get("productId"));
                }
            }
            int i = originBatchService.countAll();
            if (i > 0){
                originBatchList = originBatchService.selectOriginBatchDataList(query);
            }
            if(originBatchList != null && originBatchList.size() > 0){
                message = true;
                data = originBatchList;
            }
        }catch (Exception e){
            e.printStackTrace();
            data    = ResultStateUtil.ERROR_DATABASE_OPERATION;
        }
        return ResultMsgUtil.getResultMsg(message,data);
    }

    /**
     * Ajax 获取当前编辑项的内容
     * @param request
     * @param id
     * @return
     */
    @RequestMapping(value = "/editOriginBatchItem", method = RequestMethod.GET)
    @ResponseBody
    public Object editOriginBatchItem(HttpServletRequest request,String id){
        message = false;
        data    = null;
        if (!id.isEmpty()){
            try {
                OriginBatch originBatch = originBatchService.selectByPrimaryKey(id);
                if(originBatch != null){
                    message = true;
                    data = originBatch;
                }else{
                    data = ResultStateUtil.ERROR_QUERY;
                }
            }catch (Exception e){
                e.printStackTrace();
                data    = ResultStateUtil.ERROR_DATABASE_OPERATION;
            }
        }
        return ResultMsgUtil.getResultMsg(message,data);
    }

    /**
     * 保存和编辑数据
     * @param request
     * @param originBatch
     * @param save
     * @return
     */
    @RequestMapping(value = "/saveOrUpdateOriginBatch",method = RequestMethod.POST)
    @ResponseBody
    public Object saveOrUpdateOriginBatch(HttpServletRequest request, OriginBatch originBatch , String save){
        Users user= (Users) SecurityUtils.getSubject().getPrincipal();
        message = false;
        data    = null;
        try{
            if(!originBatch.getId().isEmpty() && save != null && save.equals("edit")){
                originBatch.setModifyId(user.getId());
                originBatch.setModifyTime(new Date());
                int i = originBatchService.updateByPrimaryKeySelective(originBatch);
                if(i > 0){
                    message = true;
                    data    = ResultStateUtil.SUCCESS_UPDATE;
                }else{
                    data    = ResultStateUtil.FAIL_UPDATE;
                }
            }else if(save.equals("add")) {
                originBatch.setId(UUID.randomUUID().toString());
                originBatch.setCreateId(user.getId());
                originBatch.setCreateTime(new Date());
                int insert = originBatchService.insertSelective(originBatch);
                if(insert > 0){
                    message = true;
                    data    = ResultStateUtil.SUCCESS_ADD;
                }else{
                    data    = ResultStateUtil.FAIL_ADD;
                }
            }
        }catch (Exception e){
            e.printStackTrace();
            data  = ResultStateUtil.ERROR_DATABASE_OPERATION;
        }
        return ResultMsgUtil.getResultMsg(message,data);
    }
    /**
     * 获取编码
     * @param request
     * @return
     */
    @RequestMapping(value = "/getMsuData",method = RequestMethod.GET)
    @ResponseBody
    public Object getMsuData(HttpServletRequest request){
        return ResultMsgUtil.getResultMsg(true,"MSU"+ CreateBatchNoUtil.createBatchNo());
    }

    /**
     * 批量生成 溯源码
     * @param request
     * @return
     */
    @RequestMapping(value = "/createCode",method = RequestMethod.POST)
    @ResponseBody
    public Object createCode(HttpServletRequest request,String originBatchId,String prefixVal,Integer createNum){
        Users user= (Users) SecurityUtils.getSubject().getPrincipal();
        message = false;
        data    = null;
        if (!originBatchId.isEmpty() && !prefixVal.isEmpty() && createNum > 0){
            Integer status = originCodeService.createOriginCodeList(originBatchId,prefixVal,createNum);
            switch (status){
                case 200:
                    OriginBatch originBatch = new OriginBatch();
                    originBatch.setId(originBatchId);
                    originBatch.setModifyId(user.getId());
                    originBatch.setModifyTime(new Date());
                    originBatch.setStatus(1);
                    message = true;
                    data = ResultStateUtil.SUCCESS_BINDING;
                    originBatchService.updateByPrimaryKeySelective(originBatch);
                    break;
                case 101:
                    data = ResultStateUtil.CODE_OUT_TIME;
                    break;
                default:
                    data = ResultStateUtil.CODE_OUT_TIME;
                    break;
            }
        }else{
            data = ResultStateUtil.ERROR_PARAMETER_NO_TCOMPATIBLE;
        }
        return ResultMsgUtil.getResultMsg(message,data);
    }

    /**
     * 导出溯源码
     */
    @RequestMapping(value = "/exportOriginCode",method = RequestMethod.GET)
    @RequiresPermissions("originBatch:export")//权限管理;
    public void exportOriginCode(HttpServletRequest request, HttpServletResponse response, String originBatchId){
        try {
            if (!originBatchId.isEmpty()){
                Map query = new HashMap();
                query.put("originBatchId",originBatchId);
                List<Map> originBatchList = originCodeService.selectOriginCodeDataList(query);
                if (originBatchList.size() > 0){
                    exportFileController.exportFileIndex(request,response,originBatchList,"第 "+originBatchList.get(0).get("batchNum")+" 批次溯源码","excel");
                }
            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    /**
     * 刪除
     * @param request
     * @param id
     * @return
     */
    @RequestMapping(value="/delOriginBatchItem",method = RequestMethod.POST)
    @ResponseBody
    public Object delOriginBatchItem(HttpServletRequest request ,String id){
        message = false;
        data    = null;
        try{
            if (!id.isEmpty()){
                int i = originBatchService.deleteByPrimaryKey(id);
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
     * 获取当前批次加工完成的产品信息，并且未绑定溯源批次
     * @param request
     * @param harvestBatchId
     * @return
     */
    @RequestMapping(value = "/getProductData", method = RequestMethod.POST)
    @ResponseBody
    public Object getProductData(HttpServletRequest request ,String harvestBatchId){
        message = false;
        data    = null;
        try{
            if (!harvestBatchId.isEmpty()){
                List<Map> proList = productsService.selectMachinOverProductNotBindOrigin(harvestBatchId);
                if(proList != null && proList.size() > 0){
                    message = true;
                    data = proList;
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
     * 获取当前批次质检完成，并且未绑定溯源批次
     * @param request
     * @param harvestBatchId
     * @return
     */
    @RequestMapping(value = "/getQualityData", method = RequestMethod.POST)
    @ResponseBody
    public Object getQualityData(HttpServletRequest request ,String harvestBatchId){
        message = false;
        data    = null;
        try{
            if (!harvestBatchId.isEmpty()){
                List<Map> quaList = qualityService.selectMachinOverQualityNotBindOrigin(harvestBatchId);
                if(quaList != null && quaList.size() > 0){
                    message = true;
                    data = quaList;
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
