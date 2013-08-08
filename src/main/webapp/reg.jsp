
<%--
  Created by IntelliJ IDEA.
  User: GGS
  Date: 13-5-10
  Time: 上午9:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <div align="right" style="margin: 5px;"> 注册步骤：1.声明确认 - 2.填写基本信息 - 3.注册成功</div>
    <div id="firstDiv" align="center">
         <h3 style="margin: 10px;">1. 声明确认</h3>
        <textarea name="textarea"  wrap="VIRTUAL" readonly style="padding-top:15px;
        font-size:14px;width: 90%;height: 350px;line-height: 30px;">&nbsp;&nbsp;&nbsp;&nbsp;本人郑重承诺：本人报名填写的所有信息均准确、真实、有效，并自觉遵守本报名系统的相关规定和要求。如有弄虚作假和违规行为，本人将承担相应的责任和由此造成的一切后果。
        </textarea>

         <div style="color:#CC3300;margin: 10px;">点击接受，表示您已阅读并同意遵守承诺。</div>


        <a id="accBtn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">我接受</a>
        <a id="nAccBtn" href="#"  class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">不接受</a>

    </div>
    <div id="secondDiv" style="display: none;" align="center">
        <h3 style="margin: 10px;">2. 填写基本信息</h3>
        <div style="margin-left: 20px;text-align: left">以下*号为必填项</div>
        <form id="regForm" method="post">
            <input type="hidden" name="task" id="task">
            <table align="center" width="100%" border="0"  cellpadding="5">
                <tr>
                    <td align="right" width="30%">* 姓名：</td>
                    <td width="70%"><input type="text" name="realname" id="r_realname" class="easyui-validatebox" required="required" validType="length[2,4]" style="width: 180px;"></td>
                </tr>
                <tr>
                    <td align="right" >* 性别：</td>
                    <td >
                        <input type="radio" name="sex" id="sexMan" class="easyui-validatebox" value="男" checked="checked"/>男
                        <input type="radio" name="sex" id="sexWoman" class="easyui-validatebox" value="女"/>女
                    </td>
                </tr>
                <tr>
                    <td align="right" >* 工作所在地：</td>
                    <td >
                        <select name="provid" id="provid" required="required"></select>&nbsp;&nbsp; &nbsp;&nbsp;
                        <select name="cityid" id="cityid" required="required" ></select>&nbsp;&nbsp; &nbsp;&nbsp;
                        <select name="areaid" id="areaid" required="required" ></select>
                    </td>
                </tr>
                <tr>
                    <td align="right">* 身份证号码：</td>
                    <td ><input type="text" name="username" id="r_username" class="easyui-validatebox" required="required" validType="length[15,18]" style="width: 180px;"></td>
                </tr>
                <tr>
                    <td align="right">* 登录密码：</td>
                    <td ><input type="password" name="pwd" id="r_password" class="easyui-validatebox" required="required" validType="length[6,10]" style="width: 180px;"></td>
                </tr>
                <tr>
                    <td align="right">* 密码确认：</td>
                    <td><input type="password" name="password2" id="r_password2" class="easyui-validatebox" required="required" validType="equals['#r_password']" style="width: 180px;"></td>
                </tr>
                <tr>
                    <td align="right" >*手机(接收短信用)：</td>
                    <td ><input type="text" name="phone" id="phone" class="easyui-validatebox" required="required" validType="cellPhone['请输入有效的11位数字手机号']"  style="width: 180px;"></td>
                </tr>
                <tr>
                    <td align="right">*邮箱(重置密码用)：</td>
                    <td ><input type="text" name="email" id="email" class="easyui-validatebox" required="required" validType="email"  style="width: 180px;"></td>
                </tr>
                <tr>
                    <td align="right">QQ：</td>
                    <td ><input type="text" name="qq" id="qq" class="easyui-validatebox"  style="width: 180px;"></td>
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
                        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="f_reg();">确定</a>
                        <a href="#" onclick="f_closeRegDialog();" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <script type="text/javascript">
        // 比较两次密码
        $.extend($.fn.validatebox.defaults.rules, {
            equals: {
                validator: function(value,param){
                    return value == $(param[0]).val();
                },
                message: '两次密码不一样'
            }
        });
        //手机号
        $.extend($.fn.validatebox.defaults.rules,{
            cellPhone: {
                validator: function(value, param){
                    return /^0{0,1}(1[3-9])[0-9]{9}$/.test(value);
                },
                message: '{0}'
            }
        });

        //我接受
        function f_accept(){
            $("#firstDiv").hide();
            $("#secondDiv").show();
        }
        //不接受
        function f_notAccept(){
            f_closeRegDialog();
        }

        function f_reg(){
            $("#task").val("saveStudent");
            $("#r_realname").val($.trim($("#r_realname").val()));
            $("#r_username").val($.trim($("#r_username").val()));
            var t = $("#regForm").form("validate");
            if(!t){
                return false;
            }
            if(f_checkUserName()){
                $("#regForm").form("submit",{
                    url:'login!reg.action',
                    success:function(msg){
                        var json =eval("("+msg+")");
                        if(json.success){
                            f_alert("注册成功！",function(){
                                location='login.jsp';
                            });


                        }else if(json.success==false && json.status=="0"){
                            f_alertError("注册失败！");
                        }else if(json.success==false && json.status=="9"){
                            f_alertError("验证码错误！");
                        }

                    }}) ;
            }
        }
        function f_checkUserName(){
            var t=false;
            $.ajax({
                type: "POST",
                async:false,
                url: "login!checkUserExist.action",
                data: {username:$("#r_username").val()},
                dataType:"json",
                success: function(json){
                    if(json.success){
                        t=false;
                        f_alertError("对不起，该身份证已存在，请认真核对您的身份证号码");
                    }else{
                        t=true;
                    }
                }
            });
            return t;
        }
        function f_getProvList(){
            $.ajax({
                type:"POST",
                url:"data!getProvList.action",
                dataType:"json",
                success:function(json){
                    $("#provid").empty();
                    for(var i=0;i<json.length;i++){
                        $("#provid").append("<option value='"+json[i].id+"'>"+json[i].name+"</option>");
                    }
                    f_getCityList( ($("#provid")[0].value));
                }
            });
        }
        function f_getCityList(pid){
            $.ajax({
                type:"POST",
                url:"data!getCityList.action",
                data:{pid:pid},
                dataType:"json",
                success:function(json){
                    $("#cityid").empty();
                    for(var i=0;i<json.length;i++){
                        $("#cityid").append("<option value='"+json[i].id+"'>"+json[i].name+"</option>");
                    }
                    f_getAreaList( ($("#cityid")[0].value));
                }
            });
        }
        function f_getAreaList(pid){
            $.ajax({
                type:"POST",
                url:"data!getAreaList.action",
                data:{pid:pid},
                dataType:"json",
                success:function(json){
                    $("#areaid").empty();
                    for(var i=0;i<json.length;i++){
                        $("#areaid").append("<option value='"+json[i].id+"'>"+json[i].name+"</option>");
                    }

                }
            });
        }
        $(function(){
            $('#qq').numberbox({
                min:0,
                precision:0
            });
            f_getProvList();
            $("#provid").change(function(){
               f_getCityList($(this).val());
            });
            $("#cityid").change(function(){
                f_getAreaList($(this).val());
            });
            $("#accBtn").click(f_accept);
            $("#nAccBtn").click(f_notAccept);
            $("#r_username").blur(f_checkUserName);
            window.setTimeout(function(){
                $(".easyui-validatebox").unbind("focus");
            },500);

        })


    </script>