<%@ page import="com.wabacus.system.ReportRequest" %>
<%@ page import="com.ggs.dao.DataDao" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%--
  Created by IntelliJ IDEA.
  User: GGS
  Date: 13-11-12
  Time: 下午3:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style type="text/css">
    body{margin:0px; padding:0px;}
    .thinTable { background-color:black; font-size:9pt; }
    .thinTable tr{ background-color:white;}
</style>

<h3 align="center">2013年度福建省药学（非临床）专业初中级技术职务任职资格考试</h3>
    <h2 align="center">合格人员登记表</h2>
<%
    ReportRequest rrequest=(ReportRequest)request.getAttribute("WX_REPORTREQUEST");
    int size=rrequest.getReportDataListSize("report1");
    if(size>0){
        String userid =rrequest.getColDisplayValue("report1","userid",0) ;
        List<Map<String,String>> scoreList = DataDao.getScoreList("2013",userid);
%>
<table class="thinTable" cellpadding="10" cellspacing="1" width="730" border="0">
        <tr>
        <td width="83">姓名</td>
        <td width="72"><%=rrequest.getColDisplayValue("report1","name",0) %></td>
        <td width="87">性别</td>
        <td width="90"><%=rrequest.getColDisplayValue("report1","sex",0) %></td>
        <td width="79">出生年月</td>
        <td width="80"><%=rrequest.getColDisplayValue("report1","birthday",0) %></td>
        <td rowspan="6" width="157" align="center"><img src="<%=rrequest.getColDisplayValue("report1","photo",0) %>" style="width: 100px;height: 120px;"></td>
    </tr>
    <tr>
        <td width="83">工作时间</td>
        <td width="72"><%=rrequest.getColDisplayValue("report1","work_date",0) %></td>
        <td width="87">身份证号码</td>
        <td colspan="3" width="249"><%=rrequest.getColDisplayValue("report1","idcard",0) %></td>
    </tr>
    <tr>
        <td width="83">工作单位</td>
        <td colspan="5" width="408"><%=rrequest.getColDisplayValue("report1","company",0) %></td>
    </tr>
    <tr>
        <td width="83">毕业院校</td>
        <td colspan="3" width="249"><%=rrequest.getColDisplayValue("report1","grad_scholl",0) %></td>
        <td width="79">所学专业</td>
        <td width="80"><%=rrequest.getColDisplayValue("report1","grad_spec",0) %></td>
    </tr>
    <tr>
        <td width="83">现专业技术职务</td>
        <td colspan="2" width="159"><%=rrequest.getColDisplayValue("report1","now_tech_name",0) %></td>
        <td width="90">取得时间</td>
        <td colspan="2" width="159"><%=rrequest.getColDisplayValue("report1","conftime",0) %></td>
    </tr>
    <tr>
        <td width="83">报考层次</td>
        <td colspan="2" width="159"><%=rrequest.getColDisplayValue("report1","tech_name_name",0) %></td>
        <td width="90">报考专业</td>
        <td colspan="2" width="159"><%=rrequest.getColDisplayValue("report1","spec_class_name",0) %></td>
    </tr>
    <tr>
        <td rowspan="2" width="83">考试成绩</td>
        <%
            for ( int i=0;i<scoreList.size();i++){
                Map<String,String>score = scoreList.get(i);
                if(i==4-1)
                    out.print("<td colspan='2'>&nbsp;</td>");
                else
                    out.print("<td>"+score.get("test_subject_name")+"</td>");
            }
            for(int i=scoreList.size()+1;i<=5;i++){
                if(i==4)
                    out.print("<td colspan='2'>&nbsp;</td>");
                else
                    out.print("<td>&nbsp;</td>");
            }

        %>

    </tr>
    <tr>
        <%
            for ( int i=0;i<scoreList.size();i++){
                Map<String,String>score = scoreList.get(i);
                if(i==4-1)
                    out.print("<td colspan='2'>&nbsp;</td>");
                else
                    out.print("<td>"+score.get("score")+"</td>");
            }
            for(int i=scoreList.size()+1;i<=5;i++){
                if(i==4)
                    out.print("<td colspan='2'>&nbsp;</td>");
                else
                    out.print("<td>&nbsp;</td>");
            }
        %>
    </tr>
    <tr>
        <td width="83">考试管理机构意见</td>
        <td colspan="6" width="565"><p align="center">该同志经全省统一考试，全部规定科目成绩合格。<br>
        </p>
            <p align="right">（章）<br/>                                                                                          年      月     日</p></td>
    </tr>

    <tr>
        <td width="83">省职改办意见</td>
        <td width="565" colspan="6"><p align="center">该同志具备 <%=rrequest.getColDisplayValue("report1","tech_name_name",0) %>   资格。<br>
        </p>
            <p align="right">（章） <br/>                                                 年        月      日</p></td>
    </tr>

    <tr>
        <td width="83">证书编号</td>
        <td colspan="6" width="565"><%=rrequest.getColDisplayValue("report1","certid",0) %></td>
    </tr>
</table>
<%}%>
