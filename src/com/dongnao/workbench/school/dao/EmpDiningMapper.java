package com.dongnao.workbench.school.dao;

import java.util.List;
import com.dongnao.workbench.school.model.EmpDining;
/**
 * 描述：员工订餐表模块dao接口，提供数据库操作方法
 *
 * @author maggie
 * @version 1.0 2016-11-24
 */
public interface EmpDiningMapper  {

	/**
	 * 新增员工订餐表方法
	 * @param empDining EmpDining:实体类
	 */
	void add(EmpDining empDining);
	
	/**
	 * 删除员工订餐表方法
	 * @param key String:多个由“，”分割开的id字符串
	 */
	void deleteByKey(String key);
	
	/**
	 * 根据主键查找员工订餐表实体方法
	 * @param key String：实体主键（查询条件）
	 * @return EmpDining: 实体
	 */
	public EmpDining getByPrimaryKey(String key);
	
	/**
	 * 根据条件查找员工订餐表列表方法
	 * @param EmpDining empDining：实体对象（查询条件）
	 * @return List<EmpDining>: 实体对象的list
	 */
	public List<EmpDining>  listByCondition(EmpDining empDining);
	
	/**
	 * 根据条件统计员工订餐表列表方法
	 * @param EmpDining empDining：实体对象（查询条件）
	 * @return List<EmpDining>: 实体对象的list
	 */
	public List<EmpDining> staticEmpDining(EmpDining empDining);
}