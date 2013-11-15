package com.ggs.util;

import com.ggs.bean.Score;
import com.ggs.dao.DataDao;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: ggs
 * Date: 13-11-5
 * Time: 下午8:36
 * To change this template use File | Settings | File Templates.
 */
public class ImpScoreUtil {
    private static DBUtil dbUtil=new DBUtil();
    /**
     *读取xml成绩数据
     * */
    public static void impScore(){
        //读取导入路径
        String dirstr= DataDao.getConf("IMP_SCORE_PATH");
        File dir = new File(dirstr);
        if(!dir.exists()){
            dir.mkdirs();
        }

        for(File file:dir.listFiles()){
            if(!file.getName().trim().toLowerCase().endsWith(".xml")){
                 continue;
            }
            List<Score>scoreList=getScoreListByXml(file);
            impScoreToDb(scoreList);
        }
    }


    /**
     *读取xml成绩数据
     * */
    public static List<Score> getScoreListByXml(File file){
        List<Score>scoreList = new ArrayList<Score>();
        SAXReader reader = new SAXReader();
        try {
            Document doc = reader.read(file);
            Element root = doc.getRootElement();
            List<Element> scoreElementList =  root.selectNodes("/stu-scores/stu-score");
            for(Element scoreElement:scoreElementList){
                Score scoreBean = new Score();
                String test_no = scoreElement.selectSingleNode("test_no").getText();
                String test_subject = scoreElement.selectSingleNode("test_subject").getText();
                String test_level = scoreElement.selectSingleNode("test_level").getText();
                String spec_class = scoreElement.selectSingleNode("spec_class").getText();
                String test_status = scoreElement.selectSingleNode("test_status").getText();
                String score = scoreElement.selectSingleNode("score").getText();
                scoreBean.setTest_no(test_no);
                scoreBean.setTest_subject(test_subject);
                scoreBean.setTest_level(test_level);
                scoreBean.setSpec_class(spec_class);
                scoreBean.setTest_status(test_status);
                scoreBean.setScore(score);
                System.out.println(file.getName()+"："+test_no+" "+test_subject+" "+test_level+" "+spec_class+" "+test_status+" "+score);
                scoreList.add(scoreBean);
            }
        } catch (DocumentException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        }
        return scoreList;
    }



    /***
     * 导入成绩数据至数据库
     * */
    public static boolean impScoreToDb(List<Score>scoreList){
        String []sql = new String[scoreList.size()];
        //清空数据

        for(int i=0;i<scoreList.size();i++){
            Score score = scoreList.get(i);
            sql[i]=" delete from  t_score where test_no='"+score.getTest_no()+"' and test_subject="+score.getTest_subject();
        }
        dbUtil.batchUpdate(sql);

        //导入数据
        for(int i=0;i<scoreList.size();i++){
            Score score = scoreList.get(i);
            score.setSpec_class(score.getSpec_class().equals("")?"0":score.getSpec_class());
            sql[i]=" insert into t_score (id,test_no,test_subject,test_level,spec_class,test_status,score)";
            sql[i]+=" select seq_t_score.nextval,"
                    +"'"+score.getTest_no()+"',"
                    +score.getTest_subject()+","
                    +score.getTest_level()+","
                    +score.getSpec_class()+","
                    +score.getTest_status()+","
                    +score.getScore()+" from dual";
        }
        return dbUtil.batchUpdate(sql);
    }

}
