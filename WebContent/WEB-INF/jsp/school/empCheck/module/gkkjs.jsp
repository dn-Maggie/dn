<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
	xmlns:w="urn:schemas-microsoft-com:office:word"
	xmlns="http://www.w3.org/TR/REC-html40">
<head>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="m" uri="/WEB-INF/tld/spring.tld"%>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath() %>/styles/skin/default/components/jqgrid/jquery.jqgrid.css" />

<script type="text/javascript"
	src="<%=request.getContextPath() %>/js/excelExport.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath() %>/styles/index.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath() %>/js/lib/biz.jquery.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath() %>/js/lib/biz-html5.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath() %>/js/lib/biz-ie.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath() %>/js/jquery.cookie.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath() %>/js/lib/WdatePicker.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath() %>/js/i18n/i18n_zh.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath() %>/js/lib/biz.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath() %>/js/jquery.nicescroll.js"></script>
<script title="js模板控件" type="text/javascript"
	src="<%=request.getContextPath() %>/js/doT.min.js"></script>
<!-- 自定义js -->
<script title="表格列耐热格式" type="text/javascript"
	src="<%=request.getContextPath() %>/js/GridColModelForMatter.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath() %>/js/bizLib/common.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath() %>/js/bizLib/jquery.form.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath() %>/js/bizLib/jquery.contextmenu.r2.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath() %>/js/tiledCombobox.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath() %>/js/bizLib/placeholder.js"></script>

<script
	src="<%=request.getContextPath() %>/js/gameco/jquery.collapse.js"></script>
<script src="<%=request.getContextPath() %>/modulejs/common.js"></script>

<!-- 新添加的js -->
<script type="text/javascript"
	src="<%=request.getContextPath() %>/js/statistic/helium.js"></script>
<meta name=ProgId content=Word.Document>
<meta name=Generator content="Microsoft Word 14">
<meta name=Originator content="Microsoft Word 14">
<title></title>
<style>
@font-face {
	font-family: "Times New Roman";
}

@font-face {
	font-family: "宋体";
}

@font-face {
	font-family: "Calibri";
}

@font-face {
	font-family: "微软雅黑";
}

@font-face {
	font-family: "Wingdings";
}

@font-face {
	font-family: "Tahoma";
}

@font-face {
	font-family: "仿宋";
}

p.MsoNormal {
	mso-style-name: 正文;
	mso-style-parent: "";
	margin-bottom: 10.0000pt;
	mso-layout-grid-align: none;
	layout-grid-mode: char;
	font-family: Tahoma;
	mso-fareast-font-family: 微软雅黑;
	mso-bidi-font-family: 'Times New Roman';
	font-size: 11.0000pt;
}

span.10 {
	font-family: Calibri;
}

span.15 {
	font-family: Tahoma;
	font-size: 9.0000pt;
}

span.16 {
	font-family: Tahoma;
	font-size: 9.0000pt;
}

p.MsoHeader {
	mso-style-name: 页眉;
	mso-style-noshow: yes;
	margin-bottom: 10.0000pt;
	border-bottom: 1.0000pt solid windowtext;
	mso-border-bottom-alt: 0.7500pt solid windowtext;
	padding: 0pt 0pt 1pt 0pt;
	mso-layout-grid-align: none;
	layout-grid-mode: char;
	text-align: center;
	font-family: Tahoma;
	mso-fareast-font-family: 微软雅黑;
	mso-bidi-font-family: 'Times New Roman';
	font-size: 9.0000pt;
}

p.MsoFooter {
	mso-style-name: 页脚;
	mso-style-noshow: yes;
	margin-bottom: 10.0000pt;
	mso-layout-grid-align: none;
	layout-grid-mode: char;
	font-family: Tahoma;
	mso-fareast-font-family: 微软雅黑;
	mso-bidi-font-family: 'Times New Roman';
	font-size: 9.0000pt;
}

span.msoIns {
	mso-style-type: export-only;
	mso-style-name: "";
	text-decoration: underline;
	text-underline: single;
	color: blue;
}

span.msoDel {
	mso-style-type: export-only;
	mso-style-name: "";
	text-decoration: line-through;
	color: red;
}

table.MsoNormalTable {
	mso-style-name: 普通表格;
	mso-style-parent: "";
	mso-style-noshow: yes;
	mso-tstyle-rowband-size: 0;
	mso-tstyle-colband-size: 0;
	mso-padding-alt: 0.0000pt 5.4000pt 0.0000pt 5.4000pt;
	mso-para-margin: 0pt;
	mso-para-margin-bottom: .0001pt;
	mso-pagination: widow-orphan;
	font-family: 'Times New Roman';
	font-size: 10.0000pt;
	mso-ansi-language: #0400;
	mso-fareast-language: #0400;
	mso-bidi-language: #0400;
}

@page {
	mso-page-border-surround-header: no;
	mso-page-border-surround-footer: no;
}

@page Section0 {
	margin-top: 72.0000pt;
	margin-bottom: 72.0000pt;
	margin-left: 90.0000pt;
	margin-right: 90.0000pt;
	size: 595.3000pt 841.9000pt;
	layout-grid: 18.0000pt;
}

div.Section0 {
	page: Section0;
}
</style>
</head>
<body style="tab-interval: 36pt;">
	<!--StartFragment-->
	<div class="Section0" style="layout-grid: 18.0000pt;">
		<p class=MsoNormal align=center
			style="margin-bottom: 0.0000pt; text-align: center; mso-line-height-alt: 12pt;">
			<span
				style="mso-spacerun: 'yes'; font-family: 微软雅黑; mso-ascii-font-family: Tahoma; mso-hansi-font-family: Tahoma; mso-bidi-font-family: 'Times New Roman'; font-size: 14.0000pt;"><font
				face="微软雅黑">动脑学院公开课讲师</font></span><span
				style="mso-spacerun: 'yes'; font-family: 微软雅黑; mso-ascii-font-family: Tahoma; mso-hansi-font-family: Tahoma; mso-bidi-font-family: 'Times New Roman'; font-size: 14.0000pt;"><font
				face="微软雅黑">月度</font></span><span
				style="mso-spacerun: 'yes'; font-family: 微软雅黑; mso-ascii-font-family: Tahoma; mso-hansi-font-family: Tahoma; mso-bidi-font-family: 'Times New Roman'; font-size: 14.0000pt;"><font
				face="微软雅黑">考核表</font></span><span
				style="mso-spacerun: 'yes'; font-family: 微软雅黑; mso-ascii-font-family: Tahoma; mso-hansi-font-family: Tahoma; mso-bidi-font-family: 'Times New Roman'; font-size: 14.0000pt;"><o:p></o:p></span>
		</p>
		<form id="form" >
		<table class=MsoNormalTable align=center
			style="border-collapse: collapse; width: 437.6500pt; mso-table-layout-alt: fixed; mso-padding-alt: 0.0000pt 5.4000pt 0.0000pt 5.4000pt;">
			<tr style="height: 30.4000pt;">
				<td width=93 valign=center
					style="width: 69.8000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: 1.0000pt solid windowtext; mso-border-left-alt: 0.5000pt solid windowtext; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: 1.0000pt solid windowtext; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal align=center
						style="margin-bottom: 0.0000pt; text-align: center;">
						<b><span
							style="mso-spacerun: 'yes'; font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; color: rgb(0, 0, 0); font-weight: bold; font-size: 14.0000pt;">姓名</span></b><b><span
							style="font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; color: rgb(0, 0, 0); font-weight: bold; font-size: 14.0000pt;"><o:p></o:p></span></b>
					</p></td>
				<td width=109 valign=center
					style="width: 82.2000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: 1.0000pt solid windowtext; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal align=center
						style="margin-bottom: 0.0000pt; text-align: center;">
						<span
							style="font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;"><o:p>&nbsp;</o:p></span>
							<span style="color:red;">${empCheck.empName}</span>
							<input name="empName" type="hidden" value="${empCheck.empName}">
							<input name="checkStanderd" type="hidden" value="${empCheck.checkStanderd}">
							<input name="checkMonth" type="hidden" value="${empCheck.checkMonth}">
							<input name="empNo" type="hidden" value="${empCheck.empNo}">
					</p></td>
				<td width=190 valign=center
					style="width: 142.8000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: 1.0000pt solid windowtext; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal align=center
						style="margin-bottom: 0.0000pt; text-align: center;">
						<b><span
							style="mso-spacerun: 'yes'; font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; color: rgb(0, 0, 0); font-weight: bold; font-size: 14.0000pt;">考核月份</span></b><span
							style="font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=190 valign=center colspan=2
					style="width: 142.8500pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: 1.0000pt solid windowtext; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal align=center
						style="margin-bottom: 0.0000pt; text-align: center;">
						<span
							style="font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;"><o:p>&nbsp;</o:p></span>
							<label style="color: orangered">${empCheck.checkMonth}</label>
					</p></td>
			</tr>
			<tr style="height: 32.1500pt;">
				<td width=93 valign=center
					style="width: 69.8000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: 1.0000pt solid windowtext; mso-border-left-alt: 0.5000pt solid windowtext; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal align=center
						style="margin-bottom: 0.0000pt; text-align: center;">
						<b><span
							style="mso-spacerun: 'yes'; font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; color: rgb(0, 0, 0); font-weight: bold; font-size: 14.0000pt;">考核项</span></b><span
							style="font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=109 valign=center
					style="width: 82.2000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal align=center
						style="margin-bottom: 0.0000pt; text-align: center;">
						<b><span
							style="mso-spacerun: 'yes'; font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; color: rgb(0, 0, 0); font-weight: bold; font-size: 14.0000pt;">基准标准</span></b><span
							style="font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=190 valign=center
					style="width: 142.8000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal align=center
						style="margin-bottom: 0.0000pt; text-align: center;">
						<b><span
							style="mso-spacerun: 'yes'; font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; color: rgb(0, 0, 0); font-weight: bold; font-size: 14.0000pt;">加减分条件</span></b><span
							style="font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=56 valign=center
					style="width: 42.5500pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal align=center
						style="margin-bottom: 0.0000pt; text-align: center;">
						<b><span
							style="mso-spacerun: 'yes'; font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; color: rgb(0, 0, 0); font-weight: bold; font-size: 14.0000pt;">得分</span></b><span
							style="font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=133 valign=center
					style="width: 100.3000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: 1.0000pt solid windowtext; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal align=center
						style="margin-bottom: 0.0000pt; text-align: center;">
						<b><span
							style="mso-spacerun: 'yes'; font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; color: rgb(0, 0, 0); font-weight: bold; font-size: 14.0000pt;">备注</span></b><b><span
							style="font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; color: rgb(0, 0, 0); font-weight: bold; font-size: 14.0000pt;"><o:p></o:p></span></b>
					</p></td>
			</tr>
			<tr style="height: 19.0500pt;">
				<td width=93 valign=center rowspan=2
					style="width: 69.8000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: 1.0000pt solid windowtext; mso-border-left-alt: 0.5000pt solid windowtext; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: none;; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal align=center
						style="margin-bottom: 0.0000pt; text-align: center;">
						<span
							style="mso-spacerun: 'yes'; font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;">工作纪律</span><span
							style="font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=109 valign=center rowspan=2
					style="width: 82.2000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: none;; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal align=justify
						style="margin-bottom: 0.0000pt; text-align: justify; text-justify: inter-ideograph;">
						<span
							style="mso-spacerun: 'yes'; font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;">基准分15分。标准：遵守公司各项规章制度</span><span
							style="font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=190 valign=center
					style="width: 142.8000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal align=justify
						style="margin-bottom: 0.0000pt; text-align: justify; text-justify: inter-ideograph;">
						<span
							style="mso-spacerun: 'yes'; font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;">加：全勤等</span><span
							style="font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=56 valign=center rowspan=2
					style="width: 42.5500pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: none;; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal align=center
						style="margin-bottom: 0.0000pt; text-align: center;">
						<span
							style="font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;"><o:p>&nbsp;</o:p></span>
					<c:choose> 
					  <c:when test="${type eq 'check'}">   
					    <select id="core1" name="core1" onchange="corechange()">
							<c:forEach var="intNum" items="${arr}">
								<option value="<c:out value="${intNum}"/>" 
								<c:if test="${intNum == '15' }">selected</c:if>>   <c:out value="${intNum}" /></option>
							</c:forEach>
						</select> 
					  </c:when>  
					  <c:otherwise>   
					    <label style="color: orangered">${checkHtmlForm.core1}</label>  
					  </c:otherwise> 
					</c:choose>
							
					</p></td>
				<td width=133 valign=center rowspan=2
					style="position:relative;width: 100.3000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: none;; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal align=center
						style="margin-bottom: 0.0000pt; text-align: center;">
						<span
							style="font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;"><o:p>&nbsp;</o:p></span>
					<c:choose> 
					  <c:when test="${type eq 'check'}">   
					    <textarea id="text1" name="text1" style="position:absolute;width:90%;height:90%;margin-left:-64px;margin-top:-54px;border:none"></textarea>
					  </c:when>  
					  <c:otherwise>   
					    <label style="color: orangered">${checkHtmlForm.text1}</label>  
					  </c:otherwise> 
					</c:choose> 
					
					</p></td>
			</tr>
			<tr style="height: 32.1500pt;">
				<td width=190 valign=center
					style="width: 142.8000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal align=justify
						style="margin-bottom: 0.0000pt; text-align: justify; text-justify: inter-ideograph;">
						<span
							style="mso-spacerun: 'yes'; font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;">减：工作时间玩手机、看视频等做与工作无关的事；迟到、早退、旷工等</span><span
							style="font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;"><o:p></o:p></span>
					</p></td>
			</tr>
			<tr style="height: 38.2500pt;">
				<td width=93 valign=center rowspan=2
					style="width: 69.8000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: 1.0000pt solid windowtext; mso-border-left-alt: 0.5000pt solid windowtext; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: none;; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal align=center
						style="margin-bottom: 0.0000pt; text-align: center;">
						<span
							style="mso-spacerun: 'yes'; font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;">工作态度</span><span
							style="font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=109 valign=center rowspan=2
					style="width: 82.2000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: none;; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal align=justify
						style="margin-bottom: 0.0000pt; text-align: justify; text-justify: inter-ideograph;">
						<span
							style="mso-spacerun: 'yes'; font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;">基准分15分。标准：工作态度良好</span><span
							style="font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=190 valign=center
					style="width: 142.8000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal align=justify
						style="margin-bottom: 0.0000pt; text-align: justify; text-justify: inter-ideograph;">
						<span
							style="mso-spacerun: 'yes'; font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;">加：平时主动加班；节假日主动值班并未调休；帮助部门负责人积极处理部门工作</span><span
							style="font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=56 valign=center rowspan=2
					style="width: 42.5500pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: none;; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal align=center
						style="margin-bottom: 0.0000pt; text-align: center;">
						<span
							style="font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;"><o:p>&nbsp;</o:p></span>
						<c:choose> 
					  <c:when test="${type eq 'check'}">   
					    <select id="core2" name="core2" onchange="corechange()">
							<c:forEach var="intNum" items="${arr}">
								<option value="<c:out value="${intNum}"/>" <c:if test="${intNum == '15' }">selected</c:if>>   
								<c:out value="${intNum}" /></option>
							</c:forEach>
						</select> 
					  </c:when>  
					  <c:otherwise>   
					    <label style="color: orangered">${checkHtmlForm.core2}</label>  
					  </c:otherwise> 
					</c:choose>
					
					</p></td>
				<td width=133 valign=center rowspan=2
					style="position:relative;width: 100.3000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: none;; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal align=center
						style="margin-bottom: 0.0000pt; text-align: center;">
						<span
							style="font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;"><o:p>&nbsp;</o:p></span>
					<c:choose> 
					  <c:when test="${type eq 'check'}">   
					   <textarea id="text2" name="text2" style="position:absolute;width:90%;height:90%;margin-left:-64px;margin-top:-63px;border:none"></textarea>  
					  </c:when>  
					  <c:otherwise>   
					    <label style="color: orangered">${checkHtmlForm.text2}</label>  
					  </c:otherwise> 
					</c:choose>
					
					</p></td>
			</tr>
			<tr style="height: 25.7000pt;">
				<td width=190 valign=center
					style="width: 142.8000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal align=justify
						style="margin-bottom: 0.0000pt; text-align: justify; text-justify: inter-ideograph;">
						<span
							style="mso-spacerun: 'yes'; font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;">减：不服从管理、工作态度消极、态度恶劣等</span><span
							style="font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;"><o:p></o:p></span>
					</p></td>
			</tr>
			<tr style="height: 33.4500pt;">
				<td width=93 valign=center rowspan=2
					style="width: 69.8000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: 1.0000pt solid windowtext; mso-border-left-alt: 0.5000pt solid windowtext; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: none;; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal align=center
						style="margin-bottom: 0.0000pt; text-align: center;">
						<span
							style="mso-spacerun: 'yes'; font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;">解答问题</span><span
							style="font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=109 valign=center rowspan=2
					style="width: 82.2000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: none;; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal align=justify
						style="margin-bottom: 0.0000pt; text-align: justify; text-justify: inter-ideograph;">
						<span
							style="mso-spacerun: 'yes'; font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;">基准分15分。标准：认真解答学生问题</span><span
							style="font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=190 valign=center
					style="width: 142.8000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal align=justify
						style="margin-bottom: 0.0000pt; text-align: justify; text-justify: inter-ideograph;">
						<span
							style="mso-spacerun: 'yes'; font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;">加：有问题不推脱，即使是自己不能解答的问题也想方设法积极联系其他老师帮助学生（vip）解答，得到学生肯定</span><span
							style="font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=56 valign=center rowspan=2
					style="width: 42.5500pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: none;; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal align=center
						style="margin-bottom: 0.0000pt; text-align: center;">
						<span
							style="font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;"><o:p>&nbsp;</o:p></span>
					<c:choose> 
					  <c:when test="${type eq 'check'}">   
					    <select id="core3" name="core3" onchange="corechange()">
							<c:forEach var="intNum" items="${arr}">
								<option value="<c:out value="${intNum}"/>" <c:if test="${intNum == '15' }">selected</c:if>>   
								<c:out value="${intNum}" /></option>
							</c:forEach>
						</select> 
					  </c:when>  
					  <c:otherwise>   
					    <label style="color: orangered">${checkHtmlForm.core3}</label>  
					  </c:otherwise> 
					</c:choose>
					
					</p></td>
				<td width=133 valign=center rowspan=2
					style="position:relative;width: 100.3000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: none;; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal align=center
						style="margin-bottom: 0.0000pt; text-align: center;">
						<span
							style="font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;"><o:p>&nbsp;</o:p></span>
					<c:choose> 
					  <c:when test="${type eq 'check'}">   
					   <textarea id="text3" name="text3" style="position:absolute;width:90%;height:90%;margin-left:-63px;margin-top:-94px;border:none"></textarea> 
					  </c:when>  
					  <c:otherwise>   
					    <label style="color: orangered">${checkHtmlForm.text3}</label>  
					  </c:otherwise> 
					</c:choose>
					
					</p></td>
			</tr>
			<tr style="height: 28.2500pt;">
				<td width=190 valign=center
					style="width: 142.8000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal align=justify
						style="margin-bottom: 0.0000pt; text-align: justify; text-justify: inter-ideograph;">
						<span
							style="mso-spacerun: 'yes'; font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;">减：不解答学生（vip）问题导致学生投诉；解答过程敷衍了事</span><span
							style="font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;"><o:p></o:p></span>
					</p></td>
			</tr>
			<tr style="height: 35.2000pt;">
				<td width=93 valign=center rowspan=2
					style="width: 69.8000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: 1.0000pt solid windowtext; mso-border-left-alt: 0.5000pt solid windowtext; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: none;; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal align=center
						style="margin-bottom: 0.0000pt; text-align: center;">
						<span
							style="mso-spacerun: 'yes'; font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;">基本业绩完成情况</span><span
							style="font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=109 valign=center rowspan=2
					style="width: 82.2000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: none;; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal align=justify
						style="margin-bottom: 0.0000pt; text-align: justify; text-justify: inter-ideograph;">
						<span
							style="mso-spacerun: 'yes'; font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;">基准分20分。标准：</span><span
							style="font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=190 valign=center
					style="width: 142.8000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal align=justify
						style="margin-bottom: 0.0000pt; text-align: justify; text-justify: inter-ideograph;">
						<span
							style="mso-spacerun: 'yes'; font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; color: rgb(0, 0, 0); font-size: 12.0000pt;">此项因有绩效提成作为计算标准，故此考核体系不做加分</span><span
							style="font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=56 valign=center rowspan=2
					style="width: 42.5500pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: none;; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal align=center
						style="margin-bottom: 0.0000pt; text-align: center;">
						<span
							style="font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;"><o:p>&nbsp;</o:p></span>
					<c:choose> 
					  <c:when test="${type eq 'check'}">   
					  <select id="core4" name="core4" onchange="corechange()">
							<c:forEach var="intNum" items="${arr}">
								<option value="<c:out value="${intNum}"/>" <c:if test="${intNum == '20' }">selected</c:if>>   
								<c:out value="${intNum}" /></option>
							</c:forEach>
						</select>
					  </c:when>  
					  <c:otherwise>   
					    <label style="color: orangered">${checkHtmlForm.core4}</label>  
					  </c:otherwise> 
					</c:choose>
					
					</p></td>
				<td width=133 valign=center rowspan=2
					style="position:relative;width: 100.3000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: none;; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal align=center
						style="margin-bottom: 0.0000pt; text-align: center;">
						<span
							style="font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;"><o:p>&nbsp;</o:p></span>
					<c:choose> 
					  <c:when test="${type eq 'check'}">   
					  <textarea id="text4" name="text4" style="position:absolute;width:90%;height:90%;margin-left:-63px;margin-top:-46px;border:none"></textarea> 
					  </c:when>  
					  <c:otherwise>   
					    <label style="color: orangered">${checkHtmlForm.text4}</label>  
					  </c:otherwise> 
					</c:choose>
					
					</p></td>
			</tr>
			<tr style="height: 14.5500pt;">
				<td width=190 valign=center
					style="width: 142.8000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal align=justify
						style="margin-bottom: 0.0000pt; text-align: justify; text-justify: inter-ideograph;">
						<span
							style="mso-spacerun: 'yes'; font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;">减：当月业绩额＜成本</span><span
							style="font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;"><o:p></o:p></span>
					</p></td>
			</tr>
			<tr style="height: 19.2500pt;">
				<td width=93 valign=center rowspan=2
					style="width: 69.8000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: 1.0000pt solid windowtext; mso-border-left-alt: 0.5000pt solid windowtext; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: none;; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal align=center
						style="margin-bottom: 0.0000pt; text-align: center;">
						<span
							style="mso-spacerun: 'yes'; font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;">培训情况</span><span
							style="font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=109 valign=center rowspan=2
					style="width: 82.2000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: none;; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal align=justify
						style="margin-bottom: 0.0000pt; text-align: justify; text-justify: inter-ideograph;">
						<span
							style="mso-spacerun: 'yes'; font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;">基准分15分。标准：</span><span
							style="font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=190 valign=center
					style="width: 142.8000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal align=justify
						style="margin-bottom: 0.0000pt; text-align: justify; text-justify: inter-ideograph;">
						<span
							style="mso-spacerun: 'yes'; font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;">加：积极参加讲师培训非常大</span><span
							style="font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=56 valign=center rowspan=2
					style="width: 42.5500pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: none;; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal align=center
						style="margin-bottom: 0.0000pt; text-align: center;">
						<span
							style="font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;"><o:p>&nbsp;</o:p></span>
					<c:choose> 
					  <c:when test="${type eq 'check'}">   
					 <select id="core5" name="core5" onchange="corechange()">
							<c:forEach var="intNum" items="${arr}">
								<option value="<c:out value="${intNum}"/>" <c:if test="${intNum == '15' }">selected</c:if>>   
								<c:out value="${intNum}" /></option>
							</c:forEach>
						</select>
					  </c:when>  
					  <c:otherwise>   
					    <label style="color: orangered">${checkHtmlForm.core5}</label>  
					  </c:otherwise> 
					</c:choose>
					
					</p></td>
				<td width=133 valign=center rowspan=2
					style="position:relative;width: 100.3000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: none;; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal align=center
						style="margin-bottom: 0.0000pt; text-align: center;">
						<span
							style="font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;"><o:p>&nbsp;</o:p></span>
					<c:choose> 
					  <c:when test="${type eq 'check'}">   
					   <textarea id="text5" name="text5" style="position:absolute;width:90%;height:90%;margin-left:-63px;margin-top:-45px;border:none"></textarea>
					  </c:when>  
					  <c:otherwise>   
					    <label style="color: orangered">${checkHtmlForm.text5}</label>  
					  </c:otherwise> 
					</c:choose>
					
					</p></td>
			</tr>
			<tr style="height: 13.9500pt;">
				<td width=190 valign=center
					style="width: 142.8000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal align=justify
						style="margin-bottom: 0.0000pt; text-align: justify; text-justify: inter-ideograph;">
						<span
							style="mso-spacerun: 'yes'; font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;">减：不服从培训安排，培训敷衍了事</span><span
							style="font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;"><o:p></o:p></span>
					</p></td>
			</tr>
			<tr style="height: 41.4000pt;">
				<td width=93 valign=center
					style="width: 69.8000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: 1.0000pt solid windowtext; mso-border-left-alt: 0.5000pt solid windowtext; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal align=center
						style="margin-bottom: 0.0000pt; text-align: center;">
						<span
							style="mso-spacerun: 'yes'; font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;">附加贡献加分</span><span
							style="font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=109 valign=center
					style="width: 82.2000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal align=justify
						style="margin-bottom: 0.0000pt; text-align: justify; text-justify: inter-ideograph;">
						<span
							style="mso-spacerun: 'yes'; font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;">加分项。参与助教外其他工作</span><span
							style="font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=190 valign=center
					style="width: 142.8000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal align=justify
						style="margin-bottom: 0.0000pt; text-align: justify; text-justify: inter-ideograph;">
						<span
							style="mso-spacerun: 'yes'; font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;">主持；对公司有突出贡献；工作有突出成绩等</span><span
							style="font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=56 valign=center
					style="width: 42.5500pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal align=center
						style="margin-bottom: 0.0000pt; text-align: center;">
						<span
							style="font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;"><o:p>&nbsp;</o:p></span>
					<c:choose> 
					  <c:when test="${type eq 'check'}">   
					 <select id="core6" name="core6" onchange="corechange()">
								<option value="0" >0</option>
								<option value="1" >1</option>
								<option value="2" >2</option>
								<option value="3" >3</option>
								<option value="4" >4</option>
								<option value="5" >5</option>
								<option value="6" >6</option>
								<option value="7" >7</option>
								<option value="8" >8</option>
								<option value="9" >9</option>
								<option value="10" >10</option>
						</select>
					  </c:when>  
					  <c:otherwise>   
					    <label style="color: orangered">${checkHtmlForm.core6}</label>  
					  </c:otherwise> 
					</c:choose>
					
					</p></td>
				<td width=133 valign=center
					style="position:relative;width: 100.3000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal align=center
						style="margin-bottom: 0.0000pt; text-align: center;">
						<span
							style="font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;"><o:p>&nbsp;</o:p></span>
					<c:choose> 
					  <c:when test="${type eq 'check'}">   
					   <textarea id="text6" name="text6" style="position:absolute;width:90%;height:90%;margin-left:-64px;margin-top:-31px;border:none"></textarea>
					  </c:when>  
					  <c:otherwise>   
					    <label style="color: orangered">${checkHtmlForm.text6}</label>  
					  </c:otherwise> 
					</c:choose>
					
					</p></td>
			</tr>
			<tr style="height: 28.0500pt;">
				<td width=93 valign=center
					style="width: 69.8000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: 1.0000pt solid windowtext; mso-border-left-alt: 0.5000pt solid windowtext; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal align=center
						style="margin-bottom: 0.0000pt; text-align: center;">
						<span
							style="mso-spacerun: 'yes'; font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;">总分</span><span
							style="font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=490 valign=center colspan=4
					style="width: 367.8500pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal align=center
						style="margin-bottom: 0.0000pt; text-align: center;">
						<span
							style="mso-spacerun: 'yes'; font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span
							style="font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;"><o:p></o:p></span>
					<c:choose> 
					  <c:when test="${type eq 'check'}">   
					   <input id="totalcore" name="totalcore" readonly="true" value="80" style="border:0px;"/>
					  </c:when>  
					  <c:otherwise>   
					    <label style="color: orangered">${checkHtmlForm.totalcore}</label>  
					  </c:otherwise> 
					</c:choose>
					</p></td>
			</tr>
			<tr style="height: 18.8500pt;">
				<td width=93 valign=center
					style="width: 69.8000pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: 1.0000pt solid windowtext; mso-border-left-alt: 0.5000pt solid windowtext; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal align=center
						style="margin-bottom: 0.0000pt; text-align: center;">
						<span
							style="mso-spacerun: 'yes'; font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;">说明</span><span
							style="font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width=490 valign=center colspan=4
					style="width: 367.8500pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: none;; mso-border-left-alt: none;; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal style="margin-bottom: 0.0000pt;">
						<span
							style="mso-spacerun: 'yes'; font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;">80分为基本工资线超过或低于80分每1分加减</span><span
							style="mso-spacerun: 'yes'; font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;">15</span><span
							style="mso-spacerun: 'yes'; font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;">元，分数不设上下限，工资加减上下限为</span><span
							style="mso-spacerun: 'yes'; font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;">300元</span><span
							style="mso-spacerun: 'yes'; font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;">。试用期员工考核结果仅作为能否转正的依据。各项适用加减分的情况由岗位负责人根据部门整体分值分配加减。</span><span
							style="font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;"><o:p></o:p></span>
					</p></td>
			</tr>
			<tr style="height: 18.8500pt;">
				<td width=583 valign=center colspan=5
					style="width: 437.6500pt; padding: 0.0000pt 5.4000pt 0.0000pt 5.4000pt; border-left: 1.0000pt solid windowtext; mso-border-left-alt: 0.5000pt solid windowtext; border-right: 1.0000pt solid windowtext; mso-border-right-alt: 0.5000pt solid windowtext; border-top: none;; mso-border-top-alt: 0.5000pt solid windowtext; border-bottom: 1.0000pt solid windowtext; mso-border-bottom-alt: 0.5000pt solid windowtext;"><p
						class=MsoNormal
						style="margin-bottom: 0.0000pt; mso-line-height-alt: 12pt;">
						<span
							style="mso-spacerun: 'yes'; font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;">注：1、在学院现有安排下如讲师既参与vip讲课也参与公开课，月末基本工资考核可选择按公开课或者vip课中的一种来考核，如选择按公开课考核，则当月基本业绩量按公开课和vip课讲课比例折算。例如：当月讲一半时间vip课一半公开课，基本业绩可按成本/2来计算基本业绩量。</span><span
							style="font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;"><o:p></o:p></span>
					</p>
					<p class=MsoNormal
						style="margin-bottom: 0.0000pt; text-indent: 23.2500pt; mso-line-height-alt: 12pt;">
						<span
							style="mso-spacerun: 'yes'; font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;">2、如当月有长时间的请假，基本业绩量可减掉请假期间的业绩任务计算。</span><span
							style="font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;"><o:p></o:p></span>
					</p>
					<p class=MsoNormal
						style="margin-bottom: 0.0000pt; text-indent: 23.2500pt; mso-line-height-alt: 12pt;">
						<span
							style="mso-spacerun: 'yes'; font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;">3、各考核项除培训情况由培训岗位负责人打分外其余项由部门负责人打分。</span><span
							style="font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;"><o:p></o:p></span>
					</p></td>
			</tr>
						<tr style="height:18.8500pt;"></tr>
            <tr align="center">
                <td colspan=5>
                     <c:choose> 
					  <c:when test="${type eq 'check'}">   
					   <input type="button" value="提交" style="width: 70px;" onclick="ajaxUpload()">
					   <input type="button" value="关闭" style="width: 70px;" onclick="cancelCheck()"> 
					  </c:when>  
					  <c:otherwise>   
						  <c:if test="${empCheck.isConfirm == 1}">
						  	<c:if test="${commonEmp}">
								<input type="button" value="确认无误" style="width: 70px;" onclick="empConfirm(3,'${empCheck.empNo}','${empCheck.checkMonth}')">
					     		<input type="button" value="有异议" style="width: 70px;" onclick="empConfirm(2,'${empCheck.empNo}','${empCheck.checkMonth}')">
							</c:if>
							<c:if test="${empCheck.empName == user.fullName}">
								<input type="button" value="确认无误" style="width: 70px;" onclick="empConfirm(3,'${empCheck.empNo}','${empCheck.checkMonth}')">
					     		<input type="button" value="有异议" style="width: 70px;" onclick="empConfirm(2,'${empCheck.empNo}','${empCheck.checkMonth}')">
							</c:if>
						  </c:if>
						<input type="button" value="关闭" style="width: 70px;" onclick="cancelShow()">
					  </c:otherwise> 
					</c:choose>
                </td>
            </tr>
		</table>
		</form>
		<p class=MsoNormal
			style="margin-bottom: 0.0000pt; text-indent: 23.2500pt; mso-line-height-alt: 12pt;">
			<span
				style="mso-spacerun: 'yes'; font-family: 仿宋; mso-bidi-font-family: 'Times New Roman'; font-size: 12.0000pt;"><o:p>&nbsp;</o:p></span>
		</p>
	</div>
	<!--EndFragment-->
</body>
<script type="text/javascript">

function corechange(){
	var sum = parseInt($("#core1").val())+parseInt($("#core2").val())+parseInt($("#core3").val())+parseInt($("#core4").val())+parseInt($("#core5").val())+parseInt($("#core6").val());
	$("#totalcore").val(sum);
}

function ajaxUpload(){
 		var options = {
				url : "<m:url value='/empCheck/saveCheckData.do'/>",
				type : "post",
				dataType:"text",
				success :function(d) {
						window.parent.closeCheck();
						window.location.reload();
				}
			};
			$('#form').ajaxSubmit(options);
 	}


function empConfirm(num,empNo,checkMonth){
	var paramDatas = {
			isConfirm:num,
			empNo:empNo,
			checkMonth:checkMonth
			};
		$.ajax({
					url : "<m:url value='/empCheck/empConfirm.do'/>",
					cache : false,
					data: paramDatas,
					async : true,
					dataType:"json",
					success : function(data, textStatus, jqXHR) {
						if(data.status==1){
							cancelShow();
						}else{
							alert("操作失败，请联系管理员！");
							window.location.reload();
						}
					}
				});
}

function cancelCheck(){
	window.parent.closeCheck();
	window.location.reload();
}

function cancelShow(){
	window.parent.closeShowCheckForm();
	window.location.reload();
}
</script>
</html>