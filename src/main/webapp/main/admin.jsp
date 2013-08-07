<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page import="com.ggs.util.DateUtil" %>
<%--
  Created by IntelliJ IDEA.
  User: ggs
  Date: 13-5-9
  Time: 下午9:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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



    </script>
</head>
<body class="easyui-layout" >

<div region="center" border="false">
    <div id="pp" style="position:relative">
        <div style="width:70%" >
            <c:choose>
                <c:when test="${admin.roleid==1||admin.username=='system'}">
                    <div title="待复审（按照提交时间排序最前20条数据，双击审核）" closable="true" style="height: 430px;"  >
                        <table class="easyui-datagrid" style="height:400px;"
                               data-options="singleSelect:true,collapsible:false,url:'apply!getApplyList.action?status=21',onDblClickRow:f_check">
                            <thead>
                            <tr>
                                <th data-options="field:'committime',width:120">提交时间</th>
                                <th data-options="field:'name',width:80">姓名</th>
                                <th data-options="field:'test_level_name',width:80">层次</th>
                                <th data-options="field:'tech_name_name',width:80">资格名称</th>
                                <th data-options="field:'spec_class_name',width:80">专业</th>
                                <th data-options="field:'test_subject_name',width:200">科目</th>
                            </tr>
                            </thead>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <div title="待预审（按照提交时间排序最前20条数据，双击审核）" closable="true"  style="height: 230px;" >
                        <table class="easyui-datagrid" style="height:200px;"
                               data-options="singleSelect:true,collapsible:false,url:'apply!getApplyList.action?status=0',onDblClickRow:f_check">
                            <thead>
                            <tr>
                                <th data-options="field:'committime',width:120">提交时间</th>
                                <th data-options="field:'name',width:80">姓名</th>
                                <th data-options="field:'test_level_name',width:80">层次</th>
                                <th data-options="field:'tech_name_name',width:80">资格名称</th>
                                <th data-options="field:'spec_class_name',width:80">专业</th>
                                <th data-options="field:'test_subject_name',width:200">科目</th>
                            </tr>
                            </thead>
                        </table>
                    </div>
                    <div title="待现场确认（按照提交时间排序最前20条数据，双击审核）" closable="true" style="height: 230px;" >
                        <table class="easyui-datagrid" style="height:200px;"
                               data-options="singleSelect:true,collapsible:false,url:'apply!getApplyList.action?status=11',onDblClickRow:f_check">
                            <thead>
                            <tr>
                                <th data-options="field:'committime',width:120">提交时间</th>
                                <th data-options="field:'name',width:80">姓名</th>
                                <th data-options="field:'test_level_name',width:80">层次</th>
                                <th data-options="field:'tech_name_name',width:80">资格名称</th>
                                <th data-options="field:'spec_class_name',width:80">专业</th>
                                <th data-options="field:'test_subject_name',width:200">科目</th>
                            </tr>
                            </thead>
                        </table>
                    </div>
                </c:otherwise>
            </c:choose>

        </div>

            <div style="width:30%">
                <div class="easyui-calendar" title="日历"  closable="true" style="padding: 5px;height: 200px;"></div>
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


    </div>
</div>
<script type="text/javascript">
    function f_check(rowIndex, rowData){
        location='${ctx}/ShowReport.wx?PAGEID=t_apply_check_detail&d=1&id='+rowData.id;
    }
</script>
</body>
</html>