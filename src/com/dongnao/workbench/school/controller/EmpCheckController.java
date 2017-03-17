package com.dongnao.workbench.school.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

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
import com.dongnao.workbench.common.util.Utils;
import com.dongnao.workbench.continuePay.model.ContinuePay;
import com.dongnao.workbench.course.model.Course;
import com.dongnao.workbench.course.service.CourseService;
import com.dongnao.workbench.nation.model.Nation;
import com.dongnao.workbench.nation.service.NationService;
import com.dongnao.workbench.salary.model.SalStandard;
import com.dongnao.workbench.salary.service.SalStandardService;
import com.dongnao.workbench.common.util.FormatEntity;
import com.dongnao.workbench.school.model.EmpCheck;
import com.dongnao.workbench.school.model.Employee;
import com.dongnao.workbench.school.service.EmpCheckService;
import com.dongnao.workbench.school.service.EmployeeService;
import com.dongnao.workbench.subject.model.Subject;
import com.dongnao.workbench.system.model.DictInfo;
import com.dongnao.workbench.system.service.DictInfoService;
import com.dongnao.workbench.vipRefund.model.VipRefund;
import com.dongnao.workbench.vipStudent.model.VipStudent;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
		List<EmpCheck> list = empCheckService.listByCondition(empCheck);
		AjaxUtils.sendAjaxForPage(request, response, page, list);
	}
	
	/**
	 * 进入员工考核信息页面方法
	 * @param key String：实体id
	 * @return ModelAndView: 查询实体
	 */	
	@RequestMapping("/toShowAssinfo")
	public ModelAndView toEdit(String key){
		ModelAndView mv = new ModelAndView(
				"WEB-INF/jsp/school/empCheck/ShowAssessmentinfo");
		EmpCheck entity = empCheckService.getByPrimaryKey(key);
		mv.addObject("employee", entity);
		return mv;
	}
	/**
	 * 员工考核信息页面请求员工考核数据方法
	 * @param key String：实体id
	 * @return ModelAndView: 查询实体
	 */
	@RequestMapping("/listshowAssinfo")
	public void listshowAssinfo(EmpCheck empCheck,HttpServletRequest request,
			HttpServletResponse response, Page page){
		empCheck.setPage(page);	
		List<EmpCheck> list = empCheckService.listByCondition(empCheck);
		AjaxUtils.sendAjaxForPage(request, response, page, list);
	}
}