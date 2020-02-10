package com.panda.controller.system.origin;

import com.alibaba.citrus.util.StringEscapeUtil;
import com.alibaba.fastjson.JSON;
import com.panda.model.commodity.Products;
import com.panda.model.origin.MachinSet;
import com.panda.model.system.Dictionary;
import com.panda.model.system.Users;
import com.panda.service.commodity.ProductsService;
import com.panda.service.origin.AssemblySetService;
import com.panda.service.origin.MachinSetService;
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
 * Date: 2017/11/28
 * Time: 22:28
 */
@Controller
@RequestMapping("/system/machinSet")
public class MachinSetController {

    @Resource
    private MachinSetService machinSetService;

    @Resource
    private AssemblySetService assemblySetService;

    @Resource
    private DictionaryService dictionaryService;
    private static boolean message = false;
    private static Object  data    = null;
    /**
     * 获取加工设置数据
     * @return
     */
    @RequestMapping(value = "/list",method= RequestMethod.GET)
    @RequiresPermissions("machinSet:view")//权限管理;
    public String getMachinSetList(HttpServletRequest request, Model model){
        Map map = new HashMap();
        map.put("status", 1);
        Users user= (Users) SecurityUtils.getSubject().getPrincipal();
        List<Dictionary> machinType = dictionaryService.selectDictionaryValueList("0b9ed538-29d6-11e5-965c-000c29d7a3a0");//加工类型
        List<Dictionary> teaArrt = dictionaryService.selectDictionaryValueList("31783870-956f-469f-b43e-9fefd905afca");//茶系
        List<Dictionary> machinProcess = dictionaryService.selectDictionaryValueList("1e12732d-246e-11e5-965c-000c29d7a3a0");//工序
        List<Dictionary> rollingType = dictionaryService.selectDictionaryValueList("6d493a67-1545-4022-b7d4-2854c5b70abd");//揉捻类型
        map.put("parentId", "10000000-0000-0000-0000-000000000000");
        List<Map> assemblyList = assemblySetService.selectAssemblySetDataList(map); //生产线
        model.addAttribute("machinType",machinType);
        model.addAttribute("rollingType",rollingType);
        model.addAttribute("assemblyList", assemblyList);
        model.addAttribute("teaArrt",teaArrt);
        model.addAttribute("machinProcess",machinProcess);
        model.addAttribute("menuList",user.getMenuList());
        model.addAttribute("user",user);
        return "system/origin/getMachinSetList";
    }

    /**
     * Ajax 获取信息列表
     * @param request
     * @return
     */
    @RequestMapping(value = "/getMachinSetDataList",method = RequestMethod.POST)
    @ResponseBody
    public Object getMachinSetDataList(HttpServletRequest request,String datatable){
        message = false;
        data    = null;
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
            List<Map> machinSetList = machinSetService.selectMachinSetDataList(query);
            if(machinSetList.size() > 0){
                message = true;
                data = machinSetList;
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
    @RequestMapping(value = "/editMachinSetItem", method = RequestMethod.GET)
    @ResponseBody
    public Object editMachinSetItem(HttpServletRequest request,String id){
        message = false;
        data    = null;
        if (!id.isEmpty()){
            try {
                MachinSet machinSet = machinSetService.selectByPrimaryKey(id);
                if(machinSet != null){
                    message = true;
                    data = machinSet;
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
     * @param machinSet
     * @param save
     * @return
     */
    @RequestMapping(value = "/saveOrUpdateMachinSet",method = RequestMethod.POST)
    @ResponseBody
    public Object saveOrUpdateMachinSet(HttpServletRequest request, MachinSet machinSet , String save){
        Users user= (Users) SecurityUtils.getSubject().getPrincipal();
        message = false;
        data    = null;
        try{
            if(!machinSet.getId().isEmpty() && save != null && save.equals("edit")){
                int i = machinSetService.updateByPrimaryKeySelective(machinSet);
                if(i > 0){
                    message = true;
                    data    = ResultStateUtil.SUCCESS_UPDATE;
                }else{
                    data    = ResultStateUtil.FAIL_UPDATE;
                }
            }else if(save.equals("add")) {
                machinSet.setId(UUID.randomUUID().toString());
                machinSet.setCreateId(user.getId());
                machinSet.setCreateTime(new Date());
                machinSet.setModifyId(user.getId());
                machinSet.setModifyTime(new Date());
                machinSet.setStatus(1);
                int insert = machinSetService.insertSelective(machinSet);
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
    @RequestMapping(value="/delMachinSetItem",method = RequestMethod.GET)
    @ResponseBody
    public Object delMachinSetItem(HttpServletRequest request ,String id){
        message = false;
        data    = null;
        try{
            if (!id.isEmpty()){
                int i = machinSetService.deleteByPrimaryKey(id);
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
