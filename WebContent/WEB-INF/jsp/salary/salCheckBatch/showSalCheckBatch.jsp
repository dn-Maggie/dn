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
				<td class="inputLabelTd">批次名称：</td>
				<td class="inputTd">${salCheckBatch.batchname}</td>
				<td class="inputLabelTd">年月：</td>
				<td class="inputTd">${salCheckBatch.ym}</td>
			</tr>
			<tr>
				<td class="inputLabelTd">包含工资ID字符串：</td>
				<td class="inputTd">${salCheckBatch.salaryInfoIds}</td>
				<td class="inputLabelTd">批次合计金额：</td>
				<td class="inputTd">${salCheckBatch.sumMoney}</td>
			</tr>
			<tr>
				<td class="inputLabelTd">所属部门ID：</td>
				<td class="inputTd">${salCheckBatch.orgId}</td>
				<td class="inputLabelTd">所属部门名称：</td>
				<td class="inputTd">${salCheckBatch.orgName}</td>
			</tr>
			<tr>
				<td class="inputLabelTd">备注：</td>
				<td class="inputTd">${salCheckBatch.remark}</td>
				<td class="inputLabelTd">创建人ID：</td>
				<td class="inputTd">${salCheckBatch.createdby}</td>
			</tr>
			<tr>
				<td class="inputLabelTd">创建人名称：</td>
				<td class="inputTd">${salCheckBatch.createdbyname}</td>
				<td class="inputLabelTd">创建时间：</td>
				<td class="inputTd">${salCheckBatch.created}</td>
			</tr>
			<tr>
				<td class="inputLabelTd">分公司审核人ID：</td>
				<td class="inputTd">${salCheckBatch.branchCkUserId}</td>
				<td class="inputLabelTd">分公司审核人名字：</td>
				<td class="inputTd">${salCheckBatch.branchCkUserName}</td>
			</tr>
			<tr>
				<td class="inputLabelTd">分公司审核时间：</td>
				<td class="inputTd">${salCheckBatch.branchCkTime}</td>
				<td class="inputLabelTd">分公司审核状态(0是未审核，1是已审核，2是审核未通过)：</td>
				<td class="inputTd">${salCheckBatch.branchCkStatus}</td>
			</tr>
			<tr>
				<td class="inputLabelTd">分公司审核备注：</td>
				<td class="inputTd">${salCheckBatch.branchCkRemark}</td>
				<td class="inputLabelTd">省级审核人ID：</td>
				<td class="inputTd">${salCheckBatch.provinceCkUserId}</td>
			</tr>
			<tr>
				<td class="inputLabelTd">省级审核人名字：</td>
				<td class="inputTd">${salCheckBatch.provinceCkUserName}</td>
				<td class="inputLabelTd">省级审核时间：</td>
				<td class="inputTd">${salCheckBatch.provinceCkTime}</td>
			</tr>
			<tr>
				<td class="inputLabelTd">省级审核状态(0是未审核，1是已审核，2是审核未通过)：</td>
				<td class="inputTd">${salCheckBatch.provinceCkStatus}</td>
				<td class="inputLabelTd">省级审核备注：</td>
				<td class="inputTd">${salCheckBatch.provinceCkRemark}</td>
			</tr>
			<tr>
				<td class="inputLabelTd">集团审核人ID：</td>
				<td class="inputTd">${salCheckBatch.groupCkUserId}</td>
				<td class="inputLabelTd">集团审核人名字：</td>
				<td class="inputTd">${salCheckBatch.groupCkUserName}</td>
			</tr>
			<tr>
				<td class="inputLabelTd">集团审核时间：</td>
				<td class="inputTd">${salCheckBatch.groupCkTime}</td>
				<td class="inputLabelTd">集团审核状态(0是未审核，1是已审核，2是审核未通过)：</td>
				<td class="inputTd">${salCheckBatch.groupCkStatus}</td>
			</tr>
			<tr>
				<td class="inputLabelTd">集团审核备注：</td>
				<td class="inputTd">${salCheckBatch.groupCkRemark}</td>
			<tr>
				<td class="inputTd" colspan="4" style="text-align:center;">
					<input class="ti_bottom"  type="button" id="close_button"  value="关闭"/>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>
