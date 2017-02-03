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
				<td class="inputLabelTd">凭证类别 字：</td>
				<td class="inputTd">${accounting.documentType}</td>
				<td class="inputLabelTd">凭证类别排序号：</td>
				<td class="inputTd">${accounting.documentNo}</td>
			</tr>
			<tr>
				<td class="inputLabelTd">会计期间：</td>
				<td class="inputTd">${accounting.accountPeriod}</td>
				<td class="inputLabelTd">制单日期：</td>
				<td class="inputTd">${accounting.billDate}</td>
			</tr>
			<tr>
				<td class="inputLabelTd">制单人编号：</td>
				<td class="inputTd">${accounting.enterPno}</td>
				<td class="inputLabelTd">审核人编号：</td>
				<td class="inputTd">${accounting.checkPno}</td>
			</tr>
			<tr>
				<td class="inputLabelTd">记账人编号：</td>
				<td class="inputTd">${accounting.bookPno}</td>
				<td class="inputLabelTd">附单据数量：</td>
				<td class="inputTd">${accounting.docAttach}</td>
			</tr>
			<tr>
				<td class="inputLabelTd">凭证有效标志 ：</td>
				<td class="inputTd">${accounting.validFlag}</td>
				<td class="inputLabelTd">记账标志：</td>
				<td class="inputTd">${accounting.bookFlag}</td>
			</tr>
			<tr>
				<td class="inputLabelTd">摘要：</td>
				<td class="inputTd">${accounting.digest}</td>
				<td class="inputLabelTd">币种：</td>
				<td class="inputTd">${accounting.exchName}</td>
			</tr>
			<tr>
				<td class="inputLabelTd">借方科目id：</td>
				<td class="inputTd">${accounting.mdId}</td>
				<td class="inputLabelTd">借方科目编码：</td>
				<td class="inputTd">${accounting.mdNo}</td>
			</tr>
			<tr>
				<td class="inputLabelTd">借方科目名称：</td>
				<td class="inputTd">${accounting.mdName}</td>
				<td class="inputLabelTd">借方金额：</td>
				<td class="inputTd">${accounting.mdMoney}</td>
			</tr>
			<tr>
				<td class="inputLabelTd">借方数量：</td>
				<td class="inputTd">${accounting.mdNum}</td>
				<td class="inputLabelTd">贷方科目id：</td>
				<td class="inputTd">${accounting.mcId}</td>
			</tr>
			<tr>
				<td class="inputLabelTd">贷方科目编号：</td>
				<td class="inputTd">${accounting.mcNo}</td>
				<td class="inputLabelTd">贷方科目名称：</td>
				<td class="inputTd">${accounting.mcName}</td>
			</tr>
			<tr>
				<td class="inputLabelTd">贷方金额：</td>
				<td class="inputTd">${accounting.mcMoney}</td>
				<td class="inputLabelTd">贷方数量 若无数量,写0：</td>
				<td class="inputTd">${accounting.mcNum}</td>
			</tr>
			<tr>
				<td class="inputLabelTd">结算方式：</td>
				<td class="inputTd">${accounting.settleType}</td>
				<td class="inputLabelTd">支(汇)票号：</td>
				<td class="inputTd">${accounting.chequeNo}</td>
			</tr>
			<tr>
				<td class="inputLabelTd">票号发生日期：</td>
				<td class="inputTd">${accounting.chequeDate}</td>
				<td class="inputLabelTd">发生时间：</td>
				<td class="inputTd">${accounting.createDate}</td>
			</tr>
			<tr>
				<td class="inputLabelTd">发生额：</td>
				<td class="inputTd">${accounting.money}</td>
				<td class="inputLabelTd">部门编码：</td>
				<td class="inputTd">${accounting.deptNo}</td>
			</tr>
			<tr>
				<td class="inputLabelTd">职员编码：</td>
				<td class="inputTd">${accounting.empNo}</td>
				<td class="inputLabelTd">客户编码：</td>
				<td class="inputTd">${accounting.custoNo}</td>
			</tr>
			<tr>
				<td class="inputLabelTd">供应商编码：</td>
				<td class="inputTd">${accounting.applyNo}</td>
				<td class="inputLabelTd">业务员编码：</td>
				<td class="inputTd">${accounting.salesmanNo}</td>
			</tr>
			<tr>
				<td class="inputLabelTd">备注：</td>
				<td class="inputTd">${accounting.note}</td>
			<tr>
				<td class="inputTd" colspan="4" style="text-align:center;">
					<input class="ti_bottom"  type="button" id="close_button"  value="关闭"/>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>
