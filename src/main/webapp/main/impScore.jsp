<%@ page import="com.ggs.util.ImpScoreUtil" %>
<%@ page import="com.ggs.dao.DataDao" %>
<%--
  Created by IntelliJ IDEA.
  User: ggs
  Date: 13-11-5
  Time: 下午9:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/inc/lib.jsp"%>
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
<body style="margin: 10px;">
    <p style="color: red;font-size: 12pt;">提示：请确认已将阅卷机导出的数据放至【<%=DataDao.getConf("IMP_SCORE_PATH")%>】目录，若需更改目录可在【系统管理】的【系统配置】菜单中修改导入路径。</p>
    <p>该目录下默认导入文件的格式为(*.xml或者*.json文件)</p>
    <a href="#" class="easyui-linkbutton" onclick="if(confirm('是否确定导入数据？')){location='impScore.jsp?active=1';}">导入成绩数据</a>
</body>
</html>