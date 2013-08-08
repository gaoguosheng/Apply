
<%--
  Created by IntelliJ IDEA.
  User: GGS
  Date: 13-5-10
  Time: 上午9:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
        <h3 style="margin: 10px;">修改资料</h3>
        <div style="margin-left: 20px;text-align: left">报名表提交后，工作所在地不允许更改。以下*号为必填项</div>
        <form id="regForm" method="post">
            <input type="hidden" name="task" id="task">
            <table align="center" width="100%" border="0"  cellpadding="5">
                <tr>
                    <td align="right" width="30%">* 姓名：</td>
                    <td width="70%">${admin.realname}</td>
                </tr>
                <tr>
                    <td align="right" >* 性别：</td>
                    <td >
                        ${admin.sex}
                    </td>
                </tr>
                <tr>
                    <td align="right" >* 工作所在地：</td>
                    <td >
                        <select name="provid" id="provid" required="required"></select>&nbsp;&nbsp;&nbsp;&nbsp;
                        <select name="cityid" id="cityid" required="required" ></select>&nbsp;&nbsp;&nbsp;&nbsp;
                        <select name="areaid" id="areaid" required="required" ></select>
                    </td>
                </tr>
                <tr>
                    <td align="right">* 身份证：</td>
                    <td >${admin.username}
                        <input type="hidden" name="username" value="${admin.username}">
                    </td>
                </tr>
                <tr>
                    <td align="right" >*手机(接收短信用)：</td>
                    <td ><input type="text" name="phone" id="phone" value="${admin.phone}" class="easyui-validatebox" required="required" validType="cellPhone['请输入有效的11位数字手机号']"  style="width: 180px;"></td>
                </tr>
                <tr>
                    <td align="right">*邮箱(重置密码用)：</td>
                    <td ><input type="text" name="email" id="email" value="${admin.email}" class="easyui-validatebox" required="required" validType="email"  style="width: 180px;"></td>
                </tr>
                <tr>
                    <td align="right">QQ：</td>
                    <td ><input type="text" name="qq" id="qq" value="${admin.qq}" class="easyui-validatebox"  style="width: 180px;"></td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>
                        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="f_modify_submit();">确定</a>
                        <a href="#" onclick="f_closeModifyUserDialog();" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
                    </td>
                </tr>
            </table>
        </form>

    <script type="text/javascript">

        //手机号
        $.extend($.fn.validatebox.defaults.rules,{
            cellPhone: {
                validator: function(value, param){
                    return /^0{0,1}(1[3-9])[0-9]{9}$/.test(value);
                },
                message: '{0}'
            }
        });

       function f_modify_submit(){
            var t = $("#regForm").form("validate");
            if(!t){
                return false;
            }
           $("#provid").attr("disabled",false);
           $("#cityid").attr("disabled",false);
           $("#areaid").attr("disabled",false);
            $("#regForm").form("submit",{
                url:'main!modifyUser.action',
                success:function(msg){
                    var json =eval("("+msg+")");
                    if(json.success){
                        f_alert("修改成功！");
                        f_closeModifyUserDialog();
                    }else{
                        f_alertError("修改失败！");
                    }

                }}) ;
        }

        function f_getProvList(){
            $.ajax({
                type:"POST",
                url:"${ctx}/data!getProvList.action",
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
                url:"${ctx}/data!getCityList.action",
                data:{pid:pid},
                dataType:"json",
                success:function(json){
                    $("#cityid").empty();
                    for(var i=0;i<json.length;i++){
                        $("#cityid").append("<option value='"+json[i].id+"'>"+json[i].name+"</option>");
                    }
                    $("#cityid").val("${admin.cityid}");
                    f_getAreaList( ($("#cityid").val()));
                }
            });
        }
        function f_getAreaList(pid){
            $.ajax({
                type:"POST",
                url:"${ctx}/data!getAreaList.action",
                data:{pid:pid},
                dataType:"json",
                success:function(json){
                    $("#areaid").empty();
                    for(var i=0;i<json.length;i++){
                        $("#areaid").append("<option value='"+json[i].id+"'>"+json[i].name+"</option>");
                    }
                    $("#areaid").val("${admin.areaid}");
                }
            });
        }

        function f_checkApplyCommit(){
            $.ajax({
                type:"POST",
                url:"main!checkApplyCommit.action",
                dataType:"json",
                success:function(json){
                    if(json.success){
                        $("#provid").attr("disabled",true);
                        $("#cityid").attr("disabled",true);
                        $("#areaid").attr("disabled",true);
                    }else{
                        $("#provid").attr("disabled",false);
                        $("#cityid").attr("disabled",false);
                        $("#areaid").attr("disabled",false);
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
            window.setTimeout(f_checkApplyCommit,300);
        })

    </script>