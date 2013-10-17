package com.ggs.dao;

import com.ggs.util.DBUtil;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: GGS
 * Date: 13-7-7
 * Time: 下午8:25
 * To change this template use File | Settings | File Templates.
 */
public class DataDao {
    private static DBUtil dbUtil=new DBUtil();
    /**
     * 获取数据字典
     * */
    public static String getDataName(String id){
        Map<String,String> item =dbUtil.queryForMap("select * from t_data where id=?",id);
        String name = item.get("name");
        return name==null?"":name;
    }

    /**
     * 获取数据字典代码
     * */
    public static String getDataCode(String id){
        Map<String,String> item =dbUtil.queryForMap("select * from t_data where id=?",id);
        String name = item.get("code");
        return name==null?"":name;
    }

    /**
     * 获取数据字典
     * */
    public static String getDataNameByIn(String ids){
        List<Map<String,String>> itemList =dbUtil.queryForList("select * from t_data where id in ("+ids+")");
        StringBuilder result = new StringBuilder();
        for(Map<String,String>item:itemList){
            result.append(item.get("name"));
            result.append("<br/>");
        }
        return result.toString();
    }

    /**
     * 获取审核状态
     * */
    public static String getCheckStatusName(String status){
        if(status!=null){
            if(status.equals("0")){
                return "未审核";
            }else if(status.equals("11")){
                return "预审通过";
            }else if(status.equals("10")){
                return "预审不通过";
            }else if(status.equals("21")){
                return "现场确认通过";
            }else if(status.equals("20")){
                return "现场确认不通过";
            }else if(status.equals("31")){
                return "复审通过";
            }else if(status.equals("30")){
                return "复审不通过";
            }else{
                return "";
            }
        }else{
            return "";
        }
    }


    /**
     * 获取省份列表
     * */
    public static List getProvList(){
        return dbUtil.queryForList("select * from T_PROVINCE");
    }
    /**
     * 获取城市列表
     * */
    public static List getCityList(String pid){
        return dbUtil.queryForList("select * from t_city where pid=?",pid);
    }
    /**
     * 获取区域列表
     * */
    public static List getAreaList(String pid){
        return dbUtil.queryForList("select * from t_area where pid=?",pid);
    }


    /***
     * 获取省份
     *
     */
    public static String getProvince(String id){
        return (String) dbUtil.queryForMap("select name from t_province where id=?",id).get("name");
    }


    /***
     * 获取城市
     *
     */
    public static String getCity(String id){
        return (String) dbUtil.queryForMap("select name from t_city where id=?",id).get("name");
    }
    /***
     * 获取区域
     *
     */
    public static String getArea(String id){
        return (String) dbUtil.queryForMap("select name from t_area where id=?",id).get("name");
    }
    /**
     * 获取用户类型
     * */
    public   static String getUserType(String id){
        if(id.equals("0")){
            return "考生";
        }else if(id.equals("1")){
            return "管理人员";
        }else{
            return "";
        }
    }
    /**
     * 获取数据权限
     * */
    public static String getDataRole(String id){
        if(id.equals("0")){
            return "默认";
        }else if(id.equals("1")){
            return "区级";
        }else if(id.equals("2")){
            return "市级";
        }else if(id.equals("3")){
            return "省级";
        }else{
            return "";
        }
    }
    /**
     * 获取角色名称
     * */
    public static String getRoleName(String id){
        return (String)dbUtil.queryForMap("select name from t_role where id=?",id).get("name");
    }

    /**
     * 获取系统配置
     * */
    public static String getConf(String name){
        return (String)dbUtil.queryForMap("select * from t_conf where name=?",name).get("value");
    }


    /**
     * 初级默认选中所有科目
     * */
    public static String selSubjectByLevel(String id){
        StringBuilder result = new StringBuilder();
        String sql = "select distinct test_subject from v_test_rule " +
                "where test_level in (select id from v_data where datatype='TestLevel' and code='01' and id=?)";
        List<Map<String,String>> itemList= dbUtil.queryForList(sql,id);
        if(itemList.size()>0){
            for(Map<String,String>item:itemList){
                result.append(item.get("test_subject"));
                result.append(",");
            }
            result =new StringBuilder( result.substring(0, result.length()-1));
        }
        return  result.toString();
    }

    /**
     * 获取数据字典列表
     * */
    public static List getDataList(String datatype){
        return dbUtil.queryForList("select * from v_data where datatype=?",datatype);
    }

    /**
     *
     * 获取系统配置列表
     * */
    public static Map getConf(){
        Map result = new HashMap();
        List<Map<String,String>> itemList = dbUtil.queryForList("select * from t_conf");
        for(Map<String,String>item:itemList){
            result.put(item.get("name"),item.get("value"));
        }
        return result;
    }

    /**
     * 默认简历模板
     * */
    public static String getDefJobTemp(){
        StringBuilder s = new StringBuilder();
        s.append("<style type='text/css'>.myJob{margin-left:20px;}</style>");
        s.append("1、   &nbsp;&nbsp;&nbsp;&nbsp;年&nbsp;&nbsp;  月&nbsp;&nbsp;   至&nbsp;&nbsp;&nbsp;&nbsp;    年 &nbsp;&nbsp; 月&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;学习；<br/>");
        s.append("2、   &nbsp;&nbsp;&nbsp;&nbsp;年&nbsp;&nbsp;  月&nbsp;&nbsp;   至&nbsp;&nbsp;&nbsp;&nbsp;    年 &nbsp;&nbsp; 月&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;工作；<br/>");
        s.append("3、   &nbsp;&nbsp;&nbsp;&nbsp;年&nbsp;&nbsp;  月&nbsp;&nbsp;   至&nbsp;&nbsp;&nbsp;&nbsp;    年 &nbsp;&nbsp; 月&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;工作；<br/>");
        s.append("4、   &nbsp;&nbsp;&nbsp;&nbsp;年&nbsp;&nbsp;  月&nbsp;&nbsp;   至&nbsp;&nbsp;&nbsp;&nbsp;    年 &nbsp;&nbsp; 月&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;工作；<br/>");
        s.append("5、   &nbsp;&nbsp;&nbsp;&nbsp;年&nbsp;&nbsp;  月&nbsp;&nbsp;   至&nbsp;&nbsp;&nbsp;&nbsp;    年 &nbsp;&nbsp; 月&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;工作；<br/>");
        return s.toString();
    }

    /**
     * 获取科目名称
     * */
    public static String getTestSubjectName(String test_level,String tech_name,String spec_class,String test_subject){
        StringBuilder result = new StringBuilder();
        String sql = "select distinct test_subject_code,test_subject_name from V_Test_RULE where test_level="+test_level+"  and tech_name="+tech_name+"  and spec_class="+spec_class+"  and test_subject in ("+test_subject+") order by test_subject_code";
        List<Map<String,String>> itemList = dbUtil.queryForList(sql);
        for(Map<String,String> item:itemList){
            String test_subject_name = item.get("test_subject_name");
            result.append(test_subject_name);
            result.append(" ");
        }
        return result.toString();
    }

    /**
     * 获取考场名称
     * */
    public static String getExamSiteName(String id){
        Map<String,String> item = dbUtil.queryForMap("select name from t_exam_site where id=?",id);
        return item.get("name");
    }

    /**
     * 获取考点名称
     * */
    public static String getExamAddrName(String id){
        Map<String,String> item = dbUtil.queryForMap("select name from t_exam_addr where id=?",id);
        return item.get("name");
    }
    /**
     * 获取考室名称
     * */
    public static String getExamRoomName(String id){
        Map<String,String> item = dbUtil.queryForMap("select name from t_exam_room where id=?",id);
        return item.get("name");
    }


    /**
     * 通过考场查询地市列表
     * */
    public static List getSiteCitysBySiteid(String siteid){
        return dbUtil.queryForList("select * from T_EXAM_SITE_CITY where siteid=?",siteid);
    }

    /**
     * 获取考试日期时间
     * */

    public static List getExamDateTime(String applyid){
        StringBuilder sql = new StringBuilder();
        sql.append(" select distinct a.*,b.test_date,b.test_time from (");
        sql.append(" select * from v_apply_subject where id=? and test_subject_id is not null)a");
        sql.append(" left join t_test_rule b on a.test_subject_id=b.test_subject and a.spec_class=b.spec_class");
        sql.append(" order by b.test_date,b.test_time");
        return dbUtil.queryForList(sql.toString(),applyid);
    }

    /***
     * 通过报名id获取考场考点
     * */
    public static Map getExamSite(String applyid){
        return dbUtil.queryForMap("select room_name,addr_name,site_name,seatnum,address from V_EXAM_SITE_STU t  where applyid="+applyid);
    }

    /**
     * 通过roomid获取考场考生列表
     * */

    public static List getRoomUserList(String roomid){
        return dbUtil.queryForList("select * from V_EXAM_SITE_STU where roomid="+roomid+" order by seatnum");
    }

    /**
     * 通过考区id、考点id获取所有考场列表
     * */
    public static List getRoomList(String siteid,String addrid,String roomid){
        String sql ="select * from V_EXAM_ROOM where 1=1";
        if(siteid!=null && siteid.trim().length()>0){
            sql+=" and siteid="+siteid;
        }
        if(addrid!=null && addrid.trim().length()>0){
            sql+=" and addrid="+addrid;
        }
        if(roomid!=null && roomid.trim().length()>0){
            sql+=" and id="+roomid;
        }
        return  dbUtil.queryForList(sql);
    }

    /**
     * 获取最新公告
     * */
    public static Map getNewNotice(){
        String sql = "select * from V_NOTICE t where t.status=1";
        return dbUtil.queryForMap(sql);
    }

}
