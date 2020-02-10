package com.panda.controller.system.index;

import com.panda.model.system.Menu;
import com.panda.model.system.RoleMenu;
import com.panda.model.system.Users;
import com.panda.service.system.MenuService;
import com.panda.service.system.RoleMenuService;
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
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

/**
 * Created with IDEA.
 * User: Alan
 * Date: 2017/11/2
 * Time: 10:19
 */
@Controller
@RequestMapping("/system/menu")
public class MenuController {
    private static final Logger logger = LoggerFactory.getLogger(IndexController.class);
    @Resource
    private MenuService menuService;
    @Resource
    private RoleMenuService roleMenuService;
    private static boolean message = false;
    private static Object  data    = null;
    /**
     * 获取菜单 Tree 当前菜单为用户 信息一起存储到 Redis 内
     * @return
     */
    @RequestMapping(value = "/list",method= RequestMethod.GET)
    @RequiresPermissions("menu:view")//权限管理;
    public String getMenuList(HttpServletRequest request, Model model){
        Users user= (Users) SecurityUtils.getSubject().getPrincipal();
        model.addAttribute("menuList",user.getMenuList());
        model.addAttribute("user",user);
        return "system/index/getMenuList";
    }

    /**
     * 获取菜单树
     * @param request
     * @return
     */
    @RequestMapping(value = "/getMenuList",method = RequestMethod.GET)
    @ResponseBody
    public Object getMenuList(HttpServletRequest request,boolean selected, boolean threeDisabled){
        Users user= (Users) SecurityUtils.getSubject().getPrincipal();
        message = false;
        data    = null;
        try {
            Map<String,Object> map = new HashMap<>();
            map.put("roleId",user.getRoleId());
            map.put("status","1");
            map.put("parentId","10000000-0000-0000-0000-000000000000");
            data = roleMenuService.selectRoleMenuListForAjaxJsTree(map,selected,threeDisabled);
            if (data != null){
                message = true;
            }
        }catch (Exception e){
            e.printStackTrace();
            data = ResultStateUtil.ERROR_QUERY;
        }
        return ResultMsgUtil.getResultMsg(message,data);
    }
    /**
     * 获取菜单信息
     * @return
     */
    @RequestMapping(value = "/getMenuData",method = RequestMethod.GET)
    @ResponseBody
    public Object getMenuListData(String id){
        message = false;
        data    = null;
        try {
            if(!id.isEmpty()){
                Menu menu= menuService.selectByPrimaryKey(id);
                if(menu != null){
                    message = true;
                    data = menu;
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

    /**
     * 新增 和 编辑 菜单保存方法
     * @param menu
     * @param save
     * @return
     */
    @RequestMapping(value = "/saveMenu",method = RequestMethod.POST)
    @ResponseBody
    public Object saveMenu(Menu menu, String save){
        message = false;
        data    = null;
        try {
            Users user= (Users) SecurityUtils.getSubject().getPrincipal();
            if(save.equals("edit") && menu.getId() != null){
                menu.setModifyTime(new Date());
                int i = menuService.updateByPrimaryKeySelective(menu);
                if(i > 0){
                    message = true;
                    data    = ResultStateUtil.SUCCESS_UPDATE;
                }else{
                    data    = ResultStateUtil.FAIL_UPDATE;
                }
            }else if(save.equals("add")) {
                menu.setId(UUID.randomUUID().toString());
                menu.setCreateId(user.getId());
                menu.setCreateTime(new Date());
                menu.setModifyId(user.getId());
                menu.setModifyTime(new Date());
                int i =menuService.insertSelective(menu);
                if(i > 0){
                    RoleMenu rolemenu = new RoleMenu();
                    rolemenu.setId(UUID.randomUUID().toString());
                    rolemenu.setStatus(1);
                    rolemenu.setCreateId(user.getId());
                    rolemenu.setCreateTime(new Date());
                    rolemenu.setMenuId(menu.getId());
                    rolemenu.setRoleId("f8692cd2-e801-11e4-8fee-40167e64eefd");
                    roleMenuService.insert(rolemenu);
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
     * Ajax 删除字典信息 包含子级时，将全部删除
     * @param request
     * @param id
     * @return
     */
    @RequestMapping(value = "/delParentMenu",method = RequestMethod.POST)
    @ResponseBody
    public Object delParentMenu(HttpServletRequest request, String id){
        message = false;
        data    = null;
        try {
            if (!id.isEmpty()){
                int i= menuService.delMenuParentAndChild(id);
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
