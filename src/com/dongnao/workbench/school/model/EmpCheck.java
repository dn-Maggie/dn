package com.dongnao.workbench.school.model;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.dongnao.workbench.common.bean.Model;

public class EmpCheck extends Model{
	
	/**
     * 主键
     **/
		private String id;
	
    /**
     * 员工id
     **/
		private String empNo;
		private String empName;
		private String nickName;
		private String post;
		private String department;
		private String checkMonth;
		private String basePoints;
		private String checkPoint;
		@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss") 
		private Date createTime;
		public String getId() {
			return id;
		}
		public void setId(String id) {
			this.id = id;
		}
		public String getEmpNo() {
			return empNo;
		}
		public void setEmpNo(String empNo) {
			this.empNo = empNo;
		}
		public String getEmpName() {
			return empName;
		}
		public void setEmpName(String empName) {
			this.empName = empName;
		}
		public String getNickName() {
			return nickName;
		}
		public void setNickName(String nickName) {
			this.nickName = nickName;
		}
		public String getPost() {
			return post;
		}
		public void setPost(String post) {
			this.post = post;
		}

		public String getDepartment() {
			return department;
		}
		public void setDepartment(String department) {
			this.department = department;
		}
		public String getCheckMonth() {
			return checkMonth;
		}
		public void setCheckMonth(String checkMonth) {
			this.checkMonth = checkMonth;
		}
		public String getBasePoints() {
			return basePoints;
		}
		public void setBasePoints(String basePoints) {
			this.basePoints = basePoints;
		}
		public String getCheckPoint() {
			return checkPoint;
		}
		public void setCheckPoint(String checkPoint) {
			this.checkPoint = checkPoint;
		}
		public Date getCreateTime() {
			return createTime;
		}
		public void setCreateTime(Date createTime) {
			this.createTime = createTime;
		}
		
}
