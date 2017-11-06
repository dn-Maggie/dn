<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="./WEB-INF/jsp/common/header.jsp"%>
	<meta charset="utf-8">
</head>
<script type="text/javascript">
$(function() {
	//绑定提交按钮click事件
	$("#submit").click(function() {
		$.ajax({
			 url : "<m:url value='/base/main.do'/>",
             processData: false,// 告诉jQuery不要去处理发送的数据
             contentType: false, // 告诉jQuery不要去设置Content-Type请求头
         });
	});

});
</script>

  
<body>
	<input id="submit" type="button" class="" style="min-width:100px;min-height:40px;font-size:26px;" value="生成"/>
</body>
</html>
