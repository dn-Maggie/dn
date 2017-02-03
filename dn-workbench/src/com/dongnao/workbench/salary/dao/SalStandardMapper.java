package com.dongnao.workbench.salary.dao;

import java.util.List;
import com.dongnao.workbench.salary.model.SalStandard;
/**
 * 描述：员工工资标准模块dao接口，提供数据库操作方法
 *
 * @author maggie
 * @version 1.0 2016-09-20
 */
public interface SalStandardMapper  {

	/**
	 * 新增员工工资标准方法
	 * @param salStandard SalStandard:实体类
	 */
	void add(SalStandard salStandard);
	
	/**
	 * 删除员工工资标准方法
	 * @param key String:多个由“，”分割开的id字符串
	 */
	void deleteByKey(String key);
	
	/**
	 * 根据主键查找员工工资标准实体方法
	 * @param key String：实体主键（查询条件）
	 * @return SalStandard: 实体
	 */
	public SalStandard getByPrimaryKey(String key);
	
	/**
	 * 根据条件查找员工工资标准列表方法
	 * @param SalStandard salStandard：实体对象（查询条件）
	 * @return List<SalStandard>: 实体对象的list
	 */
	public List<SalStandard>  listByCondition(SalStandard salStandard);
	
	/**
	 * 修改员工工资标准方法
	 * @param salStandard SalStandard：实体对象
	 */	
	public void update(SalStandard salStandard);
}