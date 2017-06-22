<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html  >
<html>
<head>
<%@ include file="../../common/header.jsp"%>
 <script type="text/javascript">
$(function() {
	//绑定提交按钮click事件
	$("#submit").click(function() {
		if(!biz.validate("valid",$('#continuePayFormEdit')[0])){
			showWarn("数据验证失败",3000);
			return;
		}
		var options = {
			url : "<m:url value='/continuePay/updateContinuePay.do'/>",
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
		$('#continuePayFormEdit').ajaxSubmit(options);
	});

	/*编辑表单数据验证*/
	new biz.validate({
		id:"#continuePayFormEdit",
		rules:{
		}
	}); 
});

</script>
</head>
  
<body>
	<form id="continuePayFormEdit" >
    <div class="ui-table ui-widget ui-corner-all ui-border" >
		<input type="hidden" id="edit_id" name="id" type="text" value="${continuePay.id}"/>
		<table class="table">
			<tr>
				<td class="inputLabelTd">VIP学员id：</td>
				<td class="inputTd">
					<input id="edit_stuId" name="stuId" type="text" class="text" value="${continuePay.stuId}"/>
				</td>
				<td class="inputLabelTd">补款学员姓名：</td>
				<td class="inputTd">
					<input id="edit_stuName" name="stuName" type="text" class="text" value="${continuePay.stuName}"/>
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd">补款金额：</td>
				<td class="inputTd">
					<input id="edit_money" name="money" type="text" class="text" value="${continuePay.money}"/>
				</td>
				<td class="inputLabelTd">录入人：</td>
				<td class="inputTd">
					<input id="edit_notes" name="notes" type="text" class="text" value="${continuePay.operator}"/>
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd">时间：</td>
				<td class="inputTd">
					<input id="edit_time" name="time" type="text" class="text" value="${continuePay.time}"/>
				</td>
				<td class="inputLabelTd">备注：</td>
				<td class="inputTd">
					<input id="edit_notes" name="notes" type="text" class="text" value="${continuePay.notes}"/>
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
