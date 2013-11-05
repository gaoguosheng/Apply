<%@ page import="com.ggs.util.ImpScoreUtil" %>
<%--
  Created by IntelliJ IDEA.
  User: ggs
  Date: 13-11-5
  Time: 下午9:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
        String active = request.getParameter("active");
        if(active!=null){
            boolean t = ImpScoreUtil.impScoreToDb(ImpScoreUtil.getScoreListByXml());
            if(t)
                out.print("<script>alert('导入成绩数据成功！');location='impScore.jsp';</script>");
            else
                out.print("<script>alert('导入成绩数据失败！');location='impScore.jsp';</script>");
        }
%>
<html>
<head>
    <title></title>
</head>
<body>
    <button onclick="if(confirm('是否确定导入数据？')){location='impScore.jsp?active=1';}">导入成绩数据</button>
</body>
</html>