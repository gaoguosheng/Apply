/*
功能:加入了参考文章中没有的发送附件的功能.本机测试通过.
参考文章:http://ajava.org/article-722-1.html
使用Javamail发送邮件例子及解释 

 2012-2-1 00:14| 发布者: mark| 查看: 236| 评论: 0|原作者: mark|来自: ajava.org
摘要: 下面例子演示怎样用javamail来发送邮件，在测试之前，我们要下载javamail的类包，并添加入你的工程中，如果你的IDE自带javamail的类包，那就很简单，直接import 就行，我使用的是MyEclipse 7.5，自带，所以可以直接 ...
下面例子演示怎样用javamail来发送邮件，在测试之前，我们要下载javamail的类包，并添加入你的工程中，如果你的IDE自带javamail的类包，那就很简单，直接import 就行，mark使用的是MyEclipse 7.5，自带，所以可以直接测试下面代码了。

 

几个javamail类的作用
javax.mail.Properties类 
我们使用Properties来创建一个session对象。里面保存里对Session的一些设置，如协议，SMTP地址，是否验证的设置信息 

javax.mail.Session类 
代表一个邮件session. 有session才有通信。

javax.mail.InternetAddress类 
Address确定信件地址。

javax.mail.MimeMessage类 
Message对象将存储发送的电子邮件信息，如主题，内容等等

javax.mail.Transport类 
 Transport传输邮件类，采用send方法是发送邮件。
 * */
package com.ggs.util.mail;

import com.ggs.dao.DataDao;

//JavaMail发送例子
public class MailUtil {


    private static String EMAIL_SMTP="";
    private static String EMAIL="";
    private static String EMAIL_PWD="";
    static{
        EMAIL_SMTP= DataDao.getConf("EMAIL_SMTP");
        EMAIL= DataDao.getConf("EMAIL");
        EMAIL_PWD= DataDao.getConf("EMAIL_PWD");
    }

	public static void main(String[] args) {

	}
    /**
     * 发送邮件
     * */
    public static void sendEmail(String to,String title,String content){
        AjavaSendMail sm = new AjavaSendMail(EMAIL_SMTP);
        sm.setNamePass(EMAIL, EMAIL_PWD);
        sm.setSubject(title);
        sm.setFrom(EMAIL);
        sm.setTo(to);
        sm.setText(content);
        sm.createMimeMessage();
        sm.setOut();
    }

    /**
     * 带附件
     * */
    public static void sendEmail(String to,String title,String content,String filename){
        AjavaSendMail sm = new AjavaSendMail(EMAIL_SMTP);
        sm.setNamePass(EMAIL, EMAIL_PWD);
        sm.setSubject(title);
        sm.setFrom(EMAIL);
        sm.setTo(to);
        sm.addFileAffix(filename);
        sm.setText(content);
        sm.createMimeMessage();
        sm.setOut();
    }
}
