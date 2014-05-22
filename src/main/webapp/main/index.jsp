<%@ page import="com.ggs.dao.ApplyDao" %>
<%--
  Created by IntelliJ IDEA.
  User: ggs
  Date: 13-5-9
  Time: 下午8:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@include file="/inc/lib.jsp"%>
    <title>${softName}</title>
    <script type="text/javascript">
        /***
         退出
         *
         */
        function f_logout(){
            f_confirm("是否确认退出?",function(){location.href = 'logout.jsp';});
        }


        function f_loadMenu(){
            var setting = {
                data: {
                    simpleData: {
                        enable: true
                    }
                },
                callback: {
                    onClick: function(event, treeId, treeNode, clickFlag){
                        if(!treeNode.isParent && treeNode.uri){
                            $("#mainFrame").attr("src","${ctx}/"+treeNode.uri);
                        }

                    }
                }
            };
            var menuDiv =$("#menuDiv");
            var nodes = <%=new ApplyDao().getMenuJson((String)session.getAttribute("user_id"))%>;
            var childNodes = new Array();
            for(var i=0;i<nodes.length;i++){
                if(nodes[i].pId==0){
                    childNodes.length=0;
                    var div  = document.createElement("div");
                    $(div).attr("title",nodes[i].name);
                    $(div).html('<ul id="tree_'+nodes[i].id+'" class="ztree"></ul>');
                    $(menuDiv).append(div);
                    f_getChildNodes(nodes[i].id);
                    $.fn.zTree.init($("#tree_"+nodes[i].id), setting, childNodes);
                }
            }
            function f_getChildNodes(id){
                for(var i=0;i<nodes.length;i++){
                    if(nodes[i].pId==id){
                        childNodes[childNodes.length]=nodes[i];
                        f_getChildNodes(nodes[i].id);
                    }
                }
            }
        }

        function f_onResize(width,height){
            $('#menuDiv').accordion({width:width-8});
        }

        /**
         * 弹出修改密码对话框
         * */
        function f_showPwdDialog(){
            $("#passwordDialog").window(
                    {
                        title:'修改密码',
                        width:450,
                        height:220,
                        modal:true,
                        href:"pwd.jsp",
                        minimizable:false,
                        maximizable:false,
                        collapsible:false
                    }
            );
        }
        /**
         * 关闭密码对话框
         * */
        function f_closePwdDialog(){
            $("#passwordDialog").window("close");
        }



        /**
         * 关闭修改资料对话框
         * */
        function f_closeModifyUserDialog(){
            $("#modifyUserDialog").window("close");
        }

        /**
         * 弹出修改资料对话框
         * */
        function f_showModifyUserDialog(){
            $("#modifyUserDialog").window(
                    {
                        title:'修改资料',
                        width:600,
                        height:450,
                        modal:true,
                        href:"modify_user.jsp",
                        minimizable:false,
                        maximizable:false,
                        collapsible:false
                    }
            );
        }

        $(function(){
            f_tips("欢迎使用${softName}");
        })
    </script>
</head>
<body>
    <div class="easyui-layout" style="width:100%;height:100%;padding: 0px;margin: 0px;">
        <div data-options="region:'north',border:true" class="header-bg" style="height: 28px;">
            <div>
                <div style="float: left;margin: 5px;"><b style="font-size: 12pt;color:darkblue">${softName}</b></div>
                <div align="right" style="margin-right: 20px;">
                    <img src="${ctx}/img/home.png">  <a href="main.jsp" target="mainFrame" class="easyui-linkbutton"  data-options="plain:true">桌面</a>
                    <img src="${ctx}/img/user_friend.png">  <a href="#" class="easyui-linkbutton"  data-options="plain:true">${sessionScope.admin.realname}</a>
                    <a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-edit'" onclick="f_showPwdDialog();">修改密码</a>
                    <a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-edit'" onclick="f_showModifyUserDialog();">修改资料</a>
                    <img src="${ctx}/img/information.png"> <a href="#" class="easyui-linkbutton" data-options="plain:true">消息(0)</a>
                    <img src="${ctx}/img/arrow_right.png"> <a href="#" class="easyui-linkbutton" data-options="plain:true" onclick="f_logout();">退出系统</a>
                </div>
            </div>
        </div>
        <div data-options="region:'west',split:true,border:false,onResize:f_onResize" title="功能菜单" style="width:200px;height: 100%;">
            <div id="menuDiv" class="easyui-accordion" align="center" data-options="animate:false"></div>
            <script type="text/javascript">f_loadMenu();</script>
        </div>
        <div data-options="region:'center',border:false">
            <iframe id="mainFrame" name="mainFrame" width="100%" height="100%" frameborder="0" src="main.jsp"></iframe>
         </div>
        </div>

        <div id="passwordDialog"></div>
        <div id="modifyUserDialog"></div>
    </div>

</body>
</html>