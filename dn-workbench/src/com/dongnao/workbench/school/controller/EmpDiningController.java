package com.dongnao.workbench.school.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dongnao.workbench.basic.model.UserInfo;
import com.dongnao.workbench.common.bean.ResultMessage;
import com.dongnao.workbench.common.excel.ExcelExpUtils;
import com.dongnao.workbench.common.excel.ExpParamBean;
import com.dongnao.workbench.common.page.Page;
import com.dongnao.workbench.common.util.AjaxUtils;
import com.dongnao.workbench.common.util.DateUtil;
import com.dongnao.workbench.common.util.Utils;
import com.dongnao.workbench.common.util.FormatEntity;
import com.dongnao.workbench.school.model.EmpDining;
import com.dongnao.workbench.school.service.EmpDiningService;
import com.dongnao.workbench.vipRefund.model.VipRefund;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


/**
 * 描述：员工订餐表模块controller类，负责页面分发与跳转
 * 
 * @author maggie
 * @version 1.0 2016-11-24
 */
 
@Controller
@RequestMapping("empDining")
public class EmpDiningController{
	@Resource
	private EmpDiningService empDiningService;
	 
 	/**
 	* 进入新增页面
 	* @return ModelAndView 返回到新增页面
 	*/
 	@RequestMapping("/toAddEmpDining")
	public ModelAndView toAdd(HttpServletRequest request){
 		ModelAndView mv = new ModelAndView("WEB-INF/jsp/school/empDining/addEmpDining");
		UserInfo user = Utils.getLoginUserInfo(request);
		mv.addObject("user",user);
		String userRole = user.getRoleId();
		if(userRole!=null||userRole!=""){
			Pattern HRRole = Pattern.compile("46f0d3f8-350f-486d-b221-cb5879019c8f");
			Matcher isHR = HRRole.matcher(userRole);
			if(isHR.find()){
				mv.addObject("isHR",true);
			}
		}
		return mv;
	}
	
	
	/**
	 * 新增方法
	 * @param response HttpServletResponse
	 * @param empDining EmpDining:实体类
	 * @return: ajax输入json字符串
	 */
	@RequestMapping("/addEmpDining")
	public void add(@RequestBody String param,HttpServletRequest request,HttpServletResponse response){
		if(param == null) {
			return;	
		}
		JSONArray ja = JSONArray.fromObject(param);
		for(Object o : ja) {
			JSONObject jo = (JSONObject)o;
			EmpDining empDining = new EmpDining();
			empDining.setDiningTime(DateUtil.parseStringToyyyyMMdd(jo.getString("diningTime")));
			empDining.setEmpId(jo.getString("empId"));
			empDining.setOrderType((jo.getString("orderType")));
			if(empDiningService.listByCondition(empDining).size()>0){
				continue;
			}else{
				empDining.setId(Utils.generateUniqueID());
				empDining.setEnterId(Utils.getLoginUserInfoId(request));
				empDining.setOrderTime(DateUtil.now());
				empDiningService.add(empDining);
			}
		}
		ResultMessage result = new ResultMessage();
		result.setStatus(1);
		result.setMessage("操作成功");
		AjaxUtils.sendAjaxForObjectStr(response,result);		
	}
	
	/**
	 * 删除方法
	 * @param response HttpServletResponse
	 * @param key String:多个由“，”分割开的id字符串
	 * @return: ajax输入json字符串
	 */
	@RequestMapping("/deleteEmpDining")
	public void deleteByKey(String key,HttpServletResponse response){
		String[] str = key.split(",");
		for(int i=0;i<str.length;i++){
			empDiningService.deleteByKey(str[i]);
		}
		Map<String, String> map = new HashMap<String, String>();
		map.put("msg", "成功");
		AjaxUtils.sendAjaxForMap(response, map);
	}
	
	/**
	 * 进入列表页面
	 * @return ModelAndView
	 */
	@RequestMapping("/toListEmpDining")
	public ModelAndView toList(HttpServletRequest request){
		ModelAndView mv = new ModelAndView("WEB-INF/jsp/school/empDining/listEmpDining");
		UserInfo user = Utils.getLoginUserInfo(request);
		mv.addObject("user",user);
		String userRole = user.getRoleId();
		if(userRole!=null||userRole!=""){
			Pattern HRRole = Pattern.compile("46f0d3f8-350f-486d-b221-cb5879019c8f");
			Matcher isHR = HRRole.matcher(userRole);
			if(isHR.find()){
				mv.addObject("isHR",true);
			}
		}
		return mv;
	}
	
	/**
	 * 根据条件查找列表方法
	 * @param empDining EmpDining：实体对象（查询条件）
	 * @param request HttpServletRequest
	 * @param response HttpServletResponse
	 * @param page Page:分页对象
	 * @return: ajax输入json字符串
	 */
	@RequestMapping("/listEmpDining")
	public void listByCondition(EmpDining empDining,HttpServletRequest request,
			HttpServletResponse response, Page page){
		empDining.setPage(page);	
		List<EmpDining> list = empDiningService.listByCondition(empDining);
		AjaxUtils.sendAjaxForPage(request, response, page, list);
	}
	
	/**
	 * 统计总数
	 */	
	@RequestMapping("/staticEmpDining")
	public void staticEmpDining(EmpDining empDining,HttpServletResponse response){
		Map<String,Object> model =new HashMap<String, Object>();
		
		EmpDining lunchDining = new EmpDining();
		EmpDining supperDining = new EmpDining();
		lunchDining.setDiningTime(DateUtil.parseStringToyyyyMMdd(empDining.getPropsMap().get("startDate").toString()));
		lunchDining.setOrderType("1");
		supperDining.setDiningTime(DateUtil.parseStringToyyyyMMdd(empDining.getPropsMap().get("startDate").toString()));
		supperDining.setOrderType("2");
		
		model.put("lunch", empDiningService.staticEmpDining(lunchDining));
		model.put("supper", empDiningService.staticEmpDining(supperDining));
		AjaxUtils.sendAjaxForMap(response, model);
	}
	//导出数据方法
	@RequestMapping("/exportExcel")
	public void exportExcel(EmpDining empDining, ExpParamBean epb,
			HttpServletRequest request, HttpServletResponse response, Page page)
			throws Exception {		
		int expType = Integer.parseInt(request.getParameter("expType"));
		if (expType == 1) {
			empDining.setPage(page);
		}
		List<EmpDining> list = empDiningService.listByCondition(empDining);
		ExcelExpUtils.exportListToExcel(list, response, epb.getFieldlist(),
				"员工订餐列表", "员工订餐列表");
	}
}