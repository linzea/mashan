package com.panda.controller.system.origin;

import com.alibaba.citrus.util.StringEscapeUtil;
import com.alibaba.fastjson.JSON;
import com.panda.model.origin.HarvestRecords;
import com.panda.model.system.Dictionary;
import com.panda.model.system.Users;
import com.panda.service.origin.HarvestRecordsService;
import com.panda.service.origin.TeaGardenService;
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
 * Date: 2017/12/22
 * Time: 9:26
 */
@Controller
@RequestMapping(value = "/system/harvest")
public class HarvestRecordsController {

    @Resource
    private HarvestRecordsService harvestRecordsService;
    @Resource
    private TeaGardenService teaGardenService;
    @Resource
    private DictionaryService dictionaryService;
    private static boolean message = false;
    private static Object  data    = null;

    /**
     * 列表首页
     * @return
     */
    @RequestMapping(value = "/list",method= RequestMethod.GET)
    @RequiresPermissions("harvest:view")//权限管理;
    public String getHarvestList(HttpServletRequest request, Model model){
        Users user= (Users) SecurityUtils.getSubject().getPrincipal();
        Map map = new HashMap();
        map.put("status",1);
        List<Dictionary> pickStandard = dictionaryService.selectDictionaryValueList("963c5d6c-7015-4f92-9b9c-80b274ab10d4");//采摘标准
        List<Dictionary> teaType = dictionaryService.selectDictionaryValueList("be0ba01c-23ad-11e5-965c-000c29d7a3a0");//品种
        List<Dictionary> pickArea = dictionaryService.selectDictionaryValueList("ab73bbbb-f7ca-4fe9-a086-296e57b9c3ac");//区域
        List<Map> teaGardens = teaGardenService.selectTeaGardenList(map);
        model.addAttribute("pickStandard",pickStandard);
        model.addAttribute("pickArea",pickArea);
        model.addAttribute("teaType",teaType);
        model.addAttribute("teaGardens",teaGardens);
        model.addAttribute("menuList",user.getMenuList());
        model.addAttribute("user",user);
        return "system/origin/getHarvestList";
    }

    /**
     * Ajax 获取信息列表
     * @param request
     * @return
     */
    @RequestMapping(value = "/getHarvestDataList",method = RequestMethod.POST)
    @ResponseBody
    public Object getHarvestDataList(HttpServletRequest request,String datatable){
        message = false;
        data    = null;
        try {
            Map query = new HashMap(4);
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
                if (status.size() > 0 && status.get("status") != ""){
                    query.put("status",status.get("status"));
                }
            }
            List<Map> harvestList = harvestRecordsService.selectHarvestRecordsList(query);
            if(harvestList.size() > 0){
                message = true;
                data = harvestList;
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
    @RequestMapping(value = "/editHarvestItem", method = RequestMethod.GET)
    @ResponseBody
    public Object editHarvestItem(HttpServletRequest request,String id){
        message = false;
        data    = null;
        if (!id.isEmpty()){
            try {
                Map harvest = harvestRecordsService.selectHarvestRecordsItem(id);
                if(harvest != null){
                    message = true;
                    data = harvest;
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
     * 保存和编辑加工设置数据
     * @param request
     * @param harvest
     * @param save
     * @return
     */
    @RequestMapping(value = "/saveOrUpdateHarvest",method = RequestMethod.POST)
    @ResponseBody
    public Object saveOrUpdateHarvest(HttpServletRequest request, HarvestRecords harvest , String save){
        Users user= (Users) SecurityUtils.getSubject().getPrincipal();
        message = false;
        data    = null;
        try{
            if(!harvest.getId().isEmpty() && save != null && save.equals("edit")){
                int i = harvestRecordsService.updateByPrimaryKeySelective(harvest);
                if(i > 0){
                    message = true;
                    data    = ResultStateUtil.SUCCESS_UPDATE;
                }else{
                    data    = ResultStateUtil.FAIL_UPDATE;
                }
            }else if(save.equals("add")) {
                harvest.setId(UUID.randomUUID().toString());
                harvest.setCreateId(user.getId());
                harvest.setCreateTime(new Date());
                harvest.setStatus(2);
                int insert = harvestRecordsService.insertSelective(harvest);
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
    @RequestMapping(value="/delHarvestItem",method = RequestMethod.GET)
    @ResponseBody
    public Object delHarvestItem(HttpServletRequest request ,String id){
        message = false;
        data    = null;
        try{
            if (!id.isEmpty()){
                int result = harvestRecordsService.delHarvestItem(id);
                switch (result){
                    case 200:
                        message = true;
                        data    = ResultStateUtil.SUCCESS_ABNORMAL;
                        break;
                    case 101:
                        data    = ResultStateUtil.FAIL_DELETE;
                        break;
                    default:
                        data    = ResultStateUtil.IO_EXCEPTION;
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
