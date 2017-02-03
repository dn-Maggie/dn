package com.dongnao.workbench.school.service;

import java.util.List;
import com.dongnao.workbench.common.bean.ResultMessage;
import com.dongnao.workbench.school.model.EmpTableGrant;

/**
 * 描述：员工晚餐补助申请表模块service接口，提供controller操作所需方法
 *
 * @author maggie
 * @version 1.0 2017-01-08
 */
public interface EmpTableGrantService  {

	/**
	 * 新增员工晚餐补助申请表方法
	 * @param empTableGrant EmpTableGrant:实体类
	 */
	public ResultMessage add(EmpTableGrant empTableGrant);
	
	/**
	 * 删除员工晚餐补助申请表方法
	 * @param key:多个由“，”分割开的id字符串
	 */
	public void deleteByKey(String key);
	
	/**
	 * 根据主键查找员工晚餐补助申请表实体方法
	 * @param key String：实体主键
	 * @return empTableGrant EmpTableGrant 实体对象
	 */
	public EmpTableGrant getByPrimaryKey(String key);
	
	/**
	 * 根据条件查找员工晚餐补助申请表列表方法
	 * @param empTableGrant EmpTableGrant 实体对象（查询条件）
	 * @return: 实体对象的list
	 */
	public List<EmpTableGrant> listByCondition(EmpTableGrant empTableGrant);
	
	/**
	 * 修改员工晚餐补助申请表方法
	 * @param empTableGrant EmpTableGrant 实体对象
	 */	
	public ResultMessage update(EmpTableGrant empTableGrant);
}