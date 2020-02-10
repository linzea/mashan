package com.panda.mapper.system;

import com.panda.model.system.Roles;
import com.panda.util.abs.AbstractMapper;

import java.util.List;
import java.util.Map;

public interface RolesMapper extends AbstractMapper<Roles> {

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