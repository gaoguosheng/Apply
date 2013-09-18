package com.ggs.web;

import com.ggs.bean.Apply;
import com.ggs.bean.User;
import com.ggs.dao.ApplyDao;
import com.ggs.dao.DataDao;
import com.opensymphony.xwork2.ModelDriven;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: GGS
 * Date: 13-7-27
 * Time: 下午3:34
 * To change this template use File | Settings | File Templates.
 */
public class ApplyAction extends BaseAction implements ModelDriven<Apply> {
    private ApplyDao applyDao = new ApplyDao();
    private Apply model = new Apply();
    public Apply getModel() {
        return model;
    }

    /**
     * 报名审核
     * */
    public void applyCheck(){
        model.setCreateid(this.getAdmin().getId());
        this.outSuccess(this.applyDao.applyCheck(model));
        User admin =this.getAdmin();
        this.applyDao.log(admin.getId(),admin.getRealname(),"审核","审核报名表","");
    }

    /**
     * 检查今年是否已经报名过
     * */
    public void checkApplyExist(){
        boolean t =  this.applyDao.checkApplyExist(this.getAdmin().getId());
        this.outSuccess(t);
    }

    /**
     * 检查报名时效
     * */
    public void checkApplyValid(){
        String stdate = this.getParam("stdate");
        String eddate= this.getParam("eddate");
        boolean t = this.applyDao.checkApplyValid(stdate,eddate);
        this.outSuccess(t);
    }

    /**
     * 解冻
     * */
    public void thaw(){
        this.outSuccess(this.applyDao.thaw(this.model.getApplyid()));
        User admin =this.getAdmin();
        this.applyDao.log(admin.getId(),admin.getRealname(),"解冻","解冻报名表","");
    }

    /**
     * 获取报名信息列表
     * */
    public void getApplyList(){
        String status = this.getParam("status");
        String userid= this.getAdmin().getId();
        List list = this.applyDao.getApplyList(userid,status);
        this.outJson(list);
    }

    /***
     * 提交报名信息
     * */
    public void applyCommit(){
        this.outSuccess(this.applyDao.applyCommit(this.model.getApplyid()));
    }

    /**
     * 获取考场列表
     * */
    public void getExamSiteList(){
        List <Map<String,String>>itemList = this.applyDao.getExamSiteList();
        List jsonList = new ArrayList();
        for(Map<String,String>item:itemList){
            Map<String,String>json = new HashMap<String,String>();
            json.put("id",item.get("id"));
            json.put("name",item.get("name"));
            json.put("pId",item.get("pid"));
            json.put("remark",item.get("remark"));
            jsonList.add(json);
        }
        this.outJson(jsonList);
    }

    /**
     * 获取城市列表
     * */
    public void getCityList(){
        List <Map<String,String>>itemList = DataDao.getCityList("350000");
        List jsonList = new ArrayList();
        for(Map<String,String>item:itemList){
            Map<String,String>json = new HashMap<String,String>();
            json.put("id",item.get("id"));
            json.put("name",item.get("name"));
            jsonList.add(json);
        }
        this.outJson(jsonList);
    }
    /**
     * 保存考场地市表
     * */
    public void saveSiteCitys(){
        String siteid = this.getParam("siteid");
        String cityids = this.getParam("cityids");
        this.applyDao.saveSiteCitys(siteid,cityids);
    }
    /**
     * 通过考场查询地市列表
     * */
    public void getSiteCitysBySiteid(){
        String siteid = this.getParam("siteid");
        List itemList = DataDao.getSiteCitysBySiteid(siteid);
        this.outJson(itemList);
    }
}
