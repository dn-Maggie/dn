<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html  >
<html>
<head>
<%@ include file="../../common/header.jsp"%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/styles/extends/css/accounting.css"/>
<script type="text/javascript">
/*获取今日时间*/
var today= new Date(); 
var y = today.getFullYear();
var m = today.getMonth()+1;
var d = today.getDate();
var h = today.getHours(); 
var mi = today.getMinutes(); 
var s = today.getSeconds(); 
var createDate= y+'-'+(m<10?('0'+m):m)+'-'+(d<10?('0'+d):d);

var mdAllMoney="",mdAllName = "";
var mcAllMoney="",mcAllName = "";



$(function() {
	$("#billDate").val(createDate);
	for(i=1;i<2;i++){
		addtrDetails();
	}
	//绑定提交按钮click事件
	$("#submit").click(function() {
		if(!biz.validate("valid",$('#accountingFormEdit')[0])){
			showWarn("数据验证失败",3000);
			return;
		}
		addAccounting();
	});

	/*日期格式化*/
	new biz.datepicker({
		id : "#billDate",
		maxDate:'#F{$dp.$D(\'billDate\',{d:0});}',
		dateFmt:'yyyy-MM-dd'
	});
	
	/*编辑表单数据验证*/
	new biz.validate({
		id:"#accountingFormEdit",
		rules:{
			"documentType" :{required : true},
			"documentNo" : {required : true,number:true},
			"billDate" :{required : true,},
			"docAttach" : {required : true,digits:true,max:100},
			"digest" : {required : true},
		}
	}); 
});

//备忘录显示
function noteBoxShow(){
	$(".noteBox").css("visibility","visible");
}


//深克隆(添加一行)
function addtrDetails(){
	var $addEnable = $(".trDetails:last");
	var $clone = $addEnable.clone(false);
	$clone.find("span").text("");
	$clone.find("input").val("");
	$addEnable.after($clone); 
};
//删除一行
function deltrDetail(Object){
	if($(".trDetails").size()>2)
	{$(Object).parents('.trDetails').remove();}
	else return;
};
//切换金额录入框显示状态
function changeHide(Object){
	$(Object).parents('td').find('.InputText').css('display','block');
	$(Object).css('display','none');
	
}
//填充每项金额
function fillNum(Object){
	var objval = $(Object).find('input').val();
// 	if(objval!=""){
		var fmtobjval = parseFloat(objval).toFixed(2);
		var fillnum = Number(fmtobjval)*100;
		if(fillnum){$(Object).parents('td').find('.DisplayText').find('span').text(fillnum);}
		else{$(Object).parents('td').find('.DisplayText').find('span').text("");}
		countTotal();
// 	}
	$(Object).css('display','none');
	$(Object).parents('td').find('.DisplayText').css('display','block');
	
}
//计算总数额
function countTotal(){
	var totalCredit = 0;
	var totalDebit = 0;
	$("input[name='mdMoney']").each(function(i){
		if($(this).val()){
			var mdMoney = parseFloat($(this).val());
			totalDebit += parseFloat(mdMoney);
			var sptotalDebit = totalDebit.toFixed(2)*100;
			if(sptotalDebit){$('span.totalDebit').text(sptotalDebit);}
			else{$('span.totalDebit').text("");}
		}
	});
	
	$("input[name='mcMoney']").each(function(i){
		if($(this).val()){
			var mcMoney = parseFloat($(this).val());
			totalCredit += parseFloat(mcMoney);
			var sptotalCredit = totalCredit.toFixed(2)*100;
			if(sptotalCredit){$('span.totalCredit').text(sptotalCredit);}
			else{$('span.totalCredit').text("");}
		}
	});
	totalChina();
}
//自动填充大写数字
function totalChina(){
	var total = $('span.totalDebit').text();
	if(total.trim()!=""){
		var AA = new Array( "零", "壹", "贰", "叁", "肆", "伍", "陆", "柒", "捌", "玖"); 		
		var yuan = parseInt(total/100) % 10;if(yuan>0){
			yuan = AA[yuan];}else{yuan="";}
		var shi = parseInt(total/1000) % 10;if(shi>0){
			shi = AA[shi]+"拾";}else{shi="";}
		var bai = parseInt(total/10000) % 10;if(bai>0){
			bai = AA[bai]+"佰";}else{bai="";}
		var qian = parseInt(total/100000)%10;if(qian>0){
			qian = AA[qian]+"仟";}else{qian="";}
		var wan = parseInt(total/1000000)%10;if(wan>0){
			wan = AA[wan]+"萬";}else{wan="";}
		var yi = parseInt(total/10000000)%10;if(yi>0){
			yi = AA[yi]+"億";}else{yi="";}
		var jiao = parseInt(total/10) % 10;if(jiao>0){
			jiao = AA[jiao]+"角";}else{jiao="";}
		var fen = total % 10;if(fen>0){
			fen = AA[fen]+"分";}else{fen="";}
		$("span.spTotal").text(wan+qian+bai+shi+yuan+"圆"+jiao+fen+"整");
	}
}
//s showAccountList
function showAccountList(Object){
	$('.accountList').css('display','none');
	$(Object).parents('td').find('.accountList').css('display','block');
}
//s hideAccountList
function hideAccountList(){
	$('.accountList').css('display','none');
}
//s showDigestList
function showDigestList(Object){
	$('.digestList').css('display','none');
	$(Object).parents('td').find('.digestList').css('display','block');
}
//s hideDigestList
function hideDigestList(){
	$('.digestList').css('display','none');
}
//科目列表填充
function fillAccount(Object){
	$(Object).parents('td').find('.inputKemu').val($(Object).attr('aname'));
	$(Object).parents('.accountList').css('display','none');
}
//摘要列表填充
function fillAccountName(Object){
	$(Object).parents('td').find('.inputZhaiYao').val($(Object).attr('aname'));
	$(Object).parents('.digestList').css('display','none');
}
//隐藏该节点
function hide(Object){
	$(Object).css('visibility','hidden');
};

//添加会计凭证
function addAccounting(){
	
	$("input[name='mdMoney']").each(function(i){
		if($(this).val()){
			var mdName = $(this).parents('.trDetails').find('.inputKemu').val();
			var mdMoney = parseFloat($(this).val());
			mdAllMoney += mdMoney+",";
			mdAllName += mdName+",";
		}
	});
	
	$("input[name='mcMoney']").each(function(i){
		if($(this).val()){
			var mcName = $(this).parents('.trDetails').find('.inputKemu').val();
			var mcMoney = parseFloat($(this).val());
			mcAllMoney += mcMoney+",";
			mcAllName += mcName+",";
		}
	});
	var documentType =  $("#documentType").val();
	var documentNo = $("#documentNo").val();
	var billDate = $("#billDate").val();
	var enterPno = $("#enterPno").val();
	var docAttach = $("#docAttach").val();
	var digest = $("#digest").val();
	var money = $(".spTotal").text();
	var note = $("#noteBox").val();
	var paramDatas = {
			validFlag:'0',
			bookFlag:'0',
			checkFlag:'1',
			accountPeriod:billDate,
			documentType:documentType,
			documentNo:documentNo,
			billDate:billDate,
			enterPno:enterPno,
			docAttach:docAttach,
			digest:digest,
			mdName:mdAllName,
			mdMoney:mdAllMoney,
			mcName:mcAllName,
			mcMoney:mcAllMoney,
			money:money,
			note:note
				};
	$.ajax({
		   type: "post",
		   url: "<m:url value='/accounting/addAccounting.do'/>",
		   data: paramDatas,
		   cache: false,
		   dataType:"json",
		   success:function(d){
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
}
</script>
</head>
  
<body>

<div id="editDialog">
	<form id="accountingFormEdit" >
	<div id="divBody" style="min-height: 400px;" >
		<input type="hidden" id="edit_id" name="id" type="text" value="${accounting.id}"/>
			<div id="VoucherHeader" style="height: auto;">
	            <div class="headerMain" style="width: 1000px; height: 60px; line-height: 60px;">
	                <div style="margin-left: 20px; float: left;">
	                	<select class="input_select" name="documentType" id="documentType" mainid="documentType" style="width:50px">
						<option value="收款凭证">收</option><option value="付款凭证">付</option><option value="转账凭证">转</option>
						</select>字第  <input name="documentNo" id="documentNo" type="number" class="text" style="width:40px;text-align: center;">  号</div>
	                <div style="margin-left: 120px; float: left;"><span>制单日期&nbsp;&nbsp;</span><div class="time_bg" style="top: 15px; height: 25px;line-height: 25px;">
							<input id="billDate" type="text" class="search_time150" name="billDate" mainid="billDate" style="height: 25px;">
							<i class="search_time_ico2" style="top:6px;"></i></div> </div>
	                <div id="VoucherFooter" style="margin-left: 120px; float: left;">
	                		<input id="enterPno" name="enterPno" type="hidden" value="${user.id}"><span id="enterPname">制单人：${user.fullName}</span></div>	                
	                <div title="点击录入备注" id="divNote" onclick="noteBoxShow();">
	                	<span></span><textarea id="noteBox" class="noteBox" name="note" onblur="hide(this);">${accountFlow.note}</textarea></div>
	                <div style="float: right; margin-right: 20px;">附单据&nbsp;<input type="text" id="docAttach" name="docAttach" class="text" style="width:50px;">&nbsp;张</div>
	            </div>
	        </div>
	
			<!--表头开始  -->
            <table id="tableVoucherHeader" style="border:#dadada 1px solid; width: 960px; margin-left: 20px; line-height: 60px; border-collapse: collapse; text-align: center;">
                <tbody><tr id="VoucherTopRow" style="background: white;">
                <td style="width: 209px;">摘要</td><td style="width: 308px;">会计科目</td>
                    <td style="width: 219px;">
                        <div>借方金额</div>
                        <div class="moneyUint" >
                            <span>亿</span> <span>千</span> <span>百</span> <span>十</span> <span>万</span> <span>千</span>
                            <span>百</span> <span>十</span> <span>元</span> <span>角</span> <span class="last">分</span>
                        </div>
                    </td>
                    <td class="tdLast" style="width: 220px;">
                        <div> 贷方金额</div>
                        <div class="moneyUint">
                            <span>亿</span> <span>千</span> <span>百</span> <span>十</span> <span>万</span> <span>千</span>
                            <span>百</span> <span>十</span> <span>元</span> <span>角</span> <span class="last">分</span>
                        </div> </td> </tr></tbody></table><!--表头结束  -->
            <!--表体开始 -->
            <table id="tableVoucher" style="width:960px; margin-left: 20px; line-height: 60px; border-collapse: collapse; text-align: center;">
                <tbody>   
	                <tr class="trDetails" >
			            <td class="tdZhaiyao" style="width: 208px;">
			                <div class="InputText" style="display: block;"><textarea  maxlength="45" type="text" class="inputZhaiYao" name="digest" id="digest" onclick="showDigestList(this);"  ondblclick="hideDigestList();">${accountFlow.accountName}</textarea></div>
			            	<div class="digestList" >
			           			<ul class="allDigestList" style="position:absolute" >
			           			<c:forEach var="digestList" items="${digestList}">
			           				<li aname="${digestList.accountName}" onclick="fillAccountName(this);">${digestList.accountName}</li>
			           			</c:forEach>
			           			</ul>
			           		</div>
			            </td>
			            <td class="tdKemu" style="width: 307px;" >
		                    <div class="InputText" style="display: block;"><textarea maxlength="45" type="text" class="inputKemu" name="accountName" onclick="showAccountList(this);" ondblclick="hideAccountList();"></textarea></div>
			           		<div class="accountList" >
			           			<ul class="allAccountList" style="position:absolute" >
			           			<c:forEach var="accountList" items="${accountList}">
			           				<li aid="${accountList.accountId}" aname="${accountList.accountName}" onclick="fillAccount(this);">${accountList.accountId} - ${accountList.accountName}</li>
			           			</c:forEach>
			           			</ul>
			           		</div>
			            </td>
			            <td class="tdJieFang" style="width: 220px" >
			              	<div class="DisplayText DisplayMoney" style="display: block;" onmouseover="changeHide(this)"><span class="DisplayJieFang" ></span></div>
			                <div class="InputText hide" onmouseout="fillNum(this)"><input type="text" class="inputJieFang" name="mdMoney" ></div>
			            </td>
			            <td class="tdLast tdDaiFang" style="width: 220px;position:relative" >
			             	<div class="DisplayText DisplayMoney" style="display: block;" onmouseover="changeHide(this)"><span class="DisplayDaiFang" ></span></div>
			                <div class="InputText hide" onmouseout="fillNum(this)"><input type="text" class="inputDaiFang" name="mcMoney" ></div>
			                	<div style="width:40px;display:inline-block;float: right;position:absolute;left:225px;top:0px">
					                <i title="添加一行" style="display: inline-block;cursor:pointer;position: relative;top:5px;" class="icon_bg icon_add" onclick="addtrDetails()"> </i>
									<i title="删除一行" style="display: inline-block;cursor:pointer;position: relative;top:5px;" class="icon_bg icon_del" onclick="deltrDetail(this)"> </i></div>
			            </td>
	        		</tr>   
	        		   
	        		<tr class="trTotal">
	                    <td colspan="2" style="width: 250px; text-align: left">
	                        <div style="margin-left: 100px; font-weight: bold;">
	                           	 总计: <span style="font-size: 13px;" class="spTotal"></span>
	                        </div>
	                    </td>
	                    <td style="width: 220px;">
	                        <div class="TotalDisplayText DisplayMoney">
	                            <span class="totalDebit">&nbsp;</span>
	                        </div>
	                    </td><td class="tdLast" style="width: 220px;">
	                    <div class="TotalDisplayText DisplayMoney"><span class="totalCredit">&nbsp;</span></div>
	                    </td></tr></tbody></table><!--表体结束 -->
            
            		<div class="inputTd"  style="text-align:center;">
						<input id="submit" type="button" class="ti_bottom" value="保存"/>
						<input id="reset" type="button" class="ti_bottom" value="重置"/>
					</div>
        </div>
	</form>
</div>

</body>
</html>
