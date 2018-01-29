<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html  >
<html>
<head>
<%@ include file="../../common/header.jsp"%>
</head>
  
<body>

<div id="editDialog">
	<form id="marketStudentFormEdit" >
    <div class="ui-table ui-widget ui-corner-all ui-border" >
		<table class="table">
			<tr>
				<td class="inputLabelTd"><span class="required">*</span>QQ号码：</td>
				<td class="inputTd">
					<input id="edit_qq" name="qq" type="text" class="text"/>
				</td>
				<td class="inputLabelTd"><span class="required">*</span>电话：</td>
				<td class="inputTd">
					<input id="edit_tel" name="tel" type="text" class="text"/>
				</td>
			</tr>
			<tr>
			<td class="inputLabelTd">意向学科：</td>
				<td class="inputTd">
					<select onchange="xuekeChange(this.value);" style="float:left" class="input_select" name="subjectid">
						<c:forEach var="mr" items="${er.subject}">
							<option value="${mr.id}"> <c:out value="${mr.name}"></c:out> </option>
			             </c:forEach>
			        </select>
				</td>
				<td class="inputLabelTd">意向课程：</td>
				<td class="inputTd" >
					<select style="float:left" class="input_select" name="courseid" id="edit_courseId">
					<c:forEach var="mr" items="${er.course}">
							<option value="${mr.id}" > <c:out value="${mr.name}"></c:out> </option>
			             </c:forEach>
					</select>
				</td>
			</tr>
			<tr>	
				<td class="inputLabelTd">是否报名：</td>
				<td class="inputTd">
					<select style="float:left" class="input_select" name="is_buy" id="edit_is_buy" mainid="actType">
						<option value="否">否</option>
						<option value="是">是</option>
					</select>
				</td>
			</tr>
			<tr>	
				<td class="inputTd" colspan='4' style="padding-left:-2px;">
					<textarea id="edit_notes" name="notes" rows="11" 
					style="width:99%;padding-top:5px;margin-top:4px;">备注:</textarea>
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
<script type="text/javascript">
var createDate = new Date().format('yyyy-MM-dd hh:mm:ss'); //获取今日时间
$(function() {
	//绑定提交按钮click事件
	$("#submit").click(function() {
		$("#submit").prop('disabled', true).css({'cursor':'not-allowed'});
		if(!biz.validate("valid",$('#marketStudentFormEdit')[0])){
			showWarn("数据验证失败",3000);
			$("#submit").prop('disabled', false).css({'cursor':'pointer'});
			return;
		}
		
		var options = {
				url : "<m:url value='/marketStudent/AddKouBeiStudent.do'/>",
				type : "post",
				dataType:"json",
				success : function(d) {
					if(d.status){
						showMessage(d.message,"","",function(){
							window.parent.closeAdd();
				     		window.parent.doSearch();
						});
					}else{
						showMessage("此条意向信息已存在!");
						$("#submit").prop('disabled', false).css({'cursor':'pointer'});
					}
				}
			};
		$('#marketStudentFormEdit').ajaxSubmit(options);
	});
	
	/*编辑表单数据验证*/
	new biz.validate({
		id:"#marketStudentFormEdit",
		rules:{
			"qq" : {required : true,number:true,rangelength:[6,10],digits:true },
		}
	}); 
 
});
function xuekeChange(val){
	$ .ajax({
		url: "<m:url value='/marketStudent/getCourseList.do'/>?key="+val,
		cache:false,
		dataType:"json",
		success: function(data, textStatus, jqXHR){
			$('#edit_courseId option').remove();
			for(var i in data.course){
				if(data.course[i].id){
					$('#edit_courseId').append('<option value="'+data.course[i].id+'">'+data.course[i].name+' </option>');
				}
			}
			if(!data.course[0]){
				$('#edit_courseId').append('<option value="">--请选择--</option>');
			}
		}
	});
}
</script>

</body>
</html>
