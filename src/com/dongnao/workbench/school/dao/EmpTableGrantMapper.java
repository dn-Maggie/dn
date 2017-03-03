package com.dongnao.workbench.school.dao;

import java.util.List;
import com.dongnao.workbench.school.model.EmpTableGrant;
/**
 * 描述：员工晚餐补助申请表模块dao接口，提供数据库操作方法
 *
 * @author maggie
 * @version 1.0 2017-01-08
 */
public interface EmpTableGrantMapper  {

	/**
	 * 新增员工晚餐补助申请表方法
	 * @param empTableGrant EmpTableGrant:实体类
	 */
	void add(EmpTableGrant empTableGrant);
	
	/**
	 * 删除员工晚餐补助申请表方法
	 * @param key String:多个由“，”分割开的id字符串
	 */
	void deleteByKey(String key);
	
	/**
	 * 根据主键查找员工晚餐补助申请表实体方法
	 * @param key String：实体主键（查询条件）
	 * @return EmpTableGrant: 实体
	 */
	public EmpTableGrant getByPrimaryKey(String key);
	
	/**
	 * 根据条件查找员工晚餐补助申请表列表方法
	 * @param EmpTableGrant empTableGrant：实体对象（查询条件）
	 * @return List<EmpTableGrant>: 实体对象的list
	 */
	public List<EmpTableGrant>  listByCondition(EmpTableGrant empTableGrant);
	
	/**
	 * 修改员工晚餐补助申请表方法
	 * @param empTableGrant EmpTableGrant：实体对象
	 */	
	public void update(EmpTableGrant empTableGrant);
}