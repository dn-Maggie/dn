<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE HTML  >
<html>
<head>
<%@ include file="../../common/header.jsp"%>
<title></title>
<script type="text/javascript">
var gridObj = {};
	$(function(){
  		gridObj = new biz.grid({
            id:"#remote_rowed",/*html部分table id*/
            url: "<m:url value='/accounting/listAccounting.do'/>",/*grid初始化请求数据的远程地址*/
            datatype: "json",/*数据类型，设置为json数据，默认为json*/
           	sortname:"bill_date",
           	sortorder:"desc",
           	//navtype:"top" /*导航栏类型*/,
           	//height: gridHeight,
           	multiselect:true,
           	multiboxonly:true,
           	pager: '#remote_prowed' /*分页栏id*/,
     		rowList:[10,15,50,100],//每页显示记录数
    		rowNum:10,//默认显示15条
            colModel:[
				{name : "id",hidden : true,key : true,label:"自动编号录入",index : "id"},
// 				{name : "accountPeriod",label:"会计期间",index : "account_period"},	
				{name : "documentType",label:"凭证类别",index : "document_type"},				
// 				{name : "documentNo",label:"凭证序号",index : "document_no"},			
				{name : "digest",label:"摘要",index : "digest"},					
				{name : "mdName",label:"借方科目名称",index : "md_name"},				
				{name : "mdMoney",label:"借方金额",index : "md_money"},			
				{name : "mcName",label:"贷方科目名称",index : "mc_name"},				
				{name : "mcMoney",label:"贷方金额",index : "mc_money"},	
				{name : "money",label:"发生额",index : "money"},	
				{name : "enterPname",label:"制单人"},	
				{name : "billDate",label:"制单日期",index : "bill_date"},		
				{name : "note",label:"备注",index : "note"},	
				{name : "enterPno",hidden:true}
           	],
           	serializeGridData:function(postData){//添加查询条件值
				var obj = getQueryCondition();
    			$ .extend(true,obj,postData);//合并查询条件值与grid的默认传递参数
    			return obj;
    		}
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
    });

 

    //新增的弹出框
	var add_iframe_dialog;
	//审核的弹出框
	var audit_iframe_dialog;
	//修改的弹出框
   	var edit_iframe_dialog;
	//查看的弹出框
	var show_iframe_dialog;
  	
  	function add(){
  	//xin zeng iframe 弹出框
		var url="<m:url value='/accounting/toAddAccounting.do'/>";
		add_iframe_dialog = new biz.dialog({
			id:$('<div id="addwindow_iframe"></div>').html('<iframe id="iframeAdd" name="iframeAdd" src="'+url+'" width="100%" frameborder="no" border="0" height="97%"></iframe>'),  
			modal: true,
			width: 1042,
			height: 705,
			title: "新增会计凭证"
		});
		add_iframe_dialog.open();
  	}
  	
  	//关闭新增页面，供子页面调用
  	function closeAdd(){
		add_iframe_dialog.close();
  	}
  	
    function edit(){
		var key = ICSS.utils.getSelectRowData("id");
		var enterPno = ICSS.utils.getSelectRowData("enterPno");
		if(key.indexOf(",")>-1||key==""){
			showMessage("请选择一条数据！");
			return ;
		}
		var url="<m:url value='/accounting/toEditAccounting.do'/>?key="+key+"&enterPno="+enterPno;
		edit_iframe_dialog = new biz.dialog({
		 	id:$('<div id="editwindow_iframe"></div>').html('<iframe id="iframeEdit" name="iframeEdit" src="'+url+'" width="100%" frameborder="no" border="0" height="97%"></iframe>'),  
			modal: true,
			width: 1042,
			height: 705,
			title: "凭证编辑"
		});
  		edit_iframe_dialog.open();
    }
    
    //关闭编辑页面，供子页面调用
    function closeEdit(){
    	edit_iframe_dialog.close();
    }
    
    function audit(){
    	var key = ICSS.utils.getSelectRowData("id");
    	if(key==""){
    		showMessage("请至少选择一条数据！");
    		return ;
    	}
    	else if(key.indexOf(",")>-1){
    		new biz.alert({type:"confirm",message:"审核以后将无法进行修改，确定继续？",title:I18N.promp,callback:function(result){
    			if(result){
    				$ .ajax({
        				url: "<m:url value='/accounting/auditAccounting.do'/>?key="+key,
        				cache:false,
        				success: function(data, textStatus, jqXHR){
        					doSearch();
    						showInfo("审核成功",3000);
        				}
        			});
    			}
    		}}) ;   
    	}else {
    		var url="<m:url value='/accounting/toAuditAccounting.do'/>?key="+key;
    		audit_iframe_dialog = new biz.dialog({
			 	id:$('<div id="auditwindow_iframe"></div>').html('<iframe id="iframesettlement" name="iframesettlement" src="'+url+'" width="100%" frameborder="no" border="0" height="97%"></iframe>'),  
				modal: true,
				width: 1042,
				height: 705,
				title: "审核凭证"
			});
			audit_iframe_dialog.open();
    	}    	
    }
    
  	//关闭审核页面，供子页面调用
    function closeAudit(){
    	audit_iframe_dialog.close();
    }
  	
    function show(){
    	var key = ICSS.utils.getSelectRowData("id");
		if(key.indexOf(",")>-1||key==""){
			showMessage("请选择一条数据！");
			return ;
		}
		var url="<m:url value='/accounting/toShowAccounting.do'/>?key="+key;
		show_iframe_dialog = new biz.dialog({
		 	id:$('<div id="showwindow_iframe"></div>').html('<iframe id="iframeShow" name="iframeShow" src="'+url+'" width="100%" frameborder="no" border="0" height="97%"></iframe>'),  
			modal: true,
			width: 800,
			height: 235,
				title: "会计凭证详情"
		});
  		show_iframe_dialog.open();
    }
    
    //关闭查看页面，供子页面调用
    function closeShow(){
    	show_iframe_dialog.close();
    }
    /**
    * 获取查询条件值
    */
    function getQueryCondition(){
       var obj = {};
		jQuery.each($("#queryForm").serializeArray(),function(i,o){
        	if(o.value){
        		obj[o.name] = o.value;
        	}
        });
		return obj;
    }
    //查询Grid数据
    function doSearch(isStayCurrentPage){
    	if(!isStayCurrentPage)gridObj.setGridParam({"page":"1"});
    	gridObj.trigger('reloadGrid');
    }
    //重置查询表单
    function resetForm(formId){
		document.getElementById(formId).reset();
	}
    
    //删除
    function batchDelete(){
    	var ids = ICSS.utils.getSelectRowData("id");
    	if(ids==""){
    		showMessage("请至少选择一条数据！");
    		return ;
    	}else{
    		new biz.alert({type:"confirm",message:I18N.msg_del_confirm,title:I18N.promp,callback:function(result){
    			if(result){
    				$ .ajax({
        				url: "<m:url value='/accounting/deleteAccounting.do'/>?key="+ids,
        				cache:false,
        				success: function(data, textStatus, jqXHR){
        					doSearch();
    						showInfo("删除成功",3000);
        				}
        			});
    			}
    		}}) ;   
    	}
    }
    </script>
</head>
<body style="height:100%;">

	<div class="main  choice_box">
		<form id="queryForm"><!-- 查询区 表单 -->
			<div class="search border-bottom">
				<ul>
				<li><input type="text" name="actorName" id="actorName" class="search_choose"> <span>操作人:</span></li><!-- 输入框-->
				<li style="width:180px;">
						<select class="search_choose" name="bookFlag" id="bookFlag" mainid="bookFlag" style="width:100px;">
						<option value="">--请选择--</option>
							<option value="0">未记账</option>
							<option value="1">已记账</option>
					</select><span>是否记账:</span>
				<!--  <input type="text" name="subjectId" id="subjectId" class="search_choose"> -->
				</li><!-- 输入框-->
				<li style="width:180px;">
						<select class="search_choose" name="checkFlag" id="checkFlag" mainid="checkFlag" style="width:100px;">
							<option value="1">未审核</option>
							<option value="2">已审核</option>
					</select><span>审核状态:</span>
				<!--  <input type="text" name="subjectId" id="subjectId" class="search_choose"> -->
				</li><!-- 输入框-->
				<li class="date_area">
					<span>制单日期:</span>
					<div class="time_bg">
						<input id="startDate" type="text" class="search_time150" name="propsMap['startDate']" mainid="startDate">
						<i class="search_time_ico2"></i>
					</div>
					<i>至</i>
					<div class="time_bg">
						<input id="endDate" type="text" class="search_time150" name="propsMap['endDate']" mainid="endDate">
						<i class="search_time_ico2"></i>
					</div></li>	
				<li><input type="reset" class="reset_btn" onclick="resetForm('queryForm')" value="重置"><!-- 重置 -->
						<input type="button" class="search_btn mr22 " onclick="doSearch();" value="查询"></li><!-- 查询-->
				</ul>
		   </div>
	    </form>
		<div class="listplace">
				<!--功能按钮begin-->
				<div class="list_btn_bg fl"><!--功能按钮 div-->
					<ul>
						<c:if test="${add}">
							<li><a title="<m:message code="button.add"/>" href="javascript:;"
								onclick="add();"> <i class="icon_bg icon_add"> </i> <span><m:message
											code="button.add" /></span>
							</a></li>
						</c:if>
						<c:if test="${edit}">
							<li><a title="<m:message code="button.edit"/>" href="javascript:;"
								onclick="edit();"><i class="icon_bg icon_edit"></i> <span><m:message
											code="button.edit" /></span> </a></li>
						</c:if>
						<c:if test="${delete}">
							<li><a title="<m:message code="button.delete"/>" href="javascript:;"
								onclick="batchDelete();"> <i class="icon_bg icon_del"></i> <span><m:message
											code="button.delete" /></span>
							</a></li>
						</c:if>
<%-- 						<li><a title="<m:message code="button.view"/>" href="javascript:" --%>
<%-- 							onclick="show();"> <i class="icon_bg icon_ckxq"></i> <span><m:message --%>
<%-- 										code="button.view" /></span> --%>
<!-- 						</a></li> -->
						<c:if test="${manage}">
						<li><a title="审核" href="javascript:"
							onclick="audit();"> <i class="icon_bg icon_audit"></i> <span>审核</span>
						</a></li>
						<li><a title="导出凭证" href="javascript:"
							onclick="moduleResMgt();"> <i class="back_icon resources_icon"></i> <span>导出凭证</span>
						</a></li>
						<li><a title="整理凭证" href="javascript:"
							onclick="moduleResMgt();"> <i class="icon_bg icon_submit"></i> <span>整理凭证</span>
						</a></li>
						</c:if>
					</ul>
				</div>
			<!--功能按钮end-->
				<div class="listtable_box">
					<!--此处放表格-->
				<table  id="remote_rowed" ></table>
				<div  id="remote_prowed"></div>		
				</div>
		</div>
	</div>
</body>
</html>
