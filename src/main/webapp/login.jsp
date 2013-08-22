<%@ page import="com.ggs.dao.DataDao" %>
<%@ page import="com.ggs.util.DateUtil" %>
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
<%--    <div id="msgDiaog" class="easyui-dialog" title="${softTitle}" resizable="false" draggable="true" closable="true" data-options="iconCls:'icon-user'" style="width:600px;height:300px;padding:10px">
        <div style="line-height: 30px;margin: 10px;">
            <h3 style="color: red;" align="center">紧急通知</h3>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;由于报名系统首次投入运行，系统存在小问题，请8月5日上午10点10分前报名的考生登陆系统核查自己的信息，若发现自己信息丢失，请重新报名。给大家带来不便，敬请谅解。
        </div>
        <div align="right" style="margin: 10px;">2013年8月5日</div>
    </div>--%>
    <div id="msgDiaog" class="easyui-dialog" title="${softTitle}" resizable="false" draggable="true" closable="true" data-options="iconCls:'icon-user'" style="width:700px;height:500px;padding:10px">
        <div style="line-height: 30px;margin: 10px;">
            <h3 style="color: red;" align="center">通知</h3>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;为方便考生报名，现决定延长考生提交审核时间。已于本月16日前（含16日）提交报名资料的考生，可在本月23日15点前继续提交报名信息，之后将关闭修改和提交。预审通过的考生可于本月30日前打印报名表，之后将关闭打印。
            <table border="0" cellspacing="1"  bgcolor="#000000" align="center">
                <tr>
                    <td width="114" valign="top" bgcolor="#FFFFFF" >考生属地 </td>
                    <td width="358" valign="top" bgcolor="#FFFFFF" >现场确认地址 </td>
                    <td width="111" valign="top" bgcolor="#FFFFFF" >联系电话 </td>
                </tr>
                <tr>
                    <td width="114" valign="top" bgcolor="#FFFFFF" >福州市考生 </td>
                    <td width="358" valign="top" bgcolor="#FFFFFF" >福州市下杭路118号 <br />
                        福州市食品药品监督管理局二楼会议室&nbsp; </td>
                    <td width="111" valign="top" bgcolor="#FFFFFF" >0591-83258334 </td>
                </tr>
                <tr>
                    <td width="114" valign="top" bgcolor="#FFFFFF" >厦门市考生 </td>
                    <td width="358" valign="top" bgcolor="#FFFFFF" >厦门市政务服务中心（云顶北路842号，BRT穆厝站）3楼D厅17，18号窗口 </td>
                    <td width="111" valign="top" bgcolor="#FFFFFF" >0592-7703957，0592-7703958 </td>
                </tr>
                <tr>
                    <td width="114" valign="top" bgcolor="#FFFFFF" >漳州市考生 </td>
                    <td width="358" valign="top" bgcolor="#FFFFFF" >漳州市芗城区元光北路 <br />
                        漳州市食品药品监管局一楼大厅 </td>
                    <td width="111" valign="top" bgcolor="#FFFFFF" >0596-2960305
                        &nbsp;</td>
                </tr>
                <tr>
                    <td width="114" valign="top" bgcolor="#FFFFFF" >泉州市考生 </td>
                    <td width="358" valign="top" bgcolor="#FFFFFF" >泉州市丰泽区祥远路2号 <br />
                        泉州市食品药品监督管理局十楼会议室 </td>
                    <td width="111" valign="top" bgcolor="#FFFFFF" >0595-22169902
                        &nbsp;</td>
                </tr>
                <tr>
                    <td width="114" valign="top" bgcolor="#FFFFFF" >三明市考生 </td>
                    <td width="358" valign="top" bgcolor="#FFFFFF" >三明市梅列区列东东新二路物资大厦八楼<br />
                        三明市食品药品监督管理局人事教育科&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </td>
                    <td width="111" valign="top" bgcolor="#FFFFFF" >0598-8296958<br />
                    </td>
                </tr>
                <tr>
                    <td width="114" valign="top" bgcolor="#FFFFFF" >莆田市考生 </td>
                    <td width="358" valign="top" bgcolor="#FFFFFF" >莆田市城厢区学园中街1899号 <br />
                        莆田市食品药品监督管理局人事教育科（303室） </td>
                    <td width="111" valign="top" bgcolor="#FFFFFF" >0594&#8212;2685130. </td>
                </tr>
                <tr>
                    <td width="114" valign="top" bgcolor="#FFFFFF" >南平市考生 </td>
                    <td width="358" valign="top" bgcolor="#FFFFFF" >南平市八一路421号 <br />
                        南平市食品药品监督管理局八楼人教科</td>
                    <td width="111" valign="top" bgcolor="#FFFFFF" >0599-8069693
                        &nbsp;</td>
                </tr>
                <tr>
                    <td width="114" valign="top" bgcolor="#FFFFFF" >龙岩市考生 </td>
                    <td width="358" valign="top" bgcolor="#FFFFFF" >龙岩市南环西路36号天马湾大厦15楼 <br />
                        龙岩市食品药品监督管理局人教科&nbsp; </td>
                    <td width="111" valign="top" bgcolor="#FFFFFF" >0597-3398382 </td>
                </tr>
                <tr>
                    <td width="114" valign="top" bgcolor="#FFFFFF" >宁德市考生 </td>
                    <td width="358" valign="top" bgcolor="#FFFFFF" >宁德市鹤峰路43号 <br />
                        宁德市食品药品监督管理局六楼人教科 </td>
                    <td width="111" valign="top" bgcolor="#FFFFFF" >0593-2805851 </td>
                </tr>
            </table>
        </div>
        <div align="right" style="margin: 10px;">2013年8月20日</div>
    </div>

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