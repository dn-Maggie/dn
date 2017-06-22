<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html  >
<html>
<head>
<%@ include file="../../common/header.jsp"%>
 <script type="text/javascript">
$(function() {
	//绑定提交按钮click事件
	$("#submit").click(function() {
		if(!biz.validate("valid",$('#accountSubjectFormEdit')[0])){
			showWarn("数据验证失败",3000);
			return;
		}
		var options = {
			url : "<m:url value='/accountSubject/updateAccountSubject.do'/>",
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
		$('#accountSubjectFormEdit').ajaxSubmit(options);
	});

	/*编辑表单数据验证*/
	new biz.validate({
		id:"#accountSubjectFormEdit",
		rules:{
		}
	}); 
});

</script>
</head>
  
<body>
	<form id="accountSubjectFormEdit" >
    <div class="ui-table ui-widget ui-corner-all ui-border" >
		<input type="hidden" id="edit_id" name="id" type="text" value="${accountSubject.id}"/>
		<table class="table">
			<tr>
				<td class="inputLabelTd">会计科目分类编号：</td>
				<td class="inputTd">
					<input id="edit_parentId" name="parentId" type="text" class="text" value="${accountSubject.parentId}"/>
				</td>
				<td class="inputLabelTd">会计科目分类名称：</td>
				<td class="inputTd">
					<input id="edit_parentName" name="parentName" type="text" class="text" value="${accountSubject.parentName}"/>
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd">会计科目编号：</td>
				<td class="inputTd">
					<input id="edit_accountId" name="accountId" type="text" class="text" value="${accountSubject.accountId}"/>
				</td>
				<td class="inputLabelTd">会计科目名称：</td>
				<td class="inputTd">
					<input id="edit_accountName" name="accountName" type="text" class="text" value="${accountSubject.accountName}"/>
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd">描述：</td>
				<td class="inputTd">
					<input id="edit_note" name="note" type="text" class="text" value="${accountSubject.note}"/>
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
