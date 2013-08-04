<%@ page import="com.ggs.dao.ApplyDao" %>
<%--
  Created by IntelliJ IDEA.
  User: ggs
  Date: 13-7-2
  Time: 下午2:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if(request.getParameter("getRoleMenu")!=null){
        String roleid=request.getParameter("roleid");
        if(roleid!=null){
            String json = new ApplyDao().getMenuList(roleid);
            out.print(json);
            return;
        }
    }

    if(request.getParameter("save")!=null){
        String roleid=request.getParameter("roleid");
        String menuidstr =request.getParameter("menuidstr");
        String[]menuid =menuidstr.split(",");
        new ApplyDao().saveRoleMenu(roleid,menuid);
    }
%>
<html>
<head>
    <%@include file="/inc/lib.jsp"%>
    <script type="text/javascript">
        var roleNodes = <%=new ApplyDao().getRoleListJson()%>;
        function f_getRoleid(){
            var treeObj = $.fn.zTree.getZTreeObj("roleTree");
            var nodes = treeObj.getSelectedNodes();
            if(nodes.length>0){
                return nodes[0].id;
            }
        }
        $(function(){
            $.fn.zTree.init($("#roleTree"), {
                view: {
                    selectedMulti: false
                },
                data: {
                    simpleData: {
                        enable: true
                    }
                } ,
                callback: {
                    onClick: function(event, treeId, treeNode){
                        var menuNodes;
                        $.ajax({
                            type: "POST",
                            async: false,
                            url: "rolemenu.jsp?getRoleMenu=1",
                            data:{roleid:treeNode.id},
                            dataType:"json",
                            success: function(json){
                                menuNodes=json;
                            }
                        });
                        $.fn.zTree.init($("#menuTree"), {
                            view: {
                                selectedMulti: true
                            },
                            check: {
                                enable: true
                            },
                            data: {
                                simpleData: {
                                    enable: true
                                }
                            }
                        }, menuNodes);
                    }
                }
            }, roleNodes);

            $("#menuTreeDiv").css("height",screen.availHeight-300);
            $("#roleTreeDiv").css("height",screen.availHeight-300);
            $("#saveRoleButton").click(function(){
                var treeObj = $.fn.zTree.getZTreeObj("menuTree");
                var nodes = treeObj.getCheckedNodes(true);
                if(nodes.length==0){
                    f_alert("至少勾选一个权限菜单！");
                    return false;
                }
                var menuidstr = "";
                for(var i=0;i<nodes.length;i++){
                    menuidstr+=nodes[i].id;
                    if(i<nodes.length-1)
                    menuidstr+=",";
                }
                $.ajax({
                    type: "POST",
                    url: "rolemenu.jsp?save=1",
                    data:{roleid:f_getRoleid(),menuidstr:menuidstr},
                    success: function(msg){
                        f_alert("保存成功");
                    }
                });
            });
        });
    </script>
</head>
<body>
    <table width="50%" cellpadding="5">
        <tr>
            <td colspan="2" align="right"><a id="saveRoleButton" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a></td>
        </tr>
        <tr>
            <td width="40%" valign="top">
                <div>角色</div>
                <div id="roleTreeDiv" class="zTreeDemoBackground left" style="overflow: auto;border:#BDDFFF solid 1px;">
                    <ul id="roleTree" class="ztree"></ul>
                </div>
            </td>
            <td width="60%" valign="top">
                <div>功能权限</div>
                <div id="menuTreeDiv" class="zTreeDemoBackground left" style="overflow: auto;border:#BDDFFF solid 1px;">
                    <ul id="menuTree" class="ztree"></ul>
                </div>
            </td>
        </tr>
    </table>
</body>
</html>
