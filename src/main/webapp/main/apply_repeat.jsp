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
  
    dbUtil.update("delete from t_apply where id in(" +
            " select min(id) from t_apply where idcard in(" +
            " select idcard from t_apply group by idcard having count(*)>1 " +
            " )group by idcard)");
%>
<html>
<head>
    <title></title>
</head>
<body>
    执行完成。
</body>
</html>