<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html  >
<html>
<head>
<%@ include file="../../common/header.jsp"%>
<script type="text/javascript">
function fillSelectUser(data){
	$("#userName").val(data[0].fullName);
	$("#userId").val(data[0].userId);
}
$(function() {
	//绑定提交按钮click事件
	$("#submit").click(function() {
		if(!biz.validate("valid",$('#salUserSanctionFormEdit')[0])){
			showWarn("数据验证失败",3000);
			return;
		}
		var options = {
			url : "<m:url value='/salUserSanction/updateSalUserSanction.do'/>",
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
		$('#salUserSanctionFormEdit').ajaxSubmit(options);
	});

	  new biz.datepicker({
			id : "#ym",
			dateFmt:'yyyy-MM'
		});
	/*编辑表单数据验证*/
	new biz.validate({
		id:"#salUserSanctionFormEdit",
		rules:{
			"money" : {
				required : true,
				maxlength : 6
			},
			"userName" : {
				required : true
			},
			"ym" : {
				required : true
			}
		}
	}); 
});
</script>
</head>
  
<body>

<div id="editDialog">
	<form id="salUserSanctionFormEdit" >
    <div class="ui-table ui-widget ui-corner-all ui-border" >
		<input type="hidden" id="edit_id" name="id" type="text" value="${salUserSanction.id}"/>
		<table class="table">
			<tr>
				<td class="inputLabelTd"><span class="required">*</span>用户名称：</td>
				<td class="inputTd">
					<input id="userName" name="userName" type="text" class="text" value="${salUserSanction.userName}"/>
					<input id="userId" name="userId" type="hidden" class="text" value="${salUserSanction.userId}"/>
					<a href="javascript:window.parent.selectUserWinOpen(window);" onClick="">选择用户</a>
				</td>
			
			</tr>
			<tr>
				<td class="inputLabelTd"><span class="required">*</span>金额：</td>
				<td class="inputTd">
					<input id="money" name="money" type="text" class="text" value="${salUserSanction.money}"/>
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd"><span class="required">*</span>执行年月：</td>
				<td class="inputTd">
					<input id="ym" name="ym" type="text" class="text" value="${salUserSanction.ym}"/>
				</td>
			
			</tr>
			<tr>
				<td class="inputLabelTd">备注：</td>
				<td class="inputTd">
					<input id="remark" name="remark" type="text" class="text" value="${salUserSanction.remark}"/>
				</td>
			</tr>
			
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
