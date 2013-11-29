<%@ page import="com.wabacus.system.ReportRequest" %>
<%--
  Created by IntelliJ IDEA.
  User: GGS
  Date: 13-11-12
  Time: 下午3:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    ReportRequest rrequest=(ReportRequest)request.getAttribute("WX_REPORTREQUEST");
    int size=rrequest.getReportDataListSize("report1");
    if(size>0){

%>
<style type="text/css">
    td{font-size: 12pt;}
    .mytd{ border-bottom:1px solid #000000;}
</style>
<table width="1000px" border="0">
    <tr>
        <td width="50%" align="center" valign="top">

            <table cellpadding="10"  width="90%" align="center" border="0" >
                <tr>
                    <td colspan="2" align="center">
                        <img src="<%=rrequest.getColDisplayValue("report1","photo",0) %>" style="width: 100px;height: 120px;">
                    </td>
                </tr>
                <tr>
                    <td width="100px">姓&nbsp;&nbsp;&nbsp;&nbsp;名：</td>
                    <td class="mytd"><%=rrequest.getColDisplayValue("report1","name",0) %></td>
                </tr>
                <tr>
                    <td>性&nbsp;&nbsp;&nbsp;&nbsp;别：</td>
                    <td class="mytd"><%=rrequest.getColDisplayValue("report1","sex",0) %></td>
                </tr>
                <tr>
                    <td>出生年月：</td>
                    <td class="mytd"><%=rrequest.getColDisplayValue("report1","birthday",0) %></td>
                </tr>
                <tr>
                    <td>工作单位：</td>
                    <td class="mytd"><%=rrequest.getColDisplayValue("report1","company",0) %></td>
                </tr>
                <tr>
                    <td>证书编号：</td>
                    <td class="mytd"><%=rrequest.getColDisplayValue("report1","certid",0) %></td>
                </tr>
            </table>

        </td>
        <td align="center" valign="top">

            <table cellpadding="10"  width="90%" align="center" border="0" class="mytb">
                <tr>
                    <td  width="100px">级&nbsp;&nbsp;&nbsp;&nbsp;别：</td>
                    <td class="mytd"><%=rrequest.getColDisplayValue("report1","test_level_name",0) %></td>
                </tr>
                <tr>
                    <td>专业名称：</td>
                    <td class="mytd"><%=rrequest.getColDisplayValue("report1","spec_class_name",0) %></td>
                </tr>
                <tr>
                    <td>资格名称：</td>
                    <td class="mytd"><%=rrequest.getColDisplayValue("report1","tech_name_name",0) %></td>
                </tr>
                <tr>
                    <td>评审组织：</td>
                    <td class="mytd"><%=rrequest.getColDisplayValue("report1","appr_org",0) %></td>
                </tr>
                <tr>
                    <td>审批部门：</td>
                    <td class="mytd"><%=rrequest.getColDisplayValue("report1","appr_dept",0) %></td>
                </tr>
                <tr>
                    <td>批准文号：</td>
                    <td class="mytd"><%=rrequest.getColDisplayValue("report1","appr_no",0) %></td>
                </tr>
                <tr>
                    <td>批准日期：</td>
                    <td class="mytd"><%=rrequest.getColDisplayValue("report1","appr_time",0) %></td>
                </tr>
            </table>

        </td>
    </tr>
</table>



<%}%>
