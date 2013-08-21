<%@ page import="com.ggs.util.DateUtil" %>
<%@ page import="com.ggs.bean.User" %>
<%--
  Created by IntelliJ IDEA.
  User: ggs
  Date: 13-5-9
  Time: 下午9:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    User admin =(User) session.getAttribute("admin");
    if(admin.getUsertype().equals("1")){
        response.sendRedirect("admin.jsp");
    }
%>
<html>
<head>
    <%@include file="/inc/lib.jsp"%>
    <title>${softName}</title>
    <style type="text/css">
        .title{
            font-size:16px;
            font-weight:bold;
            padding:20px 10px;
            background:#eee;
            overflow:hidden;
            border-bottom:1px solid #ccc;
        }
        .t-list{
            padding:5px;
        }


        .btn1_mouseout {
            margin: 5px;
            width:150px;
            height:80px;
            BORDER-RIGHT: #7EBF4F 1px solid; PADDING-RIGHT: 2px; BORDER-TOP: #7EBF4F 1px solid; PADDING-LEFT: 2px; FONT-SIZE: 14px; FILTER: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#ffffff, EndColorStr=#B3D997); BORDER-LEFT: #7EBF4F 1px solid; CURSOR: hand; COLOR: black; PADDING-TOP: 2px; BORDER-BOTTOM: #7EBF4F 1px solid

            }
        .btn1_mouseover {
            margin: 5px;
            width:150px;
            height:80px;
            BORDER-RIGHT: #7EBF4F 1px solid; PADDING-RIGHT: 2px; BORDER-TOP: #7EBF4F 1px solid; PADDING-LEFT: 2px; FONT-SIZE: 14px; FILTER: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#ffffff, EndColorStr=#CAE4B6); BORDER-LEFT: #7EBF4F 1px solid; CURSOR: hand; COLOR: black; PADDING-TOP: 2px; BORDER-BOTTOM: #7EBF4F 1px solid
            }
        .time_nav_title{
            font-weight: bold;
        }
    </style>
    <script>
        $(function(){
            $('#pp').portal({
                border:false,
                fit:true
            });
            //add();
        });
        function add(){
            for(var i=0; i<3; i++){
                var p = $('<div/>').appendTo('body');
                p.panel({
                    title:'Title'+i,
                    content:'<div style="padding:5px;">Content'+(i+1)+'</div>',
                    height:100,
                    closable:true,
                    collapsible:true
                });
                $('#pp').portal('add', {
                    panel:p,
                    columnIndex:i
                });
            }
            $('#pp').portal('resize');
        }
        function remove(){
            $('#pp').portal('remove',$('#pgrid'));
            $('#pp').portal('resize');
        }
        function f_checkApplyExist(){
            var t=false;
            $.ajax({
                type: "POST",
                async:false,
                url: "apply!checkApplyExist.action",
                dataType:"json",
                success: function(json){
                    if(json.success){
                        t=false;
                        f_alertError("对不起，您今年已经报过名了，无需重复报名！");
                    }else{
                        t=true;
                    }
                }
            });
            return t;
        }
        function f_apply(){
            if(f_checkApplyExist()){
                location='apply.jsp';
            }
        }

        $(function(){
            var nowdate = "<%=DateUtil.getNowDateString()%>";
            if(nowdate<"${sys_conf.APPLY_STDATE}" || nowdate>"${sys_conf.APPLY_EDDATE}"){
                $("#apply_btn").attr({disabled:"disabled",title:"报名时间未到或已过期"});
            }
            if(nowdate>"${sys_conf.PRINT_APPLY_STDATE}"){
                $("#print_btn").attr({disabled:"disabled",title:"打印报名表时间已过期"});
            }
            if(nowdate<"${sys_conf.PRINT_TEST_STDATE}" || nowdate>"${sys_conf.PRINT_TEST_EDDATE}"){
                $("#print_test_btn").attr({disabled:"disabled",title:"打印准考证时间未到或已过期"});
            }
            if(nowdate<"${sys_conf.SCORE_STDATE}" || nowdate>"${sys_conf.SCORE_EDDATE}"){
                $("#score_btn").attr({disabled:"disabled",title:"查询成绩时间未到或已过期"});
            }

        }) ;


    </script>
</head>
<body class="easyui-layout" >
<div id="msgDiaog" class="easyui-dialog" title="${softTitle}" resizable="false" draggable="true" closable="true" data-options="iconCls:'icon-user'" style="width:600px;height:300px;padding:10px">
<div style="line-height: 30px;margin: 10px;">
<h3 style="color: red;" align="center">通知</h3>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;为方便考生报名，现决定延长考生提交审核时间。已于本月16日前（含16日）提交报名资料的考生，可在本月23日15点前继续提交报名信息，之后将关闭修改和提交。预审通过的考生可于本月30日前打印报名表，之后将关闭打印。
</div>
<div align="right" style="margin: 10px;">2013年8月20日</div>
</div>
<div region="center" border="false">
    <div id="pp" style="position:relative">
        <div style="width:30%" >
            <div title="快速入口" align="center" style="padding: 5px;" closable="true" >
                <button id="apply_btn"
                        class="btn1_mouseout" onmouseover="this.className='btn1_mouseover'"
                        onmouseout="this.className='btn1_mouseout'"
                        onclick="f_apply();">点击报名</button>
                <button  id="print_btn"
                        class="btn1_mouseout" onmouseover="this.className='btn1_mouseover'"
                        onmouseout="this.className='btn1_mouseout'"
                        onclick="location='${ctx}/ShowReport.wx?PAGEID=t_apply_print';">打印报名表</button>
                <button  id="print_test_btn"
                        class="btn1_mouseout" onmouseover="this.className='btn1_mouseover'"
                        onmouseout="this.className='btn1_mouseout'"
                        onclick="location='${ctx}/ShowReport.wx?PAGEID=t_admis_print';">打印准考证</button>
                <button  id="score_btn"
                        class="btn1_mouseout" onmouseover="this.className='btn1_mouseover'"
                        onmouseout="this.className='btn1_mouseout'"
                        onclick="location='${ctx}/ShowReport.wx?PAGEID=t_apply_score';">查询成绩</button>
            </div>
        </div>
        <div style="width:30%">
            <div class="easyui-calendar" title="日历"  closable="true" style="padding: 5px;height: 200px;"></div>
            <%--<div title="时钟" closable="true"  style="text-align:center;padding:5px;background-color: lightblue">
                <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0" width="120" height="120">
                    <param name="movie" value="${ctx}/img/analog.swf">
                    <param name=quality value=high>
                    <param name="wmode" value="transparent">
                    <embed src="${ctx}/img/analog.swf" width="120" height="120" quality=high pluginspage="http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash" type="application/x-shockwave-flash" wmode="transparent"></embed>
                </object>
            </div>--%>
            <div title="时间导航" style="padding: 5px;line-height: 28px;" closable="true" >
                <div class="time_nav_title">报名时间段：</div>
                <div>${sys_conf.APPLY_STDATE} 至 ${sys_conf.APPLY_EDDATE}</div>
                <div class="time_nav_title">现场确认时间段：</div>
                <div>${sys_conf.PRINT_APPLY_STDATE} 至 ${sys_conf.PRINT_APPLY_EDDATE}</div>
                <div class="time_nav_title">打印准考证时间段：</div>
                <div>${sys_conf.PRINT_TEST_STDATE} 至 ${sys_conf.PRINT_TEST_EDDATE}</div>
                <div class="time_nav_title">成绩查询时间段：</div>
                <div>${sys_conf.SCORE_STDATE} 至 ${sys_conf.SCORE_EDDATE}</div>
            </div>
        </div>
        <div style="width: 40%">
            <div title="报名流程"  closable="true"  align="center" style="padding: 5px;">
                <div><a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">填写报名信息(允许修改)</a></div>
                <div><img src="${ctx}/img/down.png" /></div>
                <div><a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">提交报名信息(不能更改)</a></div>
                <div><img src="${ctx}/img/down.png" /></div>
                 <div><a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">网上预审通过</a></div>
                <div><img src="${ctx}/img/down.png" /></div>
                <div><a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-print'">打印报名表(正面)、承诺书 (反面)</a> </div>
                <div><img src="${ctx}/img/down.png" /></div>
                <div> <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">现场审核通过</a> </div>
                <div><img src="${ctx}/img/down.png" /></div>
                <div><a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">复审通过</a></div>
                <div><img src="${ctx}/img/down.png" /></div>
                <div><a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-print'">打印准考证</a></div>
                <div><img src="${ctx}/img/down.png" /></div>
                <div><a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询成绩</a></div>
            </div>
        </div>

    </div>
</div>
</body>
</html>