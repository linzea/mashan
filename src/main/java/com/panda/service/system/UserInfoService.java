package com.panda.service.system;

import com.panda.util.abs.AbstractService;
import com.panda.model.system.UserInfo;

/**
 * Created with IDEA.
 *
 * @AUTH: Alan
 * Date: 2017/10/21
 * Time: 18:34
 */
public interface UserInfoService extends AbstractService<UserInfo> {

    /**
     * 查询用户头像
     * @param userId
     * @return
     */
    String selectUserHeadImgUrl(String userId);


    /**
     * 查询用户扩展信息
     * @param userId
     * @return
     */
    UserInfo selectUserInfoByUserId(String userId);
}
