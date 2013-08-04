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
    <title>后台管理 - ${softName}</title>
</head>
<body style="background-color: lightgray">
    <div class="easyui-dialog" title="${softTitle}" resizable="false" draggable="false" closable="false" data-options="iconCls:'icon-user'" style="width:650px;height:330px;padding:10px">
        <div align="center" style="font-size: 16pt;font-weight: bold;">${softName}管理平台</div>
        <br/>
        <form id="loginForm" method="post">
            <table align="center" width="100%" border="0"  cellpadding="5" class="normalFont">
                <tr>
                    <td width="200px"  align="center"><img src="${ctx}/img/logo.jpg"></td>
                    <td valign="top">
                        <table align="center" width="100%" border="0"  cellpadding="5" class="normalFont">
                            <input type="hidden" id="usertype" name="usertype" value="1">
                            <tr>
                                <td align="right">帐号：</td>
                                <td><input type="text" name="username" id="username" required="required" class="easyui-validatebox"  style="width: 180px;" onkeydown="if(event.keyCode==13)$('#pwd').focus();"></td>
                            </tr>
                            <tr>
                                <td align="right">密码：</td>
                                <td><input type="password" name="pwd" id="pwd" required="required" class="easyui-validatebox" style="width: 180px;" onkeydown="if(event.keyCode==13)$('#valicode').focus();"></td>
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
                                    <a onclick="f_clearForm();" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-help'">重置</a>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </form>
        <div  align="center">
            <span  class="normalFont">Copyright © 2002 - 2013 . All Rights Reserved</span>
        </div>
    </div>
    <div id="regDialog"></div>

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
                            f_alertError("用户名或者密码不正确！");
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




        $(function(){

            $("#loginBtn").click(function(){f_submitForm();});
            $("#username").focus();



        })
    </script>

</body>
</html>