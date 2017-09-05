<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="./WEB-INF/jsp/common/header.jsp"%>
	<link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
</head>
<style type="text/css">
	
.paddingZero{
	padding-right:0px;
	padding-left:0px;
}
.ee{
	padding-right: 0px;
    padding-left: 29px;
}
</style>
<script type="text/javascript">
$(function() {
	//绑定提交按钮click事件
	$("#submit").click(function() {
		/* showMessage("正在处理..."); */
		if($.trim($("#edit_content").val())==""){
			showWarn("内容不能为空",3000);
			return;
		}
		var paramObj = {};
		paramObj.content = $.trim($("#edit_content").val());
		$.ajax({
			 url : "<m:url value='/common/addSurvey.do'/>",
             type: 'post',
             dataType:"json", 
             data: JSON.stringify(paramObj),
             processData: false,// 告诉jQuery不要去处理发送的数据
             contentType: false, // 告诉jQuery不要去设置Content-Type请求头
             success : function(d) {
					if(d.status == '1'){
						showMessage(d.message,3000);
						window.location.href = "thanks.jsp";
					}else{
						showMessage(d.message);
					}
			}
         });
	});

});
</script>

  
<body>
<div class="container paddingZero">
	<div class="row ee">
		<div class="paddingZero col-xs-12 col-sm-12 col-md-12 col-lg-12" style="text-align:center;margin-top:15px;">
			<h5>员工意见收集</h5>
		</div>
		<div class="paddingZero col-xs-12 col-sm-12 col-md-12 col-lg-12">
			<form id="surveyForm" border='0'>
		  <!--   <div class="ui-table ui-widget ui-corner-all ui-border" > -->
				<table class="table">
					<tr>
						<td class="inputTd" style="text-align:center;border-style:none">
							<textarea id="edit_content" name="content"  class="textarea" placeholder="请在此处输入内容..."></textarea>
						</td>
					</tr>
					<tr>
						<td class="inputTd" colspan="4" style="text-align:center;height:80px;border-style:none">
							<!-- <input id="submit" type="button" class="ti_bottom" style="min-width:100px;" value="提交"/> -->
							<input id="submit" type="button" class="" style="min-width:100px;min-height:40px;font-size:26px;" value="提交"/>
						</td>
					</tr>
				</table>
		   <!--  </div> -->
		</form>
		</div>
	</div>
</div>
	
</body>
<script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdn.bootcss.com/popper.js/1.12.3/umd/popper.min.js" integrity="sha384-vFJXuSJphROIrBnz7yo7oB41mKfc8JzQZiCq4NCceLEaO4IHwicKwpJf9c9IpFgh" crossorigin="anonymous"></script>
<script src="https://cdn.bootcss.com/bootstrap/4.0.0-beta/js/bootstrap.min.js" integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1" crossorigin="anonymous"></script>
</html>
