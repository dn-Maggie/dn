package com.dongnao.workbench.vipStudent.model;

import java.math.BigDecimal;

public class Statistical {
	//学生人数
	private BigDecimal vipcnt;
	//订单总数
	private BigDecimal cnt;
	//应缴总额
	private BigDecimal allturnover;
	//应缴学费
	private BigDecimal shouldPay;
	//实缴总额
	private BigDecimal actualPay;
	//欠费总额
	private BigDecimal owePay;

	public BigDecimal getShouldPay() {
		return shouldPay;
	}
	public void setShouldPay(BigDecimal shouldPay) {
		this.shouldPay = shouldPay;
	}

	public BigDecimal getCnt() {
		return cnt;
	}

	public void setCnt(BigDecimal cnt) {
		this.cnt = cnt;
	}


	public BigDecimal getActualPay() {
		return actualPay;
	}

	public void setActualPay(BigDecimal actualPay) {
		this.actualPay = actualPay;
	}


	public BigDecimal getAllturnover() {
		return allturnover;
	}

	public void setAllturnover(BigDecimal allturnover) {
		this.allturnover = allturnover;
	}

	public BigDecimal getVipcnt() {
		return vipcnt;
	}

	public void setVipcnt(BigDecimal vipcnt) {
		this.vipcnt = vipcnt;
	}

	public BigDecimal getOwePay() {
		return owePay;
	}

	public void setOwePay(BigDecimal owePay) {
		this.owePay = owePay;
	}
	
}
