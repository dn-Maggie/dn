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
				<td class="inputLabelTd">姓名：</td>
				<td class="inputTd">${salUserMonthHistory.userName}</td>
				<td class="inputLabelTd">岗位名称：</td>
				<td class="inputTd">${salUserMonthHistory.dutyName}</td>
			</tr>
			<tr>
			<td class="inputLabelTd">所在部门名称：</td>
				<td class="inputTd">${salUserMonthHistory.orgName}</td>
				<td class="inputLabelTd">薪酬标准名称：</td>
				<td class="inputTd">${salUserMonthHistory.standardName}</td>
			</tr>
			<tr>
				<td class="inputLabelTd">年月：</td>
				<td class="inputTd">${salUserMonthHistory.ym}</td>
				<td class="inputLabelTd">薪资总额：</td>
				<td class="inputTd">${salUserMonthHistory.totalValue}</td>
			</tr>
			<tr>
				<td class="inputLabelTd">股份配额(单位：股)：</td>
				<td class="inputTd">${salUserMonthHistory.stockNum}</td>
				<td class="inputLabelTd">创建时间：</td>
				<td class="inputTd">${salUserMonthHistory.created}</td>
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
