package com.dongnao.workbench.school.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dongnao.workbench.accountflow.model.AccountFlow;
import com.dongnao.workbench.accountflow.service.AccountFlowService;
import com.dongnao.workbench.basic.model.UserInfo;
import com.dongnao.workbench.common.bean.ResultMoney;
import com.dongnao.workbench.common.page.Page;
import com.dongnao.workbench.common.util.AjaxUtils;
import com.dongnao.workbench.continuePay.service.ContinuePayService;
import com.dongnao.workbench.marketStudent.model.MarketStudent;
import com.dongnao.workbench.marketStudent.service.MarketStudentService;
import com.dongnao.workbench.common.util.FormatEntity;
import com.dongnao.workbench.common.util.Utils;
import com.dongnao.workbench.school.model.Standard;
import com.dongnao.workbench.school.service.StandardService;
import com.dongnao.workbench.subject.model.Subject;
import com.dongnao.workbench.subject.service.SubjectService;
import com.dongnao.workbench.vipStudent.model.Statistical;
import com.dongnao.workbench.vipStudent.model.VipStudent;
import com.dongnao.workbench.vipStudent.service.VipStudentService;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


/**
 * 描述：考核标准表模块controller类，负责页面分发与跳转
 * 
 * @author maggie
 * @version 1.0 2016-07-18
 */
 
@Controller
@RequestMapping("standard")
public class StandardController{
	@Resource
	private SubjectService subjectService;
         @Resource
         private StandardService standardService;
         @Resource
         private VipStudentService vipStudentService;
         @Resource
         private ContinuePayService continuePayService;
         @Resource
     	 private AccountFlowService accountFlowService;
         @Resource
     	private MarketStudentService marketStudentService;
 	/**
 	* 进入新增页面
 	* @return ModelAndView 返回到新增页面
 	*/
 	@RequestMapping("/toAddStandard")
	public ModelAndView toAdd(){
		return new ModelAndView("WEB-INF/jsp/school/standard/addStandard");
	}
	
	/**
	 * 进入查看页面方法
	 * @param key String：实体id
	 * @return ModelAndView: 查询实体
	 */	
	@RequestMapping("/toShowStandard")
	public ModelAndView toShow(String key){
		Standard entity = standardService.getByPrimaryKey(key);
		Map<String,String> standard = FormatEntity.getObjectValue(entity);
		return new ModelAndView("WEB-INF/jsp/school/standard/showStandard","standard",standard );
	}
	
	/**
	 * 进入数据统计列表页面
	 * @return ModelAndView
	 */
	@RequestMapping("/toListStandard")
	public ModelAndView toList() {
		ModelAndView mv = new ModelAndView(
				"WEB-INF/jsp/school/standard/listStandard");
		
 		List<Subject> list = subjectService.listByCondition(new Subject());
 		mv.addObject("subject", list);
		return mv;
	}
	
	/**
	 * 进入图表统计列表页面
	 * @return ModelAndView
	 */
	@RequestMapping("/toListStandardBar")
	public ModelAndView toListBar(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView(
				"WEB-INF/jsp/school/standard/listStandardBar");
		if(Utils.isSuperAdmin(request)){
			mv.addObject("isAdmin",true);
		}
		List<Subject> list = subjectService.listByCondition(new Subject());
 		mv.addObject("subject", list);
		return mv;
	}

	
	/**
	 * 获取统计数据
	 * @return ModelAndView
	 */
	@RequestMapping("/getStatistic")
	public void getStatistic(String month,String subject,HttpServletRequest request,HttpServletResponse response) {
		/*if(month!=""){*/
			Map<Object,Object> model = new HashMap<Object,Object>();
			VipStudent vipstudent = new VipStudent();
			vipstudent.setJointime(month);
			vipstudent.setSubjectId(subject);
			model.put("curr", vipStudentService.getStatistical(vipstudent));
			
			model.put("currMarkStu", marketStudentService.getMarkStuCount(month));
			
			AccountFlow accountxf = new AccountFlow();
			accountxf.setCreateTime(month);
			accountxf.setSubjectName(subject);;
			model.put("currxf", accountFlowService.getXFMoney(accountxf));
			AjaxUtils.sendAjaxForMap(response, model);
		/*}*/
	}
	
	/**
	 * 获取学生统计数据
	 * @return ModelAndView
	 */
	@RequestMapping("/getStuStatistic")
	public void getStuStatistic(VipStudent vipStudent,HttpServletRequest request,HttpServletResponse response) {
		String joinStartDate ="";String joinEndDate ="" ;
		try{
			joinStartDate = vipStudent.getPropsMap().get("joinStartDate").toString();
			joinEndDate = vipStudent.getPropsMap().get("joinEndDate").toString();
		}catch(Exception e){}if(joinStartDate.length()>0||joinEndDate.length()>0){
			vipStudent.setJoinStartDate(joinStartDate);
			vipStudent.setJoinEndDate(joinEndDate);
		}
		Map<Object,Object> model = new HashMap<Object,Object>();
		model.put("curr", vipStudentService.getTotal(vipStudent));
		AjaxUtils.sendAjaxForMap(response, model);
	}
	
	
	/**
	 * 获取统计图表数据
	 * @return ModelAndView
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping("/getBarStatistic")
	public void getBarStatistic(String months,String subjectName,HttpServletRequest request,HttpServletResponse response) throws UnsupportedEncodingException {
		Map<Object,Object> model = new HashMap<Object,Object>();
		
		//1.有条件传入：有月份或有科目名
		if(months!=""||subjectName!=""){
			//拆分几个年月
			String[] yearMonth = months.split(",");
			
			//有月份，没有科目名
			if(yearMonth.length>0&&subjectName==""){
				//输入或没输入科目，有月份
				for(int i=0;i<yearMonth.length;i++){
					String[] ym = yearMonth[i].split("-");//分别获取日期的年、月，存入数组ym中
					int month = Integer.parseInt(ym[1]);//将月份转化为整型
					AccountFlow accountFlow = new AccountFlow();//创建一个财务流水实例
					accountFlow.setSubjectName(subjectName);//设置科目为所传入科目
					accountFlow.setCreateTime(ym[0]+month);//设置时间为所传入年月
					ResultMoney resm  = accountFlowService.getBarStatistic(accountFlow);//根据查询条件获取查询值并添加在对象中
					if(resm==null)resm = new ResultMoney();
					VipStudent vipStudent = new VipStudent();//创建一个学生类实例
					vipStudent.setJointime(ym[0]+month);//时间为所传入年月
					vipStudent.setSubjectName(subjectName);//时间为所传入年月
					List<Statistical> sv = vipStudentService.getTotal(vipStudent);//获取本月应收账款
					if(sv.size()>0&&sv.get(0).getShouldPay()!=null){
						resm.setShouldPay(sv.get(0).getShouldPay().doubleValue());//添加在对象中
					}else{resm.setShouldPay(0.00);}
					model.put(yearMonth[i], resm);
				}
			}
			//无月份，有科目名
			else{
				initBar(model,subjectName);
			}
		}
		//2.无条件传入：没有月份且没有科目名
		else{
			initBar(model,subjectName);
		}
		AjaxUtils.sendAjaxForMap(response, model);
	}
	//初始化图表(没有月份，初始默认为五个最近月份)
	public void initBar(Map<Object, Object> modelObj,String subjectName) {
		Calendar calendar = Calendar.getInstance();
		int year = calendar.get(Calendar.YEAR);
		int month = calendar.get(Calendar.MONTH)+1;
		for(int i=0;i<=5;i++){
			AccountFlow accountFlow = new AccountFlow();
			accountFlow.setSubjectName(subjectName);
				accountFlow.setCreateTime(year+""+((month-i>0)?(month-i):(month-i+12)));
				ResultMoney resm = accountFlowService.getBarStatistic(accountFlow);
				if(resm==null)resm = new ResultMoney();
				//获取本月应收账款
				VipStudent vipStudent = new VipStudent();
				vipStudent.setJointime(year+""+((month-i>0)?(month-i):(month-i+12)));
				vipStudent.setSubjectName(subjectName);
				List<Statistical> sv = vipStudentService.getTotal(vipStudent);
				//添加在对象中
				if(sv.size()>0&&sv.get(0).getShouldPay()!=null){
					resm.setShouldPay(Double.valueOf(sv.get(0).getShouldPay().toString()));
				}else{resm.setShouldPay(0.00);}
				modelObj.put(year+"-"+(((month-i>0)?(month-i):(month-i+12))<10?"0"+((month-i>0)?(month-i):(month-i+12)):((month-i>0)?(month-i):(month-i+12))),resm);
		}
	}

	/**
	 * 根据条件查找列表方法
	 * @param standard Standard：实体对象（查询条件）
	 * @param request HttpServletRequest
	 * @param response HttpServletResponse
	 * @param page Page:分页对象
	 * @return: ajax输入json字符串
	 */
	@RequestMapping("/listStandard")
	public void listByCondition(Standard standard,HttpServletRequest request,
			HttpServletResponse response, Page page){
		standard.setPage(page);	
		List<Standard> list = standardService.listByCondition(standard);
		AjaxUtils.sendAjaxForPage(request, response, page, list);
	}
	
	/**
	 * 进入修改页面方法
	 * @param key String：实体id
	 * @return ModelAndView: 查询实体
	 */	
	@RequestMapping("/toEditStandard")
	public ModelAndView toEdit(String key){
		Standard entity = standardService.getByPrimaryKey(key);
		Map<String,String> standard = FormatEntity.getObjectValue(entity);
		return new ModelAndView("WEB-INF/jsp/school/standard/editStandard","standard",standard );
	}
	
	/**
	 * 修改方法
	 * @param standard Standard：实体对象
	 * @param response HttpServletResponse
	 * @return: ajax输入json字符串
	 */	
	@RequestMapping("/updateStandard")
	public void update(Standard standard,HttpServletRequest request,HttpServletResponse response){
		AjaxUtils.sendAjaxForObjectStr(
				response,standardService.update(standard));	
	}
	
	/**
	 * 异步ajax查询业绩比例rate
	 */	
 	@RequestMapping("/getRate")
 	public void getRate(String parentId,String subId,String positionId,HttpServletResponse response){
 		Standard standard = new Standard();
 		standard.setParentId(parentId);
 		standard.setSubId(subId);
 		standard.setPositionId(positionId);
 		List<Standard> standards=standardService.listByCondition(standard);
 		if(standards!=null&&standards.size()==1){
 			AjaxUtils.sendAjaxForObject(response, standards.get(0).getRate());
 		}
 		
 	}
	
}