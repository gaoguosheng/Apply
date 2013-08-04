package com.ggs.intercept;

import com.ggs.bean.User;
import com.wabacus.system.ReportRequest;
import com.wabacus.system.intercept.AbsPageInterceptor;
import com.ggs.util.DBUtil;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: GGS
 * Date: 13-7-1
 * Time: 下午5:04
 * To change this template use File | Settings | File Templates.
 */
public class PermissionInterceptor extends AbsPageInterceptor {
    private DBUtil dbUtil = new DBUtil();
    public void doStart(ReportRequest rrequest) {
        String pageid = rrequest.getPagebean().getId();// pageid
        User user = (User)rrequest.getRequest().getSession().getAttribute("admin");

        if (user == null ) {
            try {
                // 用户没登录则跳转到登录页面
                rrequest.getWResponse().getResponse().getWriter().print("<script>top.location='"+rrequest.getRequest().getContextPath()+"/login.jsp';</script>");
            } catch (IOException e) {
                e.printStackTrace();
            }
        } else {
            // 已经登录则对要访问的页面进行授权
            String user_id=user.getId();
            String user_name=user.getUsername();
            if(!user_name.equals("system")){
                List<Map<String,String>> defList =dbUtil.queryForList("select * from t_menu where menutype=8 and pageid=?",pageid);
                List<Map<String,String>> itemList= dbUtil.queryForList("select * from t_menu where menutype=8 and pageid=?  " +
                        "and id in (select menuid from t_role_menu " +
                        "where roleid in(select roleid from t_user where id=?))",pageid,user_id);
                for(Map<String,String>item:defList){
                    rrequest.authorize(item.get("compid"), item.get("parttype"), item.get("partid"), "display", "false");
                }
                for(Map<String,String>item:itemList){
                    rrequest.authorize(item.get("compid"),item.get("parttype"), item.get("partid"), "display", "true");
                }
            }
        }
    }


    public void doEnd(ReportRequest rrequest) {

    }




}

