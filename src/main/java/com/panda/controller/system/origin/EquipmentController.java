package com.panda.controller.system.origin;

import com.alibaba.citrus.util.StringEscapeUtil;
import com.alibaba.fastjson.JSON;
import com.panda.model.origin.Equipment;
import com.panda.model.system.Dictionary;
import com.panda.model.system.Users;
import com.panda.service.commodity.ProductsService;
import com.panda.service.origin.EquipmentService;
import com.panda.service.origin.EquipmentService;
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

@Controller
@RequestMapping(value = "/system/equipment")
public class EquipmentController {

    @Resource
    private EquipmentService equipmentService;

    @Resource
    private DictionaryService dictionaryService;
    private static boolean message = false;
    private static Object  data    = null;
    /**
     * 获取加工设置数据
     * @return
     */
    @RequestMapping(value = "/list",method= RequestMethod.GET)
    @RequiresPermissions("equipment:view")//权限管理;
    public String getEquipmentList(HttpServletRequest request, Model model){
        Users user= (Users) SecurityUtils.getSubject().getPrincipal();
        List<Dictionary> machinProcess = dictionaryService.selectDictionaryValueList("1e12732d-246e-11e5-965c-000c29d7a3a0");//工序
        List<Dictionary> teaArrt = dictionaryService.selectDictionaryValueList("31783870-956f-469f-b43e-9fefd905afca");//茶系
        model.addAttribute("teaArrt", teaArrt);
        model.addAttribute("menuList",user.getMenuList());
        model.addAttribute("machinProcess",machinProcess);
        model.addAttribute("user",user);
        return "system/origin/getEquipmentList";
    }

    /**
     * Ajax 获取信息列表
     * @param request
     * @return
     */
    @RequestMapping(value = "/getEquipmentDataList",method = RequestMethod.POST)
    @ResponseBody
    public Object getEquipmentDataList(HttpServletRequest request,String datatable){
        message = false;
        data    = null;
        try {
            Map query = new HashMap();
            if (datatable != null && !datatable.isEmpty()){
                String jsonStr = StringEscapeUtil.unescapeHtml(datatable);
                Map params = JSON.parseObject(jsonStr,Map.class);
                Map status = JSON.parseObject(params.get("query").toString(),Map.class);
                if (status.size() > 0 && status.get("status") != ""){
                    query.put("status",status.get("status"));
                }
                if (status.size() > 0 && status.get("unitStatus") != ""){
                    query.put("unitStatus",status.get("unitStatus"));
                }
            }
            List<Map> EquipmentList = equipmentService.selectEquipmentDataList(query);
            if(EquipmentList.size() > 0){
                message = true;
                data = EquipmentList;
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
    @RequestMapping(value = "/editEquipmentItem", method = RequestMethod.GET)
    @ResponseBody
    public Object editEquipmentItem(HttpServletRequest request,String id){
        message = false;
        data    = null;
        if (!id.isEmpty()){
            try {
                Map equipment = equipmentService.selectEquipmentItemByPrimaryKey(id);
                if(equipment != null){
                    message = true;
                    data = equipment;
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
     * @param equipment
     * @param save
     * @return
     */
    @RequestMapping(value = "/saveOrUpdateEquipment",method = RequestMethod.POST)
    @ResponseBody
    public Object saveOrUpdateEquipment(HttpServletRequest request, Equipment equipment , String save){
        Users user= (Users) SecurityUtils.getSubject().getPrincipal();
        message = false;
        data    = null;
        try{
            if(!equipment.getId().isEmpty() && save != null && save.equals("edit")){
                int i = equipmentService.updateByPrimaryKeySelective(equipment);
                if(i > 0){
                    message = true;
                    data    = ResultStateUtil.SUCCESS_UPDATE;
                }else{
                    data    = ResultStateUtil.FAIL_UPDATE;
                }
            }else if(save.equals("add")) {
                equipment.setId(UUID.randomUUID().toString());
                equipment.setCreateId(user.getId());
                equipment.setCreateTime(new Date());
                equipment.setModifyId(user.getId());
                equipment.setModifyTime(new Date());
                equipment.setUnitStatus(2);
                int insert = equipmentService.insertSelective(equipment);
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
    @RequestMapping(value="/delEquipmentItem",method = RequestMethod.GET)
    @ResponseBody
    public Object delEquipmentItem(HttpServletRequest request ,String id){
        message = false;
        data    = null;
        try{
            if (!id.isEmpty()){
                int i = equipmentService.deleteByPrimaryKey(id);
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
