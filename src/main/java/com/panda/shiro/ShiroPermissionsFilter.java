package com.panda.shiro;

import com.panda.util.JsonUtil;
import com.panda.util.StringUtil;
import org.apache.shiro.web.filter.authz.PermissionsAuthorizationFilter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class ShiroPermissionsFilter extends PermissionsAuthorizationFilter {

	private static final Logger logger = LoggerFactory
			.getLogger(ShiroPermissionsFilter.class);
	
	/**
     * shiro认证perms资源失败后回调方法
     * @param servletRequest
     * @param servletResponse
     * @return
     * @throws IOException
     */
    @Override
    protected boolean onAccessDenied(ServletRequest servletRequest, ServletResponse servletResponse) throws IOException {
    	HttpServletRequest httpServletRequest = (HttpServletRequest) servletRequest;
        HttpServletResponse httpServletResponse = (HttpServletResponse) servletResponse;
        String requestedWith = httpServletRequest.getHeader("X-Requested-With");
        if (!StringUtil.IsNullOrEmpty(requestedWith) &&
                StringUtil.IsEmpty(requestedWith, "XMLHttpRequest")) {//如果是ajax返回指定格式数据
        	Map<String, Object> result = new HashMap<String, Object>();
			result.put("flag", false);
			result.put("msg", "权限不足！");
            httpServletResponse.setCharacterEncoding("UTF-8");
            httpServletResponse.setContentType("application/json");
            httpServletResponse.getWriter().write(JsonUtil.collectToString(result));
        } else {//如果是普通请求进行重定向
            httpServletResponse.sendRedirect("/403");
        }
        return false;
    }
	
}
