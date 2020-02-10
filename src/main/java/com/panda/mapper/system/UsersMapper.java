package com.panda.mapper.system;

import com.panda.model.system.Users;
import com.panda.util.abs.AbstractMapper;

import java.util.List;
import java.util.Map;

public interface UsersMapper extends AbstractMapper<Users> {
    /**
     * 管理员登录
     * @param account
     * @return
     */
    Users selectManagerAccount(String account);

    /**
     * 查询用户信息和用户扩展信息
     * @param id
     * @return
     */
    Map selectUserAndUserInfo(String id);

    /**
     * 获取用户列表
     * @param map
     * @return
     */
    List<Users> selectUserList(Map map);

    /**
     * 获取用户列表
     * @param map
     * @return
     */
    List<Map> selectUserMapList(Map map);

    /**
     * 获取门店可用用户
     * @param map
     * @return
     */
    List<Users> selectUserListForStore(Map map);
}