package com.ggs.filter;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Created with IntelliJ IDEA.
 * User: GGS
 * Date: 13-7-6
 * Time: 下午8:52
 * To change this template use File | Settings | File Templates.
 */
public class UserFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest)servletRequest;
        HttpServletResponse response =(HttpServletResponse)servletResponse;
        HttpSession session =request.getSession();
        if(session.getAttribute("user_id")==null){
            //未登录用户
            response.getWriter().print("<script>top.location='"+request.getContextPath()+"/login.jsp';</script>");
        } else{
            filterChain.doFilter(request,response);
        }
    }

    @Override
    public void destroy() {

    }
}
