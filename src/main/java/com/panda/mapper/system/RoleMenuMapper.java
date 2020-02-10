package com.panda.mapper.system;

import com.panda.model.system.RoleMenu;
import com.panda.util.abs.AbstractMapper;

import java.util.List;
import java.util.Map;

public interface RoleMenuMapper extends AbstractMapper<RoleMenu> {

    /**
     * 编辑 角色菜单 获取当前选中角色的 可用menu
     * @param roleId
     * @return
     */
    List<Map> selectRoleMenuList(String roleId);

    /**
     * 验证角色菜单父级菜单是否有权限
     * @param map
     * @return
     */
    boolean checkRoleMenuParentMenu(Map<String,Object> map);

    /**
     * 角色权限设置，获取 JSTree 需要的 JSON 数据
     * @param map
     * @return
     */
    List<Map> selectRoleMenuListForAjaxJsTree(Map<String, Object> map);
}