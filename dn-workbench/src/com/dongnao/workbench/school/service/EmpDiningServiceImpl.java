package com.dongnao.workbench.school.service;
import javax.annotation.Resource;
import java.util.List;
import com.dongnao.workbench.school.dao.EmpDiningMapper;
import com.dongnao.workbench.school.model.EmpDining;
import com.dongnao.workbench.school.service.EmpDiningService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.dongnao.workbench.common.bean.ResultMessage;
import com.dongnao.workbench.common.util.AjaxUtils;
 
/**
 * 描述：员工订餐表模块service接口实现类，实现service接口方法
 *
 * @author maggie
 * @version 1.0 2016-11-24
 */
@Service("empDiningService")
public class EmpDiningServiceImpl implements EmpDiningService{
        @Resource
	private EmpDiningMapper empDiningMapper;
	
 
	/**
	 * 新增员工订餐表方法
	 * @param empDining:实体类
	 */	
	public ResultMessage add(EmpDining empDining){
		empDiningMapper.add(empDining);
		return AjaxUtils.getSuccessMessage();
	}
	
	/**
	 * 根据主键查找员工订餐表实体方法
	 * @param key String 实体主键
	 * @return EmpDining 实体对象
	 */
	public EmpDining getByPrimaryKey(String key){
		return empDiningMapper.getByPrimaryKey(key);
	}
	
	/**
	 * 删除员工订餐表方法
	 * @param key String 多个由“，”分割开的id字符串
	 */
	public void deleteByKey(String key){
		empDiningMapper.deleteByKey(key);
	}
	
	/**
	 * 根据条件查找员工订餐表列表方法
	 * @param empDining EmpDining 实体对象（查询条件）
	 * @return List<EmpDining> 实体对象的list
	 */
	public List<EmpDining> listByCondition(EmpDining empDining){
		return empDiningMapper.listByCondition(empDining);
	}
	/**
	 * 根据条件统计员工订餐表列表方法
	 * @param empDining EmpDining 实体对象（查询条件）
	 * @return List<EmpDining> 实体对象的list
	 */
	public List<EmpDining> staticEmpDining(EmpDining empDining) {
		return empDiningMapper.staticEmpDining(empDining);
	}
}