<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../../common/header.jsp"%>
 <script type="text/javascript">
 var createDate = new Date().format('yyyy-MM-dd hh:mm:ss');//获取今日时间
 /*定义全局变量，存储以下变量：
 *followerTypes：转化人类型ID 
 *followerPositions：转化人类型名
 *followerIds：转化人ID 
 *followerNames：转化人名称
 *followerRates：总业绩比例
 */
 var followerTypes = [];
 var followerIds = [];
 var followerNames = [];
 var followerPositions = [];
 var followerRates = [];
 var i = 0;
 var currStatus = "";
 var u="";//分配业务类型
 var performMoney;//分配金额
$(function() {
	//弹出框
	var selectStudent_iframe_dialog; 
	
	subChange($('#edit_comSource').val());
	$("#edit_perDate").val(new Date().format('yyyy-MM-dd'));
		
	//绑定提交按钮click事件
	$("#submit").click(function() {
		$("#submit").prop('disabled', true).css({'cursor':'not-allowed'});
		showMessage("正在处理，请稍后...");
		if(!biz.validate("valid",$('#vipStudentFormEdit')[0])){
			showWarn("数据验证失败",3000);
			$("#submit").prop('disabled', false).css({'cursor':'pointer'});
			return;
		}
		
		//计算总业务比例
		var rates = 0;
		$("tr[name='addEnable']").each(function(i){
			var rate = $(this).find("#rate").val();
			rates =  Number(rates) + Number(rate);
		});
		
		//总业务比例小于1，开始分配个人业绩
		rates>1?showMessage("业绩比例分配不可大于1！"):countPerformance();
	});
	
	new biz.datepicker({
		id : "#edit_joinTime",
		maxDate:'#F{$dp.$D(\'edit_joinTime\',{d:0});}',
		dateFmt:'yyyy-MM-dd HH:mm:ss'
	});
	
	new biz.datepicker({
		id : "#edit_perDate",
		maxDate:'#F{$dp.$D(\'edit_perDate\',{d:0});}',
		dateFmt:'yyyy-MM-dd'
	});
	
	
	/*编辑表单数据验证*/
	new biz.validate({
		id:"#vipStudentFormEdit",
		rules:{
			"subjectId" : {required : true},
			"comSource" :{required : true},
			"rate" : {required : true},
			"perMoney" : {required : true,minlength:2},
			"perDate" : {required : true},
		}
	}); 
});

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


//深克隆(添加多个转化人事件)
function addFollowMess(){
	var $addEnable = $(".addEnable:last");
	var $clone = $addEnable.clone(true);
	$clone.find("input").val("");
	$addEnable.after($clone); 
	var index = $clone.index();
	$clone.find(".followerName").attr("id","followerName"+$clone.index());
};
//删除多个转化人事件
function delFollowMess(Object){
	if($(".addEnable").size()>1)
	{$(Object).parents('.addEnable').remove();}
	else return;
};
/*自动搜寻转化人 自动完成(Autocomplete) 根据用户输入值进行搜索和过滤,让用户快速找到并从预设值列表中选择*/
function getEmpIDByName(obj,value) {
	var did = $("#employeeList").find("option[value="+value+"]").attr('did');
	$(obj).parents('.addEnable').find("#edit_followerId").val(did);
}

//获取转化人所占业绩比例
function getRate(Object){
	var parentId =$("#edit_comSource").find("option:selected").val();
	var subId =$("#edit_sourceSubclass").val();
	var positionId = $(Object).parents('.addEnable').find("#edit_followerType").val();
	if (parentId && subId && positionId) {
		$.ajax({
					url : "<m:url value='/standard/getRate.do'/>?parentId="
							+ parentId+"&subId="+subId+"&positionId="+positionId,
					cache : false,
					async : false,
					success : function(data, textStatus, jqXHR) {
						$(Object).parents('.addEnable').find("#rate").val(data);
					}
				});
	};
}
//打开Vip学员信息界面
function selectStudent() {
	var url = baseUrl + '/empPerformance/toSelectStudent.do?type=addNewEmp';
	selectStudent_iframe_dialog = new biz.dialog(
			{
				id :$('<div id="addEmpwindow_iframe"></div>').html('<iframe id="iframeAdd" name="iframeAdd" src="'+url+'" width="100%" frameborder="no" border="0" height="97%"></iframe>'),
				modal : true,
				width : $(window).width(),
				height : $(window).height(),
				title: "补录员工",
			});
	selectStudent_iframe_dialog.open();
}

// 关闭Vip学员信息界面
function closeSelectStudent() {
	selectStudent_iframe_dialog.close();
}

//填充数据
function drawForm0(rowData) {
	$('#edit_id').val(rowData.id);
	$('#edit_stuId').val(rowData.id);
	$('#edit_stuName').val(rowData.name);
	$('#edit_qq').val(rowData.qq);
	$('#edit_courseName').val(rowData.courseName);
	$('#edit_joinTime').val(rowData.joinTime);
	$('#edit_comSource').val(rowData.comSource);
	$('#edit_sourceSubclass').val(rowData.sourceSubclass);
	performMoney = rowData.actualPay;
	var folPositions=rowData.followerPosition.split(",");
	var folTypes=rowData.followerType.split(",");
	var folIds =rowData.followerId.split(",");
	var folNames =rowData.followerName.split(",");	
	var folRates =rowData.followerRate.split(",");	
	for(var i = 0;i<folNames.length;i++){
			var $addEnable = $(".addEnable:last");
			var $clone = $addEnable.clone(true);
			$addEnable.after($clone); 
			$clone.find("select[name='followerType']").find("option[value='"+folTypes[i]+"']").attr("selected",true);
			$clone.find("select[name='followerType']").find("option:selected").text(folPositions[i]);
			$clone.find("#edit_followerId").val(folIds[i]);
			$clone.find(".followerName").val(folNames[i]);
			$clone.find("#rate").val(folRates[i]);
	}
	$(".addEnable:first").remove(); 
	u="员工补录";
}


function maxPerMoney(){
	if($("#edit_perMoney").val()>performMoney){
		showMessage("分配金额不能大于实缴金额");
		$("#edit_perMoney").val(0);
	}
	
}
//计算分配业绩
function countPerformance(){
	$("tr[name='addEnable']").each(function(i){
			var rate = $(this).find("#rate").val();
			var followerType = $(this).find("select[name='followerType']").find("option:selected").val();
			var followerPosition = $.trim($(this).find("select[name='followerType']").find("option:selected").text());
			var employeeId = $(this).find("#edit_followerId").val();
			var employeeName = $(this).find(".followerName").val();
			var shouldPay = $("#edit_perMoney").val();
			var actualPay = $("#edit_perMoney").val();
			var performance = parseFloat($("#edit_perMoney").val())*parseFloat(rate);
			var note = u+$("#edit_courseName").val()+"-"+rate+"*";
			var note = $("#edit_courseName").val()+"-"+u+"-"+$("#edit_perMoney").val()+"*"+rate;
			var isPass="未清算";
			var stuId = $("#edit_stuId").val();
			var paramDatas = {
					employeeId:employeeId,
					employeeName:employeeName,
					shouldPay:shouldPay,
					actualPay:actualPay,
					performance:performance,
					createDate:$("#edit_perDate").val(),
					note:note,
					position:followerPosition,
					isPass:isPass,
					stuId:stuId,
					};
			$.ajax({
				   type: "post",
				   url: "<m:url value='/empPerformance/addEmpPerformance.do'/>",
				   data: paramDatas,
				   cache: false,
				   async:false,
				   dataType:"json",
				   success : function(d){}
				});
		});
		//修改订单业绩分配状态
		updateVipInfo();
	    //返回结果提示
		$.ajax({
		   type: "get",
		   url: "<m:url value='/empPerformance/listEmpPerformance.do'/>",
		   data: {
			   stuId:$("#edit_stuId").val(),
			   createDate:$("#edit_perDate").val()
			   },
		   cache: false,
		   dataType:"json",
		   success:function(response){
			   var names = [];
			   for(var i = 0;i<response.rows.length;i++){
				   names.push(response.rows[i].employeeName+":"+response.rows[i].note+"<br/>");
				   names.join("");
			   }
			   showMessage(
				 "已成功分配，该笔订单共有 "+response.rows.length+" 条业绩记录：<br/>"+names,
				 "","",
			  	 function(){
					window.parent.closeAddEmp();
		     		window.parent.doSearch();
			   });
		   }
		});
}

function updateVipInfo(){
	$("tr[name='addEnable']").each(function(i){
		var rate = $(this).find("#rate").val();
		var followerType = $(this).find("select[name='followerType']").find("option:selected").val();
		var followerPosition = $(this).find("select[name='followerType']").find("option:selected").text();
		var employeeId = $(this).find("#edit_followerId").val();
		var employeeName = $(this).find(".followerName").val();
		//全局变量改变
		followerIds.push(employeeId);
		followerIds.join(",");
		followerPositions.push(followerPosition);
		followerPositions.join(",");
		followerTypes.push(followerType);
		followerTypes.join(",");
		followerNames.push(employeeName);
		followerNames.join(",");
		followerRates.push(rate);
		followerRates.join(",");
	});
	var isCount = "已分配业绩";
	var comSource = $("#edit_comSource").val();
	var sourceSubclass = $("#edit_sourceSubclass").val();
	var paramDatas = {
			id:$("#edit_id").val(),
			isCount:isCount,
			comSource:comSource,
			sourceSubclass:sourceSubclass,
			followerType:followerTypes.toString(),
			followerPosition:followerPositions.toString(),
			followerId:followerIds.toString(),
			followerName:followerNames.toString(),
			followerRate:followerRates.toString(),
				};
	$.ajax({
		   type: "post",
		   url: "<m:url value='/vipStudent/updateEmpPerform.do'/>",
		   data: paramDatas,
		   cache: false,
		   dataType:"json",
		});
}
</script>
</head>
  
<body>
	<form id="vipStudentFormEdit" >
    <div class="ui-table ui-widget ui-corner-all ui-border" >
		<input type="hidden" id="edit_id" name="id" type="text" />
		<table class="table">
			<tr>
				<td class="inputLabelTd"><span class="required">*</span>学员姓名：</td>
				<td class="inputTd">
					<input type="hidden" id="edit_stuId" name="stuId" type="text" />
					<input id="edit_stuName" name="stuName" type="text" class="text" onclick="selectStudent();" readonly/>
				</td>
				<td class="inputLabelTd"><span class="required">*</span>QQ号码：</td>
				<td class="inputTd">
					<input id="edit_qq" name="qq" type="text" class="text" readonly/>
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd">报名课程：</td>
				<td class="inputTd">
					<input class="text" name="courseName" id="edit_courseName" readonly/>	
				</td>
				<td class="inputLabelTd">报名时间：</td>
				<td class="inputTd">
					<div class="time_bg">
						<input type="text" class="search_time150 valid" name="joinTime" id="edit_joinTime" disabled="disabled"><!-- 时间选择控件-->
						<i class="search_time_ico2"></i>
					</div>
				</td>
			</tr>
			<tr>
			 	<td class="inputLabelTd"><span class="required">*</span>分配金额：</td>
				<td class="inputTd" >
					<input id="edit_perMoney" name="perMoney" type="text" class="text" onblur="maxPerMoney()"/>
				</td>
				<td class="inputLabelTd"><span class="required">*</span>分配时间：</td>
				<td class="inputTd" >
					<div class="time_bg">
						<input type="text" class="search_time150 valid" name="perDate" id="edit_perDate"><!-- 时间选择控件-->
						<i class="search_time_ico2"></i>
					</div>
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd"><span class="required">*</span>流量来源：</td>
				<td class="inputTd">
					<select onchange="subChange(this.value);changeFollower()" class="input_select" name="comSource" id="edit_comSource" ><option value="">--请选择--</option>
						<c:forEach var="standard" items="${standard}">
							<option value="${standard.parentId}"> <c:out value="${standard.parentName}"></c:out> </option>
			             </c:forEach>
					</select>
				</td>
			 	<td class="inputLabelTd">来源分类：</td>
				<td class="inputTd">
					<select class="input_select" name="sourceSubclass" id="edit_sourceSubclass"  onchange="changeFollower()">
			        </select>
				</td>
			</tr>
			<tr name="addEnable" class="addEnable">
				<td class="inputLabelTd">转化人类型：</td>
				<td class="inputTd">
					<select class="input_select" name="followerType" id="edit_followerType" onchange="getRate(this)"><option value="">--请选择--</option>
						<option value="0">无</option>
						<c:forEach var="followers" items="${followers}">
							<option value="${followers.positionId}"> <c:out value="${followers.position}"></c:out> </option>
			             </c:forEach>
					</select>
				</td>
				<td class="inputLabelTd">转化人：</td>
				<td class="inputTd">
					<input id="edit_followerId" name="followerId" type="hidden" class="text"/>
					<input id="edit_followerName" name="followerName" type="text" class="text followerName" style="width:59px" list="employeeList"  onchange="getEmpIDByName(this,this.value);"/>
					<datalist id="employeeList">
						<c:forEach var="tutor" items="${tutor}">
							<option did="${tutor.id}" value="${tutor.name}" label="${tutor.nickName}"></option>
			             </c:forEach>
					</datalist>
					配比率：
					<input type="text" id="rate" class="text" name="rate" style="width:40px"/>
					<i style="display: inline-block;cursor:pointer;position: relative;top:5px;" class="icon_bg icon_add" onclick="addFollowMess()"> </i>
					<i style="display: inline-block;cursor:pointer;position: relative;top:5px;" class="icon_bg icon_del" onclick="delFollowMess(this)"> </i>
				</td>
			</tr>
			<tr>
				<td class="inputTd" colspan="4" style="text-align:center;">
					<input id="submit" type="button" class="ti_bottom" value="确定分配"/>
					<input id="cancel" type="button" class="ti_bottom" value="取消" onclick="window.parent.closeAddEmp();"/>
				</td>
			</tr>
		</table>
        </div>
	</form>
</body>
</html>
