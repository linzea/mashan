package com.panda.controller.system.ucenter;

import com.alibaba.citrus.util.StringEscapeUtil;
import com.alibaba.fastjson.JSON;
import com.panda.model.system.Dictionary;
import com.panda.model.system.StoreInfo;
import com.panda.model.system.Users;
import com.panda.service.system.DictionaryService;
import com.panda.service.system.StoreInfoService;
import com.panda.service.system.UsersService;
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
 * Date: 2017/11/24
 * Time: 9:33
 */
@Controller
@RequestMapping("/system/store")
public class StoreController {

    private static final Logger logger = LoggerFactory.getLogger(StoreController.class);

    @Resource
    private StoreInfoService storeInfoService;

    @Resource
    private DictionaryService dictionaryService;

    @Resource
    private UsersService usersService;
    private static boolean message = false;
    private static Object  data    = null;

    /**
     * 获取门店列表
     * @param request
     * @return
     */
    @RequestMapping(value = "/list",method = RequestMethod.GET)
    @RequiresPermissions("store:view")//权限管理;
    public String getStoreList(HttpServletRequest request, Model model){
        Map map = new HashMap(3);
        Users user= (Users) SecurityUtils.getSubject().getPrincipal();
        List<Dictionary> statusType = dictionaryService.selectDictionaryValueList("ba259a75-f5a7-4897-949f-1c90b7958b35");
        map.put("userType","e7fbdea9-82a8-47d9-bbe0-82fd66f7bd27");
        map.put("roleId","0C03F6B6-8CC4-4826-8A51-149990861BE3");
        map.put("status",1);
        List<Users> storeList = usersService.selectUserListForStore(map);
        model.addAttribute("statusType",statusType);
        model.addAttribute("menuList",user.getMenuList());
        model.addAttribute("user",user);
        model.addAttribute("storeList",storeList);
        return "system/ucenter/getStoreList";
    }
    /**
     * Ajax 获取门店信息列表
     * @param request
     * @return
     */
    @RequestMapping(value = "/getStoreDataList",method = RequestMethod.POST)
    @ResponseBody
    public Object getStoreDataList(HttpServletRequest request,String datatable){
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
            }

            List<Map> storeInfoList = storeInfoService.selectStoreInfoList(query);
            if(storeInfoList.size() > 0){
                message = true;
                data = storeInfoList;
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
    @RequestMapping(value = "/getStoreInfoItem", method = RequestMethod.GET)
    @ResponseBody
    public Object getStoreInfoItem(HttpServletRequest request,String id){
        Map map = new HashMap();

        message = false;
        data    = null;
        if (!id.isEmpty()){
            try {
                Map storeInfoItem = storeInfoService.selectStoreItemByPrimaryKey(id);
                if(storeInfoItem != null){
                    message = true;
                    data = storeInfoItem;
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
     * @param storeInfo
     * @param save
     * @return
     */

    @RequestMapping(value = "/saveStoreInfoOrUpdate",method = RequestMethod.POST)
    @ResponseBody
    public Object saveStoreInfoOrUpdate(HttpServletRequest request, StoreInfo storeInfo , String save,String storeId){
        Users user= (Users) SecurityUtils.getSubject().getPrincipal();

        message = false;
        data    = null;
        try{
            if(!storeInfo.getId().isEmpty() && save != null && save.equals("edit")){
                int i = storeInfoService.updateByPrimaryKeySelective(storeInfo);
                if(i > 0){
                    message = true;
                    data    = ResultStateUtil.SUCCESS_UPDATE;
                }else{
                    data    = ResultStateUtil.FAIL_UPDATE;
                }
            }else if(save.equals("add")) {
                storeInfo.setId(UUID.randomUUID().toString());
                storeInfo.setCreateId(user.getId());
                storeInfo.setCreateTime(new Date());
                storeInfo.setModifyId(user.getId());
                storeInfo.setModifyTime(new Date());
                storeInfo.setStatus(1);

                Users storeUserInfo = usersService.selectByPrimaryKey(storeId);
                int insert = storeInfoService.insertSelectiveAndUser(storeInfo,storeUserInfo);
                switch (insert) {
                    case 200:
                        message = true;
                        data = ResultStateUtil.SUCCESS_ABNORMAL;
                        break;
                    case 101:
                        data = ResultStateUtil.FAIL_ADD;
                        break;
                    default:
                        data = ResultStateUtil.FAIL_ADD;
                }
                /*int insert = storeInfoService.insertSelective(storeInfo);
                if(insert > 0){
                    message = true;
                    data    = ResultStateUtil.SUCCESS_ADD;
                }else{
                    data    = ResultStateUtil.FAIL_ADD;
                }*/
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
    @RequestMapping(value="/delStoreInfoItem",method = RequestMethod.GET)
    @ResponseBody
    public Object delStoreInfoItem(HttpServletRequest request ,String id){
        message = false;
        data    = null;
        try{
            if (!id.isEmpty()){
                int i = storeInfoService.deleteByPrimaryKey(id);
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
     * 获取门店用户列表
     * @param request
     * @param id
     * @return
     */
    @RequestMapping(value = "/getStoreUserListInfo",method = RequestMethod.GET)
    @ResponseBody
    public Object getStoreUserListInfo(HttpServletRequest request,String id){
        Map map = new HashMap();
        message = false;
        data    = null;
        try {
            if (id != null && !id.isEmpty()){
                StoreInfo storeInfo = storeInfoService.selectByPrimaryKey(id);
                if(storeInfo != null){
                    map.put("userType","e7fbdea9-82a8-47d9-bbe0-82fd66f7bd27");
                    map.put("storeID",id);
                    List<Users> storeList = usersService.selectUserList(map);
                    //storeList.add(parent);
                    message = true;
                    data    = storeList;
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


}
