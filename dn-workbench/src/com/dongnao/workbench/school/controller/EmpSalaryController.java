package com.dongnao.workbench.school.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.annotation.Resource;
import javax.mail.Address;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.model.ConvertAnchor;
import org.eclipse.jdt.internal.compiler.ast.MagicLiteral;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.dongnao.workbench.accountflow.model.AccountFlow;
import com.dongnao.workbench.accountflow.service.AccountFlowService;
import com.dongnao.workbench.basic.model.UserInfo;
import com.dongnao.workbench.common.excel.ExcelUtils;
import com.dongnao.workbench.common.excel.ExpParamBean;
import com.dongnao.workbench.common.excel.ImportExcelUtil;
import com.dongnao.workbench.common.page.Page;
import com.dongnao.workbench.common.util.AjaxUtils;
import com.dongnao.workbench.common.util.DateUtil;
import com.dongnao.workbench.common.util.FormatEntity;
import com.dongnao.workbench.common.util.StringUtil;
import com.dongnao.workbench.common.util.Utils;
import com.dongnao.workbench.school.model.EmpNotice;
import com.dongnao.workbench.school.model.EmpSalary;
import com.dongnao.workbench.school.model.Employee;
import com.dongnao.workbench.school.model.LeaveApply;
import com.dongnao.workbench.school.service.EmpSalaryService;
import com.dongnao.workbench.school.service.EmployeeService;
import com.sun.mail.handlers.text_plain;

import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import sun.org.mozilla.javascript.internal.regexp.SubString;

import java.util.Properties;

import javax.mail.Address;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.NoSuchProviderException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.Store;

/**
 * 描述：员工工资表模块controller类，负责页面分发与跳转
 * 
 * @author maggie
 * @version 1.0 2016-12-14
 */
 
@Controller
@RequestMapping("empSalary")
public class EmpSalaryController{
    @Resource
	private EmployeeService employeeService;
    @Resource
	private AccountFlowService accountFlowService;
    @Resource
	private EmpSalaryService empSalaryService;
	 
 	/**
 	* 进入新增页面
 	* @return ModelAndView 返回到新增页面
 	*/
 	@RequestMapping("/toAddEmpSalary")
	public ModelAndView toAdd(){
 		ModelAndView mv =  new ModelAndView("WEB-INF/jsp/school/empSalary/addEmpSalary");
 		mv.addObject("empList",employeeService.listByCondition(null));
 		return mv;
 	}
 	/**
 	* （自动生成工资条）
 	* @return ModelAndView 返回到新增页面
 	*/
 	@RequestMapping("/toAutoAddEmpSalary")
	public void autoAdd(HttpServletResponse response){
 		EmpSalary empSalary = new EmpSalary();
 		Calendar c = Calendar.getInstance();
 		c.add(Calendar.MONTH, -1);
 		empSalary.setCreateDate(c.getTime());
 		empSalary.setSendFlag("1");
		empSalary.setCheckFlag("1");
		empSalary.setAssignFlag("1");
		if(empSalaryService.listByCondition(empSalary).size()>0){
			Map<String, String> map = new HashMap<String, String>();
			map.put("message", "已生成该月数据");
			AjaxUtils.sendAjaxForObject(response, map);
			return;
		}
 		AjaxUtils.sendAjaxForObjectStr(response,empSalaryService.autoAdd(empSalary));	
	}
 	
 	
 	 /**
     * 读取Excel的内容，第一维数组存储的是一行中格列的值，二维数组存储的是多少个行
     * @param file 读取数据的源Excel
     * @param ignoreRows 读取数据忽略的行数，比喻行头不需要读入 忽略的行数为1
     * @return 读出的Excel中数据的内容
     * @throws FileNotFoundException
     * @throws IOException
     */
 	@RequestMapping("/uploadExcelData")
	public void uploadExcelData(HttpServletRequest request,HttpServletResponse response
		)throws Exception {  	
 		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
 		InputStream in =null;  
        List<List<Object>> listob = null;  
        MultipartFile file = multipartRequest.getFile("file");  
        if(file.isEmpty()){  
            throw new Exception("文件不存在！");  
        }  
        in = file.getInputStream();  
        listob = new ImportExcelUtil().getBankListByExcel(in,file.getOriginalFilename());
        //该处可调用service相应方法进行数据保存到数据库中，现只对数据输出  
        for (int i = 1; i < listob.size(); i++) {  
            List<Object> lo = listob.get(i);  
            EmpSalary empSalary = new EmpSalary();  
            Calendar c = Calendar.getInstance();
     		c.add(Calendar.MONTH, -1);
            try{
            	empSalary.setCreateDate(c.getTime());
            	empSalary.setEmpNo(StringUtil.valueOf(lo.get(1)));
            	empSalary.setEmpName(StringUtil.valueOf(lo.get(2)));
                empSalary.setEmpNickName(StringUtil.valueOf(lo.get(3)));  
                Employee employee = employeeService.getEmpByEmpNo(StringUtil.valueOf(lo.get(1)));
                empSalary.setEmpId(employee.getId());
                empSalary.setId(employee.getId());
                empSalary.setCheckFlag("1");
                empSalary.setSendFlag("1");
                if(StringUtil.valueOf(lo.get(4)).indexOf("农行")>0){empSalary.setEmpBank("中国农业银行");}
                else{empSalary.setEmpBank("中国建设银行");}
                empSalary.setEmpBankCard(StringUtil.valueOf(lo.get(4)));   
                empSalary.setEmpMobile(StringUtil.valueOf(lo.get(5)));
                empSalary.setLeaveDay(StringUtil.toDouble(lo.get(6)));
                empSalary.setEmpEntryDate(StringUtil.valueOf(lo.get(9)));
                empSalary.setEmpBeFullDate(StringUtil.valueOf(lo.get(10)));
                empSalary.setBasicSalary(StringUtil.toDouble(lo.get(11)));
                /*empSalary.setDutyLevelSalary(employee.getSalary());*/
                empSalary.setShouldSalary(StringUtil.toDouble(lo.get(12)));
                empSalary.setSocialSecurity(StringUtil.toDouble(lo.get(13)));
            	empSalary.setLateEarlyTime(StringUtil.toInteger(lo.get(7)));
            	empSalary.setAttendanceAnomalyTime(StringUtil.toInteger(lo.get(8)));
                empSalary.setLeaveCost(StringUtil.toDouble(lo.get(14)));
                empSalary.setLateEarlyCost(StringUtil.toDouble(lo.get(15)));
                empSalary.setAttendanceAnomalyCost(StringUtil.toDouble(lo.get(16)));
                empSalary.setTableMoney(StringUtil.toDouble(lo.get(19)));
                empSalary.setHousingAllowance(StringUtil.toDouble(lo.get(20)));
                empSalary.setMeritRaise(StringUtil.toDouble(lo.get(21)));
                empSalary.setRests(StringUtil.toDouble(lo.get(22)));
                empSalary.setActualSalary(StringUtil.toDouble(lo.get(23)));
                empSalary.setNote(StringUtil.valueOf(lo.get(24)));
                empSalaryService.add(empSalary);
            }catch(Exception e){
            	continue;
            }
        }  
        PrintWriter out = null;  
        response.setCharacterEncoding("utf-8");  //防止ajax接受到的中文信息乱码  
        out = response.getWriter();  
        out.print("文件导入成功！");  
        out.flush();  
        out.close();  
	}
 	
 	
	/**
	 * 进入查看页面方法
	 * @param key String：实体id
	 * @return ModelAndView: 查询实体
	 */	
	@RequestMapping("/toShowEmpSalary")
	public ModelAndView toShow(String key){
		EmpSalary entity = empSalaryService.getByPrimaryKey(key);
		Map<String,String> empSalary = FormatEntity.getObjectValue(entity);
		return new ModelAndView("WEB-INF/jsp/school/empSalary/showEmpSalary","empSalary",empSalary );
	}
	
	
	/**
	 * 进入发送页面方法
	 * @param key String：实体id
	 * @return ModelAndView: 查询实体
	 */	
	@RequestMapping("/toSendEmpSalary")
	public ModelAndView toSend(String key,HttpServletResponse response){
		ModelAndView mv = new ModelAndView("WEB-INF/jsp/school/empSalary/sendMailList");
		EmpSalary empSalary = new EmpSalary();
		empSalary.setCheckFlag("2");
		empSalary.setSendFlag("1");
		mv.addObject("empSalaryList", empSalaryService.listByCondition(empSalary));
		return mv;
	}
	
	/**
	 * 发送方法
	 * @param key String：实体id
	 * @return ModelAndView: 查询实体
	 * @throws MessagingException 
	 * @throws AddressException 
	 */	
	@RequestMapping("/sendEmpSalary")
	public void Send(String key,HttpServletResponse response) throws AddressException, MessagingException{
		 	Properties props = new Properties();  
	        props.setProperty("mail.debug", "true");  // 开启debug调试  
	        props.setProperty("mail.smtp.auth", "true");   // 发送服务器需要身份验证  
	        props.setProperty("mail.host", "smtp.exmail.qq.com");  // 设置邮件服务器主机名  
	        props.setProperty("mail.transport.protocol", "smtp");    // 发送邮件协议名称  
	        Session session = Session.getInstance(props);  // 设置环境信息  
	        
	        String sendFrom = "suqin@dongnaoedu.com";
      		String sendPwd = "Sq123456";
	        
      		//1.通过id， 根据employee表取到所有的发送人邮箱地址 设置为 sendTo
	        //2.通过id， 根据empSalary表取到需要发送的内容 设置为 sendBody
        	EmpSalary empSalary = empSalaryService.getByPrimaryKey(key);
        	Employee employee = employeeService.getByPrimaryKey(empSalary.getEmpId());
        	String sendTo = employee.getFoxmail();
        	if(sendTo==null){
        		empSalary.setNote("未填写收件邮箱");
        		AjaxUtils.sendAjaxForObjectStr(response,empSalary);	
        		return;
        	}
      		String subject = employee.getNickName()+"工资条";
      		if(sendEmail(session,sendFrom,sendPwd,sendTo,subject,empSalary,employee)){
      			empSalary.setSendFlag("2");
    			empSalary.setSendDate(DateUtil.now());
    			empSalaryService.send(empSalary);
    			 //最后返回该工资条数据给客户端
 	    	   AjaxUtils.sendAjaxForObjectStr(response,empSalary);
      		}else{
      			empSalary.setNote("邮件服务器连接错误");
            	AjaxUtils.sendAjaxForObjectStr(response,empSalary);	
      		}
	     }
	private boolean sendEmail(Session session, String sendFrom,String sendPwd, String sendTo, String subject, EmpSalary empSalary,Employee employee) throws MessagingException {
		Message msg = new MimeMessage(session);   // 创建邮件对象  
		msg.setFrom(new InternetAddress(sendFrom)); // 发件人地址
		msg.setSubject(subject);// 邮件主题
		MimeBodyPart mbp = new MimeBodyPart();
        String htmlText = "<h3>"
        		+ "注：1、请核对好工资、卡号，如有疑问，请及时到行政部核对，核对截止时间今日15:00；</br>"
        		+"    2、薪酬工资属于保密，核对无误后，请及时删除本邮件；</br>"
        		+ "3、该工资条属于"+DateUtil.parseDate(empSalary.getCreateDate(), "yyyy-MM")+"月份工资。</h3>"
        		+ "<table  border='2' ><thead><tr><th>姓名</th><th>昵称</th>"
        		+ "<th>银行</th><th>卡号</th><th>电话号码</th><th>请假天数</th><th>迟到早退（次）</th>"
        		+ "<th>打卡异常（次）</th><th>入职时间</th><th>转正日期</th><th>基本工资</th>"
        		/*+ "<th>薪级工资</th>"*/
        		+ "<th>应发工资</th><th>社保扣款</th><th>请假扣款</th>"
        		+ "<th>迟到早退扣款</th><th>打卡异常扣款</th><th>餐补</th><th>住房补贴</th>"
        		+ "<th>绩效奖金</th><th>其他奖金</th><th>实发工资</th><th>备注</th></tr></thead>"
        		+ "<tbody><tr>"
        		+ "<td>"+StringUtil.valueOf(empSalary.getEmpName())+"</td>"
        		+ "<td>"+StringUtil.valueOf(empSalary.getEmpNickName())+"</td>"
				+ "<td>"+StringUtil.valueOf(empSalary.getEmpBank())+"</td>"
        		+ "<td>"+StringUtil.valueOf(empSalary.getEmpBankCard())+"</td>"
        		+ "<td>"+StringUtil.valueOf(empSalary.getEmpMobile())+"</td>"
        		+ "<td>"+StringUtil.toDouble(empSalary.getLeaveDay())+"</td>"
        		+ "<td>"+StringUtil.toInteger(empSalary.getLateEarlyTime())+"</td>"
        		+ "<td>"+StringUtil.toInteger(empSalary.getAttendanceAnomalyTime())+"</td>"
        		+ "<td>"+StringUtil.valueOf(empSalary.getEmpEntryDate())+"</td>"
        		+ "<td>"+StringUtil.valueOf(empSalary.getEmpBeFullDate())+"</td>"
        		+ "<td>"+StringUtil.toDouble(empSalary.getBasicSalary())+"</td>"
        		/*+ "<td>"+empSalary.getDutyLevelSalary()==null?"":+empSalary.getDutyLevelSalary()+"</td>"*/
        		+ "<td>"+StringUtil.toDouble(empSalary.getShouldSalary())+"</td>"
        		+ "<td>"+StringUtil.toDouble(empSalary.getSocialSecurity())+"</td>"
        		+ "<td>"+Math.round(StringUtil.toDouble(empSalary.getLeaveCost()))+"</td>"
        		+ "<td>"+StringUtil.toDouble(empSalary.getLateEarlyCost())+"</td>"
        		+ "<td>"+StringUtil.toDouble(empSalary.getAttendanceAnomalyCost())+"</td>"
        		+ "<td>"+StringUtil.toDouble(empSalary.getTableMoney())+"</td>"
        		+ "<td>"+StringUtil.toDouble(empSalary.getHousingAllowance())+"</td>"
        		+ "<td>"+StringUtil.toDouble(empSalary.getMeritRaise())+"</td>"
        		+ "<td>"+StringUtil.toDouble(empSalary.getRests())+"</td>"
        		+ "<td>"+Math.round(StringUtil.toDouble(empSalary.getActualSalary()))+"</td>"
        		+ "<td>"+StringUtil.valueOf(empSalary.getNote())+"</td>"
        		+ "</tr></tbody></table>"
		;
        mbp.setContent(htmlText,"text/html;charset=UTF-8");
        MimeMultipart mp = new MimeMultipart();
        // 创建Multipart
        mp.addBodyPart(mbp);
        // 把前面定义的正文和附件都添加到Multipart中
        msg.setContent(mp,"text/html");
		Transport transport = session.getTransport();   // 连接邮件服务器  
		try {
			transport.connect(sendFrom, sendPwd);// 发件人账号密码
			transport.sendMessage(msg, new Address[] {new InternetAddress(sendTo)});  
			transport.close(); 
			return true;
		} catch (MessagingException e) {
			e.printStackTrace();
			transport.close(); // 关闭连接
			return false;
		}
	}
	/**
	 * 新增方法
	 * @param response HttpServletResponse
	 * @param empSalary EmpSalary:实体类
	 * @return: ajax输入json字符串
	 */
	@RequestMapping("/addEmpSalary")
	public void add(EmpSalary empSalary,HttpServletRequest request,HttpServletResponse response){
	empSalary.setId(empSalary.getEmpId());
	empSalary.setCreateDate(DateUtil.now());
	empSalary.setSendFlag("1");
	empSalary.setCheckFlag("1");
	empSalary.setAssignFlag("1");
	AjaxUtils.sendAjaxForObjectStr(response,empSalaryService.add(empSalary));		
	}
	
	/**
	 * 新增多条数据方法
	 * @param response HttpServletResponse
	 * @param empSalary EmpSalary:实体类
	 * @return: ajax输入json字符串
	 */
	@RequestMapping("/addLotEmpSalary")
	public void addLot(@RequestBody String param,HttpServletRequest request,HttpServletResponse response){
		if(param == null) {
			return;	
		}
		JSONArray ja = JSONArray.fromObject(param);
		for(Object o : ja) {
			JSONObject jo = (JSONObject)o;
			EmpSalary empSalary = new EmpSalary();
			empSalary.setId(Utils.generateUniqueID());
			empSalary.setCreateDate(DateUtil.now());
			empSalary.setEmpId(jo.getString("id"));
			empSalary.setBasicSalary(jo.getDouble("salValue"));
			empSalary.setDutyLevelSalary(jo.getDouble("salary"));
			empSalary.setLeaveDay(jo.getDouble("leaveDays"));
			empSalary.setSendFlag("1");
			empSalary.setCheckFlag("1");
			empSalary.setAssignFlag("1");
			empSalaryService.add(empSalary);
		}
	}
	
	/**
	 * 删除方法
	 * @param response HttpServletResponse
	 * @param key String:多个由“，”分割开的id字符串
	 * @return: ajax输入json字符串
	 */
	@RequestMapping("/deleteEmpSalary")
	public void deleteByKey(String key,HttpServletResponse response){
		String[] str = key.split(",");
		for(int i=0;i<str.length;i++){
			empSalaryService.deleteByKey(str[i]);
		}
		Map<String, String> map = new HashMap<String, String>();
		map.put("msg", "成功");
		AjaxUtils.sendAjaxForMap(response, map);
	}
	/**
	 * 审核方法
	 */
	@RequestMapping("/auditEmpSalary")
	public void auditLeaveApply(String key,HttpServletRequest request,HttpServletResponse response){
		UserInfo user=Utils.getLoginUserInfo(request);
		String checkId = user.getId();
		Map<String, String> map = new HashMap<String, String>();
		Calendar calendar = Calendar.getInstance();
		
		String[] str = key.split(",");
		for(int i=0;i<str.length;i++){
			EmpSalary entity = empSalaryService.getByPrimaryKey(str[i]);
			Employee emp = employeeService.getByPrimaryKey(str[i]);
			String flag = entity.getCheckFlag();
			if("1".equals(flag)){
				try{
				entity.setId(Utils.generateUniqueID());
				entity.setLateEarlyCost(entity.getLateEarlyTime()*30.0);
				entity.setAttendanceAnomalyCost(entity.getAttendanceAnomalyTime()*50.0);
				entity.setLeaveCost((entity.getBasicSalary()/30)*entity.getLeaveDay());
				entity.setTableMoney(entity.getTableMoney());
				entity.setHousingAllowance(entity.getHousingAllowance());
				entity.setMeritRaise(entity.getMeritRaise());
				entity.setRests(entity.getRests());
				/*entity.setDutyLevelSalary(emp.getSalary());*/
				entity.setSocialSecurity(entity.getSocialSecurity());
				/*entity.setShouldSalary(emp.getSalValue()+emp.getSalary());*/
				/*entity.setActualSalary(emp.getSalValue()+emp.getSalary()
						+entity.getTableMoney()
						+entity.getHousingAllowance()
						+entity.getMeritRaise()
						+entity.getRests()
						-entity.getSocialSecurity()
						-entity.getLateEarlyTime()*30.0
						-entity.getAttendanceAnomalyTime()*50.0
						-(emp.getSalValue()/30)*entity.getLeaveDay()
						);*/
				entity.setEmpId(str[i]);
				entity.setCheckId(checkId);
				entity.setCheckFlag("2");
				entity.setCheckDate(calendar.getTime());
				empSalaryService.audit(entity);
				}catch(Exception e){
					map.put("msg", "审核失败，部分数据未完善");
					AjaxUtils.sendAjaxForMap(response, map);
					continue;
				}
			}else{
				continue;
			}
		}
		map.put("msg", "审核成功");
		AjaxUtils.sendAjaxForMap(response, map);
	}
	/**
	 * 进入列表页面
	 * @return ModelAndView
	 */
	@RequestMapping("/toListEmpSalary")
	public ModelAndView toList(){
		return new ModelAndView("WEB-INF/jsp/school/empSalary/listEmpSalary");
	}
	
	/**
	 * 进入发放列表页面
	 * @return ModelAndView
	 */
	@RequestMapping("/toListEmpSalaryBySender")
	public ModelAndView toListBySender(){
		return new ModelAndView("WEB-INF/jsp/school/empSalary/listEmpSalaryBySender");
	}
	
	/**
	 * 根据条件查找列表方法
	 * @param empSalary EmpSalary：实体对象（查询条件）
	 * @param request HttpServletRequest
	 * @param response HttpServletResponse
	 * @param page Page:分页对象
	 * @return: ajax输入json字符串
	 */
	@RequestMapping("/listEmpSalary")
	public void listByCondition(EmpSalary empSalary,HttpServletRequest request,
			HttpServletResponse response, Page page){
		empSalary.setPage(page);	
		List<EmpSalary> list = empSalaryService.listByCondition(empSalary);
		AjaxUtils.sendAjaxForPage(request, response, page, list);
	}
	
	/**
	 * 进入修改页面方法
	 * @param key String：实体id
	 * @return ModelAndView: 查询实体
	 */	
	@RequestMapping("/toEditEmpSalary")
	public ModelAndView toEdit(String key){
		EmpSalary entity = empSalaryService.getByPrimaryKey(key);
		Map<String,String> empSalary = FormatEntity.getObjectValue(entity);
		
		return new ModelAndView("WEB-INF/jsp/school/empSalary/editEmpSalary","empSalary",empSalary );
	}
	
	/**
	 * 修改方法
	 * @param empSalary EmpSalary：实体对象
	 * @param response HttpServletResponse
	 * @return: ajax输入json字符串
	 */	
	@RequestMapping("/updateEmpSalary")
	public void update(EmpSalary empSalary,HttpServletRequest request,HttpServletResponse response){
		AjaxUtils.sendAjaxForObjectStr(
				response,empSalaryService.update(empSalary));	
	}
	
	

	/**
	 * 工资成功发放后添加记录到流水表
	 * @param response HttpServletResponse
	 * @param key String:多个由“，”分割开的id字符串
	 * @return: ajax输入json字符串
	 */
	@RequestMapping("/insertSalary")
	public void insertSalary(String key,HttpServletRequest request,HttpServletResponse response){
		Calendar calendar = Calendar.getInstance();
		Map<String, String> map = new HashMap<String, String>();
		java.text.DecimalFormat   df   =new   java.text.DecimalFormat("#.00");//格式化小数点后两位  
		String[] str = key.split(",");
		for(int i=0;i<str.length;i++){
			EmpSalary entity = empSalaryService.getByPrimaryKey(str[i]);
			String flag = entity.getAssignFlag();
			if(flag!=null){
				if(!flag.equals("2")){
					//添加工资记录到财务流水信息
					AccountFlow accountFlow = new AccountFlow();
					accountFlow.setId(Utils.generateUniqueID());
					accountFlow.setIsAccount(1);//是否结转
					accountFlow.setCreateDate(calendar.getTime());
					accountFlow.setMoney((df.format(entity.getActualSalary())).toString());//actual——salary
					accountFlow.setAccountId("71f63df7-9c58-469c-ab8d-c452e3e00bb8");
					accountFlow.setAccountNo("GZZC");
					accountFlow.setAccountName("工资支出");
					accountFlow.setAccountType(2);
					accountFlow.setNote("员工工资");
					accountFlow.setEmpId(entity.getEmpId());
					accountFlowService.add(accountFlow);
					entity.setAssignFlag("2");
					entity.setNote("已生成流水");
					empSalaryService.assign(entity);
				}
				map.put("msg", "成功");
			}else{
				map.put("msg", "存在工资流水插入失败的记录");
			}
		}
		
		
		AjaxUtils.sendAjaxForMap(response, map);
	}
	
	/**
	 * 操作方法
	 * @param empSalary EmpSalary：实体对象
	 * @param response HttpServletResponse
	 * @return: ajax输入json字符串
	 */	
	@RequestMapping("/operEmpSalary")
	public void oper(EmpSalary empSalary,HttpServletRequest request,HttpServletResponse response){
		String operType = StringUtils.defaultIfEmpty(request.getParameter("oper"), StringUtils.EMPTY);
		switch (operType) {
		case "del":
			empSalaryService.deleteByKey(empSalary.getId());
			break;
		case "edit":
			try {
				empSalary.setEmpBank(empSalary.getEmpBank());
				empSalary.setEmpBankCard(empSalary.getEmpBankCard());
				empSalary.setLateEarlyCost(empSalary.getLateEarlyTime()*30.0);
				empSalary.setAttendanceAnomalyCost(empSalary.getAttendanceAnomalyTime()*50.0);
				empSalary.setLeaveCost(empSalary.getLeaveCost());
				empSalary.setTableMoney(empSalary.getTableMoney());
				empSalary.setHousingAllowance(empSalary.getHousingAllowance());
				empSalary.setMeritRaise(empSalary.getMeritRaise());
				empSalary.setRests(empSalary.getRests());
				/*empSalary.setDutyLevelSalary(empSalary.getDutyLevelSalary());*/
				empSalary.setSocialSecurity(empSalary.getSocialSecurity());
				empSalary.setShouldSalary(empSalary.getShouldSalary());
				empSalary.setActualSalary(empSalary.getShouldSalary()
						+empSalary.getTableMoney()
						+empSalary.getHousingAllowance()
						+empSalary.getMeritRaise()
						+empSalary.getRests()
						-empSalary.getSocialSecurity()
						-empSalary.getLateEarlyTime()*30.0
						-empSalary.getAttendanceAnomalyTime()*50.0
						-(empSalary.getBasicSalary()/30)*empSalary.getLeaveDay()
						);
			} catch (Exception e) {
				empSalary.setLateEarlyCost(0.0);
				empSalary.setAttendanceAnomalyCost(0.0);
				empSalary.setLeaveCost(0.0);
				empSalary.setTableMoney(0.0);
				empSalary.setHousingAllowance(0.0);
				empSalary.setMeritRaise(0.0);
				empSalary.setRests(0.0);
				/*empSalary.setDutyLevelSalary(0.0);*/
				empSalary.setSocialSecurity(0.0);
				empSalary.setShouldSalary(0.0);
				empSalary.setActualSalary(0.0);
			}finally {
				AjaxUtils.sendAjaxForObjectStr(response,empSalaryService.update(empSalary));
			}
			break;
		default:
			return;
		}
	}
	/**
	 * 获取统计数据
	 * @return ModelAndView
	 */
	@RequestMapping("/getEmpSalaryStatistic")
	public void getEmpSalaryStatistic(EmpSalary empSalary ,HttpServletRequest request,HttpServletResponse response) {
			Map<Object,Object> model = new HashMap<Object,Object>();
			model.put("curr", empSalaryService.getEmpSalaryStatistic(empSalary));
			AjaxUtils.sendAjaxForMap(response, model);
	}
}