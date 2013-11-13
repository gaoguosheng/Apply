package com.ggs.web;

import com.ggs.bean.Score;
import com.ggs.util.ImpScoreUtil;

import java.io.File;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: GGS
 * Date: 13-11-13
 * Time: 下午12:47
 * To change this template use File | Settings | File Templates.
 */
public class ImpScoreAction extends BaseAction{

    private File[]file;
    private String[]fileContentType;
    private String[]fileFileName;

    public String[] getFileContentType() {
        return fileContentType;
    }

    public void setFileContentType(String[] fileContentType) {
        this.fileContentType = fileContentType;
    }

    public File[] getFile() {
        return file;
    }

    public void setFile(File[] file) {
        this.file = file;
    }

    public String[] getFileFileName() {
        return fileFileName;
    }

    public void setFileFileName(String[] fileFileName) {
        this.fileFileName = fileFileName;
    }

    /**
     * 导入成绩
     * */
    public void imp(){
        boolean result = true;
        if(file!=null){
            for(File f:file){
                List<Score>scoreList= ImpScoreUtil.getScoreListByXml(f);
                boolean t = ImpScoreUtil.impScoreToDb(scoreList);
                if(!t){
                    result=false;
                }
            }
            if(result){
                this.out("<script>alert('导入成绩数据成功！');location='impScore.jsp';</script>");
            }else{
                this.out("<script>alert('导入成绩数据失败！');location='impScore.jsp';</script>");
            }
        } else{
            this.out("<script>alert('对不起，您还未选择成绩数据文件！');location='impScore.jsp';</script>");
        }
    }
}
