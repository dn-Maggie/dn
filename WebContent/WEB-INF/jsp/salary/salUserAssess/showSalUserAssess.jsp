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
				<td class="inputLabelTd">考核分数：</td>
				<td class="inputTd">${salUserAssess.signSum}</td>
				<td class="inputLabelTd">考核年月：</td>
				<td class="inputTd">${salUserAssess.signYm}</td>
			</tr>
			<tr>
				<td class="inputLabelTd">用户名称：</td>
				<td class="inputTd">${salUserAssess.userName}</td>
				<td class="inputLabelTd">部门名称：</td>
				<td class="inputTd">${salUserAssess.orgName}</td>
			</tr>
			<tr>
				<td class="inputLabelTd">奖罚类型：</td>
				<td class="inputTd">
				<c:if test="${salUserAssess.signType eq 1}" >奖励</c:if>
				<c:if test="${salUserAssess.signType eq 2}" >处罚</c:if>
				</td>
				<td class="inputLabelTd">创建人名字：</td>
				<td class="inputTd">${salUserAssess.createdbyname}</td>
			</tr>
			<tr>
				<td class="inputLabelTd">备注：</td>
				<td class="inputTd">${salUserAssess.remark}</td>
				<td class="inputLabelTd">创建时间：</td>
				<td class="inputTd">${salUserAssess.created}</td>
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
