package com.panda.controller.system.ucenter;

import com.alibaba.citrus.util.StringEscapeUtil;
import com.alibaba.fastjson.JSON;
import com.panda.model.system.Dictionary;
import com.panda.model.system.Roles;
import com.panda.model.system.UserInfo;
import com.panda.model.system.Users;
import com.panda.service.system.DictionaryService;
import com.panda.service.system.RolesService;
import com.panda.service.system.UserInfoService;
import com.panda.service.system.UsersService;
import com.panda.util.PasswordUtil;
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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created with IDEA.
 * User: Alan
 * Date: 2017/11/24
 * Time: 9:33
 */
@Controller
@RequestMapping("/system/user")
public class UserController {

    private static final Logger logger = LoggerFactory.getLogger(UserController.class);

    @Resource
    private UsersService usersService;
    @Resource
    private UserInfoService userInfoService;
    @Resource
    private DictionaryService dictionaryService;
    @Resource
    private RolesService rolesService;
    private static boolean message = false;
    private static Object  data    = null;

    /**
     * 获取用户列表
     * @param request
     * @return
     */
    @RequestMapping(value = "/getUserList",method = RequestMethod.GET)
    @RequiresPermissions("user:view")//权限管理;
    public String getUserList(HttpServletRequest request, Model model){
        Map map = new HashMap();
        map.put("type",1);
        map.put("status",1);
        List<Dictionary> userType = dictionaryService.selectDictionaryValueList("155a1b9b-5fbb-11e7-8697-38d547b81379");
        List<Dictionary> statusType = dictionaryService.selectDictionaryValueList("ba259a75-f5a7-4897-949f-1c90b7958b35");
        List<Roles> roleList = rolesService.selectRoleList(map);
        Users user= (Users) SecurityUtils.getSubject().getPrincipal();
        model.addAttribute("menuList",user.getMenuList());
        model.addAttribute("userType",userType);
        model.addAttribute("roleList",roleList);
        model.addAttribute("statusType",statusType);
        model.addAttribute("user",user);
        return "system/ucenter/getUserList";
    }

    @RequestMapping(value = "/getUserDataList")
    @ResponseBody
    public Object getUserDataList(HttpServletRequest request, String datatable){
        message = false;
        data    = null;
        try {
            Map params = new HashMap();
            if (datatable != null && !datatable.isEmpty()){
                String jsonStr = StringEscapeUtil.unescapeHtml(datatable);
                Map jsonMap = JSON.parseObject(jsonStr,Map.class);
                Map query = JSON.parseObject(jsonMap.get("query").toString(),Map.class);
                if (query.size() > 0 && query.get("status") != ""){
                    params.put("status",query.get("status"));
                }
                if (query.size() > 0 && query.get("userType") != ""){
                    params.put("userType",query.get("userType"));
                }
            }
            List<Map> usersList = usersService.selectUserMapList(params);
            if(usersList.size() > 0){
                message = true;
                data = usersList;
            }else{
                data = ResultStateUtil.NO_MORE_DATA;
            }
        }catch (Exception e){
            e.printStackTrace();
            data    = ResultStateUtil.ERROR_DATABASE_OPERATION;
        }
        return ResultMsgUtil.getResultMsg(message,data);
    }

    /**
     * Ajax 获取单条用户信息和扩展信息
     * @param request
     * @param id
     * @return
     */
    @RequestMapping(value = "/getUserItem",method = RequestMethod.GET)
    @ResponseBody
    public Object getUserItem(HttpServletRequest request, String id){
        message = false;
        data    = null;
        try {
            if (id != null && !id.isEmpty()){
                Map<String,Object> user = usersService.selectUserAndUserInfo(id);
                if (user != null){
                    message = true;
                    data    = user;
                }else{
                    data    = ResultStateUtil.NO_MORE_DATA;
                }
            }else{
                data = ResultStateUtil.ERROR_PARAMETER_IS_EMPTY;
            }
        }catch (Exception e){
            e.printStackTrace();
            data = ResultStateUtil.NO_MORE_DATA;
        }
        return ResultMsgUtil.getResultMsg(message,data);
    }

    /**
     * Ajax 保存 和 更新用户信息 包含用户 扩展信息 使用存储过程处理
     * @param request
     * @param user
     * @param userInfo
     * @return
     */
    @RequestMapping(value = "/saveUserOrUpdate",method = RequestMethod.POST)
    @ResponseBody
    public Object saveUserOrUpdate(HttpServletRequest request, Users user, UserInfo userInfo,String save,String infoId){
        message = false;
        data    = null;
        try {
            if (user != null && (save.equals("add") || save.equals("edit"))){
                if (infoId != null && infoId != ""){
                    userInfo.setId(infoId);
                }
                if (save.equals("add")){
                    userInfo.setId(null);
                    user.setId(null);
                }
                Integer resultStatus = usersService.saveUserOrUpdate(user,userInfo);
                switch (resultStatus){
                    case 101:
                        data    = ResultStateUtil.FAIL_ABNORMAL;
                        break;
                    case 200:
                        message = true;
                        data    = ResultStateUtil.SUCCESS_UPDATE;
                        break;
                    case 203 :
                        message = true;
                        data    = ResultStateUtil.SUCCESS_ADD;
                        break;
                    case 0:
                        data    = ResultStateUtil.ERROR_OPERATION;
                        break;
                }
            }else{
                data = ResultStateUtil.ERROR_PARAMETER_IS_EMPTY;
            }
        }catch (Exception e){
            e.printStackTrace();
            data = ResultStateUtil.NO_MORE_DATA;
        }
        return ResultMsgUtil.getResultMsg(message,data);
    }

    /**
     * Ajax 删除全部用户信息-软删除
     * @param request
     * @param id
     * @return
     */
    @RequestMapping(value = "/delUserItem",method = RequestMethod.GET)
    @ResponseBody
    public Object delUserItem(HttpServletRequest request, String id){
        message = false;
        data    = null;
        try {
            if (!id.isEmpty()){
                int i= usersService.deleteByPrimaryKey(id);
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
     * 修改我的信息 header_nav.html 快捷方式
     * @param request
     * @return
     */
    @RequestMapping(value = "/editMyAccount" ,method = RequestMethod.GET)
    @RequiresPermissions("user:edit")//权限管理;
    public String editMyAccount(HttpServletRequest request, Model model){
        Users user= (Users) SecurityUtils.getSubject().getPrincipal();
        UserInfo info = userInfoService.selectUserInfoByUserId(user.getId());
        model.addAttribute("menuList",user.getMenuList());
        model.addAttribute("user",user);
        model.addAttribute("info",info);
        return "system/ucenter/editMyAccount";
    }

    /**
     * Ajax 修改当前登录用户密码
     * 检查当前用户是否是登录状态
     * @param request
     * @param id
     * @return
     */
    @RequestMapping(value = "/getLoginUser",method = RequestMethod.POST)
    @ResponseBody
    public Object getLoginUser(HttpServletRequest request, String id){
        Users user= (Users) SecurityUtils.getSubject().getPrincipal();
        message = false;
        data    = null;
        try {
            if (!id.isEmpty() && user != null){
                Users loginUser = usersService.selectByPrimaryKey(id);
                if (loginUser != null && user.getId().equals(loginUser.getId()) && user.getPassword().equals(loginUser.getPassword())){
                    message = true;
                    data = user;
                }
            }
        }catch (Exception e){
            e.printStackTrace();
            data    = ResultStateUtil.ERROR_DATABASE_OPERATION;
        }
        return ResultMsgUtil.getResultMsg(message,data);
    }

    /**
     * Ajax 修改当前登录用户密码
     * 检查当前用户是否是登录状态
     * @param request
     * @param pass
     * @return
     */
    @RequestMapping(value = "/changePassWord",method = RequestMethod.POST)
    @ResponseBody
    public Object changePassWord(HttpServletRequest request, Users pass){
        String oldPassWord = request.getParameter("oldPassWord");
        Users user= (Users) SecurityUtils.getSubject().getPrincipal();
        message = false;
        data    = null;
        try {
            if (pass != null && user != null && oldPassWord != null){
                if (PasswordUtil.checkUserPassWord(user,oldPassWord)){
                    user.setPassword(pass.getPassword());
                    PasswordUtil.encryptPassword(user);
                    int i = usersService.updateByPrimaryKeySelective(user);
                    if (i > 0){
                        message = true;
                        data    = ResultStateUtil.SUCCESS_CHANGE_PASS;
                    }
                }else{
                    data = ResultStateUtil.FAIL_CHECK_OLD_PASS;
                }
            }
        }catch (Exception e){
            e.printStackTrace();
            data    = ResultStateUtil.ERROR_DATABASE_OPERATION;
        }
        return ResultMsgUtil.getResultMsg(message,data);
    }

    /**
     * Ajax 重置用户密码
     * @param request
     * @param reset
     * @return
     */
    @RequestMapping(value = "/resetPassWord",method = RequestMethod.POST)
    @ResponseBody
    public Object resetPassWord(HttpServletRequest request, Users reset){
        Users user= (Users) SecurityUtils.getSubject().getPrincipal();
        message = false;
        data    = null;
        try {
            if (reset != null && user != null && reset.getId() != null){
                Users resetUser = usersService.selectByPrimaryKey(reset.getId());
                if (resetUser != null){
                    String newPass = resetUser.getAccount()+"123456";
                    resetUser.setPassword(newPass);
                    PasswordUtil.encryptPassword(resetUser);
                    int i = usersService.updateByPrimaryKeySelective(resetUser);
                    if (i > 0){
                        message = true;
                        data    = "用户："+resetUser.getAccount()+" 登录密码已重置为 "+newPass;
                    }
                }else{
                    data = "用户密码重置失败";
                }
            }
        }catch (Exception e){
            e.printStackTrace();
            data    = ResultStateUtil.ERROR_DATABASE_OPERATION;
        }
        return ResultMsgUtil.getResultMsg(message,data);
    }

}
