package com.panda.controller.system.origin;

import com.alibaba.citrus.util.StringEscapeUtil;
import com.alibaba.fastjson.JSON;
import com.panda.model.origin.EquipmentMaintain;
import com.panda.model.system.Dictionary;
import com.panda.model.system.Users;
import com.panda.service.origin.AssemblySetService;
import com.panda.service.origin.EquipmentMaintainService;
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
 * Date: 2017/12/25
 * Time: 11:48
 */
@Controller
@RequestMapping(value = "/system/maintain")
public class EquipmentMaintainController {

    @Resource
    private EquipmentMaintainService equipmentMaintainService;

    @Resource
    private DictionaryService dictionaryService;

    @Resource
    private AssemblySetService assemblySetService;

    private static boolean message = false;
    private static Object  data    = null;

    /**
     * 获取页面加载
     * @return
     */
    @RequestMapping(value = "/list",method= RequestMethod.GET)
    @RequiresPermissions("maintain:view")//权限管理;
    public String getMaintainList(HttpServletRequest request, Model model){
        Users user= (Users) SecurityUtils.getSubject().getPrincipal();
        Map map = new HashMap();
        map.put("parentId","10000000-0000-0000-0000-000000000000");
        List<Dictionary> maintainType = dictionaryService.selectDictionaryValueList("5530f9e2-869f-407e-b67b-ce56688e50ca");//设备保养类型
        List<Map> assemList = assemblySetService.selectAssemblySetDataList(map);
        model.addAttribute("assemList",assemList);
        model.addAttribute("maintainType",maintainType);
        model.addAttribute("menuList",user.getMenuList());
        model.addAttribute("user",user);
        return "system/origin/getMaintainList";
    }

    /**
     * Ajax 获取信息列表
     * @param request
     * @return
     */
    @RequestMapping(value = "/getMaintainDataList",method = RequestMethod.POST)
    @ResponseBody
    public Object getMaintainDataList(HttpServletRequest request,String datatable){
        message = false;
        data    = null;
        try {
            Map query = new HashMap();
            if (datatable != null && !datatable.isEmpty()){
                String jsonStr = StringEscapeUtil.unescapeHtml(datatable);
                Map params = JSON.parseObject(jsonStr,Map.class);
                Map status = JSON.parseObject(params.get("query").toString(),Map.class);
                if (status.size() > 0 && status.get("parentId") != ""){
                    query.put("parentId",status.get("parentId"));
                }
                if (status.size() > 0 && status.get("maintainType") != ""){
                    query.put("maintainType",status.get("maintainType"));
                }
            }
            List<Map> EquipmentList = equipmentMaintainService.selectEquipmentMaintainDataList(query);
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
    @RequestMapping(value = "/editMaintainItem", method = RequestMethod.GET)
    @ResponseBody
    public Object editMaintainItem(HttpServletRequest request,String id){
        message = false;
        data    = null;
        if (!id.isEmpty()){
            try {
                Map equipment = equipmentMaintainService.selectEquipmentMaintainDataItem(id);
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
    @RequestMapping(value = "/saveOrUpdateMaintain",method = RequestMethod.POST)
    @ResponseBody
    public Object saveOrUpdateMaintain(HttpServletRequest request, EquipmentMaintain equipment , String save){
        Users user= (Users) SecurityUtils.getSubject().getPrincipal();
        message = false;
        data    = null;
        try{
            if(!equipment.getId().isEmpty() && save != null && save.equals("edit")){
                int i = equipmentMaintainService.updateByPrimaryKeySelective(equipment);
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
                int insert = equipmentMaintainService.insertSelective(equipment);
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
    @RequestMapping(value="/delMaintainItem",method = RequestMethod.GET)
    @ResponseBody
    public Object delMaintainItem(HttpServletRequest request ,String id){
        message = false;
        data    = null;
        try{
            if (!id.isEmpty()){
                int i = equipmentMaintainService.deleteByPrimaryKey(id);
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
     * 获取制定生产线下的设备信息
     * @param request
     * @param assemblySetId
     * @return
     */
    @RequestMapping(value = "/getAssemblySetEquipmentList",method = RequestMethod.GET)
    @ResponseBody
    public Object getAssemblySetEquipmentList(HttpServletRequest request ,String assemblySetId){
        message = false;
        data    = null;
        try{
            if (!assemblySetId.isEmpty()){
                Map map = new HashMap();
                map.put("parentId",assemblySetId);
                List<Map> assemblyList = assemblySetService.selectAssemblySetDataList(map);
                if(assemblyList != null && assemblyList.size() > 0){
                    message = true;
                    data = assemblyList;
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
