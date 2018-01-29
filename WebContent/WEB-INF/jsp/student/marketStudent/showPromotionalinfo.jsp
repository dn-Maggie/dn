<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html  >
<html>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<head>
<base href="<%=basePath%>">

<%@ include file="../../common/header.jsp"%>
<script type="text/javascript">
	$(function() {
		//绑定提交按钮click事件
		$("#close_button").click(function() {
			window.parent.closeShow();
		});
	});
</script>
</head>
  
<body>
	<div class="ui-table ui-widget ui-corner-all ui-border">
		<table class="table forview">
			<tr>
				<td class="inputLabelTd">录入人：</td>
				<td class="inputTd">${user}</td>
				<td class="inputLabelTd">录入时间：</td>
				<td class="inputTd">${pi.entry_time}</td>
			</tr>
			<tr>
				<td class="inputLabelTd">QQ号码：</td>
				<td class="inputTd">${pi.qq}</td>
				<td class="inputLabelTd">意向学科：</td>
				<td class="inputTd">
					<select disabled="disabled">
						<c:forEach var="mr" items="${subjectList}">
							<option value="${mr.id}" <c:if test="${pi.subjectid==mr.id}">selected</c:if> > <c:out value="${mr.name}"></c:out> </option>
			             </c:forEach>
			       	</select>
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd">意向课程：</td>
				<td class="inputTd">${pi.course}</td>
				<td class="inputLabelTd">意向级别：</td>
				<td class="inputTd">${pi.level}</td>
			</tr>
			<tr>	
				<td class="inputLabelTd">是否报名：</td>
				<td class="inputTd">${pi.is_buy}</td>
				<td class="inputLabelTd">辅助转化人：</td>
				<td class="inputTd">${pi.auxiliary}</td>
			</tr>
			<tr>	
				<td class="inputTd" colspan='4' style="padding-left:-2px;">
					<textarea id="edit_notes" name="notes" rows="11" 
					style="width:99%;padding-top:5px;margin-top:4px;" >${pi.notes}</textarea>
				</td>
			</tr>
			<tr>
				<td class="inputTd" colspan="4" style="text-align:center;">
					<input class="ti_bottom"  type="button" id="close_button"  value="关闭"/>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>
