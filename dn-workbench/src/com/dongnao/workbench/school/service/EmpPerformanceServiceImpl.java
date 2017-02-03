package com.dongnao.workbench.school.service;
import javax.annotation.Resource;
import java.util.List;
import com.dongnao.workbench.school.dao.EmpPerformanceMapper;
import com.dongnao.workbench.school.model.EmpPerformance;
import com.dongnao.workbench.school.service.EmpPerformanceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.dongnao.workbench.common.bean.ResultMessage;
import com.dongnao.workbench.common.util.AjaxUtils;
 
/**
 * 描述：员工绩效信息表模块service接口实现类，实现service接口方法
 *
 * @author maggie
 * @version 1.0 2016-07-24
 */
@Service("empPerformanceService")
public class EmpPerformanceServiceImpl implements EmpPerformanceService{
        @Resource
	private EmpPerformanceMapper empPerformanceMapper;
	
 
	/**
	 * 新增员工绩效信息表方法
	 * @param empPerformance:实体类
	 */	
	public ResultMessage add(EmpPerformance empPerformance){
		empPerformanceMapper.add(empPerformance);
		return AjaxUtils.getSuccessMessage();
	}
	
	/**
	 * 根据主键查找员工绩效信息表实体方法
	 * @param key String 实体主键
	 * @return EmpPerformance 实体对象
	 */
	public EmpPerformance getByPrimaryKey(String key){
		return empPerformanceMapper.getByPrimaryKey(key);
	}
	
	/**
	 * 删除员工绩效信息表方法
	 * @param key String 多个由“，”分割开的id字符串
	 */
	public void deleteByKey(String key){
		empPerformanceMapper.deleteByKey(key);
	}
	
	/**
	 * 根据条件查找员工绩效信息表列表方法
	 * @param empPerformance EmpPerformance 实体对象（查询条件）
	 * @return List<EmpPerformance> 实体对象的list
	 */
	public List<EmpPerformance> listByCondition(EmpPerformance empPerformance){
		return empPerformanceMapper.listByCondition(empPerformance);
	}
	
	/**
	 * 修改员工绩效信息表方法
	 * @param empPerformance EmpPerformance 实体对象
	 */	
	public ResultMessage update(EmpPerformance empPerformance){
		empPerformanceMapper.update(empPerformance);
		return AjaxUtils.getSuccessMessage();
	}

	/**
	 * 按员工统计信息
	 */
	public List<EmpPerformance> listByEmployee(EmpPerformance empPerformance) {
		return empPerformanceMapper.listByEmployee(empPerformance);
	}

	
	public void deleteByStuId(EmpPerformance empPerformance) {
		empPerformanceMapper.deleteByStuId(empPerformance);
	}

	/**
	 * 清算员工绩效信息表方法
	 * @param key String 多个由“，”分割开的id字符串
	 */
	public void settleByKey(String key) {
		empPerformanceMapper.settleByKey(key);
	}

	/**
	 * 获取某员工的业绩信息
	 */
	public EmpPerformance getMyPerformance(String userId,String startDate) {
		EmpPerformance empPerformance = new EmpPerformance();
		empPerformance.setEmployeeId(userId);
		empPerformance.setStartDate(startDate);
		return empPerformanceMapper.getMyPerformance(empPerformance);
	}
}