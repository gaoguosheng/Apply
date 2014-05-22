<%@ page import="com.ggs.dao.ApplyDao" %>
<%--
  Created by IntelliJ IDEA.
  User: ggs
  Date: 13-7-2
  Time: 下午2:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@include file="/inc/lib.jsp"%>
    <script type="text/javascript">
        var menuNodes =<%=new ApplyDao().getMenuList()%>;
        var setting = {
            view: {
                selectedMulti: false
            },
            data: {
                simpleData: {
                    enable: true
                }
            },
            callback: {
                onClick:function(event, treeId, treeNode){
                    var url="${ctx}/ShowReport.wx?PAGEID=t_menu_list&id="+treeNode.id+"&pid="+treeNode.id;
                            $("#menuFrame").attr("src",url);
                }

            }
        };
        $(function(){
            $.fn.zTree.init($("#menuTree"), setting, menuNodes);
            $("#menuTreeDiv").css("height",screen.availHeight-250);
        });
    </script>
</head>
<body>
    <table width="100%" cellpadding="5">
        <tr>
            <td width="200px" valign="top">
                <div id="menuTreeDiv" class="zTreeDemoBackground left" style="overflow: auto;border: #BDDFFF solid 1px;">
                <ul id="menuTree" class="ztree"></ul>
                </div>
            </td>
            <td valign="top">
                 <iframe id="menuFrame" src="" frameborder="0" width="100%" onload="this.height=screen.availHeight-250;"></iframe>
            </td>
        </tr>
    </table>
</body>
</html>
