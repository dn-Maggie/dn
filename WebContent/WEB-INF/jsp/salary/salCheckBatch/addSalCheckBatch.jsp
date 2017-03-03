<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html  >
<html>
<head>
<%@ include file="../../common/header.jsp"%>
<script type="text/javascript">
$(function() {
	//绑定提交按钮click事件
	$("#submit").click(function() {
		if(!biz.validate("valid",$('#salCheckBatchFormEdit')[0])){
			showWarn("数据验证失败",3000);
			return;
		}
		var options = {
			url : "<m:url value='/salCheckBatch/addSalCheckBatch.do'/>",
			type : "post",
			success : function(data) {
				var d = $ .parseJSON(data);
				showMessage(d.msg,"","",function(){
					window.parent.closeAdd();
		     		window.parent.doSearch();
				});
			}
		};
		// 将options传给ajaxForm
		$('#salCheckBatchFormEdit').ajaxSubmit(options);
	});

	/*编辑表单数据验证*/
	new biz.validate({
		id:"#salCheckBatchFormEdit",
		rules:{
		}
	}); 
});
</script>
</head>
  
<body>

<div id="editDialog">
	<form id="salCheckBatchFormEdit" >
    <div class="ui-table ui-widget ui-corner-all ui-border" >
		<input type="hidden" id="edit_id" name="id" type="text" value="${salCheckBatch.id}"/>
		<table class="table">
			<tr>
				<td class="inputLabelTd">批次名称：</td>
				<td class="inputTd">
					<input id="edit_batchname" name="batchname" type="text" class="text" value="${salCheckBatch.batchname}"/>
				</td>
				<td class="inputLabelTd">年月：</td>
				<td class="inputTd">
					<input id="edit_ym" name="ym" type="text" class="text" value="${salCheckBatch.ym}"/>
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd">包含工资ID字符串：</td>
				<td class="inputTd">
					<input id="edit_salaryInfoIds" name="salaryInfoIds" type="text" class="text" value="${salCheckBatch.salaryInfoIds}"/>
				</td>
				<td class="inputLabelTd">批次合计金额：</td>
				<td class="inputTd">
					<input id="edit_sumMoney" name="sumMoney" type="text" class="text" value="${salCheckBatch.sumMoney}"/>
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd">所属部门ID：</td>
				<td class="inputTd">
					<input id="edit_orgId" name="orgId" type="text" class="text" value="${salCheckBatch.orgId}"/>
				</td>
				<td class="inputLabelTd">所属部门名称：</td>
				<td class="inputTd">
					<input id="edit_orgName" name="orgName" type="text" class="text" value="${salCheckBatch.orgName}"/>
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd">备注：</td>
				<td class="inputTd">
					<input id="edit_remark" name="remark" type="text" class="text" value="${salCheckBatch.remark}"/>
				</td>
				<td class="inputLabelTd">创建人ID：</td>
				<td class="inputTd">
					<input id="edit_createdby" name="createdby" type="text" class="text" value="${salCheckBatch.createdby}"/>
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd">创建人名称：</td>
				<td class="inputTd">
					<input id="edit_createdbyname" name="createdbyname" type="text" class="text" value="${salCheckBatch.createdbyname}"/>
				</td>
				<td class="inputLabelTd">创建时间：</td>
				<td class="inputTd">
					<input id="edit_created" name="created" type="text" class="text" value="${salCheckBatch.created}"/>
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd">分公司审核人ID：</td>
				<td class="inputTd">
					<input id="edit_branchCkUserId" name="branchCkUserId" type="text" class="text" value="${salCheckBatch.branchCkUserId}"/>
				</td>
				<td class="inputLabelTd">分公司审核人名字：</td>
				<td class="inputTd">
					<input id="edit_branchCkUserName" name="branchCkUserName" type="text" class="text" value="${salCheckBatch.branchCkUserName}"/>
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd">分公司审核时间：</td>
				<td class="inputTd">
					<input id="edit_branchCkTime" name="branchCkTime" type="text" class="text" value="${salCheckBatch.branchCkTime}"/>
				</td>
				<td class="inputLabelTd">分公司审核状态(0是未审核，1是已审核，2是审核未通过)：</td>
				<td class="inputTd">
					<input id="edit_branchCkStatus" name="branchCkStatus" type="text" class="text" value="${salCheckBatch.branchCkStatus}"/>
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd">分公司审核备注：</td>
				<td class="inputTd">
					<input id="edit_branchCkRemark" name="branchCkRemark" type="text" class="text" value="${salCheckBatch.branchCkRemark}"/>
				</td>
				<td class="inputLabelTd">省级审核人ID：</td>
				<td class="inputTd">
					<input id="edit_provinceCkUserId" name="provinceCkUserId" type="text" class="text" value="${salCheckBatch.provinceCkUserId}"/>
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd">省级审核人名字：</td>
				<td class="inputTd">
					<input id="edit_provinceCkUserName" name="provinceCkUserName" type="text" class="text" value="${salCheckBatch.provinceCkUserName}"/>
				</td>
				<td class="inputLabelTd">省级审核时间：</td>
				<td class="inputTd">
					<input id="edit_provinceCkTime" name="provinceCkTime" type="text" class="text" value="${salCheckBatch.provinceCkTime}"/>
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd">省级审核状态(0是未审核，1是已审核，2是审核未通过)：</td>
				<td class="inputTd">
					<input id="edit_provinceCkStatus" name="provinceCkStatus" type="text" class="text" value="${salCheckBatch.provinceCkStatus}"/>
				</td>
				<td class="inputLabelTd">省级审核备注：</td>
				<td class="inputTd">
					<input id="edit_provinceCkRemark" name="provinceCkRemark" type="text" class="text" value="${salCheckBatch.provinceCkRemark}"/>
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd">集团审核人ID：</td>
				<td class="inputTd">
					<input id="edit_groupCkUserId" name="groupCkUserId" type="text" class="text" value="${salCheckBatch.groupCkUserId}"/>
				</td>
				<td class="inputLabelTd">集团审核人名字：</td>
				<td class="inputTd">
					<input id="edit_groupCkUserName" name="groupCkUserName" type="text" class="text" value="${salCheckBatch.groupCkUserName}"/>
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd">集团审核时间：</td>
				<td class="inputTd">
					<input id="edit_groupCkTime" name="groupCkTime" type="text" class="text" value="${salCheckBatch.groupCkTime}"/>
				</td>
				<td class="inputLabelTd">集团审核状态(0是未审核，1是已审核，2是审核未通过)：</td>
				<td class="inputTd">
					<input id="edit_groupCkStatus" name="groupCkStatus" type="text" class="text" value="${salCheckBatch.groupCkStatus}"/>
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd">集团审核备注：</td>
				<td class="inputTd">
					<input id="edit_groupCkRemark" name="groupCkRemark" type="text" class="text" value="${salCheckBatch.groupCkRemark}"/>
				</td>
			<tr>
				<td class="inputTd" colspan="4" style="text-align:center;">
					<input id="submit" type="button" class="ti_bottom" value="保存"/>
				</td>
			</tr>
		</table>
    </div>
	</form>
</div>
</body>
</html>
