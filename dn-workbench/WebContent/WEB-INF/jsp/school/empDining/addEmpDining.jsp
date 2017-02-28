<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../../common/header.jsp"%>
<script type="text/javascript">
$(function() {
	//绑定提交按钮click事件
	$("#submit").click(function() {
		$("#submit").prop('disabled', true).css({'cursor':'not-allowed'});
		if(!biz.validate("valid",$('#empDiningFormEdit')[0])){
			showWarn("数据验证失败",3000);
			$("#submit").prop('disabled', false).css({'cursor':'pointer'});
			return;
		}
		var paramArray = [];
		//一个日期
		if(!isLotOrderTime()){
			for (var i = 0;i<getOrderType().length;i++) {
				var paramObj = {};
	            paramObj.empId = $("#edit_empId").val();
	            paramObj.orderType = getOrderType()[i];
	            paramObj.diningTime = $("#start_diningTime").val();
	            paramArray.push(paramObj);
             }
		}else{//多个日期
			var startDate = new Date($("#start_diningTime").val());
			var endDate = new Date($("input[name='end_diningTime']").val());
			var diff=dateDiff(startDate,endDate)+1;
			for (var i = 0;i<getOrderType().length;i++) {
	            for(var j = 0,dateTemp = new Date();j<diff;j++){
	            	var paramObj = {};
		            paramObj.empId = $("#edit_empId").val();
		            paramObj.orderType = getOrderType()[i];
		            dateTemp.setDate(startDate.getDate()+j);
		            paramObj.diningTime= new Date(dateTemp).toLocaleString().split(" ")[0].replace(/\//g,"-");
		            paramArray.push(paramObj);
	            }
             }
		}
		 $.ajax({
			 url : "<m:url value='/empDining/addEmpDining.do'/>",
             type: 'post',
             dataType:"json",
             data: JSON.stringify(paramArray),
             processData: false,// 告诉jQuery不要去处理发送的数据
             contentType: false, // 告诉jQuery不要去设置Content-Type请求头
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
         });
	});

	/*编辑表单数据验证*/
	new biz.validate({
		id:"#empDiningFormEdit",
		rules:{
			"empNickName":{required : true},
			"empId":{required : true},
			"orderType":{required : true},
			"diningTime":{required : true},
			"end_diningTime":{required : true}
		}
	}); 
	new biz.datepicker({
		id : "#start_diningTime",
		minDate:'%y-%M-{%d}',
		maxDate:'%y-%M-%ld',
		dateFmt:'yyyy-MM-dd',
		disabledDays:[6]
	});
	new biz.datepicker({
		id : "#end_diningTime",
		minDate:'#F{$dp.$D(\'start_diningTime\',{d:0});}',
		maxDate:'%y-%M-%ld',
		dateFmt:'yyyy-MM-dd',
		disabledDays:[6]
	});
	new biz.datepicker({
		id : "#end_diningTime2",
		dateFmt:'yyyy-MM-dd',
		disabledDays:[6]
	});
});
//判断两个日期差值
function dateDiff(startDate,endDate){
	return Math.abs((startDate.getTime() - endDate.getTime()))/(1000*60*60*24);     
}
//判断是否有多个日期
function isLotOrderTime(){
	if($("#start_diningTime").val()===$("input[name='end_diningTime']").val()){
		return false;
	}else{
		return true;
	}
}
//获取订餐类别
function getOrderType(){
	var orderTypeObj = $("input:checkbox[name='orderType']");
	var check_val = new Array();
	for(key in orderTypeObj){
		if(orderTypeObj[key].checked)check_val.push(orderTypeObj[key].value);
	}
	return check_val;
}

//打开员工资源管理界面
function employeeMgt() {
	var url = baseUrl + '/userInfo/toSelectEmployee.do';
	employeelist_iframe_dialog = new biz.dialog(
			{
				id : $('<div id="sublist_window_iframe"></div>')
						.html(
								'<iframe id="iframeSublist" name="iframeSublist" src="'
										+ url
										+ '" width="100%" frameborder="no" border="0" height="97%"></iframe>'),
				modal : true,
				width : $(window).width()*0.8,
				height : $(window).height()*0.8,
				title : "员工信息列表"
			});
	employeelist_iframe_dialog.open();
}
//关闭员工资源管理界面
function closeEmployee() {
	employeelist_iframe_dialog.close();
}
//填充数据
function drawForm(rowData) {
	$("#edit_empId").val(rowData.id);
	$("#edit_empNickName").val(rowData.name);
}
</script>
</head>
  
<body>
		<div style="text-align: center;margin-top: 20px">
    		<h1 style="font-size: 18px;color: red;font-weight: bold;">注意</h1>
    		<p style="font-size: 16px;line-height: 2em;text-align: center;">
    		若执行操作以后需要删除当日退订信息，请直接联系行政部门。<br>
    		若要删除其他日退订数据，请根据对应日期自行删除数据。<br>
    		已生效的退订数据不能进行删除。<br>
    		请不要一次性添加过多退餐数据，以一个月为限额。<br>
    		长期不订餐的同事请在当月添加当月退餐数据。<br>
    		</p>
    	</div>
<div id="editDialog">
	<form id="empDiningFormEdit" >
    <div class="ui-table ui-widget ui-corner-all ui-border" >
		<input type="hidden" id="edit_id" name="id" type="text"/>
		<table class="table">
			<tr>
				<td class="inputLabelTd" ><span class="required">*</span>员工姓名：</td>
				<td class="inputTd">
				<c:choose>
					<c:when test="${isHR||isAdmin}">
						<input id="edit_empNickName" name="empNickName" type="text" class="text" onclick="employeeMgt()"/>
						<input id="edit_empId" name="empId" type="hidden"/>
					</c:when>
					<c:otherwise>
						<input id="edit_empNickName" name="empNickName" type="text" class="text" value="${user.fullName}" readonly/>
						<input id="edit_empId" name="empId" type="hidden" value="${user.id}"/>
					</c:otherwise>
				</c:choose>
				</td>
				<td class="inputLabelTd" ><span class="required">*</span>退订餐别：</td>
				<td class="inputTd">
					<label class="checkbox" for="orderLunch">午餐</label><input type="checkbox" name="orderType" id="orderLunch" value="1" >
					<label class="checkbox" for="orderSupper">晚餐</label><input type="checkbox" name="orderType" id="orderSupper" value="2" >
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd"><span class="required">*</span>起始日期：</td>
				<td class="inputTd">
					<div class="time_bg">
						<input type="text" class="search_time150 valid" name="diningTime" id="start_diningTime"><!-- 时间选择控件-->
						<i class="search_time_ico2"></i>
					</div>
				</td>
				<td class="inputLabelTd"><span class="required">*</span>截止日期：</td>
				<td class="inputTd">
					<div class="time_bg">
						<c:choose>
							<c:when test="${isHR||isAdmin}">
								<input type="text" class="search_time150 valid" name="end_diningTime" id="end_diningTime2" ><!-- 时间选择控件-->
							</c:when>
							<c:otherwise>
								<input type="text" class="search_time150 valid" name="end_diningTime" id="end_diningTime" ><!-- 时间选择控件-->
							</c:otherwise>
						</c:choose>
						<i class="search_time_ico2"></i>
					</div>
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
