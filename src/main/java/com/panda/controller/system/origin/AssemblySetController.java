package com.panda.controller.system.origin;

import com.panda.model.origin.AssemblySet;
import com.panda.model.system.Dictionary;
import com.panda.model.system.Users;
import com.panda.service.commodity.ProductsService;
import com.panda.service.origin.AssemblySetService;
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
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/system/assembly")
public class AssemblySetController {

    @Resource
    private EquipmentService equipmentService;

    @Resource
    private AssemblySetService assemblySetService;

    @Resource
    private ProductsService productsService;

    @Resource
    private DictionaryService dictionaryService;
    private static boolean message = false;
    private static Object  data    = null;
    /**
     * 获取生产线
     * @return
     */
    @RequestMapping(value = "/list",method= RequestMethod.GET)
    @RequiresPermissions("assembly:view")//权限管理;
    public String getAssemblySetList(HttpServletRequest request, Model model){
        Map map = new HashMap();
        map.put("parentId","10000000-0000-0000-0000-000000000000");
        List<Map> assemblyList = assemblySetService.selectAssemblySetDataList(map);
        map.put("status",1);
        map.put("unitStatus",2);
        //未绑定的设备信息
        List<Map> equipmentList = equipmentService.selectEquipmentDataList(map);
        Users user= (Users) SecurityUtils.getSubject().getPrincipal();
        List<Dictionary> teaArrt = dictionaryService.selectDictionaryValueList("31783870-956f-469f-b43e-9fefd905afca");//茶系
        model.addAttribute("teaArrt", teaArrt);
        model.addAttribute("menuList",user.getMenuList());
        model.addAttribute("assemblyList",assemblyList);
        model.addAttribute("equipmentList",equipmentList);
        model.addAttribute("user",user);
        return "system/origin/getAssemblySetList";
    }

    /**
     * Ajax 获取信息列表
     * @param request
     * @return
     */
    @RequestMapping(value = "/getAssemblySetDataList",method = RequestMethod.POST)
    @ResponseBody
    public Object getAssemblySetDataList(HttpServletRequest request,String parentId,String dicTeaAttr){
        message = false;
        data    = null;
        try {
            Map query = new HashMap();
            if ((parentId != null && !parentId.isEmpty()) || (dicTeaAttr != null && !dicTeaAttr.isEmpty())){
                query.put("parentId",parentId == null ? "10000000-0000-0000-0000-000000000000" : parentId);
                query.put("dicTeaAttr",dicTeaAttr);
                List<Map> assemblySetList = assemblySetService.selectAssemblySetDataList(query);
                if(assemblySetList.size() > 0){
                    message = true;
                    data = assemblySetList;
                }
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
    @RequestMapping(value = "/editAssemblySetItem", method = RequestMethod.GET)
    @ResponseBody
    public Object editAssemblySetItem(HttpServletRequest request,String id){
        message = false;
        data    = null;
        if (!id.isEmpty()){
            try {
                Map assemblySet = assemblySetService.selectAssemblyData(id);
                if(assemblySet != null){
                    message = true;
                    data = assemblySet;
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
     * @param assemblySet
     * @param save
     * @return
     */
    @RequestMapping(value = "/saveOrUpdateAssemblySet",method = RequestMethod.POST)
    @ResponseBody
    public Object saveOrUpdateAssemblySet(HttpServletRequest request, AssemblySet assemblySet , String save){
        Users user= (Users) SecurityUtils.getSubject().getPrincipal();
        message = false;
        data    = null;
        try{
            if(assemblySet != null){
                if(save.equals("add")){
                    AssemblySet assembly = assemblySetService.selectByPrimaryKey(assemblySet.getParentId());
                    if (assembly != null){
                        assemblySet.setDicTeaAttr(assembly.getDicTeaAttr());
                        assemblySet.setCreateId(user.getId());
                        assemblySet.setCreateTime(new Date());
                    }
                }else{
                    assemblySet.setModifyId(user.getId());
                    assemblySet.setModifyTime(new Date());
                }
                int insert = assemblySetService.saveOrUpdateAssemblySet(assemblySet);
                switch (insert){
                    case 200:
                        message = true;
                        data    = ResultStateUtil.SUCCESS_ABNORMAL;
                        break;
                    case 101:
                        data    = ResultStateUtil.FAIL_ADD;
                        break;
                    default:
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
    @RequestMapping(value="/delAssemblySetItem",method = RequestMethod.POST)
    @ResponseBody
    public Object delAssemblySetItem(HttpServletRequest request ,String id){
        message = false;
        data    = null;
        try{
            if (!id.isEmpty()){
                int del = assemblySetService.delAssemblySetItem(id);
                switch (del){
                    case 200:
                        message = true;
                        data    = ResultStateUtil.SUCCESS_ABNORMAL;
                        break;
                    case 101:
                        data    = ResultStateUtil.FAIL_ADD;
                        break;
                    default:
                        data    = ResultStateUtil.FAIL_ADD;
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
