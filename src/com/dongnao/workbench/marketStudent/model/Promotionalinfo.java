package com.dongnao.workbench.marketStudent.model;

import java.util.Date;
import java.math.BigDecimal;
import org.springframework.format.annotation.DateTimeFormat;
import com.dongnao.workbench.common.bean.Model;
/**
 * 描述：录入推广信息模块实体类，负责页面与后台数据传输功能
 *
 * @version 1.0 2018-01-02
 */
public class Promotionalinfo extends Model{
	
	private String id;
	private String qq;
	private String subjectid;
	private String course;
	private String level;
	private String entry_emp;
	private Date entry_time;
	private String is_buy;
	private String auxiliary;
	private String notes;
	
	
	
	public String getNotes() {
		return notes;
	}
	public void setNotes(String notes) {
		this.notes = notes;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getQq() {
		return qq;
	}
	public void setQq(String qq) {
		this.qq = qq;
	}
	
	
	public String getSubjectid() {
		return subjectid;
	}
	public void setSubjectid(String subjectid) {
		this.subjectid = subjectid;
	}
	public String getCourse() {
		return course;
	}
	public void setCourse(String course) {
		this.course = course;
	}
	public String getLevel() {
		return level;
	}
	public void setLevel(String level) {
		this.level = level;
	}
	public String getEntry_emp() {
		return entry_emp;
	}
	public void setEntry_emp(String entry_emp) {
		this.entry_emp = entry_emp;
	}
	public Date getEntry_time() {
		return entry_time;
	}
	public void setEntry_time(Date entry_time) {
		this.entry_time = entry_time;
	}
	public String getIs_buy() {
		return is_buy;
	}
	public void setIs_buy(String is_buy) {
		this.is_buy = is_buy;
	}
	public String getAuxiliary() {
		return auxiliary;
	}
	public void setAuxiliary(String auxiliary) {
		this.auxiliary = auxiliary;
	}
	
			
}