package com.ggs.web;

import com.ggs.dao.DataDao;

/**
 * Created with IntelliJ IDEA.
 * User: GGS
 * Date: 13-7-23
 * Time: 下午9:09
 * To change this template use File | Settings | File Templates.
 */
public class DataAction extends BaseAction {
    /**
     * 获取省份列表
     * */
    public void getProvList(){
        this.outJson(DataDao.getProvList());
    }

    /**
     * 获取城市列表
     * */
    public void getCityList(){
        this.outJson(DataDao.getCityList(this.getParam("pid")));
    }
    /**
     * 获取区域列表
     * */
    public void getAreaList(){
        this.outJson(DataDao.getAreaList(this.getParam("pid")));
    }
}
