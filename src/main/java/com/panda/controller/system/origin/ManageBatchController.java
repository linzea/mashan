package com.panda.controller.system.origin;

import com.alibaba.citrus.util.StringEscapeUtil;
import com.alibaba.fastjson.JSON;
import com.panda.controller.system.index.IndexController;
import com.panda.model.origin.ManageBatch;
import com.panda.model.system.Users;
import com.panda.service.origin.ManageBatchService;
import com.panda.service.origin.TeaGardenService;
import com.panda.service.system.DictionaryService;
import com.panda.util.CreateBatchNoUtil;
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

@Controller
@RequestMapping("/system/manageBatch")
public class ManageBatchController {
    private static final Logger logger = LoggerFactory.getLogger(IndexController.class);
    @Resource
    private ManageBatchService manageBatchService;
    @Resource
    private DictionaryService dictionaryService;
    @Resource
    private TeaGardenService teaGardenService;
    private static boolean message = false;
    private static Object  data    = null;

    /**
     * 获取菜单 Tree 当前菜单为用户 信息一起存储到 Redis 内
     * @return
     */
    @RequestMapping(value = "/list",method= RequestMethod.GET)
    @RequiresPermissions("manageBatch:view")//权限管理;
    public String getManageBatchList(HttpServletRequest request, Model model){
        Users user= (Users) SecurityUtils.getSubject().getPrincipal();
        Map query = new HashMap();
        query.put("status","1");
        List<Map> teaGardens = teaGardenService.selectTeaGardenList(query);
        model.addAttribute("teaGardens",teaGardens);
        model.addAttribute("menuList",user.getMenuList());
        model.addAttribute("user",user);
        return "system/origin/getManageBatchList";
    }


    /**
     * Ajax 获取茶园管理批次列表
     * @param request
     * @return
     */
    @RequestMapping(value = "/getManageBatchDataList",method = RequestMethod.POST)
    @ResponseBody
    public Object getManageBatchDataList(HttpServletRequest request,String datatable){
        message = false;
        data    = null;
        try {
            Map query = new HashMap();
            if (datatable != null && !datatable.isEmpty()){
                String jsonStr = StringEscapeUtil.unescapeHtml(datatable);
                Map params = JSON.parseObject(jsonStr,Map.class);
                Map status = JSON.parseObject(params.get("query").toString(),Map.class);
                if (status.size() > 0 && status.get("tea_garden_id") != ""){
                    query.put("tea_garden_id",status.get("tea_garden_id"));
                }
            }
            List<Map> manageBatchList = manageBatchService.selectManageBatchList(query);
            if(manageBatchList.size() > 0){
                message = true;
                data = manageBatchList;
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
    @RequestMapping(value = "/getManageBatchItem", method = RequestMethod.GET)
    @ResponseBody
    public Object getManageBatchItem(HttpServletRequest request,String id){
        message = false;
        data    = null;
        if (!id.isEmpty()){
            try {
                ManageBatch manageBatch = manageBatchService.selectByPrimaryKey(id);
                if(manageBatch != null){
                    message = true;
                    data = manageBatch;
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
     * 保存
     * @param request
     * @param manageBatch
     * @param save
     * @return
     */
    @RequestMapping(value = "/saveManageBatch",method = RequestMethod.POST)
    @ResponseBody
    public Object saveManageBatch(HttpServletRequest request, ManageBatch manageBatch ,String save){
        Users user= (Users) SecurityUtils.getSubject().getPrincipal();
        message = false;
        data    = null;
        try{
            if(!manageBatch.getId().isEmpty() && save.equals("edit")){
                int i = manageBatchService.updateByPrimaryKeySelective(manageBatch);
                if(i > 0){
                    message = true;
                    data    = ResultStateUtil.SUCCESS_UPDATE;
                }else{
                    data    = ResultStateUtil.FAIL_UPDATE;
                }
            }else if(save.equals("add")) {
                manageBatch.setId(UUID.randomUUID().toString());
                manageBatch.setCreateId(user.getId());
                manageBatch.setCreateTime(new Date());
                manageBatch.setModifyId(user.getId());
                manageBatch.setModifyTime(new Date());
                manageBatch.setStatus(1);
                int insert = manageBatchService.insertSelective(manageBatch);
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
    @RequestMapping(value="/delManageBatchItem",method = RequestMethod.GET)
    @ResponseBody
    public Object DelManageBatchItem(HttpServletRequest request ,String id){
        message = false;
        data    = null;
        try{
            if (!id.isEmpty()){
                int i = manageBatchService.deleteByPrimaryKey(id);
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
     * 自动生成批次号
     * @param request
     * @return
     */
    @RequestMapping(value = "/getMsuData",method = RequestMethod.GET)
    @ResponseBody
    public Object getMsuData(HttpServletRequest request){
        return ResultMsgUtil.getResultMsg(true,CreateBatchNoUtil.createBatchNo().substring(7));
    }


}
