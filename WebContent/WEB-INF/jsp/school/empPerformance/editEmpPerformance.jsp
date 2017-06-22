<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../../common/header.jsp"%>
 <script type="text/javascript">
$(function() {
	subChange($('#edit_comSource').val());
	//绑定提交按钮click事件
	$("#submit").click(function() {
		if(!biz.validate("valid",$('#empPerformanceFormEdit')[0])){
			showWarn("数据验证失败",3000);
			return;
		}
		var isPass=$("isPass").val();
		if(isPass=="已清算"){
			showWarn("已执行财务入账，不能进行修改");
			return;
		}
		else{
			var id=$("#edit_id").val();
			var performance=$.trim($("#edit_performance").val());
			var employeeName=$.trim($("#edit_employeeName").val());
			var employeeId=$.trim($("#edit_employeeId").val());
			var position=$.trim($("#edit_position").val());
			var note=$.trim($("#edit_note").val());
			var stuId=$("#edit_stuId").val();
			var comSource =$.trim($("#edit_comSource").find("option:selected").text());
			var sourceSubclass = $.trim($("#edit_sourceSubclass").find("option:selected").text());
			var createDate=$("#edit_createDate").val();
			var actualPay = $("#edit_perMoney").val();
			var paramDatas = {
					id:id,
					performance:performance,
					employeeName:employeeName,
					employeeId:employeeId,
					position:position,
					isPass:isPass,
					note:note,
					stuId:stuId,
					createDate:createDate,
					isPass:"未清算",
					actualPay:actualPay,
					comSource:comSource,
					sourceSubclass:sourceSubclass
					};
			$.ajax({
				   type: "post",
				   url: "<m:url value='/empPerformance/updateEmpPerformance.do'/>",
				   data: paramDatas,
				   cache: false,
				   dataType:"json",
				   success:function(d) {
						if(d.status){
						showMessage(d.message,"","",function(){
							window.parent.closeEdit();
				     		window.parent.doSearch();
						});
					}else{
						showMessage(d.message);
						}
					}
				});
		}
	});

	/*编辑表单数据验证*/
	new biz.validate({
		id:"#empPerformanceFormEdit",
		rules:{
			"employeeName" :{required : true},
			"position" :{required : true},
			"performance" :{required : true},
			"note" :{required : true},
		}
	}); 
	new biz.datepicker({
		id : "#edit_createDate",
		dateFmt:'yyyy-MM-dd HH:mm:ss'
	});
});
/*自动搜寻转化人 自动完成(Autocomplete) 根据用户输入值进行搜索和过滤,让用户快速找到并从预设值列表中选择*/
function getEmpIDByName(obj,value) {
	var did = $("#employeeList").find("option[value="+value+"]").attr('did');
	$(obj).parents().find("#edit_employeeId").val(did);
}
//流量分类显示控制
function subChange(val){
	switch (val) {
	case "1":
	case "5":
		$('#edit_sourceSubclass option').remove();
		$('#edit_sourceSubclass').append('<option value="1">未体验公开课报名</option><option value="2">体验公开课后报名</option>');
		break;
	default:
		$('#edit_sourceSubclass option').remove();
		$('#edit_sourceSubclass').append('<option value="0">无</option>');
		break;
	}
}
//根据来源分类改变参与岗位
function changeFollower(){
	var par =$("#edit_comSource").find("option:selected").val();
	var sub =$("#edit_sourceSubclass").find("option:selected").val();
	$ .ajax({
		url: "<m:url value='/empPerformance/getPositionList.do'/>?parentId="+par+"&subId="+sub,
		cache:false,
		dataType:"json",
		success: function(data, textStatus, jqXHR){
			$('#edit_followerType option').remove();
			for(var i in data.followers){
				if(data.followers[i].id){
					$('#edit_followerType').append('<option value="'+data.followers[i].positionId+'">'+data.followers[i].position+' </option>');
					rate = data.followers[i].rate;
				}
			}
			if(!data.followers[0]){
				$('#edit_followerType').append('<option value="">--请选择--</option>');
			}
			getRate($('#edit_followerType'));
		}
	});
}

</script>
</head>
  
<body>
	<form id="empPerformanceFormEdit" >
    <div class="ui-table ui-widget ui-corner-all ui-border" >
		<input type="hidden" id="edit_id" name="id" type="text" value="${empPerformance.id}"/>
		<input type="hidden" id="edit_stuId" name="stuId" type="text" value="${empPerformance.stuId}"/>
		<table class="table">
			<tr>
				<td class="inputLabelTd">转化人姓名：</td>
				<td class="inputTd">
					<input id="edit_employeeId" name="employeeId" type="hidden" class="text" value="${empPerformance.employeeId}"/>
					<input id="edit_employeeName" name="employeeName" type="text" class="text" list="employeeList" value="${empPerformance.employeeName}" onchange="getEmpIDByName(this,this.value);"/>				
					<datalist id="employeeList">
						<c:forEach var="tutor" items="${tutor}">
							<option did="${tutor.id}" value="${tutor.name}" label="${tutor.nickName}"></option>
			             </c:forEach>
					</datalist>
				</td>
				<td class="inputLabelTd">参与岗位：</td>
				<td class="inputTd">
					<input id="edit_position" name="position" type="text" class="text" value="${empPerformance.position}" list="positionList" />
					<datalist id="positionList">
						<c:forEach var="followers" items="${followers}">
							<option did="${followers.positionId}" value="${followers.position}"></option>
			             </c:forEach>
					</datalist>
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd">应付学费：</td>
				<td class="inputTd">
					<input id="edit_shouldPay" name="shouldPay" type="text" class="text" value="${vipStudent.shouldPay}" readonly/>
				</td>
				<td class="inputLabelTd">实付学费：</td>
				<td class="inputTd">
					<input id="edit_actualPay" name="actualPay" type="text" class="text" value="${vipStudent.actualPay}" readonly/>
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd"><span class="required">*</span>流量来源：</td>
				<td class="inputTd">
					<select onchange="subChange(this.value);changeFollower()" class="input_select" name="comSource" id="edit_comSource" ><option value="">--请选择--</option>
						<c:forEach var="standard" items="${standard}">
							<option value="${standard.parentName}" <c:if test="${empPerformance.comSource == standard.parentName}">selected</c:if>> <c:out value="${standard.parentName}"></c:out> </option>
			             </c:forEach>
					</select>
				</td>
			 	<td class="inputLabelTd">来源分类：</td>
				<td class="inputTd">
					<select class="input_select" name="sourceSubclass" id="edit_sourceSubclass"  onchange="changeFollower()">
			        </select>
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd">分配金额：</td>
				<td class="inputTd">
					<input id="edit_perMoney" name="perMoney" type="text" class="text" value="${empPerformance.actualPay}"/>
				</td>
				<td class="inputLabelTd">分配时间：</td>
				<td class="inputTd">
					<div class="time_bg">
						<input type="text" class="search_time150 valid" name="createDate" id="edit_createDate" value="<fmt:formatDate value='${empPerformance.createDate}' pattern="yyyy-MM-dd HH:mm:ss"/>"><!-- 时间选择控件-->
						<i class="search_time_ico2"></i>
					</div>
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd">贡献绩效：</td>
				<td class="inputTd">
					<input id="edit_performance" name="performance" type="text" class="text" value="${empPerformance.performance}"/>
				</td>
				<td class="inputLabelTd">备注：</td>
				<td class="inputTd">
					<input id="edit_note" name="note" type="text" class="text" value="${empPerformance.note}"/>
					<input type="hidden" id="isPass" value="${empPerformance.isPass}"/>
				</td>
			<tr>
				<td class="inputTd" colspan="4" style="text-align:center;">
					<input id="submit" type="button" class="ti_bottom" value="修改"/>
					<input id="cancel" type="button" class="ti_bottom" value="取消" onclick="window.parent.closeEdit();"/>
				</td>
			</tr>
		</table>
        </div>
	</form>
</body>
</html>
