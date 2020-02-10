package com.panda.controller.system.origin;

import com.panda.controller.system.index.IndexController;
import com.panda.model.origin.QualitySet;
import com.panda.model.system.Users;
import com.panda.service.origin.QualitySetService;
import com.panda.service.system.MenuService;
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
import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * Created with IDEA.
 * User: Alan
 * Date: 2017/12/27
 * Time: 17:53
 */
@Controller
@RequestMapping(value = "/system/qualitySet")
public class QualitySetController {

    private static boolean message = false;
    private static Object  data    = null;
    private static final Logger logger = LoggerFactory.getLogger(IndexController.class);
    @Resource
    private MenuService menuService;

    @Resource
    private QualitySetService qualitySetService;

    /**
     * 显示页面
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/list")
    @RequiresPermissions("qualitySet:view")//权限管理;
    //@RequiresAuthentication
    // @RequiresRoles("teller")
    public String list(HttpServletRequest request, Model model){
        Users user= (Users) SecurityUtils.getSubject().getPrincipal();
        List<QualitySet> qualitySetList = qualitySetService.selectAll();
        model.addAttribute("user",user);
        model.addAttribute("menuList",user.getMenuList());
        model.addAttribute("qualitySetList",qualitySetList);
        return "system/origin/getQualitySetList";
    }

    /**
     * 获取质检属性列表
     * @param request
     * @param parentId
     * @return
     */
    @RequestMapping(value = "/getQualitySetValueList",method = RequestMethod.GET)
    @ResponseBody
    public Object getQualitySetValueList(HttpServletRequest request,String parentId){
        message = false;
        data    = null;
        try {
            if (parentId != null && !parentId.isEmpty()){
                QualitySet parent = qualitySetService.selectByPrimaryKey(parentId);
                if(parent != null){
                    List<QualitySet> QualitySetList = qualitySetService.selectQualitySetValueList(parentId);
                    QualitySetList.add(parent);
                    message = true;
                    data    = QualitySetList;
                }else{
                    data = ResultStateUtil.ERROR_PARAMETER_NO_TCOMPATIBLE;
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

    /**
     * 保存和更新 质检信息
     * @param request
     * @param qualitySet
     * @return
     */
    @RequestMapping(value = "/saveQualitySetOrUpdate", method = RequestMethod.POST)
    @ResponseBody
    public Object saveQualitySetOrUpdate(HttpServletRequest request, QualitySet qualitySet, String save){
        message = false;
        data    = null;
        try {
            Users user= (Users) SecurityUtils.getSubject().getPrincipal();
            if(save.equals("edit") && qualitySet.getId() != null){
                qualitySet.setModifyTime(new Date());
                qualitySet.setParentId(null);
                int i = qualitySetService.updateByPrimaryKeySelective(qualitySet);
                if(i > 0){
                    message = true;
                    data    = ResultStateUtil.SUCCESS_UPDATE;
                }else{
                    data    = ResultStateUtil.FAIL_UPDATE;
                }
            }else if(save.equals("add")) {
                qualitySet.setId(UUID.randomUUID().toString());
                qualitySet.setCreateId(user.getId());
                qualitySet.setCreateTime(new Date());
                qualitySet.setParentId(qualitySet.getParentId().isEmpty()?"10000000-0000-0000-0000-000000000000":qualitySet.getParentId());//
                qualitySet.setModifyId(user.getId());
                qualitySet.setModifyTime(new Date());
                int i =qualitySetService.insertSelective(qualitySet);
                if(i > 0){
                    message = true;
                    data    = ResultStateUtil.SUCCESS_ADD;
                }else{
                    data    = ResultStateUtil.FAIL_ADD;
                }
            }
        }catch (Exception e){
            e.printStackTrace();
            data    = "名称或属性重复, "+ResultStateUtil.ERROR_DATABASE_OPERATION;
        }
        return ResultMsgUtil.getResultMsg(message,data);
    }

    /**
     * 获取质检子级属性信息
     * @param request
     * @param id
     * @return
     */
    @RequestMapping(value = "/getQualitySetItem", method = RequestMethod.GET)
    @ResponseBody
    public Object getQualitySetItem(HttpServletRequest request, String id){
        message = false;
        data    = null;
        try {
            if (id != null && !id.isEmpty()){
                QualitySet qualitySet = qualitySetService.selectByPrimaryKey(id);
                if (qualitySet != null){
                    message = true;
                    data    = qualitySet;
                }else{
                    data = ResultStateUtil.ERROR_PARAMETER_NO_TCOMPATIBLE;
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

    /**
     * Ajax 删除质检信息 仅子项
     * @param request
     * @param id
     * @return
     */
    @RequestMapping(value = "/delQualitySetItem",method = RequestMethod.POST)
    @ResponseBody
    public Object delQualitySetItem(HttpServletRequest request, String id){
        message = false;
        data    = null;
        try {
            if (!id.isEmpty()){
                int i= qualitySetService.deleteByPrimaryKey(id);
                if(i > 0){
                    message = true;
                    data = ResultStateUtil.SUCCESS_DELETE;
                }else{
                    data = ResultStateUtil.ERROR_PARAMETER_NO_TCOMPATIBLE;
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

    /**
     * Ajax 删除质检信息 包含子级时，将全部删除
     * @param request
     * @param id
     * @return
     */
    @RequestMapping(value = "/delParentQualitySet",method = RequestMethod.POST)
    @ResponseBody
    public Object delParentQualitySet(HttpServletRequest request, String id){
        message = false;
        data    = null;
        try {
            if (!id.isEmpty()){
                int i= qualitySetService.delQualitySetParentAndChild(id);
                switch (i){
                    case 200:
                        data = ResultStateUtil.SUCCESS_DELETE;
                        message = true;
                        break;
                    case 101:
                        data = ResultStateUtil.ERROR_DATABASE_OPERATION;
                        break;
                    default:
                        data = ResultStateUtil.ERROR_PARAMETER_IS_EMPTY;
                        break;
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
