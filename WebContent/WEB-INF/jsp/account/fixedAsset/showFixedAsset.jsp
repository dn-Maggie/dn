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
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/styles/extends/css/fixedAsset.css"/>
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

<div id="editDialog">
	<form id="fixedAssetFormEdit" >
    <div class="wrap" >
    	<div class="top_head">
			<h2 class="top_name">固定资产</h2>
			<div class="time_bg" style="top:40px; right:0px;height: 25px;line-height: 25px;position:absolute;">
				<span>录入日期&nbsp;&nbsp;</span>
				<input id="edit_currdate" type="text" class="search_time150" name="currdate" mainid="currdate" style="height: 25px;" value="${fixedAsset.currdate}"readonly>
				<i class="search_time_ico2" style="top:6px;"></i>
			</div> 
		</div>
		<input type="hidden" id="edit_id" name="id" type="text" value="${fixedAsset.id}"/>
		<table class="table">
			<tr ><td colspan="4" class="cut"><i class="icon_bg icon_plan"></i> 基本信息</td></tr>
			<tr>
				<td class="inputLabelTd"><span class="required">*</span>资产编号：</td>
				<td class="inputTd">
					<input id="edit_assetNo" name="assetNo" type="text" class="text" value="${fixedAsset.assetNo}" readonly/>
				</td>
				<td class="inputLabelTd">会计期间：</td>
				<td class="inputTd">
					<input id="edit_enterDate" type="text" class="text" style="background: #eeeeee" value="${fixedAsset.enterDate}" readonly />
					<input name="enterDate" id="enterDate" type="hidden" class="text" value="${fixedAsset.enterDate}"/>
				</td>
				<td class="inputLabelTd">增加方式：</td>
				<td class="inputTd">
					<select class="input_select text" name="addType" id="edit_addType" mainid="addType" disabled="disabled">
							<option value="${fixedAsset.addType}">${fixedAsset.addType}</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd"><span class="required">*</span>资产名称：</td>
				<td class="inputTd">
					<input id="edit_assetName" name="assetName" type="text" class="text" value="${fixedAsset.assetName}" readonly/>
				</td>
				<td class="inputLabelTd"><span class="required">*</span>资产类别：</td>
				<td class="inputTd">
					<select class="input_select text" name="assetType" id="edit_assetType" mainid="assetType" disabled="disabled">
							<option value="${fixedAsset.assetType}">${fixedAsset.assetType}</option>
					</select>
				</td>
				<td class="inputLabelTd">规格型号：</td>
				<td class="inputTd">
					<input id="edit_model" name="model" type="text" class="text" value="${fixedAsset.model}" readonly/>
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd"><span class="required">*</span>开始使用日期：</td>
				<td class="inputTd">
					<div class="time_bg">
						<input type="text" class="valid text" name="beginDate" id="edit_beginDate" mainid="beginDate" value="${fixedAsset.beginDate}" disabled="disabled"><!-- 时间选择控件-->
						<i class="search_time_ico2" style="display:inline-block;top:8px"></i>
					</div>
				</td>
				<td class="inputLabelTd"><span class="required">*</span>使用部门：</td>
				<td class="inputTd">
					<select class="input_select text" name="useOrg" id="edit_useOrg" mainid="useOrg" disabled="disabled">
							<option value="${fixedAsset.useOrg}">${fixedAsset.useOrg}</option>
				    </select>
				</td>
				<td class="inputLabelTd">使用人：</td>
				<td class="inputTd">
					<input id="edit_applyName" name="applyName" type="text" class="text" value="${fixedAsset.applyName}" readonly/>
				</td>
			</tr>
			<tr  ><td colspan="4" class="cut"><i class="icon_bg icon_plan"></i> 折旧方式</td></tr>
			<tr>
				<td class="inputLabelTd"><span class="required">*</span>折旧方法：</td>
				<td class="inputTd">
					<select class="input_select text" name="depreMethod" id="edit_depreMethod" mainid="depreMethod" disabled="disabled">
							<option value="1" <c:if test="${fixedAsset.depreMethod=='1'}">selected</c:if>>平均年限法</option>
							<option value="2" <c:if test="${fixedAsset.depreMethod=='2'}">selected</c:if>>不折旧</option>
					</select>
				</td>
				<td class="inputLabelTd"><span class="required">*</span>当期是否折旧：</td>
				<td class="inputTd">
					<label class="radio"><input type="radio" name="isDeprenow" id="edit_isDeprenow1" value="是"  disabled="disabled"<c:if test="${fixedAsset.isDeprenow=='是'}">checked</c:if>>是</label>
					<label class="radio"><input type="radio" name="isDeprenow" id="edit_isDeprenow2" value="否" disabled="disabled"<c:if test="${fixedAsset.isDeprenow=='否'}">checked</c:if>>否</label>			
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd"><span class="required">*</span>累计折旧科目：</td>
				<td class="inputTd">
					<select class="input_select text" name="ljzjSubject" id="edit_ljzjSubject" mainid="ljzjSubject">
							<option value="累计折旧">累计折旧</option>
					</select>
				</td>
				<td class="inputLabelTd"><span class="required">*</span>折旧费用科目：</td>
				<td class="inputTd">
					<input id="edit_zjfySubject" name="zjfySubject" type="text" class="text" value="管理费用-折旧费" readonly value="${fixedAsset.zjfySubject}"/>
				</td>
				<td class="inputLabelTd"><span class="required">*</span>资产清理科目：</td>
				<td class="inputTd">
					<select class="input_select text" name="zichanClear" id="edit_zichanClear" mainid="zichanClear">
							<option value="固定资产清理">固定资产清理</option>
					</select>
				</td>
			</tr>
			<tr  ><td colspan="4" class="cut"><i class="icon_bg icon_plan"></i> 资产数据</td></tr>
			<tr>
				<td class="inputLabelTd"><span class="required">*</span>资产原值：</td>
				<td class="inputTd">
					<input id="edit_initialValue" name="initialValue" type="text" class="text" value="${fixedAsset.initialValue}" readonly/>
				</td>
				<td class="inputLabelTd"><span class="required">*</span>残值率：</td>
				<td class="inputTd">
					<input id="edit_remainRatio" name="remainRatio" type="text" class="text" value="${fixedAsset.remainRatio}" readonly/>&nbsp;%
				</td>
				<td class="inputLabelTd">预计残值：</td>
				<td class="inputTd">
					<input id="edit_remainValue" name="remainValue" type="text" class="text" style="background: #eeeeee" value="${fixedAsset.remainValue}" readonly/>
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd"><span class="required">*</span>预计使用月份：</td>
				<td class="inputTd">
					<input id="edit_usePeriod" name="usePeriod" type="text" class="text" value="${fixedAsset.usePeriod}" readonly/>
				</td>
				<td class="inputLabelTd"><span class="required">*</span>已折旧月份：</td>
				<td class="inputTd">
					<input id="edit_depredMonth" name="depredMonth" type="text" class="text" value="${fixedAsset.depredMonth}" readonly/>
				</td>
				<td class="inputLabelTd">剩余使用月份：</td>
				<td class="inputTd">
					<input id="edit_remainUseMonth" name="remainUseMonth" type="text" class="text" value="${fixedAsset.remainUseMonth}" style="background: #eeeeee" readonly/>
				</td>
			</tr>
			<tr>
				<td class="inputLabelTd"><span class="required">*</span>累计折旧：</td>
				<td class="inputTd">
					<input id="edit_usedDepre" name="usedDepre" type="text" class="text" value="${fixedAsset.usedDepre}" readonly/>
				</td>
				<td class="inputLabelTd"><span class="required">*</span>每月折旧额：</td>
				<td class="inputTd">
					<input id="edit_perDepred" name="perDepred" type="text" class="text" style="background: #eeeeee" value="${fixedAsset.perDepred}" readonly/>
				</td>
				<td class="inputLabelTd">备注：</td>
				<td class="inputTd">
					<input id="edit_note" name="note" type="text" class="text" readonly/>
				</td>
			</tr>
		</table>
    </div>
	</form>
</div>
</body>
</html>
