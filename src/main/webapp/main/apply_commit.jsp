<%--
  Created by IntelliJ IDEA.
  User: GGS
  Date: 13-7-29
  Time: 下午1:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

    <script type="text/javascript">
        function f_applyCommit(){
            if(confirm("提交后报名信息将不能修改，是否确认提交?")){
                $.ajax({
                    type: "POST",
                    url: "<%=request.getContextPath()%>/main/apply!applyCommit.action",
                    async: false,
                    data:{applyid:"${param.id}"},
                    dataType:"json",
                    success: function(json){
                        if(json.success){
                            alert('提交成功');
                            artDialog.open.origin.refreshComponent("<%=request.getContextPath()%>/ShowReport.wx?PAGEID=t_apply_write");
                        }else{
                            alert("提交失败");
                        }
                    }
                });
                art.dialog.close();
            }
        }
    </script>
    <div align="center">
        <button class="cls-button2" onclick="f_applyCommit();">提交</button>
    </div>
