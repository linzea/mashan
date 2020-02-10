package com.panda.service.system;

import com.panda.model.system.UserInfo;
import com.panda.util.abs.AbstractService;
import com.panda.model.system.Users;

import java.util.List;
import java.util.Map;

/**
 * Created with IDEA.
 * User: Alan
 * Date: 2017/10/18
 * Time: 17:53
 */
public interface UsersService extends AbstractService<Users>{

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
     * 事物 -- 保存用户信息和用户详情
     * @param user
     * @param info
     * @return
     */
    Integer saveUserOrUpdate(Users user, UserInfo info);

    /**
     * 获取门店可用用户
     * @param map
     * @return
     */
    List<Users> selectUserListForStore(Map map);
}
