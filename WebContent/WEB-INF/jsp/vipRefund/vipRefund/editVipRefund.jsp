<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html  >
<html>
<head>
<%@ include file="../../common/header.jsp"%>
</head>
  
<body>
	<form id="vipRefundFormEdit" >
    <div class="ui-table ui-widget ui-corner-all ui-border" >
		<input type="hidden" id="edit_id" name="id" type="text" value="${vipRefund.id}"/>
		<table class="table">
			<tr>
				<td class="inputLabelTd">退款学员ID：</td>
				<td class="inputTd">
					<input id="edit_stuId" name="stuId" type="text" class="text" value="${vipRefund.stuId}"/>
				</td>
				<td class="inputLabelTd">退款学员姓名：</td>
				<td class="inputTd">
					<input id="edit_stuName" name="stuName" type="text" class="text" value="${vipRefund.stuName}"/>
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd">退款金额：</td>
				<td class="inputTd">
					<input id="edit_refund" name="refund" type="text" class="text" value="${vipRefund.refund}"/>
				</td>
				<td class="inputLabelTd">退款原因：</td>
				<td class="inputTd">
					<input id="edit_reason" name="reason" type="text" class="text" value="${vipRefund.reason}"/>
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd">退款时间：</td>
				<td class="inputTd">
					<input id="edit_time" name="time" type="text" class="text" value="${vipRefund.time}"/>
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
<script type="text/javascript">
$(function() {
	//绑定提交按钮click事件
	$("#submit").click(function() {
		if(!biz.validate("valid",$('#vipRefundFormEdit')[0])){
			showWarn("数据验证失败",3000);
			return;
		}
		var options = {
			url : "<m:url value='/vipRefund/updateVipRefund.do'/>",
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
		$('#vipRefundFormEdit').ajaxSubmit(options);
	});

	/*编辑表单数据验证*/
	new biz.validate({
		id:"#vipRefundFormEdit",
		rules:{
		}
	}); 
});
</script>
</body>
</html>
