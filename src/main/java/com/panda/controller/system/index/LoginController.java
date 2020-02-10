package com.panda.controller.system.index;

import com.panda.Exception.UserLoginException;
import com.panda.model.system.Users;
import com.panda.service.system.UsersService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

/**
 * Created with IDEA.
 * @author : Alan
 * Date: 2017/10/24
 * Time: 17:20
 */
@Controller
@RequestMapping(value = "/system")
public class LoginController {

    private static final Logger logger = LoggerFactory.getLogger(LoginController.class);

    @Resource
    private UsersService usersService;

    //redisKey 目前用不上,后续完善
    private String SHIRO_LOGIN_COUNT = "shiro_login_count_";
    //redisKey 目前用不上,后续完善
    private String SHIRO_IS_LOCK = "shiro_is_lock_";

    /**
     * 得到Subject及创建用户名/密码身份验证Token(即用户身份/凭证)
     * @param request
     * @param map
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/login",method=RequestMethod.GET)
    public String login(HttpServletRequest request, Map<String, Object> map)throws Exception{
        Subject currentUser = SecurityUtils.getSubject();
        if (currentUser.isAuthenticated()) {
            return "redirect:/system/index/main";
        }
        return "system/login";
    }

    /**
     * ajax登录请求
     * @return
     */
    @RequestMapping(value="ajaxLogin",method=RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> submitLogin(Users user ,String rememberMe) {
        boolean flag = true;
        String msg = "";
        Map<String, Object> resultMap = new HashMap<String, Object>();
        UsernamePasswordToken token = new UsernamePasswordToken( user.getAccount(), user.getPassword(),false);
        Subject subject = SecurityUtils.getSubject();
        try {
            subject.login(token); // 完成登录
            Users loginUser = (Users) subject.getPrincipal();
            subject.getSession().setAttribute("loginUser", loginUser);
            resultMap.put("flag", flag);
        } catch (Exception exception) {
            if (exception instanceof UnknownAccountException) {
                msg = "登录失败,用户账号不存在 !";
                logger.info(msg+"-- > UnknownAccountException");
            } else if (exception instanceof IncorrectCredentialsException) {
                msg = "登录失败,用户密码不正确 !";
                logger.info(msg+" -- >IncorrectCredentialsException");
            } else if (exception instanceof LockedAccountException){
                msg = "登录失败,你的账号被锁定 !";
                logger.info(msg+" -- > LockedAccountException");
            } else if (exception instanceof UserLoginException){
                msg = "登录失败,你的账号没有系统登录权限 !";
                logger.info(msg+" -- > UserLoginException");
            }else {
                msg = "登录失败,发生未知错误：" + exception;
                logger.info(msg+" -- >" + exception);
            }
            resultMap.put("flag", false);
        } finally {
            resultMap.put("msg", msg);
        }
        return resultMap;
    }

    /**
     * 无权限页面
     * @return
     */
    @RequestMapping({"/403"})
    public String unauthorizedRole(){
        logger.info("------没有权限 unauthorizedRole-------");
        return "/error/403";
    }

    /**
     * 退出
     * @return
     */
    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logout() {
        try {
            System.out.println("LoginController.logout()");
            SecurityUtils.getSubject().logout();
            System.out.println("您已安全退出");
        }catch (Exception e){
            System.out.println(e);
        }
        return "redirect:/system/login";

    }
}
