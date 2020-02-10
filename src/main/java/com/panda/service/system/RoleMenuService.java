package com.panda.service.system;

import com.panda.util.abs.AbstractService;
import com.panda.model.system.RoleMenu;

import java.util.List;
import java.util.Map;

/**
 * Created with IDEA.
 *
 * @AUTH: Alan
 * Date: 2017/10/21
 * Time: 18:30
 */
public interface RoleMenuService extends AbstractService<RoleMenu> {

    /**
     * 编辑 角色菜单 获取当前选中角色的 可用menu
     * @param roleId
     * @return
     */
    List<Map> selectRoleMenuList(String roleId);

    /**
     * 更新 和 保存角色菜单设置
     * @param roleMenuList
     * @return
     */
    Integer saveOrUpdateRoleMenu(List<Map> roleMenuList);

    /**
     * 验证角色菜单父级菜单是否有权限
     * @param map
     * @return
     */
    boolean checkRoleMenuParentMenu(Map<String,Object> map);


    /**
     * 角色权限设置，获取 JSTree 需要的 JSON 数据
     * @param map            ID
     * @param selected      是否选中
     * @param threeDisabled 禁用第三层
     * @return
     */
    List<Map> selectRoleMenuListForAjaxJsTree(Map<String, Object> map, boolean selected,boolean threeDisabled);
}
