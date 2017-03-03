<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html  >
<html>
<head>
<%@ include file="../../common/header.jsp"%>
 <script type="text/javascript">
$(function() {
	//绑定提交按钮click事件
	$("#submit").click(function() {
		if(!biz.validate("valid",$('#accountFinanceFormEdit')[0])){
			showWarn("数据验证失败",3000);
			return;
		}
		var options = {
			url : "<m:url value='/accountFinance/updateAccountFinance.do'/>",
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
		$('#accountFinanceFormEdit').ajaxSubmit(options);
	});

	/*编辑表单数据验证*/
	new biz.validate({
		id:"#accountFinanceFormEdit",
		rules:{
		}
	}); 
});

</script>
</head>
  
<body>
	<form id="accountFinanceFormEdit" >
    <div class="ui-table ui-widget ui-corner-all ui-border" >
		<input type="hidden" id="edit_id" name="id" type="text" value="${accountFinance.id}"/>
		<table class="table">
			<tr>
				<td class="inputLabelTd">科目编号：</td>
				<td class="inputTd">
					<input id="edit_accountNo" name="accountNo" type="text" class="text" value="${accountFinance.accountNo}"/>
				</td>
				<td class="inputLabelTd">科目名称：</td>
				<td class="inputTd">
					<input id="edit_accountName" name="accountName" type="text" class="text" value="${accountFinance.accountName}"/>
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd">科目类型：</td>
				<td class="inputTd">
					<input id="edit_accountType" name="accountType" type="text" class="text" value="${accountFinance.accountType}"/>
				</td>
				<td class="inputLabelTd">科目说明：</td>
				<td class="inputTd">
					<input id="edit_intro" name="intro" type="text" class="text" value="${accountFinance.intro}"/>
				</td>
			</tr>
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
