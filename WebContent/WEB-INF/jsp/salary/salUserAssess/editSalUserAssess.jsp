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
		if(!biz.validate("valid",$('#salUserAssessFormEdit')[0])){
			showWarn("数据验证失败",3000);
			return;
		}
		var options = {
			url : "<m:url value='/salUserAssess/updateSalUserAssess.do'/>",
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
		$('#salUserAssessFormEdit').ajaxSubmit(options);
	});

	 new biz.datepicker({
			id : "#signYm",
			dateFmt:'yyyy-MM'
		});

	/*编辑表单数据验证*/
	new biz.validate({
		id:"#salUserAssessFormEdit",
		rules:{
			"signSum" : {
				required : true,
				maxlength : 2
			},
			"userName" : {
				required : true,
				maxlength : 11
			},
			"signYm" : {
				required : true,
				maxlength : 11
			},
		}
	}); 
});

</script>
</head>
  
<body>
	<form id="salUserAssessFormEdit" >
    <div class="ui-table ui-widget ui-corner-all ui-border" >
		<input type="hidden" id="edit_id" name="id" type="text" value="${salUserAssess.id}"/>
		<table class="table">
		
		<tr>
				<td class="inputLabelTd"><span class="required">*</span>考核分数：</td>
				<td class="inputTd">
				
				<input id="signSum" name="signSum" type="text" class="text" style="width:50px;" value="${salUserAssess.signSum}"/>
					
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd"><span class="required">*</span>用户名称：</td>
				<td class="inputTd">
					<input id="userName" name="userName" type="text" class="text" value="${salUserAssess.userName}"/>
					<input id="userId" name="userId" type="hidden" class="text" value="${salUserAssess.userId}"/>
					<a href="javascript:window.parent.selectUserWinOpen(window);" onClick="">选择用户</a>
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd"><span class="required">*</span>考核年月：</td>
				<td class="inputTd">
					<input id="signYm" name="signYm" type="text" class="text" value="${salUserAssess.signYm}"/>
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd">备注：</td>
				<td class="inputTd">
					<input id="remark" name="remark" type="text" class="text" value="${salUserAssess.remark}"/>
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
