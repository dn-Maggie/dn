package com.dongnao.workbench.salary.controller;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dongnao.workbench.basic.model.Duty;
import com.dongnao.workbench.basic.service.DutyService;
import com.dongnao.workbench.common.page.Page;
import com.dongnao.workbench.common.util.AjaxUtils;
import com.dongnao.workbench.common.util.Utils;
import com.dongnao.workbench.common.util.FormatEntity;
import com.dongnao.workbench.salary.model.SalStandard;
import com.dongnao.workbench.salary.service.SalStandardService;
import com.dongnao.workbench.system.model.DictInfo;
import com.dongnao.workbench.system.service.DictInfoService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


/**
 * 描述：员工工资标准模块controller类，负责页面分发与跳转
 * 
 * @author maggie
 * @version 1.0 2016-09-20
 */
 
@Controller
@RequestMapping("salStandard")
public class SalStandardController{
         @Resource
         private SalStandardService salStandardService;
         @Resource
     	 private DutyService dutyService;
         @Resource
         private DictInfoService dictInfoService;
 	/**
 	* 进入新增页面
 	* @return ModelAndView 返回到新增页面
 	*/
 	@RequestMapping("/toAddSalStandard")
	public ModelAndView toAdd(){
 		ModelAndView mv =  new ModelAndView("WEB-INF/jsp/salary/salStandard/addSalStandard");
 		
 		List<Duty> dutyList = dutyService.listByCondition(new Duty());
 		mv.addObject("dutyList",dutyList);
 		
 		DictInfo dictInfo1 = new DictInfo();
 		DictInfo dictInfo2 = new DictInfo();
 		dictInfo1.setDictTypeCode("salStandardType");
 		dictInfo2.setDictTypeCode("dutyLevel");
 		List<DictInfo> salStandardTypeList = dictInfoService.listByCondition(dictInfo1);
 		List<DictInfo> dutyLevelList = dictInfoService.listByCondition(dictInfo2);
 		mv.addObject("salStandardTypeList",salStandardTypeList);
 		mv.addObject("dutyLevelList",dutyLevelList);
 		return mv;
	}
	
	/**
	 * 进入查看页面方法
	 * @param key String：实体id
	 * @return ModelAndView: 查询实体
	 */	
	@RequestMapping("/toShowSalStandard")
	public ModelAndView toShow(String key){
		SalStandard entity = salStandardService.getByPrimaryKey(key);
		Map<String,String> salStandard = FormatEntity.getObjectValue(entity);
		return new ModelAndView("WEB-INF/jsp/salary/salStandard/showSalStandard","salStandard",salStandard );
	}
	
	/**
	 * 新增方法
	 * @param response HttpServletResponse
	 * @param salStandard SalStandard:实体类
	 * @return: ajax输入json字符串
	 */
	@RequestMapping("/addSalStandard")
	public void add(SalStandard salStandard,HttpServletRequest request,HttpServletResponse response){
	Calendar calendar = Calendar.getInstance();
	salStandard.setId(Utils.generateUniqueID());
	salStandard.setCreated(calendar.getTime());
	salStandard.setCreatedbyname(Utils.getLoginUserInfo(request).getFullName());
	AjaxUtils.sendAjaxForObjectStr(
				response,salStandardService.add(salStandard));		
	}
	
	/**
	 * 删除方法
	 * @param response HttpServletResponse
	 * @param key String:多个由“，”分割开的id字符串
	 * @return: ajax输入json字符串
	 */
	@RequestMapping("/deleteSalStandard")
	public void deleteByKey(String key,HttpServletResponse response){
		String[] str = key.split(",");
		for(int i=0;i<str.length;i++){
			salStandardService.deleteByKey(str[i]);
		}
		Map<String, String> map = new HashMap<String, String>();
		map.put("msg", "成功");
		AjaxUtils.sendAjaxForMap(response, map);
	}
	
	/**
	 * 进入列表页面
	 * @return ModelAndView
	 */
	@RequestMapping("/toListSalStandard")
	public ModelAndView toList(){
 		ModelAndView mv = new ModelAndView("WEB-INF/jsp/salary/salStandard/listSalStandard");
 		List<Duty> dutyList = dutyService.listByCondition(new Duty());
 		mv.addObject("dutyList",dutyList); 
 		return mv;
	}
	
	/**
	 * 根据条件查找列表方法
	 * @param salStandard SalStandard：实体对象（查询条件）
	 * @param request HttpServletRequest
	 * @param response HttpServletResponse
	 * @param page Page:分页对象
	 * @return: ajax输入json字符串
	 */
	@RequestMapping("/listSalStandard")
	public void listByCondition(SalStandard salStandard,HttpServletRequest request,
			HttpServletResponse response, Page page){
		salStandard.setPage(page);	
		List<SalStandard> list = salStandardService.listByCondition(salStandard);
		AjaxUtils.sendAjaxForPage(request, response, page, list);
	}
	
	/**
	 * 进入修改页面方法
	 * @param key String：实体id
	 * @return ModelAndView: 查询实体
	 */	
	@RequestMapping("/toEditSalStandard")
	public ModelAndView toEdit(String key){
		ModelAndView mv = new ModelAndView("WEB-INF/jsp/salary/salStandard/editSalStandard");
		
		SalStandard entity = salStandardService.getByPrimaryKey(key);
		Map<String,String> salStandard = FormatEntity.getObjectValue(entity);
		
		List<Duty> dutyList = dutyService.listByCondition(new Duty());
 		mv.addObject("dutyList",dutyList);
 		
 		DictInfo dictInfo1 = new DictInfo();
 		DictInfo dictInfo2 = new DictInfo();
 		dictInfo1.setDictTypeCode("salStandardType");
 		dictInfo2.setDictTypeCode("dutyLevel");
 		List<DictInfo> salStandardTypeList = dictInfoService.listByCondition(dictInfo1);
 		List<DictInfo> dutyLevelList = dictInfoService.listByCondition(dictInfo2);
 		mv.addObject("salStandardTypeList",salStandardTypeList);
 		mv.addObject("dutyLevelList",dutyLevelList);
		
		mv.addObject("salStandard",salStandard);
		return mv;
	}
	
	/**
	 * 修改方法
	 * @param salStandard SalStandard：实体对象
	 * @param response HttpServletResponse
	 * @return: ajax输入json字符串
	 */	
	@RequestMapping("/updateSalStandard")
	public void update(SalStandard salStandard,HttpServletRequest request,HttpServletResponse response){
		AjaxUtils.sendAjaxForObjectStr(
				response,salStandardService.update(salStandard));	
	}
	
}