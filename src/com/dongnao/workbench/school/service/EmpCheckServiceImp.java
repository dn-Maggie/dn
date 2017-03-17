package com.dongnao.workbench.school.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dongnao.workbench.school.dao.EmpCheckMapper;
import com.dongnao.workbench.school.dao.EmployeeMapper;
import com.dongnao.workbench.school.model.EmpCheck;

@Service("empCheckService")
public class EmpCheckServiceImp implements EmpCheckService {

	@Resource
	private EmpCheckMapper empCheckMapper;
	
	@Override
	public List<EmpCheck> listByCondition(EmpCheck empCheck) {
		return empCheckMapper.listByCondition(empCheck);
	}

	@Override
	public EmpCheck getByPrimaryKey(String key) {
		return empCheckMapper.getByPrimaryKey(key);
	}

}
