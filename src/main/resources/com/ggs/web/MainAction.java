package com.ggs.web;

import com.ggs.bean.User;
import com.ggs.dao.ApplyDao;
import com.opensymphony.xwork2.ModelDriven;

/**
 * Created with IntelliJ IDEA.
 * User: GGS
 * Date: 13-7-22
 * Time: 下午8:09
 * To change this template use File | Settings | File Templates.
 */
public class MainAction extends BaseAction implements ModelDriven<User>{
    private ApplyDao applyDao = new ApplyDao();
    private User model = new User();
    @Override
    public User getModel() {
        return model;
    }



    /**
     * 修改用户资料
     * */
    public void modifyUser(){
        //设置当前用户id
        this.model.setId(this.getAdmin().getId());
        boolean t = this.applyDao.updateUser(this.getModel());
        User user = this.applyDao.getUser(this.model.getUsername());
        //刷新用户对象
        session.setAttribute("admin",user);
        this.outSuccess(t);
    }

}
