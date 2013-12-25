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
    .thinTable tr td{ padding: 10px;}
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
<center>
<table class="thinTable" cellpadding="0" cellspacing="1" width="730" border="0" >
        <tr>
        <td >姓名</td>
        <td ><%=rrequest.getColDisplayValue("report1","name",0) %></td>
        <td >性别</td>
        <td><%=rrequest.getColDisplayValue("report1","sex",0) %></td>
        <td >出生年月</td>
        <td><%=rrequest.getColDisplayValue("report1","birthday",0) %></td>
        <td rowspan="6" width="150" align="center"><img src="<%=rrequest.getColDisplayValue("report1","photo",0) %>" style="width: 100px;height: 120px;"></td>
    </tr>
    <tr>
        <td >工作时间</td>
        <td ><%=rrequest.getColDisplayValue("report1","work_date",0) %></td>
        <td >身份证号码</td>
        <td colspan="3" ><%=rrequest.getColDisplayValue("report1","idcard",0) %></td>
    </tr>
    <tr>
        <td>工作单位</td>
        <td colspan="5" ><%=rrequest.getColDisplayValue("report1","company",0) %></td>
    </tr>
    <tr>
        <td >毕业院校</td>
        <td colspan="3" ><%=rrequest.getColDisplayValue("report1","grad_scholl",0) %></td>
        <td >所学专业</td>
        <td ><%=rrequest.getColDisplayValue("report1","grad_spec",0) %></td>
    </tr>
    <tr>
        <td >现专业技术职务</td>
        <td colspan="2" >
            <%
                String now_tech_name=rrequest.getColDisplayValue("report1","now_tech_name",0);
                if(now_tech_name!=null){
                    out.print(now_tech_name);
                }
            %>
        </td>
        <td >取得时间</td>
        <td colspan="2" >
            <%
                String conftime=rrequest.getColDisplayValue("report1","conftime",0);
                if(conftime!=null){
                    out.print(conftime);
                }
            %>
        </td>
    </tr>
    <tr>
        <td>报考层次</td>
        <td colspan="2" ><%=rrequest.getColDisplayValue("report1","tech_name_name",0) %></td>
        <td >报考专业</td>
        <td colspan="2" ><%=rrequest.getColDisplayValue("report1","spec_class_name",0) %></td>
    </tr>
    <tr>
        <td>考试成绩</td>
        <td colspan="6">
            <table width="100%" border="0" class="thinTable" cellpadding="0" cellspacing="1">
                <tr>
                    <%
                        for ( int i=0;i<scoreList.size();i++){
                            Map<String,String>score = scoreList.get(i);
                            out.print("<td align='center' width='25%'>"+score.get("test_subject_name")+"</td>");
                        }
                        for ( int i=0;i<4-scoreList.size();i++){
                            out.print("<td align='center' width='25%'>&nbsp;</td>");
                        }
                    %>
                </tr>
                <tr>
                    <%
                        for ( int i=0;i<scoreList.size();i++){
                            Map<String,String>score = scoreList.get(i);
                            out.print("<td align='center' width='25%'>"+score.get("score")+"</td>");
                        }
                        for ( int i=0;i<4-scoreList.size();i++){
                            out.print("<td align='center' width='25%'>&nbsp;</td>");
                        }
                    %>
                </tr>
            </table>
            <p>各科成绩合格线均为50分</p>
        </td>
    </tr>

    <tr>
        <td >考试管理机构意见</td>
        <td colspan="6" >
            <p align="center" style="height: 50px;">该同志经全省统一考试，全部规定科目成绩合格。</p>
            <div style="height: 100px;text-align: right;margin-right: 30px;">
                <p style="height: 50px;">（章）</p>
                <p>年&nbsp;&nbsp;月&nbsp;&nbsp;日&nbsp;&nbsp;</p>
            </div>
        </td>
    </tr>

    <tr>
        <td >省职改办意见</td>
        <td  colspan="6">
            <p align="center" style="height: 50px;">该同志具备 <b><%=rrequest.getColDisplayValue("report1","tech_name_name",0) %></b> 资格。 </p>
            <div style="height: 100px;text-align: right;margin-right: 30px;">
                <p style="height: 50px;">（章）</p>
                <p>年&nbsp;&nbsp;月&nbsp;&nbsp;日&nbsp;&nbsp;</p>
            </div>
        </td>
    </tr>

    <tr>
        <td >证书编号</td>
        <td colspan="6" >
            <%
                String certid=rrequest.getColDisplayValue("report1","certid",0);
                if(certid!=null){
                    out.print(certid);
                }
            %>
        </td>
    </tr>
</table>
<%}%>
</center>
