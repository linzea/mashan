package com.panda.service.impl.system;

import com.panda.config.DruidConfig;
import com.panda.model.system.Menu;
import com.panda.model.system.Users;
import com.panda.util.ResultStateUtil;
import com.panda.util.abs.AbstractMapper;
import com.panda.util.abs.AbstractServiceImpl;
import com.panda.mapper.system.RoleMenuMapper;
import com.panda.model.system.RoleMenu;
import com.panda.service.system.RoleMenuService;
import org.apache.shiro.SecurityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import javax.annotation.Resource;
import java.util.*;

/**
 * Created with IDEA.
 *
 * @AUTH: Alan
 * Date: 2017/10/21
 * Time: 18:31
 */
@Service
public class RoleMenuServiceImpl extends AbstractServiceImpl<RoleMenu> implements RoleMenuService {

    private static final Logger logger = LoggerFactory.getLogger(RoleMenuServiceImpl.class);

    @Resource
    private RoleMenuMapper roleMenuMapper;

    @Override
    protected AbstractMapper<RoleMenu> getAbstractMapper() {
        return roleMenuMapper;
    }

    /**
     * 编辑 角色菜单 获取当前选中角色的 可用menu
     *
     * @param roleId
     * @return
     */
    @Override
    public List<Map> selectRoleMenuList(String roleId) {
        return roleMenuMapper.selectRoleMenuList(roleId);
    }

    /**
     * 更新 和 保存角色菜单设置 使用 spring boot 事物
     * 将父级 parent_id 放到新数组 去重 原因是
     * 事物 不会直接将数据写入数据库，而是等所有数据执行完在放到数据库
     * @param listMap
     * @return
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackFor = {Exception.class})
    public Integer saveOrUpdateRoleMenu(List<Map> listMap) {
        Integer resultStatus = 0;
        try {
            if (listMap != null && listMap.size() > 0) {
                Users user = (Users) SecurityUtils.getSubject().getPrincipal();
                List<String> parentList = new ArrayList<String>();
                RoleMenu roleMenu = new RoleMenu();
                String role_id = "", parentId = "";
                for (Map item : listMap) {
                    role_id = item.get("role_id").toString();
                    String parent_id = item.get("parent_id").toString(),
                            menu_id = item.get("menu_id").toString(),
                            role_menu_id = item.get("role_menu_id").toString();
                    Integer status = Integer.valueOf(item.get("status").toString());
                    if (status > 0 && !role_menu_id.isEmpty()) {
                        //编辑 由于使用了关联唯一组健，更新时，需要将 roleID 和menuId 带上
                        roleMenu.setId(role_menu_id);
                        roleMenu.setMenuId(menu_id);
                        roleMenu.setStatus(status);
                        roleMenu.setCreateTime(new Date());
                        roleMenuMapper.updateByPrimaryKeySelective(roleMenu);
                    } else {
                        //添加 将 parent_id 放到新数组 并去重
                        if (parent_id.equals("0")) {
                            parentId = menu_id;
                        } else if (!parentId.equals(parent_id) && !parentList.contains(parent_id)) {
                            parentList.add(parent_id);
                        }
                        //防止重复数据,已有的不添加
                        Map<String, Object> map = new HashMap<>(2);
                        map.put("roleId", role_id);
                        map.put("menuId", menu_id);
                        boolean flag = roleMenuMapper.checkRoleMenuParentMenu(map);
                        if (!flag) {
                            roleMenu.setId(UUID.randomUUID().toString());
                            roleMenu.setStatus(status + 1);
                            roleMenu.setRoleId(role_id);
                            roleMenu.setMenuId(menu_id);
                            roleMenu.setCreateTime(new Date());
                            roleMenu.setCreateId(user.getId());
                            roleMenuMapper.insertSelective(roleMenu);
                        }
                    }
                }

                if (parentList.size() > 0) {
                    for (String item : parentList) {
                        roleMenu.setId(UUID.randomUUID().toString());
                        roleMenu.setStatus(1);
                        roleMenu.setRoleId(role_id);
                        roleMenu.setMenuId(item);
                        roleMenu.setCreateTime(new Date());
                        roleMenu.setCreateId(user.getId());
                        roleMenuMapper.insertSelective(roleMenu);
                    }
                }
                resultStatus = 200;
            }
        } catch (Exception e) {
            /**
             * spring 默认情况下aop只有捕获到 RuntimeException 的异常时才进行回滚，
             * try catch 时需要手动添加回滚
             */
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            e.printStackTrace();
            logger.info("RoleMenuServiceImpl------>saveOrUpdateRoleMenu----->" + e.getMessage());
            resultStatus = 101;
        }
        return resultStatus;
    }

    /**
     * 验证角色菜单父级菜单是否有权限
     *
     * @param map
     * @return
     */
    @Override
    public boolean checkRoleMenuParentMenu(Map<String, Object> map) {
        return roleMenuMapper.checkRoleMenuParentMenu(map);
    }

    /**
     * 角色权限设置，获取 JSTree 需要的 JSON 数据
     * @param map
     * @return
     */
    @Override
    public List<Map> selectRoleMenuListForAjaxJsTree(Map map, boolean selected,boolean threeDisabled){
        List<Map> menuList = null;
        boolean first = false;
        try {
            /**
             * JsTree 参数说明
             * state:{opened:true,selected:true,disabled:true}
             * liAttr:{class:you-class,data-type:you-type}
             * aAttr:{xxx:xxx}
             */

            Map state = new HashMap<>();
            Map liAttr = new HashMap<>();
            menuList = roleMenuMapper.selectRoleMenuListForAjaxJsTree(map);
            if(menuList != null && menuList.size() > 0){
                for (Map menu: menuList) {
                    menu.put("icon","fa fa-folder m--font-danger");
                    map.put("parentId",menu.get("id"));
                    List<Map> childList = roleMenuMapper.selectRoleMenuListForAjaxJsTree(map);
                    if(childList != null && childList.size() > 0){
                        for(Map child: childList){
                            child.put("icon","fa fa-folder m--font-success");
                            map.put("parentId",child.get("id"));
                            List<Map> lastChild = roleMenuMapper.selectRoleMenuListForAjaxJsTree(map);
                            if(lastChild != null && lastChild.size() > 0){
                                for (Map lastItem: lastChild){
                                    lastItem.put("icon","fa fa-folder icon-lg m--font-warning");
                                    map.put("parentId",lastItem.get("id"));
                                    List<Map> fourChild = roleMenuMapper.selectRoleMenuListForAjaxJsTree(map);
                                    if (fourChild != null && fourChild.size() > 0){
                                        if (!first){
                                            liAttr.put("class","first-item");
                                            fourChild.get(0).put("li_attr",liAttr);
                                            first = true;
                                            if (selected){
                                                state.put("selected",true);
                                                fourChild.get(0).put("state",state);
                                            }
                                        }
                                        if (threeDisabled){
                                            state.put("disabled",true);
                                            for (Map fourItem: fourChild){
                                                fourItem.put("icon","fa fa-folder icon-lg m--font-info");
                                                fourItem.put("state",state);
                                            }
                                        }
                                        lastItem.put("children",fourChild);
                                    }
                                }

                                if (!first){
                                    liAttr.put("class","first-item");
                                    lastChild.get(0).put("li_attr",liAttr);
                                    first = true;
                                    if (selected){
                                        state.put("selected",true);
                                        lastChild.get(0).put("state",state);
                                    }
                                }
//                                if (threeDisabled){
//                                    state.put("disabled",true);
//                                    for (Map lastItem: lastChild){
//                                        lastItem.put("state",state);
//                                    }
//                                }
                                child.put("children",lastChild);
                            }else{
                                if (!first){
                                    liAttr.put("class","first-item");
                                    childList.get(0).put("li_attr",liAttr);
                                    first = true;
                                }
                            }
                        }
                        menu.put("children",childList);
                    }else{
                        if (!first){
                            liAttr.put("class","first-item");
                            menuList.get(0).put("li_attr",liAttr);
                            first = true;
                        }
                    }
                }
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return menuList;
    }
}
