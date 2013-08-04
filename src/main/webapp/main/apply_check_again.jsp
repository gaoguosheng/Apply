<%@ page import="java.util.List" %>
<%@ page import="com.ggs.dao.DataDao" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.ggs.dao.ApplyDao" %>
<%@ page import="com.ggs.bean.User" %>
<%--
  Created by IntelliJ IDEA.
  User: GGS
  Date: 13-7-27
  Time: 下午3:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String id =request.getParameter("id");
    ApplyDao applyDao = new ApplyDao();
    User admin = (User)session.getAttribute("admin");
    //当前状态
    int status = applyDao.getApplyStatus(id);
    //判断是否有权限操作此报名表
    //boolean ischeck = applyDao.checkApplyPerm(admin.getId(),id);
    //System.out.println(status);
    //下个审核状态
    //通过状态
    int succStatus=status+1;


%>
<%
    if (status % 2 ==0 ){
        //不通过


%>
<iframe src="<%=request.getContextPath()%>/ShowReport.wx?PAGEID=t_apply_list_detail&id=${param.id}" frameborder="0" width="100%" height="400px" scrolling="yes"></iframe>
<div align="center">
    <input  id="applyid" name="applyid" type="hidden" value="${param.id}">
    <button  class="cls-button2" onclick="f_noOperate();">通过</button>
    <button id="cancelBtn" class="cls-button2" onclick="f_close()">取消</button>
    <div id="no_div" style="display: none;">
        <table>
            <%--<tr>
                <td align="right">理由类型：</td>
                <td><select id="causetype" name="causetype">
                    <%
                        List<Map<String,String>> itemList  = DataDao.getDataList("NotReason");
                        for(Map<String,String>item:itemList){
                            out.print("<option value='"+item.get("id")+"'>"+item.get("name")+"</option>");
                        }
                    %>
                </select>
                </td>
            </tr>--%>
            <tr>
                <td align="right">填写理由：</td>
                <td><textarea id="cause" name="cause"  style="width: 300px;"></textarea></td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td><button class="cls-button2" onclick="f_submit(<%=succStatus%>);">确定</button></td>
            </tr>
        </table>
    </div>

</div>
<script type="text/javascript">

    var parent_url="<%=request.getContextPath()%>/ShowReport.wx?PAGEID=t_apply_check_query&status=<%=status%>";

    function f_close(){
        art.dialog.close();
    }

    function f_noOperate(){
        if($("#no_div").css("display")=="none"){
            $("#no_div").show();
        }else{
            $("#no_div").hide();
        }
    }

    function f_submit(status){
        var status_str  = new String(status);
        status_str=status_str.substr(1,1);
        if($.trim($("#cause").val())==""){
            alert("必须填写通过理由！");
            return false;
        }
        if(confirm("是否确认提交审核结果？")){
            $.ajax({
                type: "POST",
                url: "<%=request.getContextPath()%>/main/apply!applyCheck.action",
                async: false,
                data:{applyid:$("#applyid").val(),status:status,cause:$("#cause").val(),causetype:$("#causetype").val()},
                dataType:"json",
                success: function(json){
                    if(json.success){
                        alert('审核成功');
                        artDialog.open.origin.refreshComponent(parent_url);
                    }else{
                        alert("审核失败");
                    }
                }
            });
            f_close();
        }
    }
</script>


<%
    }
%>

