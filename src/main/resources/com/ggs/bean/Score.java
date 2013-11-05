package com.ggs.bean;

/**
 * Created with IntelliJ IDEA.
 * User: ggs
 * Date: 13-11-5
 * Time: 下午8:50
 * To change this template use File | Settings | File Templates.
 */
public class Score {
    private String test_no;
    private String test_subject;
    private String test_level;
    private String spec_class;
    private String test_status;
    private String score;

    public String getTest_no() {
        return test_no;
    }

    public void setTest_no(String test_no) {
        this.test_no = test_no;
    }

    public String getTest_subject() {
        return test_subject;
    }

    public void setTest_subject(String test_subject) {
        this.test_subject = test_subject;
    }

    public String getTest_level() {
        return test_level;
    }

    public void setTest_level(String test_level) {
        this.test_level = test_level;
    }

    public String getSpec_class() {
        return spec_class;
    }

    public void setSpec_class(String spec_class) {
        this.spec_class = spec_class;
    }

    public String getTest_status() {
        return test_status;
    }

    public void setTest_status(String test_status) {
        this.test_status = test_status;
    }

    public String getScore() {
        return score;
    }

    public void setScore(String score) {
        this.score = score;
    }
}
