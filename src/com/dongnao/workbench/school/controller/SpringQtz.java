package com.dongnao.workbench.school.controller;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;

import com.dongnao.workbench.accountflow.dao.AccountFlowMapper;
import com.dongnao.workbench.accountflow.service.AccountFlowService;
import com.dongnao.workbench.common.bean.ReportQuerycondition;
import com.dongnao.workbench.subject.model.Subject;
import com.dongnao.workbench.subject.service.SubjectService;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class SpringQtz {

	@Autowired
	SubjectService subjectService;
	@Autowired
	AccountFlowService accountFlowService;
	@Autowired
	AccountFlowMapper accountFlowMapper;

	protected void execute() {
		// System.out.println(subjectService);
		// System.out.println(accountFlowService);
		System.out.println(accountFlowMapper);
		ReportQuerycondition rqc = new ReportQuerycondition();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
		Date date = new Date();
		String nowyear = sdf.format(date);
		rqc.setYear(nowyear);
		System.out.println("-------1------");
		accountFlowMapper.timedupdatecostprofitdelete(rqc);
		// accountFlowService.timedupdatecostprofit(rqc);
		List<ReportQuerycondition> rqclistr = new ArrayList<ReportQuerycondition>();
		List<ReportQuerycondition> rqclistc = new ArrayList<ReportQuerycondition>();
		List<Subject> Deptlist = subjectService.listByCondition(new Subject());
		for (int i = 0; i < Deptlist.size(); i++) {
			rqc.setDeptname(Deptlist.get(i).getName());
			rqc.setClasstype("achieve");
			rqclistr.add(rqc);
			rqc.setClasstype("cost");
			rqclistc.add(rqc);
		}
		System.out.println("-------2------");
		accountFlowService.timedupdatecostprofitr(rqclistr);
		accountFlowService.timedupdatecostprofitc(rqclistc);
	}

	protected void work() {
		// System.out.println(subjectService);
		// System.out.println(accountFlowService);
		// System.out.println(accountFlowMapper);
	}
}
