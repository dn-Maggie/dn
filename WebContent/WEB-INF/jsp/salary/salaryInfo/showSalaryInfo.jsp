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
				<td class="inputLabelTd">人员姓名：</td>
				<td class="inputTd">${salaryInfo.userName}</td>
				<td class="inputLabelTd">所在部门：</td>
				<td class="inputTd">${salaryInfo.orgName}</td>
				<td class="inputLabelTd">薪酬标准：</td>
				<td class="inputTd">${salaryInfo.standName}</td>
			</tr>
			<tr>
				<td class="inputLabelTd">工资年月：</td>
				<td class="inputTd">${salaryInfo.ym}</td>
				<td class="inputLabelTd">核定工资：</td>
				<td class="inputTd currency_red_16"><fmt:formatNumber
						value="${salaryInfo.approvedSalary}" type="currency" /></td>
				<td class="inputLabelTd">应付工资：</td>
				<td class="inputTd">${salaryInfo.duesSalary}</td>
			</tr>
			<tr>
			<td class="inputLabelTd">工资类型:</td>
				<td class="inputTd">${salaryInfo.salaryTypeName}</td>
				<td class="inputLabelTd">扣款：</td>
				<td class="inputTd">${salaryInfo.deduct}</td>
				<td class="inputLabelTd">实发工资：</td>
				<td class="inputTd currency_red_16"><fmt:formatNumber
						value="${salaryInfo.factSalary}" type="currency" /></td>
			</tr>
			<tr>
				<td class="inputLabelTd">备注：</td>
				<td class="inputTd" colspan="5"
					style="padding-top: 5px; padding-bottom: 5px;">
					<div class="text" style="width: 580px; height: 45px;">${salaryInfo.remark}</div>
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd">基本工资：</td>
				<td class="inputTd">${salaryInfo.basicSalary}</td>
				<td class="inputLabelTd">岗位工资：</td>
				<td class="inputTd">${salaryInfo.dutySalary}</td>
				<td class="inputLabelTd">加班工资：</td>
				<td class="inputTd">${salaryInfo.overtimeSalary}</td>
			</tr>
			<tr>

				<td class="inputLabelTd">社保工资：</td>
				<td class="inputTd">${salaryInfo.socialSecuritySalary}</td>
				<td class="inputLabelTd">绩效工资：</td>
				<td class="inputTd">${salaryInfo.performanceSalary}</td>
				<td class="inputLabelTd">社保福利：</td>
				<td class="inputTd">${salaryInfo.welfare}</td>
			</tr>

			<tr>

				<td class="inputLabelTd">工龄工资：</td>
				<td class="inputTd">${salaryInfo.ageSalary}</td>
				<td class="inputLabelTd">文凭工资：</td>
				<td class="inputTd">${salaryInfo.diplomaSalary}</td>
				<td class="inputLabelTd">考勤扣款：</td>
				<td class="inputTd">${salaryInfo.timecardDeduct}</td>
			</tr>

			<tr>
				<td class="inputLabelTd">个人社保：</td>
				<td class="inputTd">${salaryInfo.oneSocialSecurity}</td>
				<td class="inputLabelTd">生活住宿：</td>
				<td class="inputTd">${salaryInfo.livesAccommodation}</td>
				<td class="inputLabelTd">奖励：</td>
				<td class="inputTd">${salaryInfo.reward}</td>
			</tr>
			<tr>

				<td class="inputLabelTd">处罚：</td>
				<td class="inputTd">${salaryInfo.punish}</td>
				<td class="inputLabelTd">其它：</td>
				<td class="inputTd">${salaryInfo.other}</td>
				<td class="inputLabelTd"></td>
				<td class="inputTd"></td>
			</tr>

			<tr>
				<td class="inputTd" colspan="6" style="text-align: center;"><input
					class="ti_bottom" type="button" id="close_button" value="关闭" /></td>
			</tr>
		</table>
	</div>
</body>
</html>
