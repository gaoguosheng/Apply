<%--
  Created by IntelliJ IDEA.
  User: GGS
  Date: 13-5-10
  Time: 上午9:43
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.ggs.util.DBUtil" %>
<%@ page import="com.wabacus.util.DesEncryptTools" %>
<%@ page import="com.google.gson.GsonBuilder" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%
    if(request.getParameter("updatePwd")!=null){
        String user_id = (String)session.getAttribute("user_id");
        DBUtil dbUtil = new DBUtil();
        String oldpassword=request.getParameter("oldpassword");
        String password = request.getParameter("password");
        int isRight= dbUtil.queryForInt("select count(*) from t_user where id=? and pwd=?",user_id,DesEncryptTools.encrypt(oldpassword));
        int status=0;
        if(isRight>0){
            int counter = dbUtil.update("update t_user set pwd=? where id=?",DesEncryptTools.encrypt(password),user_id);
            if(counter>0){
                status=1;
            }else{
                status=0;
            }
        }else{
            status=2;
        }
        Map json = new HashMap();
        json.put("status",status);
        String jsonstr = new GsonBuilder().create().toJson(json);
        out.print(jsonstr);
        return;
    }
%>
    <form id="pwdForm">
        <table align="center" width="400" border="0"  cellpadding="5">
            <tr>
                <td align="right" width="30%">旧密码：</td>
                <td width="70%"><input type="password" name="oldpassword" id="oldpassword" class="easyui-validatebox" required="required" style="width: 180px;"></td>
            </tr>
            <tr>
                <td align="right" width="30%">新密码：</td>
                <td width="70%"><input type="password" name="password" id="password" class="easyui-validatebox" required="required" style="width: 180px;"></td>
            </tr>
            <tr>
                <td align="right">密码确认：</td>
                <td><input type="password" name="password2" id="password2" class="easyui-validatebox" required="required" validType="equals['#password']" style="width: 180px;"></td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>
                    <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="f_submitForm();">确定</a>
                    <a href="#" onclick="f_closePwdDialog();" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
                </td>
            </tr>
        </table>
    </form>
    <script type="text/javascript">
        // extend the 'equals' rule
        $.extend($.fn.validatebox.defaults.rules, {
            equals: {
                validator: function(value,param){
                    return value == $(param[0]).val();
                },
                message: '该输入项不能匹配.'
            }
        });
        function f_submitForm(){
            $.ajax({
                type: "POST",
                async: false,
                url: "pwd.jsp?updatePwd=1",
                data:{oldpassword:$("#oldpassword").val(),password:$("#password").val()},
                dataType:"json",
                success: function(json){
                    if (json.status==1){
                        f_alert("修改密码成功！",function(){f_closePwdDialog();});
                    }else if(json.status==2){
                        f_alertError("旧密码不正确！");
                    }else{
                        f_alertError("密码修改失败！");
                    }
                }
            });
        }
    </script>