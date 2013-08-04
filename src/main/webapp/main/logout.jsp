<%@ page import="com.ggs.bean.User" %>
<%--
  Created by IntelliJ IDEA.
  User: ggs
  Date: 13-5-9
  Time: 下午9:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%

    if(session.getAttribute("admin")!=null){
        User admin = (User)session.getAttribute("admin");
        session.invalidate();
        if(admin.getUsertype().equals("1")){
            response.sendRedirect(request.getContextPath()+"/admin_login.jsp");
        }else{
            response.sendRedirect(request.getContextPath()+"/login.jsp");
        }
    }

%>