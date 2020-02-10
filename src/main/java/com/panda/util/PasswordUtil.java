package com.panda.util;


import com.panda.model.system.Users;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.util.ByteSource;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * Created with IDEA.
 * User: Alan
 * Date: 2017/11/14
 * Time: 17:28
 */
public class PasswordUtil {

    private static String algorithmName = "md5";

    private static int hashIterations = 2;

    /**
     * 创建用户密码
     * @param user
     */
    public static void encryptPassword(Users user) {
        String newPassword = new SimpleHash(algorithmName, user.getPassword(), ByteSource.Util.bytes(user.getAccount() + user.getId()), hashIterations).toHex();
        user.setPassword(newPassword);
    }

    /**
     * 比对用户输入的旧密码，修改密码时验证
     * @param user
     * @param oldPassWord
     * @return
     */
    public static boolean checkUserPassWord(Users user,String oldPassWord){
        boolean check = false;
        if (user != null && !oldPassWord.isEmpty()){
            String basePass = user.getPassword();
            user.setPassword(oldPassWord);
            PasswordUtil.encryptPassword(user);
            if (basePass.equals(user.getPassword())){
                check = true;
            }
        }
        return check;
    }
    /**
     * 测试密码
     * @param args
     */
    public static void main(String[] args) {
//        Users user = new Users();
//        user.setId("0f1443 aa-eade-410d-b8bf-74ebfa914ca4");
//        user.setAccount("morgan");
//        user.setPassword("123456789");
//        PasswordUtil.encryptPassword(user);
//        System.out.println(user.getPassword());
    }
}
