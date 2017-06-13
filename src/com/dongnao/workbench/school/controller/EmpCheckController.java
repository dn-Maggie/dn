package com.dongnao.workbench.school.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.*;
import java.io.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dongnao.workbench.account.model.AccountFinance;
import com.dongnao.workbench.area.model.ChinaArea;
import com.dongnao.workbench.area.service.ChinaAreaService;
import com.dongnao.workbench.basic.model.Org;
import com.dongnao.workbench.basic.model.UserInfo;
import com.dongnao.workbench.basic.service.DutyLevelService;
import com.dongnao.workbench.basic.service.DutyService;
import com.dongnao.workbench.basic.service.OrgService;
import com.dongnao.workbench.common.excel.ExcelExpUtils;
import com.dongnao.workbench.common.excel.ExpParamBean;
import com.dongnao.workbench.common.page.Page;
import com.dongnao.workbench.common.util.AjaxUtils;
import com.dongnao.workbench.common.util.DateUtil;
import com.dongnao.workbench.common.util.Utils;
import com.dongnao.workbench.continuePay.model.ContinuePay;
import com.dongnao.workbench.course.model.Course;
import com.dongnao.workbench.course.service.CourseService;
import com.dongnao.workbench.fileUpload.FileUpload;
import com.dongnao.workbench.nation.model.Nation;
import com.dongnao.workbench.nation.service.NationService;
import com.dongnao.workbench.salary.model.SalStandard;
import com.dongnao.workbench.salary.service.SalStandardService;
import com.dongnao.workbench.common.util.FormatEntity;
import com.dongnao.workbench.school.model.CheckHtmlForm;
import com.dongnao.workbench.school.model.EmpCheck;
import com.dongnao.workbench.school.model.EmpSalary;
import com.dongnao.workbench.school.model.Employee;
import com.dongnao.workbench.school.service.EmpCheckService;
import com.dongnao.workbench.school.service.EmployeeService;
import com.dongnao.workbench.subject.model.Subject;
import com.dongnao.workbench.system.model.DictInfo;
import com.dongnao.workbench.system.service.DictInfoService;
import com.dongnao.workbench.vipRefund.model.VipRefund;
import com.dongnao.workbench.vipStudent.model.VipStudent;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


/**
 * 描述：员工模块controller类，负责页面分发与跳转
 * 
 * @author maggie
 * @version 1.0 2016-07-15
 */
 
@Controller
@RequestMapping("empCheck")
public class EmpCheckController{
	
	Logger logger = Logger.getLogger(EmpCheckController.class);// 日志
	
    @Resource
	private EmployeeService employeeService;
    @Resource
	private EmpCheckService empCheckService;
    @Resource
    private NationService nationService;
    @Resource
    private ChinaAreaService chinaAreaService;
    @Resource
    private OrgService orgService;
    @Resource
    private SalStandardService salStandardService;
    @Resource
    private DictInfoService dictInfoService;
    @Resource
	private DutyService dutyService;
    @Resource
	private DutyLevelService dutyLevelService;

	/**
	 * 进入员工考核页面
	 * @return ModelAndView
	 */
	@RequestMapping("/toListEmpCheck")
	public ModelAndView toList(HttpServletRequest request){
		ModelAndView mv = new ModelAndView("WEB-INF/jsp/school/empCheck/listEmpCheck");
//		Employee entity = employeeService.getByPrimaryKey(Utils.getLoginUserInfo(request).getId());
//		Org org = new Org();
//		org.setOrgNo(entity.getDeptNo());
// 		mv.addObject("org",orgService.listByCondition(org));
		Org org = new Org();
		org.setParentOrgId("1");
 		mv.addObject("org",orgService.listByCondition(org));
		return mv;
	}
	
	/**
	 * 根据条件查找列表方法
	 * @param empCheck EmpCheck：实体对象（查询条件）
	 * @param request HttpServletRequest
	 * @param response HttpServletResponse
	 * @param page Page:分页对象
	 * @return: ajax输入json字符串
	 */
	@RequestMapping("/listEmpCheck")
	public void listByCondition(EmpCheck empCheck,HttpServletRequest request,
			HttpServletResponse response, Page page){
		empCheck.setPage(page);	
		empCheck.setState(2);
		empCheck.setCheckPeople(Utils.getLoginUserInfo(request).getId());
		List<EmpCheck> list = empCheckService.listByCondition(empCheck);
		AjaxUtils.sendAjaxForPage(request, response, page, list);
	}
	
	/**
	 * 进入查看员工考核信息页面方法
	 * @param key String：实体id
	 * @return ModelAndView: 查询实体
	 */	
	@RequestMapping("/toShowAssinfo")
	public ModelAndView ShowAssinfo(String key){
		ModelAndView mv = new ModelAndView(
				"WEB-INF/jsp/school/empCheck/ShowAssessmentinfo");
		EmpCheck empCheck = empCheckService.getByPrimaryKey(key);
		mv.addObject("empCheck", empCheck);
		return mv;
	}
	
	/**
	 * 进入当月考核页面
	 * @return ModelAndView
	 */
	@RequestMapping("/toAssessment")
	public ModelAndView toAssessment(HttpServletRequest request){
		ModelAndView mv = new ModelAndView("WEB-INF/jsp/school/empCheck/Assessment");
/*		Employee entity = employeeService.getByPrimaryKey(Utils.getLoginUserInfo(request).getId());
		Org org = new Org();
		org.setOrgNo(entity.getDeptNo());
		org=orgService.listByCondition(org).get(0);
 		mv.addObject("org",org);*/
		return mv;
	}
	
	@RequestMapping("/saveAssinfo")
	public void saveAssinfo(EmpCheck empCheck,HttpServletRequest request,
			HttpServletResponse response, Page page){	
		empCheck.setCheckPeople(Utils.getLoginUserInfo(request).getId());
		List<EmpCheck> lt = empCheckService.listByCondition(empCheck);
		if(lt.size()>0){
			empCheck.setState(1);
			empCheck.setPage(page);	
			List<EmpCheck> list = empCheckService.listByCondition(empCheck);
			AjaxUtils.sendAjaxForPage(request, response, page, list);
		}else{
			Employee employee=new Employee();
			employee.setCheckName(Utils.getLoginUserInfo(request).getId());
			employee.setIsAssess(1);
			List<Employee> list = employeeService.listByCondition(employee);
			List<EmpCheck> empc = new ArrayList<EmpCheck>();
			Iterator it = list.iterator();
			while(it.hasNext()) {
				Employee e = (Employee) it.next();
				EmpCheck ec=new EmpCheck();
				ec.setEmpNo(e.getEmpNo());
				ec.setEmpName(e.getName());
				ec.setPost(e.getPosition());
				ec.setDepartment(e.getDept());
				ec.setCheckMonth(empCheck.getCheckMonth());
				ec.setBasePoints("");
				ec.setCheckPoint("");
				ec.setNickName(e.getNickName());
				ec.setState(1);
				ec.setCheckPeople(e.getCheckName());
				ec.setCheckStanderd(e.getCheckStanderd());
				empc.add(ec);
			}
			//插入部门所有员工未考核的数据
			if(empc.size()>0){
				empCheckService.add(empc);
			}
			empCheck.setPage(page);	
			List<EmpCheck> list2 = empCheckService.listByCondition(empCheck);
			AjaxUtils.sendAjaxForPage(request, response, page, list2);
		}
	}
	
/*	*//**
	 * 修改方法
	 * @param empCheck EmpCheck：实体对象
	 * @param response HttpServletResponse
	 * @return: ajax输入json字符串
	 *//*	
	@RequestMapping("/update")
	public void update(EmpCheck empCheck,HttpServletRequest request,HttpServletResponse response){
		empCheck.setState(2);
		AjaxUtils.sendAjaxForObjectStr(response,empCheckService.update(empCheck));	
	}
	*/
	/**
	 * 进入员工考核表格页面方法
	 * @param key String：实体id
	 * @return ModelAndView: 查询实体
	 */	
	@RequestMapping("/toCheckTable")
	public ModelAndView toCheckTable(String key){
		EmpCheck empCheck = empCheckService.getByPrimaryKey(key);
		String mvstr = "";
		int checkstanderd = 1;
		checkstanderd = empCheck.getCheckStanderd();
	    switch (checkstanderd){
	        case 2:mvstr = "WEB-INF/jsp/school/empCheck/module/kf";break;
	        case 3:mvstr = "WEB-INF/jsp/school/empCheck/module/gkkjs";break;
	        case 4:mvstr = "WEB-INF/jsp/school/empCheck/module/vipjs";break;
	        case 5:mvstr = "WEB-INF/jsp/school/empCheck/module/zj";break;
	        case 6:mvstr = "WEB-INF/jsp/school/empCheck/module/bzr";break;
	        default:mvstr = "WEB-INF/jsp/school/empCheck/module/znbm";break;
	    }
	    ModelAndView mv = new ModelAndView(mvstr);
		ArrayList<Object> arr = new ArrayList<>();
		for(int i=0;i<30;i++){
			arr.add(i+1);
		}
		mv.addObject("empCheck", empCheck);
		mv.addObject("arr", arr);
		return mv;
	}
	
	/**
	 * 员工考核--记录成绩与生成html文件方法
	 * @param response HttpServletResponse
	 * @return: ajax输入json字符串
	 */
	@RequestMapping("/checkproducehtml")
	public void addLot(CheckHtmlForm checkHtmlForm,HttpServletRequest request,HttpServletResponse response){
			EmpCheck empCheck = new EmpCheck();
			empCheck.setCheckMonth(checkHtmlForm.getCheckMonth());
			empCheck.setEmpName(checkHtmlForm.getEmpName());
			empCheck.setCheckPoint(checkHtmlForm.getTotalcore());
			empCheck.setState(2);
			empCheckService.update(empCheck);
			int checkStanderd = checkHtmlForm.getCheckStanderd();
			String filePath = "";
		    switch (checkStanderd){
		        case 2:filePath = "/usr/dnfile/checkmodel/kf.html";break;
		        case 3:filePath = "/usr/dnfile/checkmodel/gkkjs.html";break;
		        case 4:filePath = "/usr/dnfile/checkmodel/vipjs.html";break;
		        case 5:filePath = "/usr/dnfile/checkmodel/zj.html";break;
		        case 6:filePath = "/usr/dnfile/checkmodel/bzr.html";break;
		        default:filePath = "/usr/dnfile/checkmodel/znbm.html"; break;
//			    case 2:filePath = "D:\\TestFile\\kf.html";break;
//		        case 3:filePath = "D:\\TestFile\\gkkjs.html";break;
//		        case 4:filePath = "D:\\TestFile\\vipjs.html";break;
//		        case 5:filePath = "D:\\TestFile\\zj.html";break;
//		        case 6:filePath = "D:\\TestFile\\bzr.html";break;
//		        default:filePath = "D:\\TestFile\\znbm.html"; break;
		    }

	        try {
	        	System.setProperty("sun.jnu.encoding","UTF-8");
	        	final String encoding = System.getProperty("file.encoding");      
	            System.out.println("encoding-----------------------:"+encoding); 
	        	String templateContent = "";
	        	BufferedReader  r=new BufferedReader(new InputStreamReader(new FileInputStream(filePath),"UTF-8"));    
	            String str="";
	            while((str = r.readLine())!=null) {
	            	templateContent += str;
	            }
	            templateContent = templateContent.replaceAll("#name#", checkHtmlForm.getEmpName());
	        	templateContent = templateContent.replaceAll("#month#", checkHtmlForm.getCheckMonth());
	        	templateContent = templateContent.replaceAll("#core1#", checkHtmlForm.getCore1());
	        	templateContent = templateContent.replaceAll("#core2#", checkHtmlForm.getCore2());
	        	templateContent = templateContent.replaceAll("#core3#", checkHtmlForm.getCore3());
	        	templateContent = templateContent.replaceAll("#core4#", checkHtmlForm.getCore4());
	        	templateContent = templateContent.replaceAll("#core5#", checkHtmlForm.getCore5());
	        	templateContent = templateContent.replaceAll("#note1#", StringUtils.defaultIfEmpty(checkHtmlForm.getText1(),""));
	        	templateContent = templateContent.replaceAll("#note2#", StringUtils.defaultIfEmpty(checkHtmlForm.getText2(),""));
	        	templateContent = templateContent.replaceAll("#note3#", StringUtils.defaultIfEmpty(checkHtmlForm.getText3(),""));
	        	templateContent = templateContent.replaceAll("#note4#", StringUtils.defaultIfEmpty(checkHtmlForm.getText4(),""));
	        	templateContent = templateContent.replaceAll("#note5#", StringUtils.defaultIfEmpty(checkHtmlForm.getText5(),""));
	        	templateContent = templateContent.replaceAll("#total#", checkHtmlForm.getTotalcore());
	        	if(checkHtmlForm.getCore6()!=null){
	        		templateContent = templateContent.replaceAll("#core6#", checkHtmlForm.getCore6());
	        	}
	        	if(checkHtmlForm.getCore7()!=null){
	        		templateContent = templateContent.replaceAll("#core7#", checkHtmlForm.getCore7());
	        	}
	        	if(checkHtmlForm.getCore8()!=null){
	        		templateContent = templateContent.replaceAll("#core8#", checkHtmlForm.getCore8());
	        	}
	        	if(checkHtmlForm.getText6()!=null){
	        		templateContent = templateContent.replaceAll("#note6#", checkHtmlForm.getText6());
	        	}
	        	if(checkHtmlForm.getText7()!=null){
	        		templateContent = templateContent.replaceAll("#note7#", checkHtmlForm.getText7());
	        	}
	        	if(checkHtmlForm.getText8()!=null){
	        		templateContent = templateContent.replaceAll("#note8#", checkHtmlForm.getText8());
	        	}
	        	
	        	logger.debug("文件内容=====" + templateContent);
	        	String fileame = checkHtmlForm.getEmpNo() + "-" + checkHtmlForm.getCheckMonth() + ".html";//文件名
	        	//System.out.println(checkHtmlForm.getEmpName());
	        	fileame = "/usr/dnfile/checkfile/" + fileame;//生成的html文件保存路径。D:\\TestFile\\checkfile\\   --/usr/dnfile/checkfile/     	
	        	logger.debug("====================文件名1====================" + fileame);
	        	byte[] bytes = fileame.getBytes("UTF-8");
	        	String f = new String(bytes,"UTF-8");
	        	logger.debug("====================文件名2====================" + f);
//	        	BufferedWriter  writer1 = new BufferedWriter(new OutputStreamWriter(new FileOutputStream("/usr/dnfile/checkfile/test.text"),"UTF-8"));
//	        	writer1.write(f);     
//	        	writer1.flush();     
//	        	writer1.close(); 
//	        	BufferedReader  r2=new BufferedReader(new InputStreamReader(new FileInputStream("/usr/dnfile/checkfile/test.text"),"UTF-8"));    
//	            String str2="";
//	            String templateContent2="";
//	            while((str2 = r2.readLine())!=null) {
//	            	templateContent2 += str2;
//	            }
//	            logger.debug("====================templateContent2====================" + templateContent2);
	        	BufferedWriter  writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(f),"UTF-8"));
	        	writer.write(templateContent);     
	        	writer.flush();     
	        	writer.close(); 
	        } catch (FileNotFoundException e) {
	            e.printStackTrace();
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
	}
	
	/**
	 * 进入考核报表页面
	 * @return ModelAndView
	 */
	@RequestMapping("/toCheckReport")
	public ModelAndView toCheckReport(HttpServletRequest request){
		ModelAndView mv = new ModelAndView("WEB-INF/jsp/school/empCheck/checkReport");
		Org org = new Org();
		org.setParentOrgId("1");
 		mv.addObject("org",orgService.listByCondition(org));
		return mv;
	}
	
	/**
	 * 考核报表页面数据查询
	 * @return ModelAndView
	 */
	@RequestMapping("/CheckReport")
	public void CheckReport(EmpCheck empCheck,HttpServletRequest request,
			HttpServletResponse response, Page page){
		empCheck.setPage(page);	
		empCheck.setState(2);
		List<EmpCheck> list = empCheckService.listByCondition(empCheck);
		AjaxUtils.sendAjaxForPage(request, response, page, list);
	}
}