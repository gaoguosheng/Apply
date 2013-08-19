<%@ page import="com.ggs.dao.ApplyDao" %>
<%@ page import="com.ggs.dao.DataDao" %>
<%@ page import="com.ggs.util.DateUtil" %>
<%--
  Created by IntelliJ IDEA.
  User: GGS
  Date: 13-8-1
  Time: 下午10:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
        String id =request.getParameter("id");
        ApplyDao applyDao = new ApplyDao();
        //当前状态
        int status = applyDao.getApplyStatus(id);
        if(status==10){
        //预审状态不通过可编辑
%>
<button id="commit_edit_btn" title="预审不通过可继续编辑资料" class="cls-button2" onclick="location='ShowReport.wx?DISPLAY_TYPE=1&amp;PAGEID=t_apply_commit_form&amp;WX_REFEREDREPORTID=report1&amp;report1_ACCESSMODE=update&amp;WX_SRCPAGEID=t_apply_write&amp;WX_SRCREPORTID=report1&amp;WX_EDITTYPE=update&amp;id=<%=id%>',{initsize:'max',width:800,height:600,handler:closePopUpPageEvent};">编辑</button>
<%}%>
<%--
<script type="text/javascript">
    var   APPLY_STDATE="<%=DataDao.getConf("APPLY_STDATE")%>";
    var   APPLY_EDDATE="<%=DataDao.getConf("APPLY_EDDATE")%>";
    var nowDate="<%= DateUtil.getNowDateString()%>";

    if(nowDate>=APPLY_STDATE && nowDate<=APPLY_EDDATE){
        $("#commit_edit_btn").show();
    }else{
        $("#commit_edit_btn").hide();
    }
</script>
--%>