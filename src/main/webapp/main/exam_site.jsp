<%@ page import="com.ggs.dao.ApplyDao" %>
<%@ page import="com.ggs.dao.DataDao" %>
<%@ page import="java.util.List" %>
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

        var siteNodes=f_getNodes("apply!getExamSiteList.action");
        var cityNodes=f_getNodes("apply!getCityList.action");

        function f_getSelectedId(treeid){
            var treeObj = $.fn.zTree.getZTreeObj(treeid);
            var nodes = treeObj.getSelectedNodes();
            return nodes;
        }

        function f_getNodes(url){
            var nodes ;
            $.ajax({
                type: "POST",
                async: false,
                url: url,
                data:{},
                dataType:"json",
                success: function(json){
                    nodes=json;
                }
            });
            return nodes;
        }


        $(function(){
            $.fn.zTree.init($("#siteTree"), {
                view: {
                    selectedMulti: false
                },
                data: {
                    simpleData: {
                        enable: true
                    }
                },callback: {
                    onClick: function(event, treeId, treeNode){
                        var checkNodes = f_getNodes("apply!getSiteCitysBySiteid.action?siteid="+treeNode.id);
                        var treeObj = $.fn.zTree.getZTreeObj("cityTree");
                        var nodes = treeObj.getNodes();
                        treeObj.checkAllNodes(false);
                        for(var i=0;i<nodes.length;i++){
                            for(var j=0;j<checkNodes.length;j++){
                                if(nodes[i].id==checkNodes[j].cityid){
                                    treeObj.checkNode(nodes[i], true, true);
                                }
                            }

                        }
                    }
                }
            }, siteNodes);

            $.fn.zTree.init($("#cityTree"), {
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
            }, cityNodes);



            $("#saveButton").click(function(){
                var  siteid = f_getSelectedId("siteTree")[0];
                if(!siteid){
                    f_alert("请选择一个考场！");
                    return false;
                }
                siteid=siteid.id;
                var treeObj = $.fn.zTree.getZTreeObj("cityTree");
                var nodes = treeObj.getCheckedNodes(true);
                if(nodes.length==0){
                    f_alert("至少勾选一个地市！");
                    return false;
                }
                var cityids = "";
                for(var i=0;i<nodes.length;i++){
                    cityids+=nodes[i].id;
                    if(i<nodes.length-1)
                        cityids+=",";
                }

                $.ajax({
                    type: "POST",
                    url: "apply!saveSiteCitys.action",
                    data:{siteid:siteid,cityids:cityids},
                    success: function(msg){
                        f_alert("保存成功");
                    }
                });
            });


            $("#siteTree").css("height",screen.availHeight-400);
            $("#cityTree").css("height",screen.availHeight-400);
        });



    </script>
</head>
<body>
    <table cellpadding="5">
        <tr>
            <td width="200" valign="top">
                <div>考场：</div>
                <div id="siteTreeDiv" class="zTreeDemoBackground left" style="overflow: auto;border:#BDDFFF solid 1px;">
                    <ul id="siteTree" class="ztree"></ul>
                </div>
            </td>
            <td width="200"  valign="top">
                <div>地市：</div>
                <div id="cityTreeDiv" class="zTreeDemoBackground left" style="overflow: auto;border:#BDDFFF solid 1px;">
                    <ul id="cityTree" class="ztree"></ul>
                </div>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <a id="saveButton" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a>
            </td>
        </tr>
    </table>
</body>
</html>
