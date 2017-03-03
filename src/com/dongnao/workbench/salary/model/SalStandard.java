package com.dongnao.workbench.salary.model;

import java.util.Date;
import java.math.BigDecimal;
import org.springframework.format.annotation.DateTimeFormat;
import com.dongnao.workbench.common.bean.Model;
/**
 * 描述：员工工资标准模块实体类，负责页面与后台数据传输功能
 *
 * @author maggie
 * @version 1.0 2016-09-20
 */
public class SalStandard extends Model{
	
	
		            /**
	                 * 
	                 **/
				   			private String id;
		   		
		            /**
	                 * 岗位ID
	                 **/
				   			private String dutyId;
				   			/**
			                 * 岗位ID
			                 **/
						   	private String dutyName;
		   		
		            /**
	                 * 岗位级别 duty_rank
	                 **/
				   			private String leveName;
		   		
		            /**
	                 * 标准名称
	                 **/
				   			private String standardName;
		   		
		            /**
	                 * 薪资总额
	                 **/
				   			private String totalValue;
		   		
		            /**
	                 * 薪酬类型
	                 **/
				   			private String salaryTypename;
		   		
		            /**
	                 * 股份配额(股)
	                 **/
				   			private Integer stockNum;
		   		
		            /**
	                 * 基本工资
	                 **/
				   			private String basicSalary;
		   		
		            /**
	                 * 岗位工资
	                 **/
				   			private String dutySalary;
		   		
		            /**
	                 * 社保工资
	                 **/
				   			private String socialSecuritysalary;
		   		
		            /**
	                 * 绩效工资
	                 **/
				   			private String performanceSalary;
		   		
		            /**
	                 * 创建人名字
	                 **/
				   			private String createdbyname;
		   		
		            /**
	                 * 创建时间
	                 **/
				   			private Date created;
		   		
		            /**
	                 * 备注
	                 **/
				   			private String remark;
		   		
	
				
		  			/**
			 * 获取 
			 * @return String this.id
			 */
			public String getId(){
				return this.id;
			}
			
			/**
			 * 设置 
			 * @param String id 
			 */
			public void setId(String id){
				this.id = id;
			}
		   		
		
		
			
						
		  			/**
			 * 获取 岗位ID
			 * @return String this.dutyId
			 */
			public String getDutyId(){
				return this.dutyId;
			}
			
			/**
			 * 设置 岗位ID
			 * @param String dutyId 
			 */
			public void setDutyId(String dutyId){
				this.dutyId = dutyId;
			}
		   		
		
		
			
						
		  			/**
			 * 获取 岗位级别 duty_rank
			 * @return String this.leveName
			 */
			public String getLeveName(){
				return this.leveName;
			}
			
			/**
			 * 设置 岗位级别 duty_rank
			 * @param String leveName 
			 */
			public void setLeveName(String leveName){
				this.leveName = leveName;
			}
		   		
		
		
			
						
		  			/**
			 * 获取 标准名称
			 * @return String this.standardName
			 */
			public String getStandardName(){
				return this.standardName;
			}
			
			/**
			 * 设置 标准名称
			 * @param String standardName 
			 */
			public void setStandardName(String standardName){
				this.standardName = standardName;
			}
		   		
		
		
			
						
		  			/**
			 * 获取 薪资总额
			 * @return String this.totalValue
			 */
			public String getTotalValue(){
				return this.totalValue;
			}
			
			/**
			 * 设置 薪资总额
			 * @param String totalValue 
			 */
			public void setTotalValue(String totalValue){
				this.totalValue = totalValue;
			}
		   		
		
		
			
						
		  			/**
			 * 获取 薪酬类型
			 * @return String this.salaryTypename
			 */
			public String getSalaryTypename(){
				return this.salaryTypename;
			}
			
			/**
			 * 设置 薪酬类型
			 * @param String salaryTypename 
			 */
			public void setSalaryTypename(String salaryTypename){
				this.salaryTypename = salaryTypename;
			}
		   		
		
		
			
						
		  			/**
			 * 获取 股份配额(股)
			 * @return Integer this.stockNum
			 */
			public Integer getStockNum(){
				return this.stockNum;
			}
			
			/**
			 * 设置 股份配额(股)
			 * @param BigDecimal stockNum 
			 */
			public void setStockNum(Integer stockNum){
				this.stockNum = stockNum;
			}
		  		
		
		
			
						
		  			/**
			 * 获取 基本工资
			 * @return String this.basicSalary
			 */
			public String getBasicSalary(){
				return this.basicSalary;
			}
			
			/**
			 * 设置 基本工资
			 * @param String basicSalary 
			 */
			public void setBasicSalary(String basicSalary){
				this.basicSalary = basicSalary;
			}
		   		
		
		
			
						
		  			/**
			 * 获取 岗位工资
			 * @return String this.dutySalary
			 */
			public String getDutySalary(){
				return this.dutySalary;
			}
			
			/**
			 * 设置 岗位工资
			 * @param String dutySalary 
			 */
			public void setDutySalary(String dutySalary){
				this.dutySalary = dutySalary;
			}
		   		
		
		
			
						
		  			/**
			 * 获取 社保工资
			 * @return String this.socialSecuritysalary
			 */
			public String getSocialSecuritysalary(){
				return this.socialSecuritysalary;
			}
			
			/**
			 * 设置 社保工资
			 * @param String socialSecuritysalary 
			 */
			public void setSocialSecuritysalary(String socialSecuritysalary){
				this.socialSecuritysalary = socialSecuritysalary;
			}
		   		
		
		
			
						
		  			/**
			 * 获取 绩效工资
			 * @return String this.performanceSalary
			 */
			public String getPerformanceSalary(){
				return this.performanceSalary;
			}
			
			/**
			 * 设置 绩效工资
			 * @param String performanceSalary 
			 */
			public void setPerformanceSalary(String performanceSalary){
				this.performanceSalary = performanceSalary;
			}
		   		
		
		
			
						
		  			/**
			 * 获取 创建人名字
			 * @return String this.createdbyname
			 */
			public String getCreatedbyname(){
				return this.createdbyname;
			}
			
			/**
			 * 设置 创建人名字
			 * @param String createdbyname 
			 */
			public void setCreatedbyname(String createdbyname){
				this.createdbyname = createdbyname;
			}
		   		
		
		
			
						
		  			/**
			 * 获取 创建时间
			 * @return String this.created
			 */
			public Date getCreated(){
				return this.created;
			}
			
			/**
			 * 设置 创建时间
			 * @param String created 
			 */
			public void setCreated(Date created){
				this.created = created;
			}
		   		
		
		
			
						
		  			/**
			 * 获取 备注
			 * @return String this.remark
			 */
			public String getRemark(){
				return this.remark;
			}
			
			/**
			 * 设置 备注
			 * @param String remark 
			 */
			public void setRemark(String remark){
				this.remark = remark;
			}

			public String getDutyName() {
				return dutyName;
			}

			public void setDutyName(String dutyName) {
				this.dutyName = dutyName;
			}
		   		
		
		
			
			}