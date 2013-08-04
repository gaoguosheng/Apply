<%--
  Created by IntelliJ IDEA.
  User: ggs
  Date: 13-5-9
  Time: 下午8:20
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="softTitle" value="福建省药学（非临床）专业初中级技术职务任职资格考试"/>
<c:set var="softName" value="网上报名系统"/>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:choose>
    <c:when test="${param.theme!=null}">
        <c:set var="theme" value="${param.theme}" scope="session"></c:set>
    </c:when>
</c:choose>
<link rel="stylesheet" type="text/css" href="${ctx}/lib/easyui/themes/${theme==null?"default":theme}/easyui.css">
<link rel="stylesheet" type="text/css" href="${ctx}/lib/easyui/themes/icon.css">
<link rel="stylesheet" type="text/css" href="${ctx}/lib/easyui/portal/portal.css">
<link rel="stylesheet" type="text/css" href="${ctx}/lib/zTree/css/zTreeStyle/zTreeStyle.css">
<link rel="stylesheet" type="text/css" href="${ctx}/lib/app/css/app.css">

<script type="text/javascript" src="${ctx}/lib/jquery.js"></script>
<script type="text/javascript" src="${ctx}/lib/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${ctx}/lib/easyui/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="${ctx}/lib/easyui/portal/jquery.portal.js"></script>
<script type="text/javascript" src="${ctx}/lib/zTree/js/jquery.ztree.all-3.5.min.js"></script>
<script type="text/javascript" src="${ctx}/lib/app/js/app.js"></script>

<script type="text/javascript">
    $(function(){
        $(".easyui-validatebox").unbind("focus");
    });

</script>

