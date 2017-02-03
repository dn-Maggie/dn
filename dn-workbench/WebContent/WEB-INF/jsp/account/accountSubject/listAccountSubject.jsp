<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE HTML  >
<html>
<head>
<%@ include file="../../common/header.jsp"%>
<title></title>
<script type="text/javascript">
var zichan = {};
var fuzhai = {};
var syzqy={};
var chengben = {};
var sunyi={};
	$(function(){
		zichan = new biz.grid({
            id:"#remote_rowed1",/*html部分table id*/
            url: "<m:url value='/accountSubject/listAccountSubject.do'/>",/*grid初始化请求数据的远程地址*/
            datatype: "json",/*数据类型，设置为json数据，默认为json*/
           	sortname:"id",
           	sortorder:"asc",
           	shrinkToFit:true,
           	autowidth:true,
           	//navtype:"top" /*导航栏类型*/,
           	//height: gridHeight,
           	pager: '#remote_prowed1' /*分页栏id*/,
     		rowList:[10,15,50,100],//每页显示记录数
    		rowNum:10,//默认显示15条
            colModel:[
				{name : "id",hidden : true,key : true,label:"序号",index : "id"},				
				{name : "parentId",hidden : true,label:"会计科目分类编号",index : "parent_id"},				
				{name : "parentName",label:"会计科目分类名称",index : "parent_name"},				
				{name : "accountId",label:"会计科目编号",index : "account_id"},				
				{name : "accountName",label:"会计科目名称",index : "account_name"},				
				{name : "note",label:"描述",index : "note"}				
           	],
           	serializeGridData:function(postData){//添加查询条件值
           		postData.parentId=1;
				var obj = getQueryCondition();
				$.extend(true, obj, postData);//合并查询条件值与grid的默认传递参数
				return obj;
    		}
      });
        
		fuzhai = new biz.grid({
            id:"#remote_rowed2",/*html部分table id*/
            url: "<m:url value='/accountSubject/listAccountSubject.do'/>",/*grid初始化请求数据的远程地址*/
            datatype: "json",/*数据类型，设置为json数据，默认为json*/
           	sortname:"id",
           	sortorder:"asc",
           	//navtype:"top" /*导航栏类型*/,
           	//height: gridHeight,
           	pager: '#remote_prowed2' /*分页栏id*/,
     		rowList:[10,15,50,100],//每页显示记录数
    		rowNum:10,//默认显示15条
            colModel:[
				{name : "id",hidden : true,key : true,label:"序号",index : "id"},				
				{name : "parentId",hidden : true,label:"会计科目分类编号",index : "parent_id"},				
				{name : "parentName",label:"会计科目分类名称",index : "parent_name"},				
				{name : "accountId",label:"会计科目编号",index : "account_id"},				
				{name : "accountName",label:"会计科目名称",index : "account_name"},				
				{name : "note",label:"描述",index : "note"}				
           	],
           	serializeGridData:function(postData){//添加查询条件值
           		postData.parentId=2;
				var obj = getQueryCondition();
				$.extend(true, obj, postData);//合并查询条件值与grid的默认传递参数
				return obj;
    		}
      });
		
		syzqy = new biz.grid({
            id:"#remote_rowed3",/*html部分table id*/
            url: "<m:url value='/accountSubject/listAccountSubject.do'/>",/*grid初始化请求数据的远程地址*/
            datatype: "json",/*数据类型，设置为json数据，默认为json*/
           	sortname:"id",
           	sortorder:"asc",
           	//navtype:"top" /*导航栏类型*/,
           	//height: gridHeight,
           	pager: '#remote_prowed3' /*分页栏id*/,
     		rowList:[10,20,50,100],//每页显示记录数
    		rowNum:10,//默认显示15条
            colModel:[
				{name : "id",hidden : true,key : true,label:"序号",index : "id"},				
				{name : "parentId",hidden : true,label:"会计科目分类编号",index : "parent_id"},				
				{name : "parentName",label:"会计科目分类名称",index : "parent_name"},				
				{name : "accountId",label:"会计科目编号",index : "account_id"},				
				{name : "accountName",label:"会计科目名称",index : "account_name"},				
				{name : "note",label:"描述",index : "note"}				
           	],
           	serializeGridData:function(postData){//添加查询条件值
           		postData.parentId=4;
				var obj = getQueryCondition();
				$.extend(true, obj, postData);//合并查询条件值与grid的默认传递参数
				return obj;
    		}
      });
		
		chengben = new biz.grid({
            id:"#remote_rowed4",/*html部分table id*/
            url: "<m:url value='/accountSubject/listAccountSubject.do'/>",/*grid初始化请求数据的远程地址*/
            datatype: "json",/*数据类型，设置为json数据，默认为json*/
           	sortname:"id",
           	sortorder:"asc",
           	//navtype:"top" /*导航栏类型*/,
           	//height: gridHeight,
           	pager: '#remote_prowed4' /*分页栏id*/,
     		rowList:[10,20,50,100],//每页显示记录数
    		rowNum:10,//默认显示15条
            colModel:[
				{name : "id",hidden : true,key : true,label:"序号",index : "id"},				
				{name : "parentId",hidden : true,label:"会计科目分类编号",index : "parent_id"},				
				{name : "parentName",label:"会计科目分类名称",index : "parent_name"},				
				{name : "accountId",label:"会计科目编号",index : "account_id"},				
				{name : "accountName",label:"会计科目名称",index : "account_name"},				
				{name : "note",label:"描述",index : "note"}				
           	],
           	serializeGridData:function(postData){//添加查询条件值
           		postData.parentId=5;
				var obj = getQueryCondition();
				$.extend(true, obj, postData);//合并查询条件值与grid的默认传递参数
				return obj;
    		}
      });
		
		sunyi = new biz.grid({
            id:"#remote_rowed5",/*html部分table id*/
            url: "<m:url value='/accountSubject/listAccountSubject.do'/>",/*grid初始化请求数据的远程地址*/
            datatype: "json",/*数据类型，设置为json数据，默认为json*/
           	sortname:"id",
           	sortorder:"asc",
           	//navtype:"top" /*导航栏类型*/,
           	//height: gridHeight,
           	pager: '#remote_prowed5' /*分页栏id*/,
     		rowList:[10,20,50,100],//每页显示记录数
    		rowNum:10,//默认显示15条
            colModel:[
				{name : "id",hidden : true,key : true,label:"序号",index : "id"},				
				{name : "parentId",hidden : true,label:"会计科目分类编号",index : "parent_id"},				
				{name : "parentName",label:"会计科目分类名称",index : "parent_name"},				
				{name : "accountId",label:"会计科目编号",index : "account_id"},				
				{name : "accountName",label:"会计科目名称",index : "account_name"},				
				{name : "note",label:"描述",index : "note"}				
           	],
           	serializeGridData:function(postData){//添加查询条件值
           		postData.parentId=6;
				var obj = getQueryCondition();
				$.extend(true, obj, postData);//合并查询条件值与grid的默认传递参数
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
	//修改的弹出框
   	var edit_iframe_dialog;
	//查看的弹出框
	var show_iframe_dialog;
  	
  	function add(){
  	//xin zeng iframe 弹出框
		var url="<m:url value='/accountSubject/toAddAccountSubject.do'/>";
		add_iframe_dialog = new biz.dialog({
			id:$('<div id="addwindow_iframe"></div>').html('<iframe id="iframeAdd" name="iframeAdd" src="'+url+'" width="100%" frameborder="no" border="0" height="97%"></iframe>'),  
			modal: true,
			width: 800,
			height: 235,
			title: "会计科目信息增加"
		});
		add_iframe_dialog.open();
  	}
  	
  	//关闭新增页面，供子页面调用
  	function closeAdd(){
		add_iframe_dialog.close();
  	}
  	
    function edit(){
		var key = ICSS.utils.getSelectRowData("id");
		if(key.indexOf(",")>-1||key==""){
			showMessage("请选择一条数据！");
			return ;
		}
		var url="<m:url value='/accountSubject/toEditAccountSubject.do'/>?key="+key;
		edit_iframe_dialog = new biz.dialog({
		 	id:$('<div id="editwindow_iframe"></div>').html('<iframe id="iframeEdit" name="iframeEdit" src="'+url+'" width="100%" frameborder="no" border="0" height="97%"></iframe>'),  
			modal: true,
			width: 800,
			height: 235,
			title: "会计科目信息编辑"
		});
  		edit_iframe_dialog.open();
    }
    
    //关闭编辑页面，供子页面调用
    function closeEdit(){
    	edit_iframe_dialog.close();
    }
    
    function show(){
    	var key = ICSS.utils.getSelectRowData("id");
		if(key.indexOf(",")>-1||key==""){
			showMessage("请选择一条数据！");
			return ;
		}
		var url="<m:url value='/accountSubject/toShowAccountSubject.do'/>?key="+key;
		show_iframe_dialog = new biz.dialog({
		 	id:$('<div id="showwindow_iframe"></div>').html('<iframe id="iframeShow" name="iframeShow" src="'+url+'" width="100%" frameborder="no" border="0" height="97%"></iframe>'),  
			modal: true,
			width: 800,
			height: 235,
				title: "会计科目信息详情"
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
    function doSearchzichan(isStayCurrentPage){
    	if(!isStayCurrentPage)zichan.setGridParam({"page":"1"});
    	zichan.trigger('reloadGrid');
    	doSearchfuzhai(isStayCurrentPage);
    }
    //查询Grid数据
    function doSearchfuzhai(isStayCurrentPage){
    	if(!isStayCurrentPage)fuzhai.setGridParam({"page":"1"});
    	fuzhai.trigger('reloadGrid');
    	doSearchsyzqy(isStayCurrentPage);
    }
    //查询Grid数据
    function doSearchsyzqy(isStayCurrentPage){
    	if(!isStayCurrentPage)syzqy.setGridParam({"page":"1"});
    	syzqy.trigger('reloadGrid');
    	doSearchchengben(isStayCurrentPage);
    }
    //查询Grid数据
    function doSearchchengben(isStayCurrentPage){
    	if(!isStayCurrentPage)chengben.setGridParam({"page":"1"});
    	chengben.trigger('reloadGrid');
    	doSearchsunyi(isStayCurrentPage);
    }
    //查询Grid数据
    function doSearchsunyi(isStayCurrentPage){
    	if(!isStayCurrentPage)sunyi.setGridParam({"page":"1"});
    	sunyi.trigger('reloadGrid');
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
        				url: "<m:url value='/accountSubject/deleteAccountSubject.do'/>?key="+ids,
        				cache:false,
        				success: function(data, textStatus, jqXHR){
        					doSearchzichan();
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
				<li><span>开始日期:</span>
						<div class="time_bg">
						<input type="text" class="search_time150" name="actTime" id="actTime" mainid="actTime"><!-- 时间选择控件-->
						<i class="search_time_ico2"></i>
						</div></li>
				<li class="date_area">
					<span>日期:</span>
					<div class="time_bg">
						<input id="startDate" type="text" class="search_time150" name="propsMap['startDate']" mainid="startDate">
						<i class="search_time_ico2"></i>
					</div>
					<i>至</i>
					<div class="time_bg">
						<input id="endDate" type="text" class="search_time150" name="propsMap['endDate']" mainid="endDate">
						<i class="search_time_ico2"></i>
					</div></li>	
				 <li><select class="search_select" name="actType" id="actType" mainid="actType"><option value="">--请选择--</option><option value="add">add</option><option value="save">save</option><option value="update">update</option><option value="edit">edit</option><option value="insert">insert</option><option value="delete">delete</option><option value="remove">remove</option></select>
				<span>操作类型:</span></li><!--下拉 -->
				<li><input type="text" name="actResult" id="actResult" class="search_choose"> <span>操作结果:</span></li><!-- 输入框-->			
				<li><input type="reset" class="reset_btn" onclick="resetForm('queryForm')" value="重置"><!-- 重置 -->
						<input type="button" class="search_btn mr22 " onclick="doSearchzichan();" value="查询"></li><!-- 查询-->
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
						<c:if test="${manage}">
						<li><a title="<m:message code="button.module.moduleRes"/>" href="javascript:"
							onclick="moduleResMgt();"> <i class="back_icon resources_icon"></i> <span><m:message
										code="button.module.moduleRes" /></span>
						</a></li>
						</c:if>
					</ul>
				</div>
	
			<!--功能按钮end-->
				<div class="listtable_box" style="position:relative">
				<!--此处放表格-->
				<div style="display:inline-block;width:22%;float:left;margin-right:15px;">
					<table id="remote_rowed1"></table>
					<div id="remote_prowed1"></div>
				</div>
				<div style="display:inline-block;width:22%;float:left;margin-right:15px;">
					<table id="remote_rowed2"></table>
					<div id="remote_prowed2"></div>
				</div>
				<div style="display:inline-block;width:22%;float:left;margin-right:15px;">
					<table id="remote_rowed3"></table>
					<div id="remote_prowed3"></div>
				</div>
				<div style="display:inline-block;width:22%;float:left;margin-right:15px;">
					<table id="remote_rowed4"></table>
					<div id="remote_prowed4"></div>
				</div>
				<div style="display:inline-block;width:22%;float:left;margin-right:15px;">
					<table id="remote_rowed5"></table>
					<div id="remote_prowed5"></div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
