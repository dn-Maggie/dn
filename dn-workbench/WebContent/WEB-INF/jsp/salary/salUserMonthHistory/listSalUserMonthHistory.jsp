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
            url: "<m:url value='/salUserMonthHistory/listSalUserMonthHistory.do'/>",/*grid初始化请求数据的远程地址*/
            datatype: "json",/*数据类型，设置为json数据，默认为json*/
           	sortname:"CREATED",
           	sortorder:"asc",
           	singleselect: false,//多选
           	//navtype:"top" /*导航栏类型*/,
           	//height: gridHeight,
           	pager: '#remote_prowed' /*分页栏id*/,
     		rowList:[10,15,50,100],//每页显示记录数
    		rowNum:10,//默认显示15条
            colModel:[
				{name : "id",hidden : true,key : true,label:"数据ID",index : "ID"},							
				{name : "userName",label:"姓名",index : "USER_NAME"},							
				{name : "dutyName",label:"岗位名称",index : "DUTY_NAME"},								
				{name : "standardName",label:"薪酬标准名称",index : "STANDARD_NAME"},				
				{name : "ym",label:"年月",index : "YM"},							
				{name : "orgName",label:"所在部门名称",index : "ORG_NAME"},				
				{name : "stockNum",label:"股份配额(单位：股)",index : "STOCK_NUM"},				
				{name : "totalValue",label:"薪资总额",index : "TOTAL_VALUE"},				
				{name : "created",label:"创建时间",index : "CREATED"}				
           	],
           	serializeGridData:function(postData){//添加查询条件值
				var obj = getQueryCondition();
    			$ .extend(true,obj,postData);//合并查询条件值与grid的默认传递参数
    			return obj;
    		}
      });
        
  	  new biz.datepicker({
			id : "#ym",
			dateFmt:'yyyy-MM'
		});
    });

	
	 //新增的弹出框
	var add_iframe_dialog;
	//查看的弹出框
	var show_iframe_dialog;
  	

	function add(){
	  	//xin zeng iframe 弹出框
			var url="<m:url value='/salUserMonthHistory/toAddSalUserMonthHistory.do'/>";
			add_iframe_dialog = new biz.dialog({
				id:$('<div id="addwindow_iframe"></div>').html('<iframe id="iframeAdd" name="iframeAdd" src="'+url+'" width="100%" frameborder="no" border="0" height="97%"></iframe>'),  
				modal: true,
				width: 400,
				height: 185,
				title: "生成员工月度工资核定信息"
			});
			add_iframe_dialog.open();
	  	}
	  	
	  	//关闭新增页面，供子页面调用
	  	function closeAdd(){
			add_iframe_dialog.close();
	  	}
    function show(){
    	var key = ICSS.utils.getSelectRowData("id");
		if(key.indexOf(",")>-1||key==""){
			showMessage("请选择一条数据！");
			return ;
		}
		var url="<m:url value='/salUserMonthHistory/toShowSalUserMonthHistory.do'/>?key="+key;
		show_iframe_dialog = new biz.dialog({
		 	id:$('<div id="showwindow_iframe"></div>').html('<iframe id="iframeShow" name="iframeShow" src="'+url+'" width="100%" frameborder="no" border="0" height="97%"></iframe>'),  
			modal: true,
			width: 700,
			height: 335,
				title: "员工月度工资核定信息详情"
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
		addAttrToObject(obj, "userName");
		addAttrToObject(obj, "ym");
		addAttrToObject(obj, "dutyId");
		addAttrToObject(obj, "standardId");
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
        				url: "<m:url value='/salUserMonthHistory/deleteSalUserMonthHistory.do'/>?key="+ids,
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
				<li ><span>关键字:</span>
			<input id="userName" type="text" placeholder="姓名" 
			class="search_choose100"  value="" name="userName" autocomplete="off">
			</li>
			<li>
			<span>考核月份:</span>
			<div class="time_bg">
						<input type="text" id="ym"  name="ym" class="search_time150" value="">
						<i class="search_time_ico2"></i>
					</div>
					</li>
		 <li>
				<span>岗位名称:</span>
				<select id="dutyId" name="dutyId"
							class="search_select">
					          <option value="">--全部--</option>
								<c:forEach var="duty" items="${dutyList}">
									<option value="${duty.id }">${duty.dutyName }</option>
								</c:forEach>
						</select>
				</li>
		 <li>
				<span>薪酬标准：</span>
				<select id="standardId"
							name="standardId" class="search_select">
							 <option value="">--全部--</option>
								<c:forEach var="ss" items="${salStandardList}">
									<option value="${ss.id }">${ss.standardName }</option>
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
								onclick="add();"> <i class="icon_bg icon_add"> </i> <span>生成数据</span>
							</a></li>
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
