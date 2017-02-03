<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html  >
<html>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
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
				<td class="inputLabelTd">执行年月：</td>
				<td class="inputTd" colspan="3">${salUserSanction.ym}</td>
			</tr>
			<tr>
				<td class="inputLabelTd">被奖罚姓名：</td>
				<td class="inputTd">${salUserSanction.userName}</td>
				<td class="inputLabelTd">所在部门：</td>
				<td class="inputTd">${salUserSanction.orgName}</td>
			</tr>
			<tr>
				<td class="inputLabelTd">奖罚类型：</td>
				<td class="inputTd">
				<c:if test="${salUserSanction.type eq 1}">奖励</c:if>
				<c:if test="${salUserSanction.type eq 2}">处罚</c:if>
				</td>
				<td class="inputLabelTd">金额：</td>
				<td class="inputTd">${salUserSanction.money}</td>
			</tr>
			<tr>
				<td class="inputLabelTd">创建时间：</td>
				<td class="inputTd" >${salUserSanction.created}</td>
				<td class="inputLabelTd">创建人名称：</td>
				<td class="inputTd">${salUserSanction.createdbyname}</td>
			
			</tr>
		
			<tr>
				<td class="inputLabelTd">备注：</td>
				<td class="inputTd" colspan="3">${salUserSanction.remark}</td>
			</tr>
			
			<tr>
				
			</tr>
			<tr>
				<td class="inputTd" colspan="4" style="text-align: center;"><input
					class="ti_bottom" type="button" id="close_button" value="关闭" /></td>
			</tr>
		</table>
	</div>
</body>
</html>
