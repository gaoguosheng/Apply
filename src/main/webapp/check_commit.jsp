<%@ page import="com.ggs.util.DBUtil" %>
<%--
  Created by IntelliJ IDEA.
  User: GGS
  Date: 13-8-19
  Time: 下午8:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%!
    DBUtil dbUtil = new DBUtil();
%>
<%
    String applyid = request.getParameter("applyid");
    StringBuilder sql = new StringBuilder();
    sql.append("select count(*) from t_apply t where t.id="+applyid);
    //在报名截止期间的报名表
    sql.append(" and (((to_char(sysdate,'yyyy-mm-dd') between (select value from t_conf where name='APPLY_STDATE') and (select value from t_conf where name='APPLY_EDDATE'))");
    //现场报名前预审不通过人员的报名表
    sql.append(" or (to_date(to_char(sysdate, 'yyyy-mm-dd'), 'yyyy-mm-dd') <= to_date((select value from t_conf where name ='PRINT_APPLY_STDATE'), 'yyyy-mm-dd') - 2 and (select count(*) from t_apply_check where applyid=t.id)>0)))");
    int counter = dbUtil.queryForInt(sql.toString());
    out.print(counter);
%>