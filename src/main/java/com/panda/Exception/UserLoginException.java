package com.panda.Exception;

import org.apache.shiro.ShiroException;
import org.apache.shiro.authc.CredentialsException;
import org.apache.shiro.authc.IncorrectCredentialsException;

public class UserLoginException  extends CredentialsException {
        public UserLoginException() {
        }

        public UserLoginException(String message) {
            super(message);
        }

        public UserLoginException(Throwable cause) {
            super(cause);
        }

        public UserLoginException(String message, Throwable cause) {
            super(message, cause);
        }

}
