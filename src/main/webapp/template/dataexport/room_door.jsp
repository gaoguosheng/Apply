<%@ page import="com.wabacus.system.ReportRequest" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.ggs.dao.DataDao" %>
<%@ page import="com.ggs.util.DateUtil" %>
<%--
  Created by IntelliJ IDEA.
  User: ggs
  Date: 13-10-7
  Time: 下午10:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style type="text/css">
    body{margin:0px; padding:0px;}
    .thinTable { background-color:black; font-size:9pt; }
    .thinTable tr{ background-color:white;}
</style>
<%
    String curYear = DateUtil.getDatebyFormat("yyyy");
    List<Map<String,String>> roomList = DataDao.getRoomList(request.getParameter("siteid"),request.getParameter("addrid"),request.getParameter("roomid"));
    int pagesize=15;
    for(Map<String,String> room:roomList){

%>

<h3 align="center"><%=curYear%>年度药学（非临床）专业初中级技术职务任职资格考试</h3>
<p align="center">
    （ <u>&nbsp;&nbsp;<%=room.get("site_name")%>&nbsp;&nbsp;</u>考区<u>&nbsp;&nbsp;<%=room.get("addr_name")%>&nbsp;&nbsp;</u>考点，第<u>&nbsp;<%=room.get("name")%>&nbsp;</u>考场  ） </p>

<%

    List<Map<String,String>> userList = DataDao.getRoomUserList(room.get("id"));
    int size =userList.size();
%>
<table border="1" cellpadding="10" align="center"  width="980" class="thinTable">
    <tr>
        <td ><p align="center">座号</p> </td>
        <td><p align="center">准考证号 </p></td>
        <td><p align="center">姓名 </p></td>
        <td><p align="center">级别 </p></td>
        <td><p align="center">专业 </p></td>
        <td><p align="center">座号 </p></td>
        <td><p align="center">准考证号 </p></td>
        <td><p align="center">姓名 </p></td>
        <td><p align="center">级别 </p></td>
        <td><p align="center">专业 </p></td>
    </tr>
    <%
        for(int i=0;i<pagesize;i++) {

            if(i<size){


            Map<String,String> user =userList.get(i);
    %>
    <tr>
        <td><p align="center"><%=i+1 %></p> </td>
        <td><p align="center"><%=user.get("test_no") %> </p></td>
        <td ><p align="center"> <%=user.get("name") %></p></td>
        <td ><p align="center"><%=user.get("tech_name_name") %></p></td>
        <td><p align="center"><%=user.get("spec_class_name") %></p></td>
        <%
            }else{

        %>
        <td ><p align="center"><%=i+1 %> </p></td>
        <td ><p align="center">&nbsp;</p></td>
        <td ><p align="center">&nbsp; </p></td>
        <td ><p align="center">&nbsp;</p></td>
        <td ><p align="center">&nbsp;</p></td>
        <%
            }


            if(i+pagesize<size){
                Map<String,String> user2 =userList.get(i+pagesize);
        %>
        <td><p align="center"><%=i+pagesize+1%> </p></td>
        <td ><p align="center"><%=user2.get("test_no") %></p></td>
        <td ><p align="center"><%=user2.get("name") %> </p></td>
        <td><p align="center"><%=user2.get("tech_name_name") %> </p></td>
        <td><p align="center"><%=user2.get("spec_class_name") %> </p></td>
        <%
            }else{
        %>
        <td ><p align="center"><%=i+pagesize+1 %> </p></td>
        <td ><p align="center">&nbsp;</p></td>
        <td ><p align="center">&nbsp; </p></td>
        <td ><p align="center">&nbsp;</p></td>
        <td><p align="center">&nbsp;</p></td>
        <%
            }
        %>

    </tr>

    <%
        }
    %>
</table>
<p style="line-height: 7px;">&nbsp;</p>
<%
    }

%>
