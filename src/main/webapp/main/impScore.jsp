<%@ page import="com.ggs.util.ImpScoreUtil" %>
<%@ page import="com.ggs.dao.DataDao" %>
<%--
  Created by IntelliJ IDEA.
  User: ggs
  Date: 13-11-5
  Time: 下午9:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@include file="/inc/lib.jsp"%>
<%
        String active = request.getParameter("active");
        if(active!=null){
            try{
                ImpScoreUtil.impScore();
                out.print("<script>alert('导入成绩数据成功！');location='impScore.jsp';</script>");
            }catch (Exception e){
                e.printStackTrace();
                out.print("<script>alert('导入成绩数据失败！');location='impScore.jsp';</script>");
            }
        }
%>
<html>
<head>
    <title></title>
</head>
<body style="margin: 10px;">
    <h3>服务端导入（本地）</h3>
    <p style="color: red;font-size: 12pt;">提示：请确认已将阅卷机导出的数据放至服务器【<%=DataDao.getConf("IMP_SCORE_PATH")%>】目录，若需更改目录可在【系统管理】的【系统配置】菜单中修改导入路径。</p>
    <p>可一次导入该目录下所有数据文件(*.xml文件)</p>
    <a href="#" class="easyui-linkbutton" onclick="if(confirm('是否确定导入数据？')){location='impScore.jsp?active=1';}">导入数据</a>
    <h3>客户端导入（远程）</h3>
    <p style="color: red;font-size: 12pt;">提示：请选择将阅卷机导出的数据文件上传至服务器导入数据，数据导入系统后成绩数据文件自动删除。</p>
    <p>可一次性上传五个文件导入系统</p>
    <form name="impScoreForm" action="impScore!imp.action" method="post" enctype="multipart/form-data">
        <div>成绩数据文件(*.xml)：<input type="file" name="file"/></div>
        <div>成绩数据文件(*.xml)：<input type="file" name="file"/></div>
        <div>成绩数据文件(*.xml)：<input type="file" name="file"/></div>
        <div>成绩数据文件(*.xml)：<input type="file" name="file"/></div>
        <div>成绩数据文件(*.xml)：<input type="file" name="file"/></div>
        <a href="#" class="easyui-linkbutton" onclick="if(confirm('是否确定导入数据？')){impScoreForm.submit();}">导入数据</a>
    </form>
</body>
</html>