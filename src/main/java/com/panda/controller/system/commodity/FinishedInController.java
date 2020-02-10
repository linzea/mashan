package com.panda.controller.system.commodity;

import com.alibaba.citrus.util.StringEscapeUtil;
import com.alibaba.fastjson.JSON;
import com.panda.model.commodity.Finished;
import com.panda.model.commodity.FinishedOut;
import com.panda.model.commodity.Package;
import com.panda.model.system.Dictionary;
import com.panda.model.system.Users;
import com.panda.service.commodity.FinishedService;
import com.panda.service.system.DictionaryService;
import com.panda.service.system.StoreInfoService;
import com.panda.util.ResultMsgUtil;
import com.panda.util.ResultStateUtil;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.*;

@Controller
@RequestMapping(value = "/system/finishedIn")
public class FinishedInController {

    @Resource
    private StoreInfoService storeInfoService;

    @Resource
    private FinishedService finishedService;

    @Resource
    private DictionaryService dictionaryService;

    private static boolean message = false;
    private static Object  data    = null;

    /**
     * 获取产品
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/list")
    @RequiresPermissions("finishedIn:view")
    public String getFinishedList(HttpServletRequest request, Model model){
        Users user= (Users) SecurityUtils.getSubject().getPrincipal();
        Map query = new HashMap();
        query.put("status",1);
        List<Dictionary> teaArrt = dictionaryService.selectDictionaryValueList("31783870-956f-469f-b43e-9fefd905afca");//茶系
        List<Dictionary> treeType = dictionaryService.selectDictionaryValueList("be0ba01c-23ad-11e5-965c-000c29d7a3a0");//树种
        List<Dictionary> teaGrade= dictionaryService.selectDictionaryValueList("f63fe4f8-27ab-11e5-965c-000c29d7a3a0");//等级
        List<Map> storeList = storeInfoService.selectStoreInfoList(query);
        model.addAttribute("treeType",treeType);
        model.addAttribute("storeList",storeList);
        model.addAttribute("teaArrt",teaArrt);
        model.addAttribute("teaGrade",teaGrade);
        model.addAttribute("menuList",user.getMenuList());
        model.addAttribute("user",user);
        return "system/commodity/getFinishedList";
    }

    /**
     * 获取产品数据
     * @param request
     * @return
     */
    @RequestMapping(value = "/getFinishedDataList")
    @ResponseBody
    public Object getFinishedDataList(HttpServletRequest request, String datatable){
        Users user= (Users) SecurityUtils.getSubject().getPrincipal();
        message = false;
        data    = null;
        try {
            Map map = new HashMap();
            if (datatable != null && !datatable.isEmpty()){
                String jsonStr = StringEscapeUtil.unescapeHtml(datatable);
                Map params = JSON.parseObject(jsonStr,Map.class);
                Map query = JSON.parseObject(params.get("query").toString(),Map.class);
                if (query.size() > 0 && query.get("harvestBatchId") != ""){
                    map.put("harvestBatchId",query.get("harvestBatchId"));
                }
                if (query.size() > 0 && query.get("dicTeaAttr") != ""){
                    map.put("dicTeaAttr",query.get("dicTeaAttr"));
                }
                if (query.size() > 0 && query.get("dicTeaType") != ""){
                    map.put("dicTeaType",query.get("dicTeaType"));
                }
            }
            List<Map> list = finishedService.selectFinishedList(map);
            if(list.size() > 0){
                message = true;
                data = list;
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
    @RequestMapping(value = "/getFinishedItem", method = RequestMethod.POST)
    @ResponseBody
    public Object getFinishedItem(HttpServletRequest request,String id){
        message = false;
        data    = null;
        try {
            if (!id.isEmpty()){
                Map item = finishedService.selectFinishedItem(id);
                if(item != null){
                    message = true;
                    data = item;
                }else{
                    data = ResultStateUtil.ERROR_QUERY;
                }
            }
        }catch (Exception e){
            e.printStackTrace();
            data    = ResultStateUtil.ERROR_DATABASE_OPERATION;
        }

        return ResultMsgUtil.getResultMsg(message,data);
    }

    /**
     * 成品出货，
     * @param request
     * @param finished
     * @param save
     * @return
     */
    @RequestMapping(value = "/saveOrUpdateFinishedOut",method = RequestMethod.POST)
    @ResponseBody
    public Object saveOrUpdateFinishedOut(HttpServletRequest request, Finished finished, FinishedOut finishedOut ,String save){
        Users user= (Users) SecurityUtils.getSubject().getPrincipal();
        message = false;
        data    = null;
        try{
            if(!finished.getId().isEmpty() && save != null && save.equals("edit")){
                int i = finishedService.saveOrUpdateFinishedOut(finished, finishedOut);
                if(i > 0){
                    message = true;
                    data    = ResultStateUtil.SUCCESS_FINI_OUT;
                }else{
                    data    = ResultStateUtil.FAIL_UPDATE;
                }
            }else{
                data    = ResultStateUtil.FAIL_ADD;
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
    @RequestMapping(value="/delFinishedItem",method = RequestMethod.POST)
    @ResponseBody
    public Object delFinishedItem(HttpServletRequest request ,String id){
        message = false;
        data    = null;
        try{
            if (!id.isEmpty()){
                int i = finishedService.deleteByPrimaryKey(id);
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
}
