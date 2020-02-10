package com.panda.controller.system.origin;

import com.alibaba.citrus.util.StringEscapeUtil;
import com.alibaba.fastjson.JSON;
import com.panda.model.commodity.Products;
import com.panda.model.origin.MachinSet;
import com.panda.model.origin.OriginBatch;
import com.panda.model.origin.OriginInfo;
import com.panda.model.system.Dictionary;
import com.panda.model.system.Users;
import com.panda.service.commodity.ProductsService;
import com.panda.service.origin.MachinSetService;
import com.panda.service.origin.OriginBatchService;
import com.panda.service.origin.OriginInfoService;
import com.panda.service.system.DictionaryService;
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

/**
 * Created with IDEA.
 *
 * @AUTH: Alan
 * Date: 2017/12/7
 * Time: 11:00
 */
@Controller
@RequestMapping("/system/originInfo")
public class OriginInfoController {
    @Resource
    private OriginBatchService originBatchService;

    @Resource
    private OriginInfoService originInfoService;

    @Resource
    private ProductsService productsService;

    @Resource
    private DictionaryService dictionaryService;
    private static boolean message = false;
    private static Object  data    = null;

    /**
     * 列表页面
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/list",method= RequestMethod.GET)
    @RequiresPermissions("originInfo:view")//权限管理;
    public String getMachinSetList(HttpServletRequest request, Model model){
        Users user= (Users) SecurityUtils.getSubject().getPrincipal();
        List<OriginBatch> batchList = originBatchService.selectAll();//溯源批次
        List<Dictionary> originInfoType = dictionaryService.selectDictionaryValueList("7dcd4ffe-3041-4ce7-ae5f-ac3ba811ff71");
        model.addAttribute("batchList",batchList);
        model.addAttribute("originInfoType",originInfoType);
        model.addAttribute("menuList",user.getMenuList());
        model.addAttribute("user",user);
        return "system/origin/getOriginInfoList";
    }

    /**
     * Ajax 获取信息列表
     * @param request
     * @return
     */
    @RequestMapping(value = "/getOriginInfoDataList",method = RequestMethod.POST)
    @ResponseBody
    public Object getOriginInfoDataList(HttpServletRequest request,String datatable){
        message = false;
        data    = null;
        try {
            Map query = new HashMap();
            if (datatable != null && !datatable.isEmpty()){
                String jsonStr = StringEscapeUtil.unescapeHtml(datatable);
                Map params = JSON.parseObject(jsonStr,Map.class);
                Map status = JSON.parseObject(params.get("query").toString(),Map.class);
                if (status.size() > 0 && status.get("dicOriginType") != ""){
                    query.put("dicOriginType",status.get("dicOriginType"));
                }
                if (status.size() > 0 && status.get("originBatch") != ""){
                    query.put("originBatch",status.get("originBatch"));
                }
            }
            List<Map> infoDataList = originInfoService.selectOriginInfoDataList(query);
            if(infoDataList.size() > 0){
                message = true;
                data = infoDataList;
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
    @RequestMapping(value = "/getOriginInfoItem", method = RequestMethod.GET)
    @ResponseBody
    public Object getOriginInfoItem(HttpServletRequest request,String id){
        message = false;
        data    = null;
        if (!id.isEmpty()){
            try {
                OriginInfo originInfo = originInfoService.selectByPrimaryKey(id);
                if(originInfo != null){
                    message = true;
                    data = originInfo;
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
     * @param originInfo
     * @param save
     * @return
     */
    @RequestMapping(value = "/saveOrUpdateOriginInfo",method = RequestMethod.POST)
    @ResponseBody
    public Object saveOrUpdateMachinSet(HttpServletRequest request, OriginInfo originInfo , String save){
        Users user= (Users) SecurityUtils.getSubject().getPrincipal();
        message = false;
        data    = null;
        try{
            if(!originInfo.getId().isEmpty() && save != null && save.equals("edit")){
                originInfo.setModifyTime(new Date());
                int i = originInfoService.updateByPrimaryKeySelective(originInfo);
                if(i > 0){
                    message = true;
                    data    = ResultStateUtil.SUCCESS_UPDATE;
                }else{
                    data    = ResultStateUtil.FAIL_UPDATE;
                }
            }else if(save.equals("add")) {
                originInfo.setId(UUID.randomUUID().toString());
                originInfo.setCreateId(user.getId());
                originInfo.setCreateTime(new Date());
                originInfo.setModifyId(user.getId());
                originInfo.setModifyTime(new Date());
                originInfo.setStatus(1);
                int insert = originInfoService.insertSelective(originInfo);
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
     * 刪除
     * @param request
     * @param id
     * @return
     */
    @RequestMapping(value="/delOriginInfoItem",method = RequestMethod.GET)
    @ResponseBody
    public Object delOriginInfoItem(HttpServletRequest request ,String id){
        message = false;
        data    = null;
        try{
            if (!id.isEmpty()){
                int i = originInfoService.deleteByPrimaryKey(id);
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
