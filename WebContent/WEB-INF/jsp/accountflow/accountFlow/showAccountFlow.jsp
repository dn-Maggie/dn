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
				<td class="inputLabelTd">科目id：</td>
				<td class="inputTd">${accountFlow.accountId}</td>
				<td class="inputLabelTd">科目编号：</td>
				<td class="inputTd">${accountFlow.accountNo}</td>
			</tr>
			<tr>
				<td class="inputLabelTd">科目类型：</td>
				<td class="inputTd">${accountFlow.accountType}</td>
				<td class="inputLabelTd">科目名称：</td>
				<td class="inputTd">${accountFlow.accountName}</td>
			</tr>
			<tr>
				<td class="inputLabelTd">发生时间：</td>
				<td class="inputTd">${accountFlow.createDate}</td>
				<td class="inputLabelTd">发生金额：</td>
				<td class="inputTd">${accountFlow.money}</td>
			</tr>
			<tr>
				<td class="inputLabelTd">备注：</td>
				<td class="inputTd">${accountFlow.note}</td>
			<tr>
				<td class="inputTd" colspan="4" style="text-align:center;">
					<input class="ti_bottom"  type="button" id="close_button"  value="关闭"/>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>
