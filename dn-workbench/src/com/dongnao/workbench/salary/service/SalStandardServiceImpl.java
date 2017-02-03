package com.dongnao.workbench.salary.service;
import javax.annotation.Resource;
import java.util.List;
import com.dongnao.workbench.salary.dao.SalStandardMapper;
import com.dongnao.workbench.salary.model.SalStandard;
import com.dongnao.workbench.salary.service.SalStandardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.dongnao.workbench.common.bean.ResultMessage;
import com.dongnao.workbench.common.util.AjaxUtils;
 
/**
 * 描述：员工工资标准模块service接口实现类，实现service接口方法
 *
 * @author maggie
 * @version 1.0 2016-09-20
 */
@Service("salStandardService")
public class SalStandardServiceImpl implements SalStandardService{
        @Resource
	private SalStandardMapper salStandardMapper;
	
 
	/**
	 * 新增员工工资标准方法
	 * @param salStandard:实体类
	 */	
	public ResultMessage add(SalStandard salStandard){
		salStandardMapper.add(salStandard);
		return AjaxUtils.getSuccessMessage();
	}
	
	/**
	 * 根据主键查找员工工资标准实体方法
	 * @param key String 实体主键
	 * @return SalStandard 实体对象
	 */
	public SalStandard getByPrimaryKey(String key){
		return salStandardMapper.getByPrimaryKey(key);
	}
	
	/**
	 * 删除员工工资标准方法
	 * @param key String 多个由“，”分割开的id字符串
	 */
	public void deleteByKey(String key){
		salStandardMapper.deleteByKey(key);
	}
	
	/**
	 * 根据条件查找员工工资标准列表方法
	 * @param salStandard SalStandard 实体对象（查询条件）
	 * @return List<SalStandard> 实体对象的list
	 */
	public List<SalStandard> listByCondition(SalStandard salStandard){
		return salStandardMapper.listByCondition(salStandard);
	}
	
	/**
	 * 修改员工工资标准方法
	 * @param salStandard SalStandard 实体对象
	 */	
	public ResultMessage update(SalStandard salStandard){
		salStandardMapper.update(salStandard);
		return AjaxUtils.getSuccessMessage();
	}
}