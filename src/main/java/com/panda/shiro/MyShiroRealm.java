package com.panda.shiro;

import com.panda.Exception.UserLoginException;
import com.panda.model.system.Menu;
import com.panda.model.system.Users;
import com.panda.service.system.PageRoleService;
import com.panda.service.system.UsersService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.annotation.Resource;
import java.io.IOException;
import java.util.List;

/**
 * Created by yangqj on 2017/4/21.
 */
public class MyShiroRealm extends AuthorizingRealm {

    @Resource
    private UsersService usersService;

    @Resource
    private PageRoleService pageRoleService;

    private static final Logger logger = LoggerFactory.getLogger(MyShiroRealm.class);

    /**
     * 授权-URL 及页面权限
     * @param principalCollection
     * @return
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
        Users user= (Users)principalCollection.getPrimaryPrincipal();
        try {
            List<Menu> menuList = user.getMenuList();
            info.addRole(user.getRoleId());
            for(Menu menu: menuList){
                if(menu.getChildMenuList() != null && menu.getChildMenuList().size() > 0){
                    for (Menu childMenu : menu.getChildMenuList()){
                        if(childMenu.getChildMenuList() != null && childMenu.getChildMenuList().size() > 0){
                            for (Menu lastChild : childMenu.getChildMenuList()){
                                if(lastChild.getPermissionList() != null){
                                    info.addStringPermissions(lastChild.getPermissionList());
                                }
                            }
                        }else{
                            if(childMenu.getPermissionList() != null){
                                info.addStringPermissions(childMenu.getPermissionList());
                            }
                        }
                    }
                }else{
                    if(menu.getPermissionList() != null){
                        info.addStringPermissions(menu.getPermissionList());
                    }
                }
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return info;
    }

    /**
     * 用户登录认证
     * @param token
     * @return
     * @throws AuthenticationException
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        //获取用户的输入的账号.
        String username = (String)token.getPrincipal();
        Users user = usersService.selectManagerAccount(username);
        if(user==null){
            throw new UnknownAccountException();
        }
        if (0==user.getStatus()) {
            throw new LockedAccountException();
        }
        if (!user.getLoginType().equals("systemUser")){
            throw new UserLoginException();
        }
        SimpleAuthenticationInfo authenticationInfo = new SimpleAuthenticationInfo(
                user,
                user.getPassword(),
                ByteSource.Util.bytes(user.getAccount()+user.getId()),
                getName()
        );
        // 当验证都通过后，把用户信息放在session里
        Session session = SecurityUtils.getSubject().getSession();
        session.setAttribute("userSession", user);
        session.setAttribute("userSessionId", user.getId());
        return authenticationInfo;
    }

    /**
     * 指定principalCollection 清除
     */
  /*  public void clearCachedAuthorizationInfo(PrincipalCollection principalCollection) {

        SimplePrincipalCollection principals = new SimplePrincipalCollection(
                principalCollection, getName());
        super.clearCachedAuthorizationInfo(principals);
    }
*/
}
