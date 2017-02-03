package com.dongnao.workbench.school.service;
import javax.annotation.Resource;
import java.util.List;
import com.dongnao.workbench.school.dao.EmpTableGrantMapper;
import com.dongnao.workbench.school.model.EmpTableGrant;
import com.dongnao.workbench.school.service.EmpTableGrantService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.dongnao.workbench.common.bean.ResultMessage;
import com.dongnao.workbench.common.util.AjaxUtils;
 
/**
 * 描述：员工晚餐补助申请表模块service接口实现类，实现service接口方法
 *
 * @author maggie
 * @version 1.0 2017-01-08
 */
@Service("empTableGrantService")
public class EmpTableGrantServiceImpl implements EmpTableGrantService{
        @Resource
	private EmpTableGrantMapper empTableGrantMapper;
	
 
	/**
	 * 新增员工晚餐补助申请表方法
	 * @param empTableGrant:实体类
	 */	
	public ResultMessage add(EmpTableGrant empTableGrant){
		empTableGrantMapper.add(empTableGrant);
		return AjaxUtils.getSuccessMessage();
	}
	
	/**
	 * 根据主键查找员工晚餐补助申请表实体方法
	 * @param key String 实体主键
	 * @return EmpTableGrant 实体对象
	 */
	public EmpTableGrant getByPrimaryKey(String key){
		return empTableGrantMapper.getByPrimaryKey(key);
	}
	
	/**
	 * 删除员工晚餐补助申请表方法
	 * @param key String 多个由“，”分割开的id字符串
	 */
	public void deleteByKey(String key){
		empTableGrantMapper.deleteByKey(key);
	}
	
	/**
	 * 根据条件查找员工晚餐补助申请表列表方法
	 * @param empTableGrant EmpTableGrant 实体对象（查询条件）
	 * @return List<EmpTableGrant> 实体对象的list
	 */
	public List<EmpTableGrant> listByCondition(EmpTableGrant empTableGrant){
		return empTableGrantMapper.listByCondition(empTableGrant);
	}
	
	/**
	 * 修改员工晚餐补助申请表方法
	 * @param empTableGrant EmpTableGrant 实体对象
	 */	
	public ResultMessage update(EmpTableGrant empTableGrant){
		empTableGrantMapper.update(empTableGrant);
		return AjaxUtils.getSuccessMessage();
	}
}