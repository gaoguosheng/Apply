<%@ page import="com.wabacus.system.ReportRequest" %>
<%@ page import="com.ggs.util.DateUtil" %>
<%@ page import="java.util.List" %>
<%@ page import="com.ggs.dao.DataDao" %>
<%@ page import="java.util.Map" %>
<%--
  Created by IntelliJ IDEA.
  User: ggs
  Date: 13-10-10
  Time: 下午9:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
<style type="text/css">
    .thinTable { background-color:black; font-size:10pt; line-height:27px;}
    .thinTable tr{ background-color:white;}
</style>
<table width="700px" border="0" cellpadding="5" cellspacing="1" class="thinTable">
    <tr>
        <td colspan="8" align="center" valign="middle" style="height:50px;text-align: center">
            <h3><%=DateUtil.getDatebyFormat("yyyy")%>年度福建省药学（非临床）专业初中级技术职务任职资格考试</h3>
            <h2 align="center">准 考 证</h2>
        </td>
    </tr>
</table>
<%!
    List getExamDateTime(){
          return DataDao.getExamDateTime();
    }
    Map getExamSite(String applyid){
        return DataDao.getExamSite(applyid);
    }
%>
<%
    List<Map<String,String>> examDateList = getExamDateTime();
    Map<String,String>siteAddr = getExamSite(request.getParameter("id"));
    ReportRequest rrequest=(ReportRequest)request.getAttribute("WX_REPORTREQUEST");
    int size=rrequest.getReportDataListSize("report1");
    if(size>0){
%>
<table width="700px" border="0" cellpadding="5" cellspacing="0" class="thinTable">
    <tr>
        <td width="80" align="right">姓&nbsp;&nbsp;&nbsp;&nbsp;名：</td>
        <td width="150" align="center"><%=rrequest.getColDisplayValue("report1","name",0) %></td>
        <td width="80" align="right">准考证号：</td>
        <td width="150" align="center"><%=rrequest.getColDisplayValue("report1","test_no",0) %></td>
        <td width="178" colspan="2" rowspan="5" align="center"><%=rrequest.getColDisplayValue("report1","photo",0) %></td>
    </tr>
    <tr>
        <td align="right">性&nbsp;&nbsp;&nbsp;&nbsp;别：</td>
        <td align="center"><%=rrequest.getColDisplayValue("report1","sex",0) %></td>
        <td align="right">档&nbsp;案&nbsp;号：</td>
        <td align="center"><%=rrequest.getColDisplayValue("report1","fn",0) %></td>
    </tr>
    <tr>
        <td align="right">报考级别：</td>
        <td align="center"><%=rrequest.getColDisplayValue("report1","test_level",0) %></td>
        <td align="right">报考专业：</td>
        <td align="center"><%=rrequest.getColDisplayValue("report1","spec_class",0) %></td>
    </tr>
    <tr>
        <td align="right">身份证号：</td>
        <td align="center"><%=rrequest.getColDisplayValue("report1","idcard",0) %></td>
        <td align="right">&nbsp;</td>
        <td align="center">&nbsp;</td>
    </tr>
    <tr>
        <td align="right">工作单位：</td>
        <td align="center"><%=rrequest.getColDisplayValue("report1","company",0) %></td>
        <td align="right">&nbsp;</td>
        <td align="center">&nbsp;</td>
    </tr>
</table>

<table width="700px" border="0" cellpadding="5" cellspacing="1" class="thinTable">
    <tr>

        <td width="66" align="center">考试科目</td>
        <td width="100" align="center">药事管理与法规</td>
        <td width="100" align="center">(中)药学综合知识<br/>与技能</td>
        <td width="100" align="center">（中）药学专业<br/>知识</td>
        <td width="100" align="center">（中）药学专业<br/>知识一</td>
        <td width="100" align="center">（中）药学专业<br/>知识二</td>

    </tr>
    <tr>
        <td align="center">考试日期</td>
        <%for (Map<String,String> item:examDateList){%>
        <td align="center"><%=item.get("test_date")%></td>
        <%}%>
    </tr>
    <tr>
        <td align="center">考试时间</td>
        <%for (Map<String,String> item:examDateList){%>
        <td align="center"><%=item.get("test_time")%></td>
        <%}%>
    </tr>
    <tr>
        <td align="center">所在考场</td>
        <td align="center" colspan="5"><%=siteAddr.get("site_name")%> <%=siteAddr.get("addr_name")%></td>
    </tr>
    <tr>
        <td align="center">考试地点</td>
        <td align="center" colspan="5"> <%=siteAddr.get("room_name")%> 第<%=siteAddr.get("seatnum")%>座位</td>
    </tr>

</table>
<table width="700px" border="0" cellpadding="5" cellspacing="1" class="thinTable">
    <tr>
        <td colspan="8" align="left" valign="middle"><h3 align="center">考 生 须 知</h3>
            <p>1、考生应提前半天熟悉考场，以免考试当天找不到考场或找错考场； <br>
                2、考生必须带齐准考证、身份证，方可进入考场；未带证件或证件不齐、不符者，不得入场； <br>
                3、考试一律用2B铅笔在答题卡上填涂作答。考生自备2B铅笔、橡皮、黑色、蓝色墨水笔（签字笔）或圆珠笔； <br>
                4、禁止将移动电话、电子记事本、计算器等带有记忆、运算或通讯功能的电子设备带至座位； <br>
                5、考试开始30分钟后，不得入场；考试期间不得在开考后60分钟内提前交卷退场； <br>
                6、严禁将答题卡、题本、试卷、草稿纸等带出考场； <br>
                7、考生必须遵守考场规则，若有作弊行为，将被取消考试资格，并按《专业技术人员资格考试违纪违规行为处理规定》（2011年人社部令第12号）处理； <br>
                8、考场没有为考生保管财物的义务； <br>
                9、考生可于${sys_conf.SCORE_STDATE}后登陆&ldquo;福建省食品药品监督管理局网&rdquo;（www.fjfda.gov.cn）查询考试成绩。 <br>
                10、本次准考证打印时间为：${sys_conf.PRINT_TEST_STDATE}~${sys_conf.PRINT_TEST_EDDATE}。 </p>
            <p align="center">
            </p></td>
    </tr>
</table>
<%
    }
%>
</body>
</html>