<%@ page import="com.ggs.dao.DataDao" %>
<%@ page import="com.ggs.util.DateUtil" %>
<%@ page import="java.util.Map" %>
<%--
  Created by IntelliJ IDEA.
  User: ggs
  Date: 13-5-9
  Time: 下午8:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@include file="/inc/lib.jsp"%>
    <title>考生登陆 - ${softName}</title>
</head>
<body style="background-image: url('img/top_3.gif')">
    <div class="easyui-dialog" title="${softTitle}" resizable="false" draggable="false" closable="false" data-options="iconCls:'icon-user'" style="width:700px;height:380px;padding:10px">
        <div align="center" style="font-size: 16pt;font-weight: bold;">${softName}</div>
        <form id="loginForm" method="post">
            <table align="center" width="100%" border="0"  cellpadding="5" class="normalFont">
                <tr>
                    <td width="200px"  align="center"><img src="${ctx}/img/logo.jpg"></td>
                    <td valign="top">
                        <table align="center" width="100%" border="0"  cellpadding="5" class="normalFont">
                            <input type="hidden" id="usertype" name="usertype" value="0">
                            <tr>
                                <td align="right">身份证号码：</td>
                                <td><input type="text" name="username" id="username" class="easyui-validatebox" required="required"  style="width: 180px;" onkeydown="if(event.keyCode==13)$('#pwd').focus();"></td>
                            </tr>
                            <tr id="realnameTr">
                                <td align="right">真实姓名：</td>
                                <td><input type="text" name="realname" id="realname" class="easyui-validatebox"  required="required" style="width: 180px;" onkeydown="if(event.keyCode==13)$('#pwd').focus();"></td>
                            </tr>
                            <tr>
                                <td align="right">密码：</td>
                                <td><input type="password" name="pwd" id="pwd" class="easyui-validatebox" required="required"  style="width: 180px;" onkeydown="if(event.keyCode==13)$('#valicode').focus();"></td>
                            </tr>
                            <tr>
                                <td align="right">验证码：</td>
                                <td>
                                    <input type="text" name="valicode" id="valicode" class="easyui-validatebox"  style="width: 60px;" onkeydown="f_enter_submit()">
                                    <img src="inc/valicode.jsp" style="cursor: hand;" onclick="this.src='inc/valicode.jsp?date='+new Date();" title="换一个">
                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                                <td>
                                    <a id="loginBtn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">登陆</a>
                                    <a id="regBtn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'">注册报名</a>
                                    <a id="lostBtn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-help'">忘记密码</a>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </form>
        <div  align="center">
            <div>建议使用1280*768 以上分辨率、IE浏览器(推荐8.0以上)浏览</div>
            <div>Copyright © 2013 . All Rights Reserved</div>
           <%-- <hr style="height: 1px;"/>
            <div style="text-align: left">注意事项：<br/>
                1、系统报名信息填报错误、密码重置及修改信息等业务问题，请咨询当地市局药监局人教处（科）；<br/>
                2、系统无法访问、打印出错等技术问题请联系0591-86295224。</div>--%>
        </div>
    </div>
    <div id="regDialog"></div>
    <%
        Map<String,String> notice =  DataDao.getNewNotice();
        if(notice.size()>0){

    %>
    <div id="msgDiaog" class="easyui-dialog" title="${softTitle}" resizable="false" draggable="true" closable="true" data-options="iconCls:'icon-user'" style="width:640px;height:480px;padding:10px">
        <div style="line-height: 30px;margin: 10px;">
            <h2 style="color: red;" align="center"><%=notice.get("title")%></h2>
            <div><%=notice.get("content")%></div>
        </div>
    </div>
    <%
        }
    %>


    <script type="text/javascript">
        function f_submitForm(){
            var t = $("#loginForm").form("validate");
            if(!t){
                return false;
            }
            $.messager.progress();
            $.ajax({
                type: "POST",
                url: "login!checkLogin.action",
                data: {username:$("#username").val(),pwd:$("#pwd").val(),realname:$("#realname").val(),usertype:$("#usertype").val(),valicode:$("#valicode").val()},
                dataType:"json",
                success: function(json){
                    $.messager.progress("close");
                    if (json.success){
                        location='${ctx}/main/index.jsp';
                    }else{
                        if(json.status=="9"){
                            f_alertError("验证码不正确！");
                        }else{
                            f_alertError("错误的身份证、姓名或者密码！");
                        }
                    }
                }
            });
        }
        function f_clearForm(){
            $('#loginForm').form('clear');
        }
        function f_enter_submit(){
            if(event.keyCode==13){
                f_submitForm();
            }
        }

        /**
         * 弹出注册对话框
         * */
        function f_openRegDialog(){
            $("#regDialog").window(
                    {
                        title:'首次报表 ',
                        width:750,
                        height:580,
                        modal:true,
                        href:"reg.jsp",
                        minimizable:false,
                        maximizable:false,
                        collapsible:false
                    }
            );
        }
        /**
         * 关闭注册对话框
         * */
        function f_closeRegDialog(){
            $("#regDialog").window("close");
        }


        function f_lostPwd(){
            if($("#username").val()=="" || $("#realname").val()==""){
                f_alertError("重置密码时，至少要输入身份证号和姓名！");
                return false;
            }
            $.messager.progress();
            $.ajax({
                type: "POST",
                url: "login!lostPwd.action",
                data: {username:$("#username").val(),realname:$("#realname").val()},
                dataType:"json",
                success: function(json){
                    $.messager.progress("close");
                    if (json.success){
                        f_alert("密码重置成功！请查收邮箱并即时更新密码！");
                    }else{
                        f_alertError("重置失败！请检查你的姓名和身份证是否正确");
                    }
                }
            });
        }

        $(function(){
            $("#usertype").change(function(){
               if($(this).val()==1){
                   $("#realnameTr").css("display","none");
               }else{
                   $("#realnameTr").css("display","");
               }
            });
            $("#loginBtn").click(function(){f_submitForm();});
            $("#regBtn").click(function(){f_openRegDialog();});
            $("#lostBtn").click(function(){f_lostPwd();});
            $("#username").focus();

            var   APPLY_STDATE="<%=DataDao.getConf("APPLY_STDATE")%>";
            var   APPLY_EDDATE="<%=DataDao.getConf("APPLY_EDDATE")%>";
            var nowDate="<%= DateUtil.getNowDateString()%>";

            if(nowDate>=APPLY_STDATE && nowDate<=APPLY_EDDATE){
                $("#regBtn").show();
            }else{
                $("#regBtn").hide();
            }

        })
    </script>

</body>
</html>