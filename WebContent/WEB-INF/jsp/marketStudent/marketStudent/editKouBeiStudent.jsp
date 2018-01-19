<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html  >
<html>
<head>
<%@ include file="../../common/header.jsp"%>
</head>
  
<body>
	<form id="marketStudentFormEdit" >
    <div class="ui-table ui-widget ui-corner-all ui-border" >
		<input type="hidden" id="edit_id" name="id" type="text" value="${kouBeiStudent.id}"/>
		<input id="entry_time" name="entry_time" type="hidden" value="${kouBeiStudent.entry_time}"/>
		<table class="table">
			<tr>
				<td class="inputLabelTd">QQ号码：</td>
				<td class="inputTd">
					<input id="edit_qq" name="qq" type="text" class="text" value="${kouBeiStudent.qq}"/>
				</td>
				<td class="inputLabelTd">电话：</td>
				<td class="inputTd">
					<input id="edit_qq" name="tel" type="text" class="text" value="${kouBeiStudent.tel}"/>
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd">意向学科：</td>
				<td class="inputTd">
					<select onchange="xuekeChange(this.value);"  style="float:left" class="input_select" name="subjectid" id="edit_subjectid" mainid="actType">
						<option value="">--请选择--</option>
						<c:forEach var="mr" items="${er.xueke}">
							<option value="${mr.id}" <c:if test="${kouBeiStudent.subjectid==mr.id}">selected</c:if> > <c:out value="${mr.name}"></c:out> </option>
			             </c:forEach>
			       	</select>
				</td>
				<td class="inputLabelTd">意向课程：</td>
				<td class="inputTd" >
					<select style="float:left" class="input_select" name="courseid" id="edit_courseId">
					<c:forEach var="mr" items="${er.kechen}">
							<option value="${mr.id}" <c:if test="${kouBeiStudent.courseid==mr.id}">selected</c:if>> <c:out value="${mr.name}"></c:out> </option>
			             </c:forEach>
					</select>
				</td>
			</tr>
			<tr>	
				<td class="inputLabelTd">是否报名：</td>
				<td class="inputTd">
					<select style="float:left" class="input_select" name="is_buy" id="edit_is_buy" mainid="actType">
						<option value="否" <c:if test="${kouBeiStudent.is_buy=='否'}">selected</c:if>>否</option>
						<option value="是" <c:if test="${kouBeiStudent.is_buy=='是'}">selected</c:if>>是</option>
					</select>
				</td>
			</tr>
			<tr>	
				<td class="inputTd" colspan='4' style="padding-left:-2px;">
					<textarea id="edit_notes" name="notes" rows="11" 
					style="width:99%;padding-top:5px;margin-top:4px;" >${kouBeiStudent.notes}</textarea>
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
		if(!biz.validate("valid",$('#marketStudentFormEdit')[0])){
			showWarn("数据验证失败",3000);
			return;
		}
		var options = {
			url : "<m:url value='/marketStudent/updateKouBeiStudent.do'/>",
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
		$('#marketStudentFormEdit').ajaxSubmit(options);
	});

	/*编辑表单数据验证*/
	new biz.validate({
		id:"#marketStudentFormEdit",
		rules:{
			"qq" : {
				required : true
			}
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
