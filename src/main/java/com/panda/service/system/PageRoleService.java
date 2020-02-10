package com.panda.service.system;

import com.panda.model.system.PageRole;
import com.panda.util.abs.AbstractService;

import java.util.List;
import java.util.Map;

/**
 * Created with IDEA.
 *
 * @AUTH: Alan
 * Date: 2017/10/21
 * Time: 18:28
 */
public interface PageRoleService extends AbstractService<PageRole> {

    /**
     * 获取角色对应的菜单 操作权限
     * @param map
     * @return
     */
    Map<String,Object> selectPageRoleListByDictionary(Map<String,Object> map);

    /**
     * 新增和编辑角色权限设置
     * @param pageRole
     * @return
     */
    Integer saveOrUpdatePageRole(PageRole pageRole);

    /**
     * 获取用户菜单对应的操作权限
     * @param map
     * @return
     */
    List<Map> selectUserMenuRolePermission(Map map);
}
