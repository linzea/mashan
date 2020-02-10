package com.panda.controller.system.index;

import com.alibaba.citrus.util.StringEscapeUtil;
import com.alibaba.fastjson.JSON;
import com.panda.model.system.Dictionary;
import com.panda.model.system.Roles;
import com.panda.model.system.Users;
import com.panda.service.system.DictionaryService;
import com.panda.service.system.RolesService;
import com.panda.util.ResultMsgUtil;
import com.panda.util.ResultStateUtil;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
 * Date: 2017/11/2
 * Time: 10:19
 */
@Controller
@RequestMapping("/system/roles")
public class RolesController {
    private static final Logger logger = LoggerFactory.getLogger(IndexController.class);
    @Resource
    private RolesService rolesService;
    @Resource
    private DictionaryService dictionaryService;

    private static boolean message = false;
    private static Object  data    = null;
    /**
     * 权限管理列表
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    @RequiresPermissions("roles:view")//权限管理;
    public String getRolesList(HttpServletRequest request, Model model){
        Users user= (Users) SecurityUtils.getSubject().getPrincipal();
        List<Dictionary> statusType = dictionaryService.selectDictionaryValueList("ba259a75-f5a7-4897-949f-1c90b7958b35");
        model.addAttribute("statusType",statusType);
        model.addAttribute("user",user);
        model.addAttribute("menuList",user.getMenuList());
        return "system/index/getRolesList";
    }

    /**
     * Ajax 获取角色列表
     * @param request
     * @return
     */
    @RequestMapping(value = "/getRolesDataList",method = RequestMethod.POST)
    @ResponseBody
    public Object getRolesDataList(HttpServletRequest request, String datatable){

        message = false;
        data    = null;
        try {
            Map query = new HashMap();
            if (datatable != null && !datatable.isEmpty()){
                String jsonStr = StringEscapeUtil.unescapeHtml(datatable);
                Map params = JSON.parseObject(jsonStr,Map.class);
                Map status = JSON.parseObject(params.get("query").toString(),Map.class);
                if (status.get("status") != ""){
                    query.put("status",status.get("status"));
                }
            }

            List<Roles> rolesList = rolesService.selectRoleList(query);
            if(rolesList.size() > 0){
                message = true;
                data = rolesList;
            }
        }catch (Exception e){
            e.printStackTrace();
            data    = ResultStateUtil.ERROR_DATABASE_OPERATION;
        }
        return ResultMsgUtil.getResultMsg(message,data);
    }

    /**
     * Ajax 编辑权限，获取当前编辑项的内容
     * @param request
     * @param id
     * @return
     */
    @RequestMapping(value = "/getRoleItem", method = RequestMethod.GET)
    @ResponseBody
    public Object getRoleItem(HttpServletRequest request,String id){
        message = false;
        data    = null;
        if (!id.isEmpty()){
            try {
                Roles role = rolesService.selectByPrimaryKey(id);
                if(role != null){
                    message = true;
                    data = role;
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
     * Ajax 保存角色信息
     * @param request
     * @return
     */
    @RequestMapping(value = "/saveRole",method = RequestMethod.POST)
    @ResponseBody
    public Object saveRole(HttpServletRequest request, Roles role,String save){
        Users user= (Users) SecurityUtils.getSubject().getPrincipal();
        message = false;
        data    = null;
        try {
            if(!role.getId().isEmpty() && save.equals("edit")){
                int i = rolesService.updateByPrimaryKeySelective(role);
                if(i > 0){
                    message = true;
                    data    = ResultStateUtil.SUCCESS_UPDATE;
                }else{
                    data    = ResultStateUtil.FAIL_UPDATE;
                }
            }else if(save.equals("add")) {
                role.setId(UUID.randomUUID().toString());
                role.setCreateId(user.getId());
                role.setCreateTime(new Date());
                role.setModifyId(user.getId());
                role.setModifyTime(new Date());
                role.setType(1);
                int insert =rolesService.insertSelective(role);
                if(insert > 0){
                    message = true;
                    data    = ResultStateUtil.SUCCESS_ADD;
                }else{
                    data    = ResultStateUtil.FAIL_ADD;
                }
            }
        }catch (Exception e){
            e.printStackTrace();
            data    = ResultStateUtil.ERROR_DATABASE_OPERATION;
        }
        return ResultMsgUtil.getResultMsg(message,data);
    }


    /**
     * Ajax 删除单个角色
     * @param request
     * @param id
     * @return
     */
    @RequestMapping(value = "/delRoleItem",method = RequestMethod.GET)
    @ResponseBody
    public Object delRoleItem(HttpServletRequest request, String id){
        message = false;
        data    = null;
        try {
            if (!id.isEmpty()){
                int i= rolesService.deleteByPrimaryKey(id);
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
            data    = ResultStateUtil.ERROR_DATABASE_OPERATION;
        }
        return ResultMsgUtil.getResultMsg(message,data);
    }
}
