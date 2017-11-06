package com.dongnao.workbench.common.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.util.List;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.annotation.Resource;
import javax.mail.Address;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.dongnao.workbench.common.util.AjaxUtils;
import com.dongnao.workbench.common.util.DateUtil;
import com.dongnao.workbench.common.util.StringUtil;
import com.dongnao.workbench.school.model.EmpSalary;
import com.dongnao.workbench.school.model.Employee;
import com.dongnao.workbench.vipStudent.model.VipStudent;
import com.dongnao.workbench.vipStudent.service.VipStudentService;
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Font;
import com.itextpdf.text.Image;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPageEventHelper;
import com.itextpdf.text.pdf.PdfTransition;
import com.itextpdf.text.pdf.PdfWriter;
import com.sun.xml.internal.messaging.saaj.packaging.mime.internet.MimeUtility;


@Controller
@RequestMapping("/base/")
public class BaseController {
	@Resource
	private VipStudentService vipStudentService;
	/**
	 * 获取警告视图
	 * 
	 * @param message
	 * @return
	 */
	public ModelAndView getWarningView(String message) {
		ModelAndView m = new ModelAndView("WEB-INF/jsp/common/warning");
		m.addObject("message", message);
		return m;
	}
	@RequestMapping("/main")
	public void main() {
		//批量制作，插入数据库学生姓名
		/*数据库获取学生姓名-课程*/
		VipStudent stu = new VipStudent();
		stu.setSubjectName("ANDROID");
		List<VipStudent> students = vipStudentService.listSendEmail(stu);
		for(int i = 0;i<students.size();i++){
			generatePdf(students.get(i));
			sendPdf(students.get(i));
		}
	}
	private void sendPdf(VipStudent vipStudent) {
		 JavaMailWithAttachment se = new JavaMailWithAttachment(true);
		 String stuName = vipStudent.getName().trim().replaceAll("\\d+","");
			if(stuName==null || stuName.length()==0){
				stuName = vipStudent.getQqNick();
			}
		 File pdf = new File("D:\\pdfTest\\"+vipStudent.getSubjectName()+"\\"+StringUtil.formatDateyyyyMM(vipStudent.getJoinTime())+"\\"+vipStudent.getName().trim().replaceAll("\\d+","")+"\\邀请函.pdf");
		 File xin = new File("D:\\pdfTest\\"+vipStudent.getSubjectName()+"\\"+StringUtil.formatDateyyyyMM(vipStudent.getJoinTime())+"\\"+vipStudent.getName().trim().replaceAll("\\d+","")+"\\感恩信.jpg");
	        String content = "亲爱的动脑VIP学员："
	        +"为了感谢您对我们的支持与肯定，作为2017年中国-长沙互联网技术峰会承办单位的动脑科技，"
			+ "特设会场前排 钻石VIP席位诚邀动脑VIP家人共襄盛会，想要参加的学员提前联系班主任预定和获取VIP钻石席位，"
			+ "这场 饱含盛恩与回馈的大会，于2017年11月17日--2017年11月21日隆重举行，让我们一起相约在深秋的长沙，如您因工作或时间冲突等因素不能到场参与，"
			+ "也可通过订阅腾讯课堂中国·长沙技术互联网技术峰会线上直播同步观看。"
			+ "邀请函已发至您的QQ邮箱，请您确认收到后与班主任发送确认收到信息哦，谢谢！"
			+ "线上参与订阅地址：https://ke.qq.com/course/252543#tuin=a3544b2a";
	        se.doSendHtmlEmail("致"+stuName+"的一封信", content, vipStudent.getQq()+"@qq.com", pdf,xin);
	}
	public void generatePdf(VipStudent student){
		//页面大小  
		Rectangle rect = new Rectangle(PageSize.B5.rotate());  
		
		Document doc = new Document(rect);  
		PdfWriter writer = null;
		BaseFont bfChinese = null;
		Font fontChinese = null;
		//创建目录路径
		String pdfPath = "D:\\pdfTest\\"+student.getSubjectName()+"\\"+StringUtil.formatDateyyyyMM(student.getJoinTime())+"\\"+student.getName().trim().replaceAll("\\d+","")+"\\邀请函.pdf";  
		File file = new File(pdfPath);  
		File fileParent = file.getParentFile();  
		if(!fileParent.exists()){  
		    fileParent.mkdirs();  
		}  
		try {
			file.createNewFile();
		} catch (IOException e1) {
			e1.printStackTrace();
		}  
		
		//向文件夹中插入信
		File srcFile = new File("E:\\接收文件\\来自QQ接收文件\\243781187\\FileRecv\\邀请\\邀请\\xin.jpg");    
		String xinPath = "D:\\pdfTest\\"+student.getSubjectName()+"\\"+StringUtil.formatDateyyyyMM(student.getJoinTime())+"\\"+student.getName().trim().replaceAll("\\d+","")+"\\感恩信.jpg";  
		File targetFile = new File(xinPath);  
		File fileParent2 = file.getParentFile();  
		if(!fileParent2.exists()){  
		    fileParent2.mkdirs();  
		}  
		try {
			targetFile.createNewFile();
		} catch (IOException e1) {
			e1.printStackTrace();
		}  
		 try {    
             InputStream in = new FileInputStream(srcFile);     
             OutputStream out = new FileOutputStream(targetFile);    
             byte[] bytes = new byte[1024];    
             int len = -1;    
             while((len=in.read(bytes))!=-1)  
             {    
                 out.write(bytes, 0, len);    
             }    
             in.close();    
             out.close();    
         } catch (FileNotFoundException e) {    
             e.printStackTrace();    
         } catch (IOException e) {    
             e.printStackTrace();    
         }    
		
		
		//向文件夹中创建pdf文件
		try {
			writer = PdfWriter.getInstance(doc, new FileOutputStream(pdfPath));
			 /**  新建一个字体,iText的方法 
		       *  STSongStd-Light 是字体，在iTextAsian.jar 中以property为后缀 
		       *  UniGB-UCS2-H   是编码，在iTextAsian.jar 中以cmap为后缀 
		       *  H 代表文字版式是 横版， 相应的 V 代表 竖版 
		      */
			//bfChinese = BaseFont.createFont("STSong-Light", "UniGB-UCS2-H", BaseFont.NOT_EMBEDDED);  
			//bfChinese = BaseFont.createFont("Font/HaTian-SuiXing.ttf,1",BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);  
			
			bfChinese = BaseFont.createFont("C:/WINDOWS/Fonts/HaTian-SuiXing.ttf", BaseFont.IDENTITY_H,BaseFont.NOT_EMBEDDED);    
	        fontChinese = new Font(bfChinese, 24, Font.BOLD);   
	        fontChinese.setColor(BaseColor.WHITE);
		} catch (FileNotFoundException | DocumentException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}  
		//PDF版本(默认1.4)  
		/*writer.setPdfVersion(PdfWriter.PDF_VERSION_1_2);  */
		writer.setViewerPreferences(PdfWriter.PageModeFullScreen);//全屏  
		writer.setPageEvent(new PdfPageEventHelper() {  
		    public void onStartPage(PdfWriter writer, Document document) {  
		        writer.setTransition(new PdfTransition(PdfTransition.DISSOLVE, 3));  
		        writer.setDuration(5);//间隔时间  
		    }  
		});  
		  

		//文档属性  
		doc.addTitle("邀请函");  
		doc.addAuthor("作者@动脑学院");  
		doc.addKeywords("关键字@长沙互联网峰会");  
		  
		//页边空白  
		//doc.setMargins(10, 20, 30, 40);  
		doc.setMargins(0, 0, 0, 0);  
		doc.open();  
		try {
			//设置内容
			/*第一页 ，放置封面图片*/
			Image img = null ;
			try {
				img = Image.getInstance("E:\\接收文件\\来自QQ接收文件\\243781187\\FileRecv\\邀请\\邀请\\1.png");
			} catch (MalformedURLException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}  
			img.scaleAbsolute(720,500);// 直接设定显示尺寸
			doc.add(img);  

			
			
			/*第二页 */
			doc.newPage();  
			/*放置学生姓名*/
			PdfContentByte cb = writer.getDirectContent();  
			cb.beginText();  
			cb.setFontAndSize(bfChinese,25);  
			cb.setColorFill(new BaseColor(212,125,71));
			cb.setTextMatrix(190, 400);  
			String stuName = student.getName().trim().replaceAll("\\d+","");
			if(stuName!=null && stuName.length()>0){
				if(stuName.length()>1 && stuName.length()<=2){
					stuName = stuName.substring(0,1)+" "+stuName.substring(1);
				}
				else if(stuName.length()>4){
					cb.setTextMatrix(170, 400);  
				}
			}else{
				stuName = student.getQqNick();
				if(stuName.length()>1 && stuName.length()<=2){
					stuName = stuName.substring(0,1)+" "+stuName.substring(1);
				}
				else if(stuName.length()>4){
					cb.setTextMatrix(170, 400);  
				}
			}
			cb.showText(stuName);  
			cb.endText(); 
			/*放置正文图片*/
			Image img2 = null ;
			try {
				img2 = Image.getInstance("E:\\接收文件\\来自QQ接收文件\\243781187\\FileRecv\\邀请\\邀请\\2.png");
				img2.setAbsolutePosition(0,0);
			} catch (MalformedURLException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}  
			img2.scaleAbsolute(720,500);// 直接设定显示尺寸
			doc.add(img2);  
			
			
			
			/*第三页 */
			doc.newPage(); 
			/*放置页尾*/
			Image img3 = null ;
			try {
				img3 = Image.getInstance("E:\\接收文件\\来自QQ接收文件\\243781187\\FileRecv\\邀请\\邀请\\3.jpg");
				img3.setAbsolutePosition(0,0);
			} catch (MalformedURLException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}  
			img3.scaleAbsolute(720,500);// 直接设定显示尺寸
			doc.add(img3);  
			
			
			
			/*第四页 */
			doc.newPage(); 
			Image img4 = null ;
			try {
				img4 = Image.getInstance("E:\\接收文件\\来自QQ接收文件\\243781187\\FileRecv\\邀请\\邀请\\4.jpg");
				img4.setAbsolutePosition(0,0);
			} catch (MalformedURLException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}  
			img4.scaleAbsolute(720,500);// 直接设定显示尺寸
			doc.add(img4);  
			
			
		} catch (DocumentException e) {
			e.printStackTrace();
		}  
		doc.close();  
	}
	
	
}
