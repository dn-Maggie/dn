<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html  >
<html>
<head>
<%@ include file="../../common/header.jsp"%>
</head>

<body>

	<div id="editDialog">
		<form id="salStandardFormEdit">
			<div class="ui-table ui-widget ui-corner-all ui-border">
				<input type="hidden" id="edit_id" name="id" type="text"
					value="${salStandard.id}" />
				<table class="table">
					<tr>

						<td class="inputLabelTd"><span class="required">*</span>岗位名称：</td>
						<td class="inputTd"><select id="dutyId" name="dutyId"
							class="select" onChange="changeStandardName()">
					          <option value=""></option>
								<c:forEach var="duty" items="${dutyList}">
									<option value="${duty.id }" <c:if test="${duty.id eq salStandard.dutyId}" >selected</c:if>>${duty.dutyName }</option>
								</c:forEach>
						</select> <input type="hidden" id="dutyName" name="dutyName" type="text"
							value="" /></td>
						<td class="inputLabelTd"><span class="required">*</span>岗位级别：</td>
						<td class="inputTd"><select id="levelCode"
							name="levelCode" class="select" onChange="changeStandardName()">
							  <option value=""></option>
								<c:forEach var="dutyLevel" items="${dutyLevelList}">
									<option value="${dutyLevel.dictCode }" <c:if test="${dutyLevel.dictCode eq salStandard.levelCode}" >selected</c:if>>${dutyLevel.dictName }</option>
								</c:forEach>
						</select> <input type="hidden" id="levelName" name="levelName"
							type="text" value="" /></td>
					</tr>
					<tr>
						<td class="inputLabelTd">基本工资：</td><td class="inputTd"><input id="basicSalary" name="basicSalary" type="text" class="text" value="${salStandard.basicSalary}" onblur="countTotalValue()"/></td>
						<td class="inputLabelTd">岗位工资：</td><td class="inputTd"><input id="dutySalary" name="dutySalary" type="text" class="text" value="${salStandard.dutySalary}" onblur="countTotalValue()"/></td>
					</tr>
					<tr>
						<td class="inputLabelTd">社保工资：</td><td class="inputTd"><input id="socialSecuritysalary" name="socialSecuritysalary" type="text" class="text" value="${salStandard.socialSecuritysalary}" onblur="countTotalValue()"/></td>
						<td class="inputLabelTd">绩效工资：</td><td class="inputTd"><input id="performanceSalary" name="performanceSalary" type="text" class="text" value="${salStandard.performanceSalary}" onblur="countTotalValue()"/></td>
					</tr>
					<tr>
						<td class="inputLabelTd"><span class="required">*</span>标准名称：</td>
						<td class="inputTd"><input id="standardName"
							name="standardName" type="text" class="text"
							value="${salStandard.standardName}" /></td>
						<td class="inputLabelTd"><span class="required">*</span>薪资总额：</td>
						<td class="inputTd"><input id="edit_totalValue"
							name="totalValue" type="text" class="text"
							value="${salStandard.totalValue}" /></td>
					</tr>

					<tr>
						<td class="inputLabelTd">薪酬类型：</td>
						<td class="inputTd"><select id="salaryTypeCode"
							name="salaryTypeCode" class="select">
								<c:forEach var="sst" items="${salStandardTypeList}">
									<option value="${sst.dictCode }" <c:if test="${sst.dictCode eq salStandard.salaryType}" >selected</c:if>>${sst.dictName }</option>
								</c:forEach>
						</select>
						<input type="hidden" id="salaryTypeName" name="salaryTypeName"
							type="text" value="${salStandard.salaryTypeName}" />						
						</td>
						<td class="inputLabelTd"><span class="required">*</span>股份配额(万)：</td>
						<td class="inputTd"><input id="stockNum" name="stockNum"
							type="text" class="text" value="${salStandard.stockNum}" /></td>
					</tr>
					<tr>
						<td class="inputLabelTd">备注：</td>
						<td class="inputTd" colspan="3" ><input id="edit_remark" name="remark"
							type="text" class="text" style="width:96%;" value="${salStandard.remark}" /></td>
					</tr>

					<tr>
						<td class="inputTd" colspan="4" style="text-align: center;">
							<input id="submit" type="button" class="ti_bottom" value="保存" />
						</td>
					</tr>
				</table>
			</div>
		</form>
	</div>
	<script type="text/javascript">
    function changeStandardName(){
    	var _leve=$('#levelCode').find("option:selected").text();
    	var _n=$('#dutyId').find("option:selected").text()+(_leve==''?'':'['+_leve+']');
    	$('#standardName').val(_n);
    }
    function countTotalValue(){
		var _basic = $('#basicSalary').val();
		var _duty = $('#dutySalary').val();
		var _social = $('#socialSecuritysalary').val();
		var _perform = $('#performanceSalary').val();
		$('#edit_totalValue').val(Number(_basic)+Number(_duty==''?0:_duty)+Number(_social==''?0:_social)+Number(_perform==''?0:_perform));
	}
	$(function() {
		//绑定提交按钮click事件
		$("#submit").click(function() {
			$('#levelName').val($('#levelCode').find("option:selected").text());
			$('#dutyName').val($('#dutyId').find("option:selected").text());
			$('#salaryTypeName')
			.val(
					$('#salaryTypeCode')
							.find("option:selected")
							.text());
			if (!biz.validate("valid", $('#salStandardFormEdit')[0])) {
				showWarn("数据验证失败", 3000);
				return;
			}
			var options = {
				url : "<m:url value='/salStandard/updateSalStandard.do'/>",
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
			$('#salStandardFormEdit').ajaxSubmit(options);
		});

		/*编辑表单数据验证*/
		new biz.validate({
			id : "#salStandardFormEdit",
			rules : {
				"dutyId" : {
					required : true
				},
				"standardName" : {
					required : true,
					maxlength : 15
				},
				"totalValue" : {
					required : true,
					maxlength : 15,
					number:true
				}
				,
				/* "stockNum" : {
					required : true,
					maxlength : 15,
					number:true
				} */
			}
		});
	});
</script>
</body>
</html>
