<%@ page import="com.ggs.util.DBUtil" %>
<%@ page import="java.util.Map" %>
<%--
  Created by IntelliJ IDEA.
  User: ggs
  Date: 14-3-9
  Time: 下午9:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String active = request.getParameter("active");
    active=active==null?"":active;
    if(active.equals("filing")){
        //开始归档
        DBUtil  dbUtil=new DBUtil();
        Map<String,String> map  =dbUtil.queryForMap("select distinct to_char(to_date(createtime,'yyyy-mm-dd hh24:mi:ss'),'yyyy') test_year from t_apply");
        String test_year = map.get("test_year");
        String[]sqls = new String[]{
                "create table t_his_apply as select "+test_year+" test_year, t.* from v_apply t",
                "create table t_his_score as select "+test_year+" test_year,t.* from v_score t",
                "create table t_his_cert_filing as select "+test_year+" test_year, t.* from v_cert_filing t",
                "create table t_his_exam_site_stu as select "+test_year+" test_year, t.* from V_EXAM_SITE_STU t",
                "create table t_his_score_imp_log as select "+test_year+" test_year,t.* from V_SCORE_IMP_LOG t",
                "create table t_his_conf as select "+test_year+" test_year,t.* from t_conf t",
                "create table t_his_test_rule as select "+test_year+" test_year,t.* from v_test_rule t",
                "create table t_his_test_subject as select "+test_year+" test_year,t.* from t_test_subject t",
                "create table t_his_cert_rule as select "+test_year+" test_year,t.* from t_cert_rule t",
                "create table t_his_exam_site as select "+test_year+" test_year,t.* from v_exam_site t",
                "create table t_his_exam_addr as select "+test_year+" test_year,t.* from t_exam_addr t",
                "create table t_his_exam_room as select "+test_year+" test_year,t.* from v_exam_room t",
                "create table t_his_exam_site_city as select "+test_year+" test_year,t.* from v_exam_site_city t"
        };

        sqls = new String[]{
                "insert into t_his_apply  select "+test_year+" test_year, t.* from v_apply t",
                "insert into t_his_score  select "+test_year+" test_year,t.* from v_score t",
                "insert into t_his_cert_filing  select "+test_year+" test_year, t.* from v_cert_filing t",
                "insert into t_his_exam_site_stu  select "+test_year+" test_year, t.* from V_EXAM_SITE_STU t",
                "insert into t_his_score_imp_log  select "+test_year+" test_year,t.* from V_SCORE_IMP_LOG t",
                "insert into t_his_conf as select "+test_year+" test_year,t.* from t_conf t",
                "insert into t_his_test_rule  select "+test_year+" test_year,t.* from v_test_rule t",
                "insert into t_his_test_subject  select "+test_year+" test_year,t.* from t_test_subject t",
                "insert into t_his_cert_rule  select "+test_year+" test_year,t.* from t_cert_rule t",
                "insert into t_his_exam_site  select "+test_year+" test_year,t.* from v_exam_site t",
                "insert into t_his_exam_addr  select "+test_year+" test_year,t.* from t_exam_addr t",
                "insert into t_his_exam_room  select "+test_year+" test_year,t.* from v_exam_room t",
                "insert into t_his_exam_site_city  select "+test_year+" test_year,t.* from v_exam_site_city t"
        };

        boolean t = dbUtil.batchUpdate(sqls);
        if(t){
            out.print("<script>alert('归档成功！');history.back();</script>");
        }else{
            out.print("<script>alert('归档失败！可能重复归档，或者出现服务器异常，详请联系系统管理员。');history.back();</script>");
        }


    }
%>
<html>
<head>
    <title>归档数据</title>
</head>
<body>
<a href="history.jsp?active=filing" onclick="return confirm('归档后将本地数据添加至历史库，同时清空本地数据，是否确定开始归档？');">开始归档</a>
</body>
</html>
