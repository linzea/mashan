package com.panda.service.system;

import com.panda.util.abs.AbstractService;
import com.panda.model.system.Menu;

import java.util.List;
import java.util.Map;

/**
 * Created with IDEA.
 *
 * @AUTH: Alan
 * Date: 2017/10/21
 * Time: 18:26
 */
public interface MenuService extends AbstractService<Menu>{

    /**
     * 获取当前角色授权菜单 一维数组-供下拉列表使用
     * @param map
     * @return
     */
    List<Menu>selectManagerAuthMenu(Map<String,String> map);

    /**
     * 获取当前管理员所拥有的菜单列表 三维数组 -- 供 left_aside 模板使用
     * @param map
     * @return
     */
    List<Menu> selectManagerRoleMenuList(Map<String,String> map);

    /**
     * 根据菜单 ID 获取 当前菜单和子菜单 shiro config init
     * @param menuId
     * @return
     */
    List<Menu> selectMenuAndChildMenu(String menuId);

    /**
     * 查询前台普通用户菜单
     * @param roleId
     * @return
     */
    List<Menu> selectHomeMenuList(String roleId);

    /**
     * Ajax 删除菜单信息 包含子级时，菜单
     * @param id
     * @return
     */
    Integer delMenuParentAndChild(String id);

    /**
     * Ajax 删除菜单信息 包含子级时，将权限等全部删除
     * @param id
     * @return
     */
    Integer delMenuParentAndChildRole(String id);
}
