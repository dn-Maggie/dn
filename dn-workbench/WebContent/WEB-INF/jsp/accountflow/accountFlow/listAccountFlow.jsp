<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<%@page import="com.dongnao.workbench.common.enums.FinanceType"%>
<!DOCTYPE HTML>
<html>
<head>
<%@ include file="../../common/header.jsp"%>
<title></title>
<script type="text/javascript">
	var lendTable = {};
	var loanTable={};
	var showUrl = ""
	var jsion_sumColumns = {};	
	jsion_sumColumns["sumColumns"] = "rn,money";   //总计
	
	$(function() {
		$("#endDate").val(new Date().format('yyyy-MM-dd'));
		var showType = $("#showType").val();
		if(showType=="monthcost"||showType=="yearcost"){
			showUrl="<m:url value='/accountFlow/listAccountFlowCost.do'/>";
		}else{
			showUrl="<m:url value='/accountFlow/listAccountFlow.do'/>";
		}
		lendTable = new biz.grid({
			id : "#lend_table",/*html部分table id*/
// 			url : "<m:url value='/accountFlow/listAccountFlow.do'/>",/*grid初始化请求数据的远程地址*/
			url:showUrl,
			datatype : "json",/*数据类型，设置为json数据，默认为json*/
			sortname : "create_date",
			sortorder : "desc",
			autowidth:true,
			shrinkToFit:true,
			footerrow:true,
			pager : '#remote_prowed1' /*分页栏id*/,
			rowList : [ 10, 20, 50, 100 ],//每页显示记录数
			rowNum : 20,//默认显示15条
			colModel : [ {
				name : "id",
				hidden : true,
				key : true,
				label : "财务流水id",
				index : "id"
			}, {
				name : "accountId",
				hidden : true,
				label : "科目id",
				index : "account_id"
			}, {
				name : "accountNo",
				label : "科目编号",
				index : "account_no",
				width:'20',
			}, {
				name : "accountName",
				label : "科目名称",
				index : "account_name",
				width:'20',
			}, {
				name : "createDate",
				label : "发生时间",
				index : "create_date",
				width:'30',
			}, {
				name : "money",
				label : "发生金额",
				index : "money",
				width:'20',
			}, {
				name : "note",
				label : "备注",
				index : "note",
				width:'60',
			} ],
			serializeGridData : function(postData) {//添加查询条件值
				var obj2 ={};
				obj2.accountType="1";
				var obj = getQueryCondition();
				$.extend(true, obj, postData,obj2);//合并查询条件值与grid的默认传递参数
				return obj;
				$("#gview_remote_rowed").setGridWidth($(window).width()*0.98);
			},
	  		gridComplete:function(){
               	getFooterJsonData($(this));
	 		}	
		});	
			loanTable = new biz.grid({
				id : "#loan_table",/*html部分table id*/
//	 			url : "<m:url value='/accountFlow/listAccountFlow.do'/>",/*grid初始化请求数据的远程地址*/
				url:showUrl,
				datatype : "json",/*数据类型，设置为json数据，默认为json*/
				sortname : "create_date",
				sortorder : "desc",
				footerrow:true,
				pager : '#remote_prowed2' /*分页栏id*/,
				rowList : [ 10, 20, 50, 100 ],//每页显示记录数
				
				rowNum : 20,//默认显示15条
				colModel : [ {
					name : "id",
					hidden : true,
					key : true,
					label : "财务流水id",
					index : "id"
				}, {
					name : "accountId",
					hidden : true,
					label : "科目id",
					index : "account_id"
				}, {
					name : "accountNo",
					label : "科目编号",
					index : "account_no",
					width:'20',
				}, {
					name : "accountName",
					label : "科目名称",
					index : "account_name",
					width:'20',
				}, {
					name : "createDate",
					label : "发生时间",
					index : "create_date",
					width:'30',
				}, {
					name : "money",
					label : "发生金额",
					index : "money",
					width:'20',
				}, {
					name : "note",
					label : "备注",
					index : "note",
					width:'60',
				} ],
				serializeGridData : function(postData) {//添加查询条件值
					postData.accountType=2;
					var obj = getQueryCondition();
					$.extend(true, obj, postData);//合并查询条件值与grid的默认传递参数
					return obj;
				},
		  		gridComplete:function(){
	               	getFooterJsonData($(this));
		 		}	 
				
		});

		new biz.datepicker({
			id : "#create_date",
			dateFmt : 'yyyy-MM-dd'
		});
		
		new biz.datepicker({
  			id : "#startDate",
  			maxDate:'#F{$dp.$D(\'endDate\',{d:0});}',
  			dateFmt:'yyyy-MM-dd'
  		});
  	    
  	    new biz.datepicker({
  			id : "#endDate",
  			minDate:'#F{$dp.$D(\'startDate\',{d:0});}',
  			dateFmt:'yyyy-MM-dd'
  		});
		
		/* $.ajax({
			url : "<m:url value='/accountFlow/getTotal.do'/>",
			success : function(result) {
				var data = {};
				data = eval("("+result+")");
				data = data.money;
				$("#lend_text").text(data.lend);
				$("#loan_text").text(data.loan);
				$("#total_text").text(data.total);
			}
		}); */
	});

	//新增的弹出框
	var add_iframe_dialog;
	//修改的弹出框
	var edit_iframe_dialog;
	//查看的弹出框
	var show_iframe_dialog;
	//查看的弹出框
	var account_iframe_dialog;
	//查看的弹出框
	var count_iframe_dialog;

	function add() {
		//xin zeng iframe 弹出框
		var url = "<m:url value='/accountFlow/toAddAccountFlow.do'/>";
		add_iframe_dialog = new biz.dialog(
				{
					id : $('<div id="addwindow_iframe"></div>')
							.html(
									'<iframe id="iframeAdd" name="iframeAdd" src="'
											+ url
											+ '" width="100%" frameborder="no" border="0" height="97%"></iframe>'),
					modal : true,
					width : 800,
					height : 285,
					title : "财务流水增加"
				});
		add_iframe_dialog.open();
	}

	//关闭新增页面，供子页面调用
	function closeAdd() {
		add_iframe_dialog.close();
	}

	function edit() {
		var key = ICSS.utils.getSelectRowData("id");
		if (key.indexOf(",") > -1 || key == "") {
			showMessage("请选择一条数据！");
			return;
		}
		var url = "<m:url value='/accountFlow/toEditAccountFlow.do'/>?key="
				+ key;
		edit_iframe_dialog = new biz.dialog(
				{
					id : $('<div id="editwindow_iframe"></div>')
							.html(
									'<iframe id="iframeEdit" name="iframeEdit" src="'
											+ url
											+ '" width="100%" frameborder="no" border="0" height="97%"></iframe>'),
					modal : true,
					width : 800,
					height : 285,
					title : "财务流水编辑"
				});
		edit_iframe_dialog.open();
	}

	//关闭编辑页面，供子页面调用
	function closeEdit() {
		edit_iframe_dialog.close();
	}

	function show() {
		var key = ICSS.utils.getSelectRowData("id");
		if (key.indexOf(",") > -1 || key == "") {
			showMessage("请选择一条数据！");
			return;
		}
		var url = "<m:url value='/accountFlow/toShowAccountFlow.do'/>?key="
				+ key;
		show_iframe_dialog = new biz.dialog(
				{
					id : $('<div id="showwindow_iframe"></div>')
							.html(
									'<iframe id="iframeShow" name="iframeShow" src="'
											+ url
											+ '" width="100%" frameborder="no" border="0" height="97%"></iframe>'),
					modal : true,
					width : 800,
					height : 235,
					title : "财务流水详情"
				});
		show_iframe_dialog.open();
	}

	//关闭查看页面，供子页面调用
	function closeShow() {
		show_iframe_dialog.close();
	}
	
	function account() {
		var key = lendTable.getGridParam('selarrrow');
		key += loanTable.getGridParam('selarrrow');
		if (key.indexOf(",") > -1 ||key == "") {
			showMessage("请选择一条数据！");
			return;
		}
		//xin zeng iframe 弹出框
		var url = "<m:url value='/accountFlow/toAddNewAccounting.do'/>?key="
			+ key;

		account_iframe_dialog = new biz.dialog(
				{
					id : $('<div id="accountwindow_iframe"></div>')
							.html(
									'<iframe id="iframeAdd" name="iframeAdd" src="'
											+ url
											+ '" width="100%" frameborder="no" border="0" height="97%"></iframe>'),
					modal : true,
					width : 1040,
					height : 705,
					title : "新增会计凭证"
				});
		account_iframe_dialog.open();
	}

	//关闭新增页面，供子页面调用
	function closeAccount() {
		account_iframe_dialog.close();
	}
	
	function count() {
		//xin zeng iframe 弹出框
		var url = "<m:url value='/accountFlow/toCountAll.do'/>";
		count_iframe_dialog = new biz.dialog(
				{
					id : $('<div id="countwindow_iframe"></div>')
							.html(
									'<iframe id="iframeAdd" name="iframeAdd" src="'
											+ url
											+ '" width="100%" frameborder="no" border="0" height="97%"></iframe>'),
					modal : true,
					width : 800,
					height : 685,
					title : "财务报表"
				});
		count_iframe_dialog.open();
	}

	//关闭新增页面，供子页面调用
	function closeCount() {
		count_iframe_dialog.close();
	}
	
	/**
	 * 获取查询条件值
	 */
	function getQueryCondition() {
		var obj = {};
		jQuery.each($("#queryForm").serializeArray(), function(i, o) {
			if (o.value) {
				obj[o.name] = o.value;
			}
		});
		return obj;
	}
	//查询Grid数据
	function doSearch(isStayCurrentPage) {
		if (!isStayCurrentPage)
			lendTable.setGridParam({
				"page" : "1"
			});
		lendTable.trigger('reloadGrid');
		doSearchForLoan(isStayCurrentPage);
	}
	//查询Grid数据
	function doSearchForLoan(isStayCurrentPage) {
		if (!isStayCurrentPage)
			loanTable.setGridParam({
				"page" : "1"
			});
		loanTable.trigger('reloadGrid');
	}
	//重置查询表单
	function resetForm(formId) {
		document.getElementById(formId).reset();
	}

	//删除
	function batchDelete() {
		var ids = ICSS.utils.getSelectRowData("id");
		if (ids == "") {
			showMessage("请至少选择一条数据！");
			return;
		} else {
			new biz.alert(
					{
						type : "confirm",
						message : I18N.msg_del_confirm,
						title : I18N.promp,
						callback : function(result) {
							if (result) {
								$
										.ajax({
											url : "<m:url value='/accountFlow/deleteAccountFlow.do'/>?key="
													+ ids,
											cache : false,
											success : function(data,
													textStatus, jqXHR) {
												doSearch();
												showInfo("删除成功", 3000);
											}
										});
							}
						}
					});
		}
	}
	//总计
  	//@param jqGridObj
	  function getFooterJsonData(jqGridObj){
	  	var addFootData = {} ;
	  	var resObj = ajaxGetStatistic();
		if(jqGridObj[0].id=="lend_table"){
			var _strColumns = jsion_sumColumns.sumColumns.split(",");
            for(var k = 0;k<_strColumns.length; k++){
            	k == 0?addFootData[_strColumns[k]] = "总计":addFootData[_strColumns[k]] = Math.round(resObj.lend) ||0;
            }
		}else{
			var _strColumns = jsion_sumColumns.sumColumns.split(",");
            for(var k = 0;k<_strColumns.length; k++){
            	k == 0?addFootData[_strColumns[k]] = "总计":addFootData[_strColumns[k]] = Math.round(resObj.loan) ||0;
            }
		}
   			jqGridObj.jqGrid('footerData','set',addFootData,false);
  	}
	
	//根据条件从数据库获取结果集
	function ajaxGetStatistic(){
		var resObj = {};
		var paramArray = [];
		var paramObj = {};
            paramObj.accountName = $("#accountName").val()||"";
            paramObj.accountNameExcept = $("#accountNameExcept").val()||"";
            paramObj.accountNameInclude= $("#accountNameInclude").val()||"";
            paramObj.subjectName= $("#subjectName").val()||"";
            paramObj.startDate= $("#startDate").val()||"";
            paramObj.endDate= $("#endDate").val()||"";
            paramArray.push(paramObj);
       	$.ajax({
   			url : "<m:url value='/accountFlow/getTotal.do'/>",
   			type: 'post',
               dataType:"json",
               cache: false,
               async : false,
               data: JSON.stringify(paramArray),
	   		processData: false,// 告诉jQuery不要去处理发送的数据
            contentType: false, // 告诉jQuery不要去设置Content-Type请求头
   			success : function(data) {
   				if(data.money){
	   				resObj.lend= parseFloat(data.money.lend-data.money.xftk);
	   				resObj.loan = parseFloat(data.money.loan);
   				}
   			}
   		});
       	return resObj;
	};
</script>
</head>
<body style="height: 100%;">
	<div class="main  choice_box">
		<form id="queryForm">
		<input type="hidden"  id="showType" value="${condition}">
			<!-- 查询区 表单 -->
			<div class="search border-bottom">
				<ul>
					<li>
						<c:choose>
							<c:when test="${condition=='majorIncome'||condition=='monthmajorIncome'}">
								<input type="text" name="accountName" id="accountName" class="search_choose" >
								<input type="hidden" name="accountNameInclude" id="accountNameInclude" class="search_choose" value="学费收入,学费补款,学费退款">
							</c:when>
							<c:when test="${condition=='monthactualPay'||condition=='yearactualPay' }">
								<input type="text" name="accountName" id="accountName" class="search_choose" value='学费收入'>
							</c:when>
							<c:when test="${condition=='QTSR'}">
								<input type="text" name="accountName" id="accountName" class="search_choose" value='其他收入'>
							</c:when>
							<c:when test="${condition=='QT'}">
								<input type="text" name="accountName" id="accountName" class="search_choose" value='其他支出'>
							</c:when>
							<c:when test="${condition=='monthcost'||condition=='yearcost'}">
								<input type="text" name="accountName" id="accountName" class="search_choose">
							</c:when>
							<c:when test="${condition=='monthxftk'||condition=='yearxftk'}">
								<input type="text" name="accountName" id="accountName" class="search_choose" value='学费退款'>
							</c:when>
							<c:when test="${condition=='majorCost'}">
								<input type="text" name="accountName" id="accountName" class="search_choose">
								<input type="hidden" name="accountNameExcept" id="accountNameExcept" class="search_choose" value="其他支出">
							</c:when>
							<c:when test="${condition=='allCost'}">
								<input type="text" name="accountName" id="accountName" class="search_choose">
								<input type="hidden" name="accountNameExcept" id="accountNameExcept" class="search_choose" value=" ">
							</c:when>
							<c:otherwise>
								<input type="text" name="accountName" id="accountName" class="search_choose">
							</c:otherwise>
						</c:choose>
						 <span>科目名称:</span></li>
						<li style="width:180px;">
						<select class="search_choose" name="isAccount" id="isAccount" mainid="isAccount" style="width:100px;">
							<option value="">--请选择--</option>
							<option value="1">未清算</option>
							<option value="2">已清算</option>
						</select><span>是否清算:</span>
				<!--  <input type="text" name="subjectId" id="subjectId" class="search_choose"> -->
					</li><!-- 输入框-->
					<li style="width:160px;">
						<select class="search_choose" name="subjectName" id="subjectName" mainid="subjectName" style="width:88px;">
						<option value="">-请选择-</option>
						<c:forEach var="mr" items="${er.subject}">
							<option value="${mr.name}"> <c:out value="${mr.name}"></c:out> </option>
			            </c:forEach>
					</select><span>学科:</span>
					</li><!-- 输入框-->
					<!-- 输入框-->
					<li class="date_area">
					<span>发生日期:</span>
					<div class="time_bg">
						<c:choose>
							<c:when test="${condition=='monthcost'||condition=='monthxftk'||condition=='monthmajorIncome'||condition=='monthactualPay'}">
								<input id="startDate" type="text" class="search_time150" name="propsMap['startDate']" mainid="startDate" value="${currDate}">
							</c:when>
							<c:when test="${condition=='yearcost'||condition=='yearxftk'||condition=='allCost'||condition=='QT'||condition=='majorIncome'||condition=='QTSR'||condition=='majorCost'||condition=='yearactualPay'}">
								<input id="startDate" type="text" class="search_time150" name="propsMap['startDate']" mainid="startDate" value="${currDate}">
							</c:when>
							<c:otherwise>
								<input id="startDate" type="text" class="search_time150" name="propsMap['startDate']" mainid="startDate">
							</c:otherwise>
						</c:choose>
						<i class="search_time_ico2"></i>
					</div>
					<i>至</i>
					<div class="time_bg">
						<input id="endDate" type="text" class="search_time150" name="propsMap['endDate']" mainid="endDate">
						<i class="search_time_ico2"></i>
					</div></li>	
					<!--下拉 -->
					<li><input type="reset" class="reset_btn"
						onclick="resetForm('queryForm')" value="重置"> <!-- 重置 --> <input
						type="button" class="search_btn mr22 " onclick="doSearch();"
						value="查询"></li>
					<!-- 查询-->
				</ul>
			</div>
		</form>
		<div class="listplace">
			<!--功能按钮begin-->
			<div class="list_btn_bg fl">
				<!--功能按钮 div-->
				<ul>
					<c:if test="${add}">
						<li><a title="<m:message code="button.add"/>"
							href="javascript:;" onclick="add();"> <i
								class="icon_bg icon_add"> </i> <span><m:message
										code="button.add" /></span>
						</a></li>
					</c:if>
					<c:if test="${account}">
						<li><a title="结转凭证"
							href="javascript:;" onclick="account();"> <i
								class="icon_bg icon_add"> </i> <span>结转凭证</span>
						</a></li>
					</c:if>
					<c:if test="${count}">
						<li><a title="查看总计"
							href="javascript:;" onclick="count();"> <i
								class="icon_bg icon_ckxq"> </i> <span>查看总计</span>
						</a></li>
					</c:if>
				</ul>
			</div>

			<!--功能按钮end-->
			<div class="listtable_box" style="position:relative">
				<!--此处放表格-->
						<c:choose>
							<c:when test="${condition=='majorIncome'||condition=='QTSR'||condition=='monthmajorIncome'||condition=='yearactualPay'||condition=='monthactualPay'}">
								<div style="display:inline-block;width:100%;">
									<table id="lend_table"></table>
									<div id="remote_prowed1"></div>
								</div>
							</c:when>
							<c:when test="${condition=='monthxftk'||condition=='yearxftk'||condition=='monthcost'||condition=='yearcost'||condition=='majorCost'||condition=='QT'||condition=='allCost'}">
								<div style="display:inline-block;width:100%;position:absolute">
									<table id="loan_table"></table>
									<div id="remote_prowed2"></div>
								</div>
							</c:when>
							<c:otherwise>
								<div style="display:inline-block;width:49%;margin-right:15px;">
									<table id="lend_table"></table>
									<div id="remote_prowed1"></div>
								</div>
								<div style="display:inline-block;width:49%;position:absolute">
									<table id="loan_table"></table>
									<div id="remote_prowed2"></div>
								</div>
							</c:otherwise>
						</c:choose>
			</div>
			
		</div>
	</div>
			<!-- <div id="total" style="position:fixed;bottom:0px;width:600px;left:50%;margin-left:-250px">
				<div id="lend" style="width:33%;float:left">借[收入]：<span id="lend_text" ></span></div>
				<div id="loan" style="width:33%;float:left">贷[支出]：<span id="loan_text"></span></div>
				<div id="total" style="width:33%;float:left">余额情况：<span id="total_text"></span></div>
			</div>  -->
</body>
</html>
