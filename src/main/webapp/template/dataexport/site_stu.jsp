<%@ page import="com.wabacus.system.ReportRequest" %>
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
<h3 align="center">${cur_year}年度药学（非临床）专业初中级技术职务任职资格考试</h3>
<p align="center">
    （ <u>&nbsp;&nbsp;${addr_name}&nbsp;&nbsp;</u>考区<u>&nbsp;&nbsp;${site_name}&nbsp;&nbsp;</u>考点，第<u>&nbsp;${room_name}&nbsp;</u>考室 ） </p>
<%
    ReportRequest rrequest=(ReportRequest)request.getAttribute("WX_REPORTREQUEST");
    int size=rrequest.getReportDataListSize("report1");
    int pagesize=15;
    if(size>0)
    {
%>
<table border="1" cellpadding="4" align="center"  width="980" class="thinTable">
    <tr>
        <td width="64"><p align="center">座号</p> </td>
        <td width="158"><p align="center">准考证号 </p></td>
        <td width="105"><p align="center">姓名 </p></td>
        <td width="113"><p align="center">级别 </p></td>
        <td width="86"><p align="center">专业 </p></td>
        <td width="69"><p align="center">座号 </p></td>
        <td width="170"><p align="center">准考证号 </p></td>
        <td width="101"><p align="center">姓名 </p></td>
        <td width="104"><p align="center">级别 </p></td>
        <td width="84"><p align="center">专业 </p></td>
    </tr>
    <%
        for(int i=0;i<pagesize;i++)
        {
    %>
    <tr>
        <td width="64"><p align="center"><%=rrequest.getColDisplayValue("report1","seatnum",i) %></p> </td>
        <td width="158"><p align="center"><%=rrequest.getColDisplayValue("report1","test_no",i) %> </p></td>
        <td width="105"><p align="center"><%=rrequest.getColDisplayValue("report1","name",i) %> </p></td>
        <td width="113"><p align="center"><%=rrequest.getColDisplayValue("report1","tech_name_name",i) %> </p></td>
        <td width="86"><p align="center"><%=rrequest.getColDisplayValue("report1","spec_class_name",i) %> </p></td>
        <%
            if(i+pagesize<size){

        %>
        <td width="69"><p align="center"><%=rrequest.getColDisplayValue("report1","seatnum",i+pagesize) %> </p></td>
        <td width="170"><p align="center"><%=rrequest.getColDisplayValue("report1","test_no",i+pagesize) %></p></td>
        <td width="101"><p align="center"><%=rrequest.getColDisplayValue("report1","name",i+pagesize) %> </p></td>
        <td width="104"><p align="center"><%=rrequest.getColDisplayValue("report1","tech_name_name",i+pagesize) %> </p></td>
        <td width="84"><p align="center"><%=rrequest.getColDisplayValue("report1","spec_class_name",i+pagesize) %> </p></td>
        <%
            }else{

        %>
        <td width="69"><p align="center"><%=i+pagesize+1 %> </p></td>
        <td width="170"><p align="center">&nbsp;</p></td>
        <td width="101"><p align="center">&nbsp; </p></td>
        <td width="104"><p align="center">&nbsp;</p></td>
        <td width="84"><p align="center">&nbsp;</p></td>
        <%
            }
        %>

    </tr>

    <%
        }
    %>
</table>
<%
    }
%>