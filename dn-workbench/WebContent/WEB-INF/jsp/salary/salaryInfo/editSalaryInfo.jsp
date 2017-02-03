<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html  >
<html>
<head>
<%@ include file="../../common/header.jsp"%>
<script type="text/javascript">


function compute(){
	var userId=$('#userId').val();
	var ym=$('#ym').val();
	if(userId==''){
		showWarn("请选择人员",3000);
		return;
	}
	if(ym==''){
		showWarn("请选择工资月份",3000);
		return;
	}
	$ .ajax({
		url: "<m:url value='/salaryInfo/compute.do'/>?userId="+userId+"&ym="+ym,
		cache:false,
		dataType:"json",
		success: function(d, textStatus, jqXHR){
			if(d.status){
				 $.each(d.data,function(n,v){
					   if(n!="id")
					  $("#"+n).val(v);
					  });
			}else{
				showMessage(d.message);
			}
			 
		}
	});
	
}


//重置查询表单
function resetSalaryForm(formId){
	document.getElementById(formId).reset();
}

$(function() {	
	//绑定提交按钮click事件
	$("#submit").click(function() {
		if(!biz.validate("valid",$('#salaryInfoFormEdit')[0])){
			showWarn("数据验证失败",3000);
			return;
		}
		var options = {
			url : "<m:url value='/salaryInfo/updateSalaryInfo.do'/>",
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
		$('#salaryInfoFormEdit').ajaxSubmit(options);
	});
	 new biz.datepicker({
			id : "#ym",
			dateFmt:'yyyy-MM'
		});
	/*编辑表单数据验证*/
	new biz.validate({
		id:"#salaryInfoFormEdit",
		rules:{
			"ym" : {
				required : true
			},
		}
	}); 
	
});

function checkNegativeNumber(textbox){
	var value = Number(textbox.value);
		if(value>0){
		textbox.value=value*-1;
		}
		
}
function changeSalaryInfo(textbox, type) {
	var oldValue = Number(textbox.oldvalue);
	var value = Number(textbox.value);
	if (isNaN(oldValue)) {
		oldValue = 0.0;
	}
	if (!isNaN(value)) {
		if (type == 1) {// 加款项
			// var jkItemIds = ['基本工资', '岗位工资', '加班工资',
			// '社保工资', '绩效工资', '社保福利',
			// '工龄工资','文凭工资', '奖励','其他'];
			var jkItemIds = ['basicSalary', 'dutySalary', 'overtimeSalary',
					'socialSecuritySalary', 'performanceSalary', 'welfare',
					'ageSalary', 'diplomaSalary', 'reward', 'other'];
			var duesSalary = 0.0;
			var jitemv;
			for (var i = 0; i < jkItemIds.length; i++) {
				jitemv = $('#' + jkItemIds[i]).val();
				if (jitemv != '') {
					if (parseFloat(jitemv) != 0) {
						duesSalary = duesSalary + parseFloat(jitemv);
					}

				}
			}
			$("#duesSalary").val(duesSalary.toFixed(2));// 应付
			var deduct = Number($("#deduct").val());
			$("#factSalary").val((duesSalary + deduct).toFixed(2)); // 实发工资
		}
		if (type == 2) {// 减款项
			// var kkItemIds = ['考勤扣款', '个人社保', '生活住宿', '罚款'];
			var kkItemIds = ['timecardDeduct', 'oneSocialSecurity',
					'livesAccommodation', 'punish'];
			var deduct = 0.0;
			var itemv;
			for (var i = 0; i < kkItemIds.length; i++) {
				itemv = $('#' + kkItemIds[i]).val();
				if (itemv != '') {
					if (parseFloat(itemv) != 0) {
						deduct = deduct + parseFloat(itemv);
					}

				}
			}
			$("#deduct").val(deduct.toFixed(2));
			var duesSalary = Number($("#duesSalary").val());
			$("#factSalary").val((duesSalary + deduct).toFixed(2)); // 更新实发工资结果
		}
	} else {
		showMessage("亲！这里只能输入数字呢！");
		textbox.value = oldValue;
	}
}

	function reckonSalaryInfo(){
	var ym=$('#ym').val();
			if(ym==''){
				showMessage("请选择工资月份！");
				return;
			}
			var userId=$('#userId').val();
			if(userId==''){
				showMessage("请选择人员！");
				return;
			}
				$.ajaxGetPostData(applicationPath
						+ "/salaryInfoController.do?method=reckon",
				"userId=" + userId+"&ym="+ym, function(data) {
							$.each(data, function(n,v) {
							   var tmp=$('#'+n);
							    if(tmp.val()!=''){
							    if(parseFloat(tmp.val())!=parseFloat(v)){
							    tmp.val(v);
							    }
							    }else{
			                    tmp.val(v);
			                    }
								});
				});
	}

	function clanInpit(textbox){	//获得文本框
			var val = $("input[name="+textbox.name+"]").val();
			if(val == 0){
				$("input[name="+textbox.name+"]").val("");
			}
		}
		
		function byeInput(textbox){		//离开可选框
			if($("input[name="+textbox.name+"]").val() == ""){
				$("input[name="+textbox.name+"]").val("0.0");
			}
		}
</script>
<style type="text/css">
input.border_none {
    background-color: transparent;
    border: 1px none;
 
}
.salary_input_w_def{
   width:100px;
}
</style>
</head>
  
<body>

<div id="editDialog">
	<form id="salaryInfoFormEdit" >
    <div class="ui-table ui-widget ui-corner-all ui-border" >
		<input type="hidden" id="id" name="id" value="${salaryInfo.id}"/>
		<table class="table">
			<tr>
				<td class="inputLabelTd">人员姓名：</td>
				<td class="inputTd">
				<div style="width:130px;">
					<input id="userName"  readonly="readonly"  type="text" 
					class="text" style="width:103px;background-color: #eee;"  value="${salaryInfo.userName}"/>
					<input type="hidden" id="userId"  type="text" value="${salaryInfo.userId}"/>
					</div>
				</td>
				<td class="inputLabelTd">所在部门：</td>
				<td class="inputTd">
					<input id="orgName" name="orgName" type="text" class="border_none" value="${salaryInfo.orgName}"/>
					<input type="hidden" id="orgId" name="orgId"  value="${salaryInfo.orgId}"  />
				</td>
				<td class="inputLabelTd">薪酬标准：</td>
				<td class="inputTd">
					<input id="standName" name="standName" type="text" class="border_none" value="${salaryInfo.standName}"/>
					<input type="hidden" id="standId" name="standId" value="${salaryInfo.standId}" />
				</td>
			</tr>
				<tr>
				<td class="inputLabelTd">工资年月：</td>
				<td class="inputTd">
				<div class="time_bg">
						<input id="ym" type="text" class="search_time150" style="width:80px;" name="ym" value="${salaryInfo.ym}">
						<i class="search_time_ico2"></i>
					</div>
				</td>
				<td class="inputLabelTd">核定工资：</td>
				<td class="inputTd">
					<input id="approvedSalary" name="approvedSalary" 
					class="border_none salary_input_w_def currency_red_16" 
					readonly="readonly"  type="text"  value="${salaryInfo.approvedSalary}"/>
				</td>
				<td class="inputLabelTd">应付工资：</td>
				<td class="inputTd">
					<input id="duesSalary" name="duesSalary" 
					class="border_none salary_input_w_def" 
					readonly="readonly"  type="text"  value="${salaryInfo.duesSalary}"/>
				</td>
			</tr>
			<tr>
			<td class="inputLabelTd">工资类型:</td>
				<td class="inputTd">
				<input id="salaryTypeName" name="salaryTypeName" class="border_none salary_input_w_def"
				 readonly="readonly"  type="text"  value="${salaryInfo.salaryTypeName}"/>
					<input type="hidden" id="salaryTypeCode" name="salaryTypeCode" type="text" value="${salaryInfo.salaryTypeCode}"/>
				</td>
				<td class="inputLabelTd">扣款：</td>
				<td class="inputTd">
					<input id="deduct" name="deduct" class="border_none salary_input_w_def"
					 readonly="readonly" type="text"  value="${salaryInfo.deduct}"/>
				</td>
				<td class="inputLabelTd">实发工资：</td>
				<td class="inputTd">
					<input id="factSalary" name="factSalary" class="border_none salary_input_w_def currency_red_16" 
					readonly="readonly" type="text"  value="${salaryInfo.factSalary}"/>
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd">备注：</td>
				<td class="inputTd" colspan="5" style="padding-top:5px;padding-bottom:5px;">
				<textarea rows="1" id="remark" name="remark" class="text" style="width: 580px;height:45px;">${salaryInfo.remark}</textarea>
				</td>
				
			</tr>
		
		
			<tr>
				<td class="inputLabelTd">基本工资：</td>
				<td class="inputTd">
					<input id="basicSalary"  name="basicSalary" class="border_none salary_input_w_def" 
					readonly="readonly"  value="${salaryInfo.basicSalary}"/>
				</td>
				<td class="inputLabelTd">岗位工资：</td>
				<td class="inputTd">
					<input id="dutySalary" name="dutySalary" class="border_none salary_input_w_def" 
					readonly="readonly" value="${salaryInfo.dutySalary}"/>
				</td>
				<td class="inputLabelTd">加班工资：</td>
				<td class="inputTd">
					<input id="overtimeSalary" name="overtimeSalary" 
					  class="text salary_input_w_def" 
					onkeyup="checkNegativeNumber(this);changeSalaryInfo(this,2);this.oldvalue = this.value" 
				onkeydown="this.oldvalue = this.value;" 
				onkeypress="return forbidBackSpace(event);" 
				onfocus="clanInpit(this);" 
				onblur="byeInput(this);" 
				value="${salaryInfo.overtimeSalary}" />
				
				</td>
				
			</tr>
			<tr>
				
				<td class="inputLabelTd">社保工资：</td>
				<td class="inputTd">
					<input id="socialSecuritySalary" name="socialSecuritySalary" 
					class="border_none salary_input_w_def" readonly="readonly" value="${salaryInfo.socialSecuritySalary}"/>
				</td>
				<td class="inputLabelTd">绩效工资：</td>
				<td class="inputTd">
					<input id="performanceSalary" name="performanceSalary" 
					class="border_none salary_input_w_def" readonly="readonly"  value="${salaryInfo.performanceSalary}"/>
				</td>
				<td class="inputLabelTd">社保福利：</td>
				<td class="inputTd">
				<input id="welfare" name="welfare" type="text"  class="text salary_input_w_def" 
					onkeyup="checkNegativeNumber(this);changeSalaryInfo(this,2);this.oldvalue = this.value" 
				onkeydown="this.oldvalue = this.value;" 
				onkeypress="return forbidBackSpace(event);" 
				onfocus="clanInpit(this);" 
				onblur="byeInput(this);" 
				value="${salaryInfo.welfare}" />
				</td>
			</tr>
		
			<tr>
				
				<td class="inputLabelTd">工龄工资：</td>
				<td class="inputTd">
					<input id="ageSalary" name="ageSalary" 
					class="border_none salary_input_w_def" readonly="readonly" value="${salaryInfo.ageSalary}"/>
				</td>
				<td class="inputLabelTd">文凭工资：</td>
				<td class="inputTd">
					<input id="diplomaSalary" name="diplomaSalary" 
					class="border_none salary_input_w_def" readonly="readonly" value="${salaryInfo.diplomaSalary}"/>
				</td>
				<td class="inputLabelTd">考勤扣款：</td>
				<td class="inputTd">
					<input id="timecardDeduct" name="timecardDeduct" type="text" class="text salary_input_w_def" 
					onkeyup="checkNegativeNumber(this);changeSalaryInfo(this,2);this.oldvalue = this.value" 
				onkeydown="this.oldvalue = this.value;" 
				onkeypress="return forbidBackSpace(event);" 
				onfocus="clanInpit(this);" 
				onblur="byeInput(this);" 
				value="${salaryInfo.timecardDeduct}" />
				
				</td>
			</tr>
		
			<tr>
				<td class="inputLabelTd">个人社保：</td>
				<td class="inputTd">
					<input id="oneSocialSecurity" name="oneSocialSecurity" type="text" class="text salary_input_w_def"
				onkeyup="checkNegativeNumber(this);changeSalaryInfo(this,2);this.oldvalue = this.value" 
				onkeydown="this.oldvalue = this.value;" 
				onkeypress="return forbidBackSpace(event);" 
				onfocus="clanInpit(this);" 
				onblur="byeInput(this);" 
				 value="${salaryInfo.oneSocialSecurity}" />
				</td>
				<td class="inputLabelTd">生活住宿：</td>
				<td class="inputTd">
					<input id="livesAccommodation" name="livesAccommodation" type="text" class="text salary_input_w_def" 
					onkeyup="checkNegativeNumber(this);changeSalaryInfo(this,2);this.oldvalue = this.value" 
				onkeydown="this.oldvalue = this.value;" 
				onkeypress="return forbidBackSpace(event);" 
				onfocus="clanInpit(this);" 
				onblur="byeInput(this);" 
				value="${salaryInfo.livesAccommodation}" />
				</td>
				<td class="inputLabelTd">奖励：</td>
				<td class="inputTd">
					<input id="reward" name="reward" type="text" 
					class="border_none salary_input_w_def" readonly="readonly" value="${salaryInfo.reward}"/>
				</td>
			</tr>
			<tr>
				
				<td class="inputLabelTd">处罚：</td>
				<td class="inputTd">
					<input id="punish" name="punish" type="text" 
					class="border_none salary_input_w_def" readonly="readonly" value="${salaryInfo.punish}" />
				</td>
				<td class="inputLabelTd">其它：</td>
				<td class="inputTd">
					<input id="other" name="other" type="text" class="text salary_input_w_def" 
					onkeyup="checkNegativeNumber(this);changeSalaryInfo(this,2);this.oldvalue = this.value" 
				onkeydown="this.oldvalue = this.value;" 
				onkeypress="return forbidBackSpace(event);" 
				onfocus="clanInpit(this);" 
				onblur="byeInput(this);" 
				value="${salaryInfo.other}" />
				</td>
				<td class="inputLabelTd"></td>
				<td class="inputTd">
				</td>
			</tr>
			
		
			<tr>
				<td class="inputTd" colspan="6" style="text-align:center;">
					<input id="compute_btn" onClick="compute();" type="button" class="ti_bottom" value="计算"/>
					<input id="submit" type="button" class="ti_bottom" value="保存"/>
					<input id="reset_btn" onClick="resetSalaryForm('salaryInfoFormEdit');" type="button" class="ti_bottom" value="重填"/>
					<input id="close_btn" onClick="window.parent.closeEdit();" type="button" class="ti_bottom" value="取消"/>
				</td>
			</tr>
		</table>
    </div>
	</form>
</div>
</body>
</html>
