package com.dongnao.workbench.school.service;

import java.util.List;
import com.dongnao.workbench.common.bean.ResultMessage;
import com.dongnao.workbench.school.model.EmpDining;

/**
 * 描述：员工订餐表模块service接口，提供controller操作所需方法
 *
 * @author maggie
 * @version 1.0 2016-11-24
 */
public interface EmpDiningService  {

	/**
	 * 新增员工订餐表方法
	 * @param empDining EmpDining:实体类
	 */
	public ResultMessage add(EmpDining empDining);
	
	/**
	 * 删除员工订餐表方法
	 * @param key:多个由“，”分割开的id字符串
	 */
	public void deleteByKey(String key);
	
	/**
	 * 根据主键查找员工订餐表实体方法
	 * @param key String：实体主键
	 * @return empDining EmpDining 实体对象
	 */
	public EmpDining getByPrimaryKey(String key);
	
	/**
	 * 根据条件查找员工订餐表列表方法
	 * @param empDining EmpDining 实体对象（查询条件）
	 * @return: 实体对象的list
	 */
	public List<EmpDining> listByCondition(EmpDining empDining);
	
	/**
	 * 根据条件统计员工订餐表列表方法
	 * @param empDining EmpDining 实体对象（查询条件）
	 * @return: 实体对象的list
	 */
	public List<EmpDining> staticEmpDining(EmpDining lunchDining);
}