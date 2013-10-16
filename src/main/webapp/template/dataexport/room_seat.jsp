<%@ page import="com.wabacus.system.ReportRequest" %>
<%@ page import="java.util.List" %>
<%@ page import="com.ggs.util.DateUtil" %>
<%@ page import="com.ggs.dao.DataDao" %>
<%@ page import="java.util.Map" %>
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
    .thinTable { background-color:black; font-size:12pt; }
    .thinTable tr{ background-color:white;line-height: 23px;}
</style>
<%
    String curYear = DateUtil.getDatebyFormat("yyyy");
    List<Map<String,String>> roomList = DataDao.getRoomList(request.getParameter("siteid"), request.getParameter("addrid"), request.getParameter("roomid"));
    int pagesize=5;
    for(Map<String,String> room:roomList){

%>
<%
    List<Map<String,String>> userList = DataDao.getRoomUserList(room.get("id"));
    int size =userList.size();



    for(int k=1;k<=5;k=k+2){
        //循环三次

%>
<br/>
<h3 align="center"><%=curYear%>年度药学（非临床）专业初中级技术职务任职资格考试</h3>
<h2 align="center">座次表</h2>
<p align="center">
    （ <u>&nbsp;&nbsp;<%=room.get("site_name")%>&nbsp;&nbsp;</u>考区<u>&nbsp;&nbsp;<%=room.get("addr_name")%>&nbsp;&nbsp;</u>考点，第<u>&nbsp;<%=room.get("name")%>&nbsp;</u>考场  ）
</p>

<table cellpadding="0" cellspacing="0" width="100%" border="0" class="thinTable" align="center">
    <%
        for(int i=k*pagesize-1;i>=(k-1)*pagesize;i--){

            if(i<size){
                Map<String,String> user =userList.get(i);


    %>
    <tr>
        <td width="50%"><table width="100%" border="0" align="center" class="thinTable">
            <tr>
                <td>姓名：<%=user.get("name") %></td>
                <td rowspan="6" align="center" style="width:100px;height:120px;"><img src="<%=user.get("photo") %>" style="width:100px;height:120px;"></td>
            </tr>
            <tr>
                <td>身份证号：<%=user.get("idcard") %></td>
            </tr>
            <tr>
                <td>准考证号：<%=user.get("test_no") %></td>
            </tr>
            <tr>
                <td>座号：<%=i+1 %></td>
            </tr>
            <tr>
                <td>进场签名：</td>
            </tr>
            <tr>
                <td>交卷签名：</td>
            </tr>
        </table></td>
        <%
            }else{

        %>

        <td><table width="100%" border="0" align="center" class="thinTable">
            <tr>
                <td>姓名：</td>
                <td rowspan="6" align="center" style="width:100px;height:120px;">&nbsp;</td>
            </tr>
            <tr>
                <td>身份证号：</td>
            </tr>
            <tr>
                <td>准考证号：</td>
            </tr>
            <tr>
                <td>座号：<%=i+1 %></td>
            </tr>
            <tr>
                <td>进场签名：</td>
            </tr>
            <tr>
                <td>交卷签名：</td>
            </tr>
        </table></td>

        <%

            }


            if(i+pagesize<size){

                Map<String,String> user2 =userList.get(i+pagesize);
        %>
        <td width="50%"><table width="100%" border="0" align="center" class="thinTable">
            <tr>
                <td>姓名：<%=user2.get("name") %></td>
                <td rowspan="6" align="center" style="width:100px;height:120px;"><img src="<%=user2.get("photo") %>" style="width:100px;height:120px;"></td>
            </tr>
            <tr>
                <td>身份证号：<%=user2.get("idcard") %></td>
            </tr>
            <tr>
                <td>准考证号：<%=user2.get("test_no") %></td>
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
        <%}else{

        %>


        <td><table width="100%" border="0" align="center" class="thinTable">
            <tr>
                <td>姓名：</td>
                <td rowspan="6" align="center" style="width:100px;height:120px;">&nbsp;</td>
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
         }
        %>
    </tr>
    <%}%>
</table>
<p style="line-height: 75px;">&nbsp;</p>
<%
    }

    }

%>