package com.panda.controller.system.index;

import com.panda.model.system.Dictionary;
import com.panda.model.system.Users;
import com.panda.service.system.DictionaryService;
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
 * Date: 2017/11/14
 * Time: 17:28
 */
@Controller
@RequestMapping(value = "/system/dictionary")
public class DictionaryController {
    private static boolean message = false;
    private static Object  data    = null;
    private static final Logger logger = LoggerFactory.getLogger(IndexController.class);
    @Resource
    private MenuService menuService;

    @Resource
    private DictionaryService dictionaryService;

    /**
     * 显示页面
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/list")
    @RequiresPermissions("dictionary:view")//权限管理;
    //@RequiresAuthentication
    // @RequiresRoles("teller")
    public String list(HttpServletRequest request, Model model){
        Users user= (Users) SecurityUtils.getSubject().getPrincipal();
        List<Dictionary> dictionaryList = dictionaryService.selectAll();
        model.addAttribute("user",user);
        model.addAttribute("menuList",user.getMenuList());
        model.addAttribute("dictionaryList",dictionaryList);
        return "system/index/getDictionaryList";
    }

    /**
     * 获取字典属性列表
     * @param request
     * @param parentId
     * @return
     */
    @RequestMapping(value = "/getDictionaryValueList",method = RequestMethod.GET)
    @ResponseBody
    public Object getDictionaryValueList(HttpServletRequest request,String parentId){
        message = false;
        data    = null;
        try {
            if (parentId != null && !parentId.isEmpty()){
                Dictionary parent = dictionaryService.selectByPrimaryKey(parentId);
                if(parent != null){
                    List<Dictionary> dictionaryList = dictionaryService.selectDictionaryValueList(parentId);
                    dictionaryList.add(parent);
                    message = true;
                    data    = dictionaryList;
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
     * 保存和更新 字典信息
     * @param request
     * @param dictionary
     * @return
     */
    @RequestMapping(value = "/saveDictionaryOrUpdate", method = RequestMethod.POST)
    @ResponseBody
    public Object saveDictionaryOrUpdate(HttpServletRequest request, Dictionary dictionary, String save){
        message = false;
        data    = null;
        try {
            Users user= (Users) SecurityUtils.getSubject().getPrincipal();
            if(save.equals("edit") && dictionary.getId() != null){
                dictionary.setModifyTime(new Date());
                dictionary.setParentId(null);
                int i = dictionaryService.updateByPrimaryKeySelective(dictionary);
                if(i > 0){
                    message = true;
                    data    = ResultStateUtil.SUCCESS_UPDATE;
                }else{
                    data    = ResultStateUtil.FAIL_UPDATE;
                }
            }else if(save.equals("add")) {
                dictionary.setId(UUID.randomUUID().toString());
                dictionary.setCreateId(user.getId());
                dictionary.setCreateTime(new Date());
                dictionary.setParentId(dictionary.getParentId().isEmpty()?"10000000-0000-0000-0000-000000000000":dictionary.getParentId());//
                dictionary.setModifyId(user.getId());
                dictionary.setModifyTime(new Date());
                int i =dictionaryService.insertSelective(dictionary);
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
     * 获取字典子级属性信息
     * @param request
     * @param id
     * @return
     */
    @RequestMapping(value = "/getDictionaryItem", method = RequestMethod.GET)
    @ResponseBody
    public Object getDictionaryItem(HttpServletRequest request, String id){
        message = false;
        data    = null;
        try {
            if (id != null && !id.isEmpty()){
                Dictionary dictionary = dictionaryService.selectByPrimaryKey(id);
                if (dictionary != null){
                    message = true;
                    data    = dictionary;
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
     * Ajax 删除字典信息 仅子项
     * @param request
     * @param id
     * @return
     */
    @RequestMapping(value = "/delDictionaryItem",method = RequestMethod.POST)
    @ResponseBody
    public Object delDictionaryItem(HttpServletRequest request, String id){
        message = false;
        data    = null;
        try {
            if (!id.isEmpty()){
                int i= dictionaryService.deleteByPrimaryKey(id);
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
     * Ajax 删除字典信息 包含子级时，将全部删除
     * @param request
     * @param id
     * @return
     */
    @RequestMapping(value = "/delParentDictionary",method = RequestMethod.POST)
    @ResponseBody
    public Object delParentDictionary(HttpServletRequest request, String id){
        message = false;
        data    = null;
        try {
            if (!id.isEmpty()){
                int i= dictionaryService.delDictionaryParentAndChild(id);
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
