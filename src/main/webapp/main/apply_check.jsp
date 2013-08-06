<%@ page import="java.util.List" %>
<%@ page import="com.ggs.dao.DataDao" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.ggs.dao.ApplyDao" %>
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
    //当前状态
    int status = applyDao.getApplyStatus(id);
    //下个审核状态
    //不通过状态
    int unsuccStatus=0;
    //通过状态
    int succStatus=1;
    switch (status){
        case 0:
          unsuccStatus=10;
            succStatus=11;
            break;
        case 11:
            unsuccStatus=20;
            succStatus=21;
            break;
        case 21:
            unsuccStatus=30;
            succStatus=31;
            break;
    }

%>
    <iframe src="<%=request.getContextPath()%>/ShowReport.wx?PAGEID=t_apply_list_detail&id=${param.id}" frameborder="0" width="100%" height="400px" scrolling="yes"></iframe>
    <div align="center">
            <input  id="applyid" name="applyid" type="hidden" value="${param.id}">
            <button  class="cls-button2" onclick="f_submit(<%=succStatus%>);">通过</button>
            <button class="cls-button2" onclick="f_noOperate();">不通过</button>
            <button class="cls-button2" onclick="f_thaw();">解冻</button>
            <button id="cancelBtn" class="cls-button2" onclick="f_close()">取消</button>
            <div id="no_div" style="display: none;">
                <table>
                    <tr>
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
                    </tr>
                    <tr>
                        <td align="right">具体内容：</td>
                        <td><textarea id="cause" name="cause"  style="width: 600px;height:80px;"></textarea></td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td><button class="cls-button2" onclick="f_submit(<%=unsuccStatus%>);">确定</button></td>
                    </tr>
                </table>
            </div>


    </div>
    <script type="text/javascript">

        var parent_url="<%=request.getContextPath()%>/ShowReport.wx?PAGEID=t_apply_check&status=<%=status%>";

        function f_close(){
            <%
            if(request.getParameter("d")!=null){
            %>
            location='<%=request.getContextPath()%>/main/main.jsp';
            <%
            }else{
               %>
              art.dialog.close();
            <%
            }
            %>

        }

        function f_thaw(){
            if(confirm("解冻后考生可继教修改报名信息，是否确认要解冻？")){
                $.ajax({
                    type: "POST",
                    url: "<%=request.getContextPath()%>/main/apply!thaw.action",
                    async: false,
                    data:{applyid:$("#applyid").val()},
                    dataType:"json",
                    success: function(json){
                        if(json.success){
                            alert('解冻成功');
                            artDialog.open.origin.refreshComponent(parent_url);
                        }else{
                            alert("解冻失败");
                        }
                    }
                });
                f_close();
            }
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
            if(status_str=="0"){
                //不通过要填写理由内容
                if($.trim($("#cause").val())==""){
                    alert("必须填写不通过理由！");
                    return false;
                }
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
