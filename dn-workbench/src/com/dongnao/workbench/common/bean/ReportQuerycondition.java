package com.dongnao.workbench.common.bean;

public class ReportQuerycondition  extends Model{
	//报表查询条件实体类
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String r_year;//查询的年份
	private String deptname;//查询的部门
	private String zyjcolunm;//查询的报表项目（总业绩，总成本，总利润）
	private String zcbcolunm;
	private String profitcolunm;
	public String getR_year() {
		return r_year;
	}
	public void setR_year(String r_year) {
		this.r_year = r_year;
	}
	public String getDeptname() {
		return deptname;
	}
	public void setDeptname(String deptname) {
		this.deptname = deptname;
	}
	public String getZyjcolunm() {
		return zyjcolunm;
	}
	public void setZyjcolunm(String zyjcolunm) {
		this.zyjcolunm = zyjcolunm;
	}
	public String getZcbcolunm() {
		return zcbcolunm;
	}
	public void setZcbcolunm(String zcbcolunm) {
		this.zcbcolunm = zcbcolunm;
	}
	public String getProfitcolunm() {
		return profitcolunm;
	}
	public void setProfitcolunm(String profitcolunm) {
		this.profitcolunm = profitcolunm;
	}

	
}
