package com.dongnao.workbench.school.dao;

import java.util.List;

import com.dongnao.workbench.school.model.EmpCheck;

public interface EmpCheckMapper {
	/**
	 * 根据条件查找员工列表方法
	 * @param empCheck EmpCheck 实体对象（查询条件）
	 * @return: 实体对象的list
	 */
	public List<EmpCheck> listByCondition(EmpCheck empCheck);
	
	
	/**
	 * 根据条件查找员工列表方法
	 * @param empCheck EmpCheck 实体对象（查询条件）
	 * @return: 实体对象的list
	 */
	public EmpCheck getByPrimaryKey(String key);
	
}
