package com.panda.service.impl.system;

import com.panda.model.system.UserInfo;
import com.panda.service.system.*;
import com.panda.util.abs.AbstractMapper;
import com.panda.util.abs.AbstractServiceImpl;
import com.panda.mapper.system.UsersMapper;
import com.panda.model.system.Users;
import com.panda.util.PasswordUtil;
import org.apache.shiro.SecurityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import javax.annotation.Resource;
import java.util.*;

/**
 * Created with IDEA.
 * User: Alan
 * Date: 2017/10/18
 * Time: 17:53
 */
@Service
public class UsersServiceImpl extends AbstractServiceImpl<Users> implements UsersService{

    private static final Logger logger = LoggerFactory.getLogger(UsersServiceImpl.class);

    @Resource
    private UsersMapper usersMapper;

    @Resource
    private MenuService menuService;

    @Resource
    private UserInfoService userInfoService;

    @Override
    protected AbstractMapper<Users> getAbstractMapper() {
        return usersMapper;
    }

    /**
     * 获取当前登录用户可访问的URL 和 菜单 将数据存入 redis
     * @param account
     * @return
     */
    @Override
    public Users selectManagerAccount(String account) {
        Users user = usersMapper.selectManagerAccount(account);
        try {
            if(user != null && user.getRoleId() != null){
                user.setHeadImgUrl(userInfoService.selectUserHeadImgUrl(user.getId()));
                Map<String,String> map = new HashMap<String,String>(3);
                map.put("roleId",user.getRoleId());
                map.put("status","1");
                map.put("parentId","10000000-0000-0000-0000-100000000000");
                user.setMenuList(menuService.selectManagerRoleMenuList(map));
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return user;
    }

    /**
     * 查询用户信息和用户扩展信息
     * @param id
     * @return
     */
    @Override
    public Map selectUserAndUserInfo(String id){
        return usersMapper.selectUserAndUserInfo(id);
    }

    /**
     * 获取用户列表
     * @param map
     * @return
     */
    @Override
    public List<Users> selectUserList(Map map){
        return usersMapper.selectUserList(map);
    }

    /**
     * 获取用户列表
     * @param map
     * @return
     */
    @Override
    public List<Map> selectUserMapList(Map map){
        return usersMapper.selectUserMapList(map);
    }
    /**
     * 事物 -- 保存用户信息和用户详情
     * @param user
     * @param info
     * @return
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackFor = {Exception.class})
    public Integer saveUserOrUpdate(Users user, UserInfo info){
        Users admin = (Users) SecurityUtils.getSubject().getPrincipal();
        Integer resultStatus = 0;
        try {
            if (user.getId() != null && user.getId() != "") {
                int res = 0;
                res = usersMapper.updateByPrimaryKeySelective(user);
                if (res > 0 && info.getId() != null){
                    res += userInfoService.updateByPrimaryKeySelective(info);
                }else{
                    info.setId(UUID.randomUUID().toString());
                    info.setCreateId(admin.getId());
                    info.setCreateTime(new Date());
                    res += userInfoService.insertSelective(info);
                }
                if (res > 1){
                    resultStatus = 200;
                }
            }else{
                user.setId(UUID.randomUUID().toString());
                user.setRegisterTime(new Date());
                user.setModifyId(user.getId());
                user.setModifyTime(new Date());
               // user.setLoginType(user.getUserType().equals("manager")? 1 : 2);
                user.setLastDate(new Date());
                PasswordUtil.encryptPassword(user);
                int res = usersMapper.insertSelective(user);
                if (res > 0){
                    info.setId(UUID.randomUUID().toString());
                    info.setUserId(user.getId());
                    info.setCreateTime(new Date());
                    info.setCreateId(admin.getId());
                    res += userInfoService.insertSelective(info);
                    if (res > 1){
                        resultStatus = 203;
                    }
                }
            }
        } catch (Exception e) {
            /**
             * spring 默认情况下aop只有捕获到 RuntimeException 的异常时才进行回滚，
             * try catch 时需要手动添加回滚
             */
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            e.printStackTrace();
            logger.info("RoleMenuServiceImpl------>saveOrUpdateRoleMenu----->" + e.getMessage());
            resultStatus = 101;
        }
        return resultStatus;
    }

    /**
     * 获取门店可用用户
     * @param map
     * @return
     */
    @Override
    public List<Users> selectUserListForStore(Map map){
        return usersMapper.selectUserListForStore(map);
    }
}
