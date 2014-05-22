package com.ggs.dao;

import com.ggs.bean.Apply;
import com.ggs.bean.User;
import com.ggs.util.BeanUtil;
import com.ggs.util.DBUtil;
import com.google.gson.GsonBuilder;
import com.wabacus.util.DesEncryptTools;

import javax.servlet.http.HttpSession;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: GGS
 * Date: 13-7-6
 * Time: 下午8:39
 * To change this template use File | Settings | File Templates.
 */
public class ApplyDao {
    private DBUtil dbUtil = new DBUtil();

    /**
     *
     * 检查用户名是否存在
     * */
    public boolean checkUserExist(String username){
        int counter  =dbUtil.queryForInt("select count(*) from t_user where username=?",username);
        return counter>0?true:false;
    }

    /**
     * 检查学生身份证和姓名是否正确
     * */
    public boolean checkLogin(String username,String realname){
        int counter = this.dbUtil.queryForInt("select count(*) from t_user where username=? and realname=?",username,realname);
        return counter>0?true:false;
    }

    /**
     * 通过用户名获取学生信息
     * */
    public User getUser(String username){
        Map<String,Object> user = dbUtil.queryForMap("select * from t_user where username=?",username);
        User userBean = new User();
        BeanUtil.mapCopyObject(user,userBean);
        return userBean;
    }

     /**
     * 检查用户登录
     * */
    public boolean checkLogin(String username,String realname, String password) {
        boolean isExist = false;
        int counter=0;
        if(realname!=null){
            counter = dbUtil.queryForInt("select count(*) from t_user where username=? and realname=? and pwd=?",username,realname,password );
        }else{
            counter = dbUtil.queryForInt("select count(*) from t_user where username=? and pwd=?",username, password);
        }

        if(counter>0){
            isExist=true;
        }else{
            isExist=false;
        }
        return isExist;
    }
    /**
     * 根据用户获取菜单列表
     * */
    public String getMenuJson(String userid){
        String username = (String)dbUtil.queryForMap("select username from t_user where id=?",userid).get("username");
        String sql="select * from t_menu where menutype=0 and id in (select menuid from t_role_menu where roleid in (select roleid from t_user where id="+userid+"))";
        if(username.equals("system")){
            sql="select * from t_menu where menutype=0";
        }
        sql+=" order by orderno";
        List<Map<String,String>> itemList =dbUtil.queryForList(sql);
        List jsonList =new ArrayList();
        for(Map<String,String>item:itemList){
            Map<String,String>json = new HashMap<String,String>();
            json.put("id",item.get("id"));
            json.put("name",item.get("name"));
            json.put("pId",item.get("pid"));
            json.put("uri",item.get("uri"));
            jsonList.add(json);
        }
        String jsonstr = new GsonBuilder().create().toJson(jsonList);
        return jsonstr;
    }

    /**
     * 获取所有菜单
     * */
    public String getMenuList(){
        List<Map<String,String>> itemList =dbUtil.queryForList("select * from t_menu order by orderno");
        List jsonList =new ArrayList();
        for(Map<String,String>item:itemList){
            Map<String,String>json = new HashMap<String,String>();
            json.put("id",item.get("id"));
            json.put("name",item.get("name"));
            json.put("pId",item.get("pid"));
            json.put("uri",item.get("uri"));
            json.put("pageid",item.get("pageid"));
            json.put("menutype",item.get("menutype"));
            json.put("compid",item.get("compid"));
            json.put("parttype",item.get("parttype"));
            jsonList.add(json);
        }
        String jsonstr = new GsonBuilder().create().toJson(jsonList);
        return jsonstr;
    }

    /**
     * 根据 角色获取菜单列表
     * */
    public String getMenuList(String roleid){
        List<Map<String,String>> itemList =dbUtil.queryForList("select * from t_menu order by orderno");
        List<Map<String,String>> checkList =dbUtil.queryForList("select * from t_menu where id in (select menuid from t_role_menu where roleid=?)",roleid);
        List jsonList =new ArrayList();
        for(Map<String,String>item:itemList){
            Map json = new HashMap();
            for(Map<String,String>checkItem:checkList){
                if(item.get("id").equals(checkItem.get("id"))){
                    json.put("checked",true);
                }
            }
            json.put("id",item.get("id"));
            json.put("name",item.get("name"));
            json.put("pId",item.get("pid"));
            json.put("uri",item.get("uri"));
            json.put("pageid",item.get("pageid"));
            json.put("menutype",item.get("menutype"));
            json.put("compid",item.get("compid"));
            json.put("parttype",item.get("parttype"));
            jsonList.add(json);
        }
        String jsonstr = new GsonBuilder().create().toJson(jsonList);
        return jsonstr;
    }

    /**
     * 获取某个菜单
     * */
    public String getMenu(String id){
        Map item = dbUtil.queryForMap("select * from t_menu where id=?",id);
        return new GsonBuilder().create().toJson(item);
    }
    /**
     * 获取角色名称
     * */
    public String getRoleName(String id){
        Map<String,String> item = dbUtil.queryForMap("select name from t_role where id=?",id);
        return item.get("name");
    }
    /**
     * 保存角色权限
     * */
    public void saveRoleMenu(String roleid,String[]menuid){
        String[]sql = new String[menuid.length+1];
        sql[0]="delete from t_role_menu where roleid="+roleid;
        for(int i=1;i<=menuid.length;i++){
            sql[i]="insert into t_role_menu (roleid,menuid) values("+roleid+","+menuid[i-1]+")";
        }
        dbUtil.batchUpdate(sql);
    }
    /**
     * 获取角色列表
     * */
    public String getRoleListJson(){
        List itemLit = dbUtil.queryForList("select * from t_role");
        return new GsonBuilder().create().toJson(itemLit);
    }

    /**
     * 注册考生信息
     *
     * */
    public boolean saveUser(User user){
        int counter =   this.dbUtil.update("insert into t_user (id,username,realname,pwd,provid,cityid,areaid,roleid,email,phone,qq,sex)" +
                "values (seq_t_user.nextval,?,?,?,?,?,?,?,?,?,?,?)",
                user.getUsername(),
                user.getRealname(),
                DesEncryptTools.encrypt(user.getPwd()),
                user.getProvid(),
                user.getCityid(),
                user.getAreaid(),
                24,
                user.getEmail() ,
                user.getPhone(),
                user.getQq(),
                user.getSex()
        );
        return counter>0?true:false;
    }

    /**
     * 更新密码
     * */
    public boolean updatePwd(String username,String pwd){
        int counter = dbUtil.update("update t_user set pwd=? where username=?",DesEncryptTools.encrypt(pwd),username);
        return counter>0?true:false;
    }

    /**
     * 可报名的课程
     * */

    public List getValidRuleList(){
        return this.dbUtil.queryForList("select * from v_valid_rule");
    }

    /**
     * 获取我的报名列表
     * */
    public List getMyApplyList(String userid){
        return this.dbUtil.queryForList("select * from v_apply where createid=? order by id desc",userid);
    }

    /***
     *
     * 报名审核
     * */
    public boolean applyCheck(Apply apply){
        int counter = 0;
        if(apply.getStatus().endsWith("1")){
            //通过
            counter=this.dbUtil.update("insert into t_apply_check (id,applyid,status,createid,cause) values(seq_t_apply_check.nextval,?,?,?,?)",
                    apply.getApplyid(),
                    apply.getStatus(),
                    apply.getCreateid(),
                    apply.getCause());
            //如果是预审通过，生成FN档案号
           if(apply.getStatus().equals("11")){
               String fn =this.getFN(apply.getApplyid());
               this.dbUtil.update("update t_apply set fn=? where id=?",fn,apply.getApplyid());
           }

        }else{
            //不通过
            counter=this.dbUtil.update("insert into t_apply_check (id,applyid,status,createid,cause,causetype) values(seq_t_apply_check.nextval,?,?,?,?,?)",
                    apply.getApplyid(),
                    apply.getStatus(),
                    apply.getCreateid(),
                    apply.getCause(),
                    apply.getCausetype());
        }

        if(apply.getStatus().equals("10")){
            //预审不通过直接退回草稿
            this.dbUtil.update("update t_apply set iscommit=0,status=? where id=?",apply.getStatus(),apply.getApplyid());
        }else{
            this.dbUtil.update("update t_apply set status=? where id=?",apply.getStatus(),apply.getApplyid());
        }
        return  counter>0?true:false;
    }

    /**
     * 获取报名表当前状态
     * */
    public int getApplyStatus(String id){
        return this.dbUtil.queryForInt("select status from t_apply where id=?",id);
    }

    /**
     * 检查是否已经报过名
     * */
    public boolean checkApplyExist(String userid){
        int counter  = dbUtil.queryForInt("select count(*) from t_apply where substr(createtime,0,4)=to_char(sysdate,'yyyy')" +
                " and createid=?",userid);
       return counter>0?true:false;
    }

    /**
     * 检查报名时间限制
     * */
   public boolean checkApplyValid(String stdate,String eddate){
       StringBuilder sql = new StringBuilder();
       sql.append("select 1 from dual where to_char(sysdate,'yyyy-mm-dd') between");
       sql.append(" (select value from t_conf where name=?)");
       sql.append(" and (select value from t_conf where name=?)");
       int counter=dbUtil.queryForInt(sql.toString(),stdate,eddate);
        return counter>0?true:false;
   }

    /**
     * 解冻
     * */
    public boolean thaw(String applyid){
        int counter = this.dbUtil.update("update t_apply set iscommit=0 and status=0 where id=?",applyid);
        return counter>0?true:false;
    }

    /**
     * 获取档案号
     * */
    public String getFN(String applyid){
        Map<String,String> item = this.dbUtil.queryForMap("select b.porv_code|| b.city_code|| a.spec_class_code|| a.tech_name_code|| to_char(sysdate, 'yyyymmdd')||trim(to_char(SEQ_APPLY_SEQ.nextval,'0000'))fn"+
                " from v_apply a   left join v_user b    on a.createid = b.ID  where a.id =?",applyid);
        return item.get("fn");
    }

    /**
     * 系统日志
     * */
    public void log(String user_id,String realname,String otype,String title,String log){
        String sql = "insert into t_log (id,userid,name,optype,opobj,content) values(seq_t_log.nextval,?,?,?,?,?)";
        dbUtil.update(sql,user_id,realname,otype,title,log);
    }

    /**
     * 获取相应权限的报名列表
     * */
    public List getApplyList(String userid,String status){
        StringBuilder sql = new StringBuilder();
        sql.append("select * from v_apply where iscommit=1 and status=? and createid in");
        sql.append(" ( select id from t_user  where usertype=0 and(");
        sql.append("   (areaid =(select areaid from t_user where  id=? and datarole=1))");
        sql.append("  or (cityid =(select cityid from t_user where  id=? and datarole=2))");
        sql.append(" or (provid =(select provid from t_user where  id=? and datarole=3))))  and rownum<=20 order by committime");
       return dbUtil.queryForList(sql.toString(),status,userid,userid,userid) ;
    }

    /**
     * 修改用户资料
     * */
    public boolean updateUser(User user){
        int counter  =this.dbUtil.update("update t_user set phone=?,email=?,qq=?,provid=?,cityid=?,areaid=? where id=?",
                user.getPhone(),
                user.getEmail(),
                user.getQq(),
                user.getProvid(),
                user.getCityid(),
                user.getAreaid(),
                user.getId());
        return counter>0?true:false;
    }

    /**
     * 提交报名信息
     * */
    public boolean applyCommit(String applyid){
        int counter  = this.dbUtil.update("update t_apply set iscommit=1,committime=to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') where id=?",applyid);
        return counter>0?true:false;
    }

    /**
     * 检查是否有相应权限操作报名表
     * */
    public boolean checkApplyPerm(String userid,String applyid){
        StringBuilder sql = new StringBuilder();
        sql.append("select count(*) from v_apply where iscommit=1 and id=? and createid in");
        sql.append(" ( select id from t_user  where usertype=0 and(");
        sql.append("   (areaid =(select areaid from t_user where  id=? and datarole=1))");
        sql.append("  or (cityid =(select cityid from t_user where  id=? and datarole=2))");
        sql.append(" or (provid =(select provid from t_user where  id=? and datarole=3))))  and rownum<=20 order by committime");
        int counter = dbUtil.queryForInt(sql.toString(),applyid,userid,userid,userid) ;
        return counter>0?true:false;

    }

    /**
     * 检查是否有存在提交的报名表
     * */
    public boolean checkApplyCommit(String userid){
        int counter = dbUtil.queryForInt("select count(*) from t_apply where iscommit=1 and createid=?",userid);
        return counter>0?true:false;
    }

    /**
     * 获取考场列表
     * */
    public List getExamSiteList(){
        return this.dbUtil.queryForList("select * from t_exam_site");
    }

    /**
     * 保存考场地市表
     * */
    public void saveSiteCitys(String siteid,String cityids, String specids){
        String []cityid = cityids.split(",");
        String []specid = specids.split(",");
        String []sql = new String[cityid.length+1];
        sql[0]="delete from T_EXAM_SITE_CITY where siteid="+siteid;
        for(int i=0;i<cityid.length;i++){
            sql[i+1]="insert into T_EXAM_SITE_CITY(siteid,cityid,spec_type) values ("+siteid+","+cityid[i]+","+specid[i]+")";
        }
        this.dbUtil.batchUpdate(sql);
    }

    /**
     * 检查考场地市表是否重复
     * */
    public List checkSiteCitys(String siteid,String cityids, String specids){
        List list  =new ArrayList();
        String []cityid = cityids.split(",");
        String []specid = specids.split(",");
        for(int i=0;i<cityid.length;i++){
            int counter=0;
            String sql;
            if(specid[i].equals("0")){
                //全部
                sql="select count(*) from  T_EXAM_SITE_CITY where siteid!=? and cityid=?";
                counter = this.dbUtil.queryForInt(sql,siteid,cityid[i]);
            }else{
                sql="select count(*) from  T_EXAM_SITE_CITY where siteid!=? and cityid=? and (spec_type=? or spec_type=0) ";
                counter = this.dbUtil.queryForInt(sql,siteid,cityid[i],specid[i]);
            }

            if(counter>0){
                //有重复数据
                Map<String,String> item = new HashMap<String,String>();
                item.put("siteid",siteid);
                item.put("cityid",cityid[i]);
                list.add(item);
            }
        }
        return list;

    }

    /**
     *  保存登录日志
     * */
    public void saveLoginLog(String userid,String ip){
        this.dbUtil.update("insert into t_login_log (id,userid,loginip,logintime,logouttime) values(seq_t_login_log.nextval,?,?,to_char(sysdate,'yyyy-mm-dd hh24:mi:ss'),'')",
                userid,
                ip);
    }


    /**
     *  保存退出日志
     * */
    public void saveLogoutLog(String userid,String ip){
        this.dbUtil.update("update t_login_log set logouttime=to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') where id= (select max(id) from t_login_log where  userid=? and loginip=?) ",
                userid,
                ip);
    }
}
