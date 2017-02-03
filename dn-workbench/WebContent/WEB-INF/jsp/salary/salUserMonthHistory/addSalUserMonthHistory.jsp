<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html  >
<html>
<head>
<%@ include file="../../common/header.jsp"%>
<script type="text/javascript">
$(function() {
	//绑定提交按钮click事件
	$("#submit").click(function() {
		if(!biz.validate("valid",$('#salUserMonthHistoryFormEdit')[0])){
			showWarn("数据验证失败",3000);
			return;
		}
		var options = {
			url : "<m:url value='/salUserMonthHistory/addSalUserMonthHistory.do'/>",
			type : "post",
				dataType:"json",
				success : function(d) {
					if(d.status){
						showMessage(d.message,"","",function(){
							window.parent.closeAdd();
				     		window.parent.doSearch();
						});
					}else{
						showMessage(d.message);
					}
				}
		};
		// 将options传给ajaxForm
		$('#salUserMonthHistoryFormEdit').ajaxSubmit(options);
	});

	new biz.datepicker({
		id : "#ym",
		dateFmt:'yyyy-MM'
	});
	/*编辑表单数据验证*/
	new biz.validate({
		id:"#salUserMonthHistoryFormEdit",
		rules:{
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
	<form id="salUserMonthHistoryFormEdit" >
    <div class="ui-table ui-widget ui-corner-all ui-border" >
		<table class="table">
			<tr>
				<td class="inputLabelTd">年月：</td>
				<td class="inputTd">
					<input id="ym" name="ym" type="text" class="text" value="${salUserMonthHistory.ym}"/>
				</td>
			</tr>
			<tr>
				<td class="inputTd" colspan="4" style="text-align:center;">
					<input id="submit" type="button" class="ti_bottom" value="确定生成"/>
				</td>
			</tr>
		</table>
    </div>
	</form>
</div>
</body>
</html>
