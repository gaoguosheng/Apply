package com.ggs.web;

import com.ggs.bean.User;
import com.ggs.dao.ApplyDao;
import com.ggs.dao.DataDao;
import com.ggs.util.mail.MailUtil;
import com.opensymphony.xwork2.ModelDriven;
import com.wabacus.util.DesEncryptTools;

/**
 * Created with IntelliJ IDEA.
 * User: GGS
 * Date: 13-7-22
 * Time: 下午8:06
 * To change this template use File | Settings | File Templates.
 */
public class LoginAction extends  BaseAction implements ModelDriven<User> {

    private  User model = new User();
    private ApplyDao applyDao = new ApplyDao();

    public User getModel() {
        return model;
    }

    public void lostPwd(){
        boolean t = applyDao.checkLogin(model.getUsername(),model.getRealname());
        if(t){
            String filename = this.servletContext.getRealPath("/img/logo.jpg");
            User user = this.applyDao.getUser(model.getUsername());
            String pwd =String.valueOf(System.currentTimeMillis()).substring(0,8);
            this.applyDao.updatePwd(model.getUsername(),pwd);
            MailUtil.sendEmail(user.getEmail(),
                    "网上报名系统 ：您的密码重置成功！",
                    "您的密码已被重置为【"+pwd+"】，请妥善保存。此消息为邮件自动发送，无需回复。",
                    filename);
        }
        this.outSuccess(t);
    }


    /**
     * 注册
     * */
    public void reg(){
        String valicode = request.getParameter("valicode");
        String sessionCode=(String)session.getAttribute("sessionCode");
        if(!valicode.equalsIgnoreCase(sessionCode)){
            this.outSuccess(false,9);
        }else{
            boolean t = applyDao.saveUser(model);
            if(t){
                this.outSuccess(t,1);
            }else{
                this.outSuccess(t,0);
            }

        }

    }

    /**
     * 检查用户是否存在
     * */
    public void checkUserExist(){
        boolean t = this.applyDao.checkUserExist(this.model.getUsername());
        this.outSuccess(t);
    }


    /***
     * 登录
     * */
    public void checkLogin(){
        String valicode = request.getParameter("valicode");
        String sessionCode=(String)session.getAttribute("sessionCode");
        if(!valicode.equalsIgnoreCase(sessionCode)){
            this.outSuccess(false,9);
        }else{
            boolean isExist=false;
            String pwd= DesEncryptTools.encrypt(model.getPwd());
            isExist =this.applyDao.checkLogin(model.getUsername(),model.getRealname(),pwd);
            if(isExist){
                this.outSuccess(true,1);
                User userBean = this.applyDao.getUser(model.getUsername());
                session.setAttribute("user_id",userBean.getId());
                session.setAttribute("admin",userBean);
                session.setAttribute("sys_conf", DataDao.getConf());
                //保存登录日志
                this.applyDao.saveLoginLog(userBean.getId(),request.getRemoteAddr());
            }else{
                this.outSuccess(false,0);
            }
        }
    }
}
