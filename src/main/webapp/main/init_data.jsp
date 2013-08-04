<%@ page import="com.ggs.util.DBUtil" %>
<%--
  Created by IntelliJ IDEA.
  User: GGS
  Date: 13-8-4
  Time: 下午4:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    DBUtil dbUtil = new DBUtil();
    dbUtil.update("delete from t_apply");
    dbUtil.update("delete from t_apply_check");
    dbUtil.update("delete from t_user where usertype=0");
    dbUtil.update("delete from t_log");
    dbUtil.update("drop sequence SEQ_APPLY_SEQ");
    dbUtil.update("create sequence SEQ_APPLY_SEQ " +
            "minvalue 1 " +
            "maxvalue 999999999999999999999999999 " +
            "start with 1 " +
            "increment by 1 " +
            "cache 20");
%>
<html>
<head>
    <title></title>
</head>
<body>
    初始化数据完成。
</body>
</html>