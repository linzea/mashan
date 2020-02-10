package com.panda.mapper.system;

import com.panda.model.system.UserInfo;
import com.panda.util.abs.AbstractMapper;

public interface UserInfoMapper extends AbstractMapper<UserInfo> {

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