package com.dongnao.workbench.accountflow.dao;

import java.util.List;

import com.dongnao.workbench.accountflow.model.AccountFlow;
import com.dongnao.workbench.common.bean.ResultMoney;
/**
 * 描述：财务流水模块dao接口，提供数据库操作方法
 *
 * @author cjw
 * @version 1.0 2016-05-01
 */
public interface AccountFlowMapper  {

	/**
	 * 新增财务流水方法
	 * @param accountFlow AccountFlow:实体类
	 */
	void add(AccountFlow accountFlow);
	
	/**
	 * 删除财务流水方法
	 * @param key String:多个由“，”分割开的id字符串
	 */
	void deleteByKey(String key);
	
	/**
	 * 根据主键查找财务流水实体方法
	 * @param key String：实体主键（查询条件）
	 * @return AccountFlow: 实体
	 */
	public AccountFlow getByPrimaryKey(String key);
	
	/**
	 * 根据条件查找财务流水列表方法
	 * @param AccountFlow accountFlow：实体对象（查询条件）
	 * @return List<AccountFlow>: 实体对象的list
	 */
	public List<AccountFlow>  listByCondition(AccountFlow accountFlow);
	
	/**
	 * 修改财务流水方法
	 * @param accountFlow AccountFlow：实体对象
	 */	
	public void update(AccountFlow accountFlow);
	/**
	 * 根据月份统计财务流水列表方法
	 * @param String month（查询条件）
	 * @return: 实体对象的list
	 */
	public ResultMoney countMoney(AccountFlow accountFlow);
	/**
	 * 根据月份查找与学费相关的科目名称的财务流水列表方法
	 * @param String month（查询条件）
	 * @return: 实体对象的list
	 */
	public ResultMoney countXF(AccountFlow accountFlow);
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

	ResultMoney getBarStatistic(AccountFlow accountFlow);
}