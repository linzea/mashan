package com.panda.controller.system.commodity;

import com.alibaba.citrus.util.StringEscapeUtil;
import com.alibaba.fastjson.JSON;
import com.panda.model.commodity.SemiFinished;
import com.panda.model.system.Dictionary;
import com.panda.model.system.Users;
import com.panda.service.commodity.SemiFinishedService;
import com.panda.service.origin.HarvestRecordsService;
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
 * User: Alan
 * Date: 2017/12/29
 * Time: 10:03
 */
@Controller
@RequestMapping(value = "/system/semiFinished")
public class SemiFinishedController {

    @Resource
    private SemiFinishedService semiFinishedService;//半成品库

    @Resource
    private DictionaryService dictionaryService;

    @Resource
    private HarvestRecordsService harvestRecordsService;//鲜叶批次

    private static boolean message = false;
    private static Object data = null;

    /**
     * 获取半成品数据
     * @return
     */
    @RequestMapping(value = "/list",method= RequestMethod.GET)
    @RequiresPermissions("semiFinished:view")//权限管理;
    public String getSemiFinishedList(HttpServletRequest request, Model model){
        Users user= (Users) SecurityUtils.getSubject().getPrincipal();
        Map map = new HashMap();
        List<Dictionary> teaArrt = dictionaryService.selectDictionaryValueList("31783870-956f-469f-b43e-9fefd905afca");//茶系
        List<Dictionary> treeType = dictionaryService.selectDictionaryValueList("be0ba01c-23ad-11e5-965c-000c29d7a3a0");//树种
        List<Map> harvestQuery = harvestRecordsService.selectHarvestRecordsListPickNum(map); //鲜叶批次查询时
        model.addAttribute("menuList",user.getMenuList());
        model.addAttribute("harvestQuery", harvestQuery);
        model.addAttribute("treeType",treeType);
        model.addAttribute("teaArrt", teaArrt);
        model.addAttribute("user",user);
        return "system/commodity/getSemiFinishedList";
    }

    /**
     * Ajax 获取信息列表
     * @param request
     * @return
     */
    @RequestMapping(value = "/getSemiFinishedDataList",method = RequestMethod.POST)
    @ResponseBody
    public Object getSemiFinishedDataList(HttpServletRequest request,String datatable){
        message = false;
        data    = null;
        try {
            Map query = new HashMap();
            if (datatable != null && !datatable.isEmpty()){
                String jsonStr = StringEscapeUtil.unescapeHtml(datatable);
                Map params = JSON.parseObject(jsonStr,Map.class);
                Map status = JSON.parseObject(params.get("query").toString(),Map.class);
                if (status.size() > 0 && status.get("harvestBatchId") != ""){
                    query.put("harvestBatchId",status.get("harvestBatchId"));
                }
                if (status.size() > 0 && status.get("dicTeaAttr") != ""){
                    query.put("dicTeaAttr",status.get("dicTeaAttr"));
                }
                if (status.size() > 0 && status.get("dicTeaType") != ""){
                    query.put("dicTeaType",status.get("dicTeaType"));
                }
            }
            List<Map> SemiFinishedList = semiFinishedService.selectSemiFinishedDataList(query);
            if(SemiFinishedList.size() > 0){
                message = true;
                data = SemiFinishedList;
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
    @RequestMapping(value = "/editSemiFinishedItem", method = RequestMethod.GET)
    @ResponseBody
    public Object editSemiFinishedItem(HttpServletRequest request,String id){
        message = false;
        data    = null;
        if (!id.isEmpty()){
            try {
                Map semiFinished = semiFinishedService.selectSemiFinishedDataItem(id);
                if(semiFinished != null){
                    message = true;
                    data = semiFinished;
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
     * @param SemiFinished
     * @param save
     * @return
     */
    @RequestMapping(value = "/saveOrUpdateSemiFinished",method = RequestMethod.POST)
    @ResponseBody
    public Object saveOrUpdateSemiFinished(HttpServletRequest request, SemiFinished SemiFinished , String save){
        Users user= (Users) SecurityUtils.getSubject().getPrincipal();
        message = false;
        data    = null;
        try{
            if(!SemiFinished.getId().isEmpty() && save != null && save.equals("edit")){
                SemiFinished.setModifyId(user.getId());
                SemiFinished.setModifyTime(new Date());
                int i = semiFinishedService.updateByPrimaryKeySelective(SemiFinished);
                if(i > 0){
                    message = true;
                    data    = ResultStateUtil.SUCCESS_UPDATE;
                }else{
                    data    = ResultStateUtil.FAIL_UPDATE;
                }
            }else if(save.equals("add")) {
                SemiFinished.setId(UUID.randomUUID().toString());
                SemiFinished.setCreateId(user.getId());
                SemiFinished.setCreateTime(new Date());
                SemiFinished.setStatus(1);
                int insert = semiFinishedService.insertSelective(SemiFinished);
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
    @RequestMapping(value="/delSemiFinishedItem",method = RequestMethod.GET)
    @ResponseBody
    public Object delSemiFinishedItem(HttpServletRequest request ,String id){
        message = false;
        data    = null;
        try{
            if (!id.isEmpty()){
                int i = semiFinishedService.deleteByPrimaryKey(id);
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
     * 半成品出库-加工成成品
     * @return
     */
    @RequestMapping(value = "/semiFinishedOut")
    @ResponseBody
    public Object semiFinishedOut(HttpServletRequest request ,String id){
        message = false;
        data    = null;
        try{
            if (!id.isEmpty()){
                int insert = semiFinishedService.semiFinishedOut(id);
                switch (insert) {
                    case 200:
                        message = true;
                        data = ResultStateUtil.SUCCESS_ABNORMAL;
                        break;
                    case 101:
                        data = "半成品出库失败,数据异常!";
                        break;
                    default:
                        data = "半成品出库失败,数据异常!";
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
