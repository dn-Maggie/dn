package com.dongnao.workbench.school.controller;


import org.springframework.beans.factory.annotation.Autowired;

import com.dongnao.workbench.accountflow.dao.AccountFlowMapper;
import com.dongnao.workbench.accountflow.service.AccountFlowService;
import com.dongnao.workbench.common.bean.ReportQuerycondition;
import com.dongnao.workbench.common.util.Utils;
import com.dongnao.workbench.school.dao.EmpPerformanceMapper;
import com.dongnao.workbench.school.dao.EmployeeMapper;
import com.dongnao.workbench.school.model.Employee;
import com.dongnao.workbench.school.model.PerformanceStiData;
import com.dongnao.workbench.subject.model.Subject;
import com.dongnao.workbench.subject.service.SubjectService;
import com.mysql.jdbc.Util;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

public class SpringQtz {

	@Autowired
	SubjectService subjectService;
	@Autowired
	AccountFlowService accountFlowService;
	@Autowired
	AccountFlowMapper accountFlowMapper;
	@Autowired
	EmployeeMapper employeeMapper;
	@Autowired
	EmpPerformanceMapper empPerformanceMapper;

	/**
	 * 定时更新成本业绩数据表
	 */	
	protected void execute() {
		ReportQuerycondition rqc = new ReportQuerycondition();
		String nowYear = new SimpleDateFormat("yyyy").format(new Date());
		rqc.setYear(nowYear);
		int a =accountFlowMapper.timedupdatecostprofitdelete(rqc);//删除当年的旧数据
		  /*List<ReportQuerycondition> rqclistr = new ArrayList<ReportQuerycondition>();
			List<ReportQuerycondition> rqclistc = new ArrayList<ReportQuerycondition>();*/
			List<Subject> Deptlist = subjectService.listByCondition(new Subject());
			for (int i = 0; i < Deptlist.size(); i++) {//不采用批量插入
				ReportQuerycondition rqcr = new ReportQuerycondition();//业绩
				ReportQuerycondition rqcc = new ReportQuerycondition();//成本
				rqcr.setYear(nowYear);
				rqcc.setYear(nowYear);
				rqcr.setDeptname(Deptlist.get(i).getName());
				rqcc.setDeptname(Deptlist.get(i).getName());
				rqcr.setClasstype("achieve");
				rqcc.setClasstype("cost");
				accountFlowMapper.timedupdatecostprofitrs(rqcr);//插入当年每个月此部门的业绩
				accountFlowMapper.timedupdatecostprofitcs(rqcc);//插入当年每个月此部门的成本
	/*			rqclistr.add(rqcr);
				rqclistc.add(rqcc);*/
			}
	/*		accountFlowMapper.timedupdatecostprofitr(rqclistr);//批量插入
			accountFlowMapper.timedupdatecostprofitc(rqclistc);*/
	}
	
	/*每个月月初更新上一个月的业绩到业绩统计表*/
	protected void updatePerformance(){
		Calendar c = Calendar.getInstance();
		Employee employee = new Employee();
		employee.setDutyId("ddfd8fbf-e7fc-4768-a052-1b252e168344");//只统计讲师的成本
		List<Employee> EmployeeList = employeeMapper.listByCondition(employee);
		List<PerformanceStiData> performanceStiData = new ArrayList<PerformanceStiData>();
		for(int i = 0 ; i < EmployeeList.size() ; i++) {
			if(EmployeeList.get(i).getCurrState().equals("3"))continue;
			PerformanceStiData pfsd = new PerformanceStiData();
			pfsd.setId(Utils.generateUniqueID());
			pfsd.setEmpId(EmployeeList.get(i).getId());
			performanceStiData.add(pfsd);
		}
		try {
			empPerformanceMapper.updatePerformance(performanceStiData);
			performanceStiData.clear();
			PerformanceStiData pf = new PerformanceStiData();
			pf.setMonth(c.get(Calendar.YEAR)+"-"+c.get(Calendar.MONTH)+"-"+c.get(Calendar.DAY_OF_MONTH));
			performanceStiData = empPerformanceMapper.perSticlistByCondition(pf);
			for(int i = 0 ; i < performanceStiData.size() ; i++){
				PerformanceStiData pfsd = performanceStiData.get(i);
				if(pfsd.getMoney()<pfsd.getCost()){
					pfsd.setActualBonus(pfsd.getBonus()/3);
					empPerformanceMapper.updateActualBonus(pfsd);
				}	
			}		
		} catch (Exception e) {
			e.printStackTrace();
		}		
	}
}
