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
				<td class="inputLabelTd">会计科目分类编号：</td>
				<td class="inputTd">${accountSubject.parentId}</td>
				<td class="inputLabelTd">会计科目分类名称：</td>
				<td class="inputTd">${accountSubject.parentName}</td>
			</tr>
			<tr>
				<td class="inputLabelTd">会计科目编号：</td>
				<td class="inputTd">${accountSubject.accountId}</td>
				<td class="inputLabelTd">会计科目名称：</td>
				<td class="inputTd">${accountSubject.accountName}</td>
			</tr>
			<tr>
				<td class="inputLabelTd">描述：</td>
				<td class="inputTd">${accountSubject.note}</td>
			<tr>
				<td class="inputTd" colspan="4" style="text-align:center;">
					<input class="ti_bottom"  type="button" id="close_button"  value="关闭"/>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>
