package com.dongnao.workbench.marketStudent.model;

import java.util.Date;
import java.math.BigDecimal;
import org.springframework.format.annotation.DateTimeFormat;
import com.dongnao.workbench.common.bean.Model;
/**
 * 描述：口碑学员模块实体类，负责页面与后台数据传输功能
 *
 * @version 1.0 2018-01-19
 */
public class KouBeiStudent extends Model{
	
	private String id;
	private String qq;
	private String subjectid;
	private String courseid;
	private String tel;
	private String entry_emp;
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss") 
	private Date time;
	private String is_buy;
	private String notes;
	private String subjectname;
	private String coursename;
	
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
	public String getCourseid() {
		return courseid;
	}
	public void setCourseid(String courseid) {
		this.courseid = courseid;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getEntry_emp() {
		return entry_emp;
	}
	public void setEntry_emp(String entry_emp) {
		this.entry_emp = entry_emp;
	}
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
	public String getIs_buy() {
		return is_buy;
	}
	public void setIs_buy(String is_buy) {
		this.is_buy = is_buy;
	}
	public String getNotes() {
		return notes;
	}
	public void setNotes(String notes) {
		this.notes = notes;
	}
	public String getSubjectname() {
		return subjectname;
	}
	public void setSubjectname(String subjectname) {
		this.subjectname = subjectname;
	}
	public String getCoursename() {
		return coursename;
	}
	public void setCoursename(String coursename) {
		this.coursename = coursename;
	}
	
	
			
}