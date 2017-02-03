<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html  >
<html>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<head>
<base href="<%=basePath%>">

<%@ include file="../../common/header.jsp"%>
<script type="text/javascript">
	$(function() {
		//绑定提交按钮click事件
		$("#close_button").click(function() {
			window.parent.closeShow();
		});
	});
</script>
</head>
  
<body>
	<div class="ui-table ui-widget ui-corner-all ui-border">
		<table class="table forview">
			<tr>
				<td class="inputLabelTd">岗位名称：</td>
				<td class="inputTd">${salStandard.dutyName}</td>
				<td class="inputLabelTd">岗位级别：</td>
				<td class="inputTd">${salStandard.levelName}</td>
			</tr>
			<tr>
				<td class="inputLabelTd">基本工资：</td>
				<td class="inputTd">${salStandard.basicSalary}</td>
				<td class="inputLabelTd">岗位工资：</td>
				<td class="inputTd">${salStandard.dutySalary}</td>
			</tr>
			<tr>
				<td class="inputLabelTd">社保工资：</td>
				<td class="inputTd">${salStandard.socialSecuritysalary}</td>
				<td class="inputLabelTd">绩效工资：</td>
				<td class="inputTd">${salStandard.performanceSalary}</td>
			</tr>
			<tr>
				<td class="inputLabelTd">标准名称：</td>
				<td class="inputTd">${salStandard.standardName}</td>
				<td class="inputLabelTd">薪资总额：</td>
				<td class="inputTd">${salStandard.totalValue}</td>
			</tr>
		
			<tr>
				<td class="inputLabelTd">薪酬类型：</td>
				<td class="inputTd">
				${salStandard.salaryTypeName}
				</td>
				<td class="inputLabelTd">股份配额(股)：</td>
				<td class="inputTd">${salStandard.stockNum}</td>
			</tr>
			<tr>
				
				<td class="inputLabelTd">基本工资：</td>
				<td class="inputTd">${salStandard.basicSalary}</td>
				<td class="inputLabelTd">岗位工资：</td>
				<td class="inputTd">${salStandard.dutySalary}</td>
			</tr>
			<tr>
				
				<td class="inputLabelTd">社保工资：</td>
				<td class="inputTd">${salStandard.socialSecuritySalary}</td>
				
					<td class="inputLabelTd">绩效工资：</td>
				<td class="inputTd">${salStandard.performanceSalary}</td>
			</tr>
			<tr>
				<td class="inputLabelTd">创建人名字：</td>
				<td class="inputTd">${salStandard.createdbyname}</td>
				<td class="inputLabelTd">创建时间：</td>
				<td class="inputTd">${salStandard.created}</td>
			</tr>
				<tr>
						<td class="inputLabelTd">备注：</td>
						<td class="inputTd" colspan="3" >${salStandard.remark}</td>
					</tr>
			<tr>
				<td class="inputTd" colspan="4" style="text-align:center;">
					<input class="ti_bottom"  type="button" id="close_button"  value="关闭"/>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>
