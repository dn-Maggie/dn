package com.dongnao.workbench.common.controller;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;
import java.util.Random;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;

public class JavaMailWithAttachment {
	
	/** 
     * Message对象将存储我们实际发送的电子邮件信息， 
     * Message对象被作为一个MimeMessage对象来创建并且需要知道应当选择哪一个JavaMail session。 
     */  
    private MimeMessage message;
    private Session session;
    private Transport transport;

    private String mailHost = "";
    private String sender_username = "";
    private String sender_password = "";

    private Properties properties = new Properties();

    /*
     * 初始化方法
     */
    public JavaMailWithAttachment(boolean debug) {
        try {
            properties.setProperty("mail.debug", "true");  // 开启debug调试  
            properties.setProperty("mail.smtp.auth", "true");   // 发送服务器需要身份验证  
            //properties.setProperty("mail.smtp.host", "smtp.qq.com");  // 设置邮件服务器主机名  
            properties.setProperty("mail.transport.protocol", "smtp");    // 发送邮件协议名称  
            properties.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
            properties.setProperty("mail.smtp.port", "465");
           /* int num = new Random().nextInt(3);
            switch (num) {
			case 0:
				 properties.setProperty("mail.smtp.host", "smtp.126.com");
				 properties.setProperty("mail.sender.username", "hndongnao@126.com");    // 发送邮件地址 
		         properties.setProperty("mail.sender.password", "dongnao123");    // 发送邮件地址   
				break;
			case 1:
				 properties.setProperty("mail.smtp.host", "smtp.163.com");
				 properties.setProperty("mail.sender.username", "HNdongnaoedu@163.com");    // 发送邮件地址 
		         properties.setProperty("mail.sender.password", "dongnao123");    // 发送邮件地址   
				break;
			case 2:
				 properties.setProperty("mail.smtp.host", "smtp.qq.com");
				 properties.setProperty("mail.sender.username", "413538864@qq.com");    // 发送邮件地址 
		         properties.setProperty("mail.sender.password", "jkrcrsdbjveecaje");    // 发送邮件地址   
				break;
			default:
				properties.setProperty("mail.smtp.host", "smtp.126.com");
				 properties.setProperty("mail.sender.username", "hndongnaoedu@126.com");    // 发送邮件地址 
		         properties.setProperty("mail.sender.password", "dongnao123");    // 发送邮件地址   
				break;
			}*/
            properties.setProperty("mail.smtp.host", "smtp.163.com");
			 properties.setProperty("mail.sender.username", "HNdongnaoedu@163.com");    // 发送邮件地址 
	         properties.setProperty("mail.sender.password", "dongnao123");    // 发送邮件地址   
            properties.setProperty("mail.smtp.socketFactory.port","465");
            
            this.mailHost = properties.getProperty("mail.smtp.host");
            this.sender_username = properties.getProperty("mail.sender.username");
            this.sender_password = properties.getProperty("mail.sender.password");
        } catch (Exception e) {
            e.printStackTrace();
        }

        session = Session.getInstance(properties);
        session.setDebug(debug);// 开启后有调试信息
        message = new MimeMessage(session);
    }

    /**
     * 发送邮件
     * 
     * @param subject
     *            邮件主题
     * @param sendHtml
     *            邮件内容
     * @param receiveUser
     *            收件人地址
     * @param attachment
     *            附件
     */
    public void doSendHtmlEmail(String subject, String sendHtml, String receiveUser, File attachment,File attachment2) {
        try {
            // 发件人
            InternetAddress from = new InternetAddress(sender_username);
            message.setFrom(from);

            // 收件人
            InternetAddress to = new InternetAddress(receiveUser);
            message.setRecipient(Message.RecipientType.TO, to);

            // 邮件主题
            message.setSubject(subject);

            // 向multipart对象中添加邮件的各个部分内容，包括文本内容和附件
            Multipart multipart = new MimeMultipart();
            
            // 添加邮件正文
            BodyPart contentPart = new MimeBodyPart();
            contentPart.setContent(sendHtml, "text/html;charset=UTF-8");
            multipart.addBodyPart(contentPart);
            
            // 添加附件的内容
            if (attachment != null) {
                BodyPart attachmentBodyPart = new MimeBodyPart();
                DataSource source = new FileDataSource(attachment);
                attachmentBodyPart.setDataHandler(new DataHandler(source));
                
                // 网上流传的解决文件名乱码的方法，其实用MimeUtility.encodeWord就可以很方便的搞定
                // 这里很重要，通过下面的Base64编码的转换可以保证你的中文附件标题名在发送时不会变成乱码
                sun.misc.BASE64Encoder enc = new sun.misc.BASE64Encoder();
                attachmentBodyPart.setFileName("=?GBK?B?" + enc.encode(attachment.getName().getBytes()) + "?=");
                
                //MimeUtility.encodeWord可以避免文件名乱码
                attachmentBodyPart.setFileName(MimeUtility.encodeWord(attachment.getName()));
                multipart.addBodyPart(attachmentBodyPart);
            }
            
            // 添加附件的内容
            if (attachment2 != null) {
                BodyPart attachmentBodyPart = new MimeBodyPart();
                DataSource source = new FileDataSource(attachment2);
                attachmentBodyPart.setDataHandler(new DataHandler(source));
                
                // 网上流传的解决文件名乱码的方法，其实用MimeUtility.encodeWord就可以很方便的搞定
                // 这里很重要，通过下面的Base64编码的转换可以保证你的中文附件标题名在发送时不会变成乱码
                sun.misc.BASE64Encoder enc = new sun.misc.BASE64Encoder();
                attachmentBodyPart.setFileName("=?GBK?B?" + enc.encode(attachment2.getName().getBytes()) + "?=");
                
                //MimeUtility.encodeWord可以避免文件名乱码
                attachmentBodyPart.setFileName(MimeUtility.encodeWord(attachment2.getName()));
                multipart.addBodyPart(attachmentBodyPart);
            }
            
            // 将multipart对象放到message中
            message.setContent(multipart);
            // 保存邮件
           // message.saveChanges();
            transport = session.getTransport("smtp");
            // smtp验证，就是你用来发邮件的邮箱用户名密码
            transport.connect(mailHost, sender_username, sender_password);
            // 发送
            transport.sendMessage(message, message.getAllRecipients());
            transport.close(); 
            System.out.println("send success!");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (transport != null) {
                try {
                    transport.close();
                } catch (MessagingException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    public static void main(String[] args) {
        JavaMailWithAttachment se = new JavaMailWithAttachment(true);
        File pdf = new File("E:\\1.png");
        File xin = new File("E:\\1.png");
        String content = "亲爱的动脑VIP学员："
        +"为感谢我们动脑家人们，作为2017年中国-长沙互联网技术峰会承办单位的动脑科技，"
		+ "特设会场前排 钻石VIP席位诚邀动脑VIP家人共襄盛会，想要参加的学员提前联系班主任获取和预定VIP钻石席位，"
		+ "这场 饱含盛恩与回馈的大会，于2017年11月17日--21日，让我们相约在深秋的长沙，如您因工作或时间冲突等因素不能到场参与，"
		+ "也可通过订阅腾讯课堂中国·长沙技术互联网技术峰会线上直播同步观看。"
		+ "邀请函已发至您的QQ邮箱，请您确认收到后与班主任发送确认收到信息哦，谢谢。"
		+ "线上参与订阅地址：https://ke.qq.com/course/252543#tuin=a3544b2a";
        se.doSendHtmlEmail("测试邮件", content, "625546687@qq.com", pdf,xin);
    }
}
