<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html  >
<html>
<head>
<%@ include file="../../common/header.jsp"%>
 <script type="text/javascript">
$(function() {
	//绑定提交按钮click事件
	$("#submit").click(function() {
		if(!biz.validate("valid",$('#accountFlowFormEdit')[0])){
			showWarn("数据验证失败",3000);
			return;
		}
		var options = {
			url : "<m:url value='/accountFlow/updateAccountFlow.do'/>",
			type : "post",
				dataType:"json",
				success : function(d) {
					if(d.status){
						showMessage(d.message,"","",function(){
							window.parent.closeEdit();
				     		window.parent.doSearch();
						});
					}else{
						showMessage(d.message);
					}
				}
		};
		// 将options传给ajaxForm
		$('#accountFlowFormEdit').ajaxSubmit(options);
	});

	/*编辑表单数据验证*/
	new biz.validate({
		id:"#accountFlowFormEdit",
		rules:{
		}
	}); 
});

</script>
</head>
  
<body>
	<form id="accountFlowFormEdit" >
    <div class="ui-table ui-widget ui-corner-all ui-border" >
		<input type="hidden" id="edit_id" name="id" type="text" value="${accountFlow.id}"/>
		<table class="table">
			<tr>
				<td class="inputLabelTd">科目编号：</td>
				<td class="inputTd" colspan="3">
					<input id="edit_accountId" name="accountId" type="text" class="text" value="${accountFlow.accountId}"/>
					<input id="edit_accountNo" name="accountNo" type="text" class="text" value="${accountFlow.accountNo}"/>
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd">科目类型：</td>
				<td class="inputTd">
					<input id="edit_accountType" name="accountType" type="text" class="text" value="${accountFlow.accountType}"/>
				</td>
				<td class="inputLabelTd">科目名称：</td>
				<td class="inputTd">
					<input id="edit_accountName" name="accountName" type="text" class="text" value="${accountFlow.accountName}"/>
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd">发生时间：</td>
				<td class="inputTd">
					<input id="edit_createDate" name="createDate" type="text" class="text" value="${accountFlow.createDate}"/>
				</td>
				<td class="inputLabelTd">发生金额：</td>
				<td class="inputTd">
					<input id="edit_money" name="money" type="text" class="text" value="${accountFlow.money}"/>
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd">备注：</td>
				<td class="inputTd">
					<input id="edit_note" name="note" type="text" class="text" value="${accountFlow.note}"/>
				</td>
			<tr>
				<td class="inputTd" colspan="4" style="text-align:center;">
					<input id="submit" type="button" class="ti_bottom" value="<m:message code='button.save' />"/>
				</td>
			</tr>
		</table>
        </div>
	</form>
</body>
</html>
