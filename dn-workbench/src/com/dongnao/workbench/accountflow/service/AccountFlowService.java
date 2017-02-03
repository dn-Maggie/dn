package com.dongnao.workbench.accountflow.service;

import java.util.List;

import com.dongnao.workbench.common.bean.ResultMessage;
import com.dongnao.workbench.common.bean.ResultMoney;
import com.dongnao.workbench.accountflow.model.AccountFlow;

/**
 * 描述：财务流水模块service接口，提供controller操作所需方法
 *
 * @author cjw
 * @version 1.0 2016-05-01
 */
public interface AccountFlowService  {

	/**
	 * 新增财务流水方法
	 * @param accountFlow AccountFlow:实体类
	 */
	public ResultMessage add(AccountFlow accountFlow);
	
	/**
	 * 删除财务流水方法
	 * @param key:多个由“，”分割开的id字符串
	 */
	public void deleteByKey(String key);
	
	/**
	 * 根据主键查找财务流水实体方法
	 * @param key String：实体主键
	 * @return accountFlow AccountFlow 实体对象
	 */
	public AccountFlow getByPrimaryKey(String key);
	
	/**
	 * 根据条件查找财务流水列表方法
	 * @param accountFlow AccountFlow 实体对象（查询条件）
	 * @return: 实体对象的list
	 */
	public List<AccountFlow> listByCondition(AccountFlow accountFlow);
	
	/**
	 * 修改财务流水方法
	 * @param accountFlow AccountFlow 实体对象
	 */	
	public ResultMessage update(AccountFlow accountFlow);
	
	/**
	 * 根据月份统计财务流水列表方法
	 * @param String month（查询条件）
	 * @return: 实体对象的list
	 */
	public ResultMoney getCountMoney(AccountFlow accountFlow);
	
	/**
	 * 根据月份查找与学费相关的科目名称的财务流水列表方法
	 * @param String month（查询条件）
	 * @return: 实体对象的list
	 */
	public ResultMoney getXFMoney(AccountFlow accountFlow);

	/**
	 * 根据月份查找每个科目名称的财务流水列表方法
	 * @param String month（查询条件）
	 * @return: 实体对象的list
	 */
	public List<AccountFlow> listByAccountName(String month);
	
	/**
	 * 根据月份列出每个月财务流水消费支出列表方法
	 * @param accountFlow AccountFlow 实体对象（查询条件）
	 * @return: 实体对象的list
	 */
	public List<AccountFlow> listCostByCondition(AccountFlow accountFlow);

	public ResultMoney getBarStatistic(AccountFlow accountFlow);
}