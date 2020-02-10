package com.panda.service.system;

import com.panda.util.abs.AbstractService;
import com.panda.model.system.Roles;

import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * Created with IDEA.
 *
 * @AUTH: Alan
 * Date: 2017/10/21
 * Time: 18:32
 */
public interface RolesService extends AbstractService<Roles> {

    /**
     * 获取用户的角色ID
     * @param userId
     * @return
     */
    Set<String> selectUserRoleId(String userId);

    /**
     * 获取用户角色信息
     * @param userId
     * @return
     */
    List<Map> selectUserRoleMap(String userId);

    /**
     * 获取角色列表
     * @param map
     * @return
     */
    List<Roles> selectRoleList(Map map);
}
