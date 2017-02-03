<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../../common/header.jsp"%>
</head>
  
<body>
	<form id="marketStudentFormEdit" >
    <div class="ui-table ui-widget ui-corner-all ui-border" >
		<table class="table">
			<tr style="text-indent: 4em"><td colspan="4">学生基本信息</td></tr>
			<tr>
				<td class="inputLabelTd"><span class="required">*</span>QQ号码：</td>
				<td class="inputTd">
					<input id="edit_qq" name="qq" type="text" class="text" value="${marketStudent.qq}" readonly />
				</td>
				<td class="inputLabelTd">QQ昵称：</td>
				<td class="inputTd">
					<input id="edit_qqNick" name="qqNick" type="text" class="text" >
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd"><span class="required">*</span>报名学科：</td>
				<td class="inputTd">
					<select  style="float:left" class="input_select" name="subjectId" id="edit_subjectId" onchange="courseChange(this.value);">
						<c:forEach var="mr" items="${er.xueke}">
							<option value="${mr.id}" <c:if test="${marketStudent.subjectId==mr.id}">selected</c:if> > <c:out value="${mr.name}"></c:out> </option>
			             </c:forEach>
			        </select>
				</td>
				<td class="inputLabelTd"><span class="required">*</span>报名课程：</td>
				<td class="inputTd">
					<input type="hidden" name="courseId" id="edit_courseId" value="${marketStudent.courseId}" />	
					<input class="text" name="courseName" id="edit_courseName" list="courseList" value="${marketStudent.courseName}" onchange="getIdByName(this,this.value)" />	
						<datalist id="courseList">
						</datalist>
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd"><span class="required">*</span>报名时间：</td>
				<td class="inputTd">
					<div class="time_bg">
						<input type="text" class="search_time150 valid" name="joinTime" id="edit_joinTime" mainid="joinTime" value="${marketStudent.time}"><!-- 时间选择控件-->
						<i class="search_time_ico2"></i>
					</div>
				</td> 
				<td class="inputLabelTd">备注：</td>
				<td class="inputTd">
					<input id="edit_notes" name="notes" type="text" class="text" value="${marketStudent.notes}"/>
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd"><span class="required">*</span>学员姓名：</td>
				<td class="inputTd">
					<input id="edit_name" name="name" type="text" class="text" onblur="drawPayName(this.value)"/>
				</td>
				<td class="inputLabelTd"><span class="required">*</span>年龄：</td>
				<td class="inputTd">
					<input id="edit_age" name="age" type="text" class="text" />
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd"><span class="required">*</span>手机号码：</td>
				<td class="inputTd">
					<input id="edit_phone" name="phone" type="text" class="text" />
				</td>
				<td class="inputLabelTd">能否上课：</td>
				<td class="inputTd">
					<select style="float:left" class="input_select" name="isGoclass" id="edit_isGoclass">
						<option value="0">否</option>
						<option value="1">是</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd">任课讲师：</td>
				<td class="inputTd">
					<input class="text" name="teacherId" id="edit_teacherId" list="teacherList" value="${marketStudent.teacherId}"/>	
						<datalist id="teacherList">
							<c:forEach var="teacher" items="${teacher}">
								<option value="${teacher.nickName}" did="${teacher.id}" label="${teacher.name}" ></option>
				            </c:forEach>
						</datalist>
				</td>
				<td class="inputLabelTd">班主任：</td>
				<td class="inputTd">
					<input class="text" name="tutorId" id="edit_tutorId" list="tutorList" value="${marketStudent.tutorId}"/>	
						<datalist id="tutorList">
							<c:forEach var="tutor" items="${tutor}">
								<option value="${tutor.nickName}" did="${tutor.id}" label="${tutor.name}"></option>
				            </c:forEach>
						</datalist>
				</td>
			</tr>
			<tr style="text-indent: 4em"><td colspan="4">学生付款信息</td></tr>
			<tr>
				<td class="inputLabelTd"><span class="required">*</span>应缴学费：</td>
				<td class="inputTd">
					<input id="edit_shouldPay" onblur="countOwePay()" name="shouldPay" type="text" class="text"/>
				</td>
				<td class="inputLabelTd"><span class="required">*</span>实缴学费：</td>
				<td class="inputTd">
					<input id="edit_actualPay" onblur="countOwePay()" name="actualPay" type="text" class="text"/>
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd">欠缴学费：</td>
				<td class="inputTd">
					<input id="edit_owePay" name="owePay" type="text" class="text" readonly />
				</td>
				<td class="inputLabelTd"><span class="required">*</span>付款方姓名：</td>
				<td class="inputTd">
					<input id="edit_payerName" name="payerName" type="text" class="text" />
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd"><span class="required">*</span>付款方式：</td>
				<td class="inputTd">
					<input class="text" name="payType" id="edit_payType" list="payTypeList" value="${marketStudent.payType}"/>
						<dataList id="payTypeList">
							<option value="支付宝">支付宝</option>
							<option value="网银支付">网银支付</option>
							<option value="微信支付">微信支付</option>
							<option value="银行卡支付">银行卡支付</option>
							<option value="财付通">财付通</option>
							<option value="腾讯课堂">腾讯课堂</option>
							<option value="分期付款">分期付款</option>
						</dataList>			
				</td>
				<td class="inputLabelTd">付款账号：</td>
				<td class="inputTd">
					<input id="edit_payAccount" name="payAccount" type="text" class="text" />
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd">到款账号：</td>
				<td class="inputTd">
					<input id="edit_receiveAccount" name="receiveAccount" type="text" class="text"/>
				</td>
				<td class="inputLabelTd">交易号或流水号：</td>
				<td class="inputTd">
					<input id="edit_serialNo" name="serialNo" type="text" class="text" />
				</td>
			</tr>
			<tr>
				<td class="inputTd" colspan="4" style="text-align:center;">
					<input id="submit" type="button" class="ti_bottom" value="<m:message code='button.save' />"/>
				</td>
			</tr>
		</table>
        </div>
       			<input type="hidden" id="accountNo" name="accountNo" value="${accountFlow.accountNo}" />
				<input type="hidden" id="accountId"  value="${accountFlow.id}" />
				<input type="hidden" id="accountType"  value="${accountFlow.accountType}" />
				<input type="hidden" id="accountName"  value="${accountFlow.accountName}" />
	</form>
<script type="text/javascript">
 var createDate = new Date().format('yyyy-MM-dd hh:mm:ss'); //获取今日时间
 /*定义全局变量，存储以下变量：
 *followerTypes：转化人类型ID 
 *followerPositions：转化人类型名
 *followerIds：转化人ID 
 *followerNames：转化人名称
 *rates：总业绩比例
 */
 var followerTypes = [];
 var followerIds = [];
 var followerNames = [];
 var followerPositions = [];
 
 var currStatus = "";
 
$(function() {
	courseChange($("#edit_subjectId").val());
	
	//绑定提交按钮click事件
	$("#submit").click(function() {
		$("#submit").prop('disabled', true).css({'cursor':'not-allowed'});
		showMessage("正在处理，请稍后...");
		//验证表单数据是否完整正确输入
		if(!biz.validate("valid",$('#marketStudentFormEdit')[0])){
			showWarn("数据验证失败",3000);
			$("#submit").prop('disabled', false).css({'cursor':'pointer'});
			return;
		}	
		//验证数据是否存在
		var serialNo = $("#edit_serialNo").val();
		if (ajaxGetVipInfoBySerialNo(serialNo)) {
			showMessage("该Vip学员记录已经存在，请重新输入.");
			return;
		} 
		//增加一条财务流水信息
		addAccountFlow();
	});
	
	/*编辑表单数据验证*/
	new biz.validate({
		id:"#marketStudentFormEdit",
		rules:{
			"name" :{required : true},
			"qq" : {required : true,number:true,rangelength:[6,10],digits:true },
			"phone" :{required : true,rangelength:[7,11],digits:true },
			"age" : {required : true,digits:true,max:100},
			"subjectId" : {required : true},
			"courseName": {required : true},
			"payerName" : {required : true},
			"shouldPay" : {required : true},
			"actualPay" : {required : true}
		}
	}); 
	
	new biz.datepicker({
		id : "#edit_joinTime",
		maxDate:'#F{$dp.$D(\'edit_joinTime\',{d:0});}',
		dateFmt:'yyyy-MM-dd HH:mm:ss'
	});
});
//自动填入付款方名称
function drawPayName(val){
		$('#edit_payerName').val(val);
}
//自动计算欠款金额
function countOwePay(){
		var actualPay=Number($("#edit_actualPay").val());
		var shouldPay=Number($("#edit_shouldPay").val());
		if(actualPay>shouldPay){
			showMessage("实缴学费不能大于应缴学费");
			$("#edit_actualPay").val(0);
			$("#edit_shouldPay").val(0);
			$('#edit_owePay').val(0);
		}else{
			$('#edit_owePay').val((parseFloat(shouldPay)-parseFloat(actualPay)).toFixed(2));
			$('#edit_owePay').val()>0?currStatus = "分期付款":currStatus = "已付全款";
		}
}
//报名课程随报名学科联动
function courseChange(val){
	if(val){
		$("#edit_courseName").val("");
		$ .ajax({
			url: "<m:url value='/marketStudent/getCourseList.do'/>?key="+val,
			cache:false,
			dataType:"json",
			success: function(data, textStatus, jqXHR){
				$('#courseList option').remove();
				for(var i in data.course){
					if(data.course[i].id){
						$('#courseList').append('<option value="'+data.course[i].name+'" did="'+data.course[i].id+'"></option>');
					}
				}
			},error:function(){
				$('#courseList option').remove();
			}
		});
	}else{$('#courseList option').remove();}
}
function getIdByName(obj,value) {
	var did = $("#courseList").find("option[value="+value+"]").attr('did');
	$(obj).parents().find("#edit_courseId").val(did);
}
//根据交易号查询订单是否存在
function ajaxGetVipInfoBySerialNo(serialNo) {
	var b = false;
	if (serialNo != null && serialNo != "") {
		$.ajax({
					url : "<m:url value='/vipStudent/ajaxGetVipInfoBySerialNo.do'/>?serialNo="
							+ serialNo,
					cache : false,
					async : false,
					success : function(data, textStatus, jqXHR) {
						if (data == "true") {
							showMessage("该VIP用户信息已经存在，请重新输入.");
							b = true;
						}
					}
				});
	};
	return b;
}

//插入一条学生数据
function addVipStudent(){
	var name =  $("#edit_name").val();
	var phone = $("#edit_phone").val();
	var age = $("#edit_age").val();
	var qq = $("#edit_qq").val();
	var qqNick = $("#edit_qqNick").val();
	var isGoclass = $("#edit_isGoclass").val();
	var subjectId = $("#edit_subjectId").find("option:selected").val();
	var subjectName = $("#edit_subjectId").find("option:selected").text();
	var courseName = $("#edit_courseName").val();
	var teacherId = $("#edit_teacherId").val();
	var tutorId = $("#edit_tutorId").val();
	var notes = $("#edit_notes").val();
	var shouldPay = $("#edit_shouldPay").val();
	var actualPay = $("#edit_actualPay").val();
	var owePay = $("#edit_owePay").val();
	var payerName = $("#edit_payerName").val();
	var payType = $("#edit_payType").val();
	var payAccount = $("#edit_payAccount").val();
	var receiveAccount = $("#edit_receiveAccount").val();
	var serialNo = $("#edit_serialNo").val();
	var comSource = $("#edit_comSource").val();
	var sourceSubclass = $("#edit_sourceSubclass").val();
	var accountNo = $("#edit_accountNo").val();
	var joinTime = $("#edit_joinTime").val();
	if(joinTime.length<2){
		joinTime= createDate;	}
	var paramDatas = {
			name:name,
			age:age,
			phone:phone,
			qq:qq,
			qqNick:qqNick,
			isGoclass:isGoclass,
			subjectId:subjectId,
			subjectName:subjectName,
			courseName:courseName,
			teacherId:teacherId,
			tutorId:tutorId,
			notes:notes,
			shouldPay:shouldPay,
			actualPay:actualPay,
			owePay:owePay,
			payerName:payerName,
			payType:payType,
			payAccount:payAccount,
			receiveAccount:receiveAccount,
			serialNo:serialNo,
			comSource:comSource,
			sourceSubclass:sourceSubclass,
			followerType:followerTypes,
			followerPosition:followerPositions,
			followerId:followerIds,
			followerName:followerNames,
			accountNo:accountNo,
			joinTime:joinTime,
			currStatus:currStatus,
			isCount:"未分配业绩",
				};
	$.ajax({
		   type: "post",
		   url: "<m:url value='/marketStudent/baomin.do'/>?stuid=${marketStudent.id}",
		   data: paramDatas,
		   cache: false,
		   dataType:"json",
		   success:function(d){
				if(d.status){
					showMessage(d.message,"","",function(){
						window.parent.closeShow();
			     		window.parent.doSearch();
					});
				}else{
					showMessage(d.message);
				}
		   }
		});
}

//增加财务流水信息
function addAccountFlow(){
	var money=$("#edit_actualPay").val();
	var accountId = $("#accountId").val();
	var accountNo = $("#accountNo").val();
	var accountType = $("#accountType").val();
	var accountName = $("#accountName").val();
	var note = $("#edit_name").val()+"-"+$("#edit_subjectId").find("option:selected").text()+"："+$("#edit_courseName").val()+"-"+accountName;
	var paramDatas = {
					money:money,
					accountId:accountId,
					accountName:accountName,
					accountType:accountType,
					accountNo:accountNo,
					createDate:createDate,
					note:note,
					};
	$.ajax({
		   type: "post",
		   url: "<m:url value='/accountFlow/addAccountFlow.do'/>",
		   data: paramDatas,
		   cache: false,
		   dataType:"json",
		   success:function(response){
			 //增加一条学生信息
				addVipStudent();
		   }
		});
}
</script>
</body>
</html>
