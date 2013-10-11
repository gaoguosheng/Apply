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
    .thinTable tr{ background-color:white;line-height: 23px;}
</style>

<%
    ReportRequest rrequest=(ReportRequest)request.getAttribute("WX_REPORTREQUEST");
    int size=rrequest.getReportDataListSize("report1");
    System.out.println("size:"+size);
    int pagesize=5;
    if(size>0)
    {

    for(int k=1;k<=5;k=k+2){
        //循环三次

%>
<br/>
<h2 align="center">${cur_year}年度药学（非临床）专业初中级技术职务任职资格考试<br/>座次表</h2>
<h3 align="center">
    （ <u>&nbsp;${addr_name}&nbsp;</u>考区<u>&nbsp;${site_name}&nbsp;</u>考点，第<u>&nbsp;${room_name}&nbsp;</u>考室 ） </h3>

<table cellpadding="0" cellspacing="0" width="100%" border="0" class="thinTable" align="center">
    <%
        for(int i=k*pagesize-1;i>=(k-1)*pagesize;i--)
        {
    %>
    <tr>
        <td width="50%"><table width="100%" border="0" align="center" class="thinTable">
            <tr>
                <td>姓名：<%=rrequest.getColDisplayValue("report1","name",i) %></td>
                <td rowspan="6" align="center" style="width:100px;height:120px;"><img src="<%=rrequest.getColDisplayValue("report1","photo",i) %>" style="width:100px;height:120px;" /></td>
            </tr>
            <tr>
                <td>身份证号：<%=rrequest.getColDisplayValue("report1","idcard",i) %></td>
            </tr>
            <tr>
                <td>准考证号：<%=rrequest.getColDisplayValue("report1","test_no",i) %></td>
            </tr>
            <tr>
                <td>座号：<%=rrequest.getColDisplayValue("report1","seatnum",i) %></td>
            </tr>
            <tr>
                <td>进场签名：</td>
            </tr>
            <tr>
                <td>交卷签名：</td>
            </tr>
        </table></td>
        <%
            if(i+pagesize<size){
            System.out.println("i:"+i);
        %>
        <td><table width="100%" border="0" align="center" class="thinTable">
            <tr>
                <td>姓名：<%=rrequest.getColDisplayValue("report1","name",i+pagesize) %></td>
                <td rowspan="6" align="center" style="width:100px;height:120px;"><img src="<%=rrequest.getColDisplayValue("report1","photo",i) %>" style="width:100px;height:120px;"/></td>
            </tr>
            <tr>
                <td>身份证号：<%=rrequest.getColDisplayValue("report1","idcard",i+pagesize) %></td>
            </tr>
            <tr>
                <td>准考证号：<%=rrequest.getColDisplayValue("report1","test_no",i+pagesize) %></td>
            </tr>
            <tr>
                <td>座号：<%=rrequest.getColDisplayValue("report1","seatnum",i+pagesize) %></td>
            </tr>
            <tr>
                <td>进场签名：</td>
            </tr>
            <tr>
                <td>交卷签名：</td>
            </tr>
        </table></td>
        <%}else{

        %>


        <td><table width="100%" border="0" align="center" class="thinTable">
            <tr>
                <td>姓名：</td>
                <td rowspan="6" align="center" style="width:100px;height:120px;"><img src="" style="width:100px;height:120px;"/></td>
            </tr>
            <tr>
                <td>身份证号：</td>
            </tr>
            <tr>
                <td>准考证号：</td>
            </tr>
            <tr>
                <td>座号：<%=i+pagesize+1 %></td>
            </tr>
            <tr>
                <td>进场签名：</td>
            </tr>
            <tr>
                <td>交卷签名：</td>
            </tr>
        </table></td>

        <%
        }%>
    </tr>
    <%}%>
</table>
<p style="line-height: 80px;">&nbsp;</p>
<%}
}
%>