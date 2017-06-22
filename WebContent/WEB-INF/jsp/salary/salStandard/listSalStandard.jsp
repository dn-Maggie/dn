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
            url: "<m:url value='/salStandard/listSalStandard.do'/>",/*grid初始化请求数据的远程地址*/
            datatype: "json",/*数据类型，设置为json数据，默认为json*/
           	sortname:"id",
           	sortorder:"asc",
           	//navtype:"top" /*导航栏类型*/,
           	//height: gridHeight,
           	pager: '#remote_prowed' /*分页栏id*/,
     		rowList:[10,15,50,100],//每页显示记录数
    		rowNum:10,//默认显示15条
            colModel:[
				{name : "id",hidden : true,key : true,label:"主键ID",index : "ID"},				
				{name : "standardName",label:"标准名称",index : "STANDARD_NAME"},				
				{name : "totalValue",label:"薪资总额",index : "TOTAL_VALUE",width:100},	
				{name : "stockNum",label:"股份配额(股)",index : "STOCK_NUM",width:100},		
				{name : "dutyName",label:"岗位名称",index : "DUTY_ID"},				
				{name : "salaryTypename",label:"薪酬类型",index : "SALARY_TYPENAME",width:100},							
				{name : "leveName",label:"岗位级别",index : "LEVE_NAME"},				
				{name : "basicSalary",label:"基本工资",index : "BASIC_SALARY",width:100},				
				{name : "dutySalary",label:"岗位工资",index : "DUTY_SALARY",width:100},				
				{name : "socialSecuritysalary",label:"社保工资",index : "SOCIAL_SECURITYSALARY",width:100},				
				{name : "performanceSalary",label:"绩效工资",index : "PERFORMANCE_SALARY",width:100},				
				{name : "remark",hidden : true,label:"备注",index : "REMARK"},								
				{name : "createdbyname",hidden : true,label:"创建人名字",index : "CREATEDBYNAME"},				
				{name : "created",hidden : true,label:"创建时间",index : "CREATED"}				
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
	//修改的弹出框
   	var edit_iframe_dialog;
	//查看的弹出框
	var show_iframe_dialog;
  	
  	function add(){
  	//xin zeng iframe 弹出框
		var url="<m:url value='/salStandard/toAddSalStandard.do'/>";
		add_iframe_dialog = new biz.dialog({
			id:$('<div id="addwindow_iframe"></div>').html('<iframe id="iframeAdd" name="iframeAdd" src="'+url+'" width="100%" frameborder="no" border="0" height="97%"></iframe>'),  
			modal: true,
			width: 650,
			height: 370,
			title: "薪酬标准增加"
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
		var url="<m:url value='/salStandard/toEditSalStandard.do'/>?key="+key;
		edit_iframe_dialog = new biz.dialog({
		 	id:$('<div id="editwindow_iframe"></div>').html('<iframe id="iframeEdit" name="iframeEdit" src="'+url+'" width="100%" frameborder="no" border="0" height="97%"></iframe>'),  
			modal: true,
			width: 600,
			height: 300,
			title: "薪酬标准编辑"
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
		var url="<m:url value='/salStandard/toShowSalStandard.do'/>?key="+key;
		show_iframe_dialog = new biz.dialog({
		 	id:$('<div id="showwindow_iframe"></div>').html('<iframe id="iframeShow" name="iframeShow" src="'+url+'" width="100%" frameborder="no" border="0" height="97%"></iframe>'),  
			modal: true,
			width: 600,
			height: 400,
				title: "薪酬标准详情"
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
		addAttrToObject(obj, "dutyId");
		addAttrToObject(obj, "levelCode");
		addAttrToObject(obj, "salaryTypeCode");
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
		doSearch();
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
        				url: "<m:url value='/salStandard/deleteSalStandard.do'/>?key="+ids,
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
				 <li>
				<span>岗位名称:</span>
				<select id="dutyId" name="dutyId"
							class="search_select">
					          <option value=""></option>
								<c:forEach var="duty" items="${dutyList}">
									<option value="${duty.id }">${duty.dutyName }</option>
								</c:forEach>
						</select>
				</li>
				<li>
				<span>岗位级别:</span>
				<%-- <select id="levelCode"
							name="levelCode" class="search_select">
							  <option value=""></option>
								<c:forEach var="dutyLevel" items="${dutyLevelList}">
									<option value="${dutyLevel.dictCode }">${dutyLevel.dictName }</option>
								</c:forEach>
						</select>  --%>
						<select name="levelName" id="levelName" class="search_select"  >
								<option value=""></option>
								<option value="1">初级</option>
								<option value="2">中级</option>
								<option value="3">高级</option>
						</select>
				</li>
				<li>
				<span>薪酬类型：</span>
				<select id="salaryTypeCode"
							name="salaryTypeCode" class="search_select">
							 <option value=""></option>
								<c:forEach var="sst" items="${salStandardTypeList}">
									<option value="${sst.dictCode }">${sst.dictName }</option>
								</c:forEach>
						</select>
				</li><!--下拉 -->			
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
						<li><a title="<m:message code="button.view"/>" href="javascript:"
							onclick="show();"> <i class="icon_bg icon_ckxq"></i> <span><m:message
										code="button.view" /></span>
						</a></li>
						<c:if test="${manage}">
						<li><a title="<m:message code="button.module.moduleRes"/>" href="javascript:"
							onclick="moduleResMgt();"> <i class="back_icon resources_icon"></i> <span><m:message
										code="button.module.moduleRes" /></span>
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
