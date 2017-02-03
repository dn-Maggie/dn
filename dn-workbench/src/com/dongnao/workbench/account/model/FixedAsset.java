package com.dongnao.workbench.account.model;

import java.util.Date;
import java.math.BigDecimal;
import org.springframework.format.annotation.DateTimeFormat;
import com.dongnao.workbench.common.bean.Model;
/**
 * 描述：固定资产信息模块实体类，负责页面与后台数据传输功能
 *
 * @author maggie
 * @version 1.0 2016-08-12
 */
public class FixedAsset extends Model{
	
	
		            /**
	                 * 主键
	                 **/
				   			private String id;
		   		
		            /**
	                 * 资产编号
	                 **/
				   			private String assetNo;
		   		
		            /**
	                 * 录入期间
	                 **/
					@DateTimeFormat(pattern="yyyy-MM") 
			private Date enterDate;
		
		            /**
	                 * 增加方式
	                 **/
				   			private String addType;
		   		
		            /**
	                 * 资产名称
	                 **/
				   			private String assetName;
		   		
		            /**
	                 * 资产类别
	                 **/
				   			private String assetType;
		   		
		            /**
	                 * 规格型号
	                 **/
				   			private String model;
		   		
		            /**
	                 * 开始使用日期
	                 **/
					@DateTimeFormat(pattern="yyyy-MM-dd") 
			private Date beginDate;
		
		            /**
	                 * 使用部门
	                 **/
				   			private String useOrg;
		   		
		            /**
	                 * 使用人
	                 **/
				   			private String applyName;
		   		
		            /**
	                 * 折旧方法
	                 **/
				   			private String depreMethod;
		   		
		            /**
	                 * 当期是否折旧
	                 **/
				   			private String isDeprenow;
		   		
		            /**
	                 * 累计折旧科目
	                 **/
				   			private String ljzjSubject;
		   		
		            /**
	                 * 折旧费用科目
	                 **/
				   			private String zjfySubject;
		   		
		            /**
	                 * 资产清理科目
	                 **/
				   			private String zichanClear;
		   		
		            /**
	                 * 资产原值
	                 **/
				   			private String initialValue;
		   		
		            /**
	                 * 残值率
	                 **/
				   			private Integer remainRatio;
		   		
		            /**
	                 * 预计残值
	                 **/
				   			private String remainValue;
		   		
		            /**
	                 *  预计使用月份
	                 **/
				   			private Integer usePeriod;
		   		
		            /**
	                 * 已折旧月份
	                 **/
				   			private Integer depredMonth;
		   		
		            /**
	                 * 剩余使用月份
	                 **/
				   			private Integer remainUseMonth;
		   		
		            /**
	                 * 累计折旧
	                 **/
				   			private String usedDepre;
		   		
		            /**
	                 * 当期录入时间
	                 **/
					@DateTimeFormat(pattern="yyyy-MM-dd") 
			private Date currdate;
		
		            /**
	                 * 每月折旧额
	                 **/
				   			private String perDepred;
		   		
	
				
		  			/**
			 * 获取 主键
			 * @return String this.id
			 */
			public String getId(){
				return this.id;
			}
			
			/**
			 * 设置 主键
			 * @param String id 
			 */
			public void setId(String id){
				this.id = id;
			}
		   		
		
		
			
						
		  			/**
			 * 获取 资产编号
			 * @return Integer this.assetNo
			 */
			public String getAssetNo(){
				return this.assetNo;
			}
			
			/**
			 * 设置 资产编号
			 * @param BigDecimal assetNo 
			 */
			public void setAssetNo(String assetNo){
				this.assetNo = assetNo;
			}
		  		
		
		
			
								/**
			 * 获取 录入期间
			 * @return Date this.enterDate
			 */
			public Date getEnterDate(){
				return this.enterDate;
			}
			
			/**
			 * 设置 录入期间
			 * @param Date enterDate 
			 */
			public void setEnterDate(Date enterDate){
				this.enterDate = enterDate;
			}
						
		  			/**
			 * 获取 增加方式
			 * @return String this.addType
			 */
			public String getAddType(){
				return this.addType;
			}
			
			/**
			 * 设置 增加方式
			 * @param String addType 
			 */
			public void setAddType(String addType){
				this.addType = addType;
			}
		   		
		
		
			
						
		  			/**
			 * 获取 资产名称
			 * @return String this.assetName
			 */
			public String getAssetName(){
				return this.assetName;
			}
			
			/**
			 * 设置 资产名称
			 * @param String assetName 
			 */
			public void setAssetName(String assetName){
				this.assetName = assetName;
			}
		   		
		
		
			
						
		  			/**
			 * 获取 资产类别
			 * @return String this.assetType
			 */
			public String getAssetType(){
				return this.assetType;
			}
			
			/**
			 * 设置 资产类别
			 * @param String assetType 
			 */
			public void setAssetType(String assetType){
				this.assetType = assetType;
			}
		   		
		
		
			
						
		  			/**
			 * 获取 规格型号
			 * @return String this.model
			 */
			public String getModel(){
				return this.model;
			}
			
			/**
			 * 设置 规格型号
			 * @param String model 
			 */
			public void setModel(String model){
				this.model = model;
			}
		   		
		
		
			
								/**
			 * 获取 开始使用日期
			 * @return Date this.beginDate
			 */
			public Date getBeginDate(){
				return this.beginDate;
			}
			
			/**
			 * 设置 开始使用日期
			 * @param Date beginDate 
			 */
			public void setBeginDate(Date beginDate){
				this.beginDate = beginDate;
			}
						
		  			/**
			 * 获取 使用部门
			 * @return String this.useOrg
			 */
			public String getUseOrg(){
				return this.useOrg;
			}
			
			/**
			 * 设置 使用部门
			 * @param String useOrg 
			 */
			public void setUseOrg(String useOrg){
				this.useOrg = useOrg;
			}
		   		
		
		
			
						
		  			/**
			 * 获取 使用人
			 * @return String this.applyName
			 */
			public String getApplyName(){
				return this.applyName;
			}
			
			/**
			 * 设置 使用人
			 * @param String applyName 
			 */
			public void setApplyName(String applyName){
				this.applyName = applyName;
			}
		   		
		
		
			
						
		  			/**
			 * 获取 折旧方法
			 * @return String this.depreMethod
			 */
			public String getDepreMethod(){
				return this.depreMethod;
			}
			
			/**
			 * 设置 折旧方法
			 * @param String depreMethod 
			 */
			public void setDepreMethod(String depreMethod){
				this.depreMethod = depreMethod;
			}
		   		
		
		
			
						
		  			/**
			 * 获取 当期是否折旧
			 * @return String this.isDeprenow
			 */
			public String getIsDeprenow(){
				return this.isDeprenow;
			}
			
			/**
			 * 设置 当期是否折旧
			 * @param String isDeprenow 
			 */
			public void setIsDeprenow(String isDeprenow){
				this.isDeprenow = isDeprenow;
			}
		   		
		
		
			
						
		  			/**
			 * 获取 累计折旧科目
			 * @return String this.ljzjSubject
			 */
			public String getLjzjSubject(){
				return this.ljzjSubject;
			}
			
			/**
			 * 设置 累计折旧科目
			 * @param String ljzjSubject 
			 */
			public void setLjzjSubject(String ljzjSubject){
				this.ljzjSubject = ljzjSubject;
			}
		   		
		
		
			
						
		  			/**
			 * 获取 折旧费用科目
			 * @return String this.zjfySubject
			 */
			public String getZjfySubject(){
				return this.zjfySubject;
			}
			
			/**
			 * 设置 折旧费用科目
			 * @param String zjfySubject 
			 */
			public void setZjfySubject(String zjfySubject){
				this.zjfySubject = zjfySubject;
			}
		   		
		
		
			
						
		  			/**
			 * 获取 资产清理科目
			 * @return String this.zichanClear
			 */
			public String getZichanClear(){
				return this.zichanClear;
			}
			
			/**
			 * 设置 资产清理科目
			 * @param String zichanClear 
			 */
			public void setZichanClear(String zichanClear){
				this.zichanClear = zichanClear;
			}
		   		
		
		
			
						
		  			/**
			 * 获取 资产原值
			 * @return String this.initialValue
			 */
			public String getInitialValue(){
				return this.initialValue;
			}
			
			/**
			 * 设置 资产原值
			 * @param String initialValue 
			 */
			public void setInitialValue(String initialValue){
				this.initialValue = initialValue;
			}
		   		
		
		
			
						
		  			/**
			 * 获取 残值率
			 * @return Integer this.remainRatio
			 */
			public Integer getRemainRatio(){
				return this.remainRatio;
			}
			
			/**
			 * 设置 残值率
			 * @param BigDecimal remainRatio 
			 */
			public void setRemainRatio(Integer remainRatio){
				this.remainRatio = remainRatio;
			}
		  		
		
		
			
						
		  			/**
			 * 获取 预计残值
			 * @return String this.remainValue
			 */
			public String getRemainValue(){
				return this.remainValue;
			}
			
			/**
			 * 设置 预计残值
			 * @param String remainValue 
			 */
			public void setRemainValue(String remainValue){
				this.remainValue = remainValue;
			}
		   		
		
		
			
						
		  			/**
			 * 获取  预计使用月份
			 * @return Integer this.usePeriod
			 */
			public Integer getUsePeriod(){
				return this.usePeriod;
			}
			
			/**
			 * 设置  预计使用月份
			 * @param BigDecimal usePeriod 
			 */
			public void setUsePeriod(Integer usePeriod){
				this.usePeriod = usePeriod;
			}
		  		
		
		
			
						
		  			/**
			 * 获取 已折旧月份
			 * @return Integer this.depredMonth
			 */
			public Integer getDepredMonth(){
				return this.depredMonth;
			}
			
			/**
			 * 设置 已折旧月份
			 * @param BigDecimal depredMonth 
			 */
			public void setDepredMonth(Integer depredMonth){
				this.depredMonth = depredMonth;
			}
		  		
		
		
			
						
		  			/**
			 * 获取 剩余使用月份
			 * @return Integer this.remainUseMonth
			 */
			public Integer getRemainUseMonth(){
				return this.remainUseMonth;
			}
			
			/**
			 * 设置 剩余使用月份
			 * @param BigDecimal remainUseMonth 
			 */
			public void setRemainUseMonth(Integer remainUseMonth){
				this.remainUseMonth = remainUseMonth;
			}
		  		
		
		
			
						
		  			/**
			 * 获取 累计折旧
			 * @return String this.usedDepre
			 */
			public String getUsedDepre(){
				return this.usedDepre;
			}
			
			/**
			 * 设置 累计折旧
			 * @param String usedDepre 
			 */
			public void setUsedDepre(String usedDepre){
				this.usedDepre = usedDepre;
			}
		   		
		
		
			
								/**
			 * 获取 当期录入时间
			 * @return Date this.currdate
			 */
			public Date getCurrdate(){
				return this.currdate;
			}
			
			/**
			 * 设置 当期录入时间
			 * @param Date currdate 
			 */
			public void setCurrdate(Date currdate){
				this.currdate = currdate;
			}
						
		  			/**
			 * 获取 每月折旧额
			 * @return String this.perDepred
			 */
			public String getPerDepred(){
				return this.perDepred;
			}
			
			/**
			 * 设置 每月折旧额
			 * @param String perDepred 
			 */
			public void setPerDepred(String perDepred){
				this.perDepred = perDepred;
			}
		   		
		
		
			
			}