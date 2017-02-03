<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE HTML>
<html>
<head>
<%@ include file="../../common/header.jsp"%>
<title></title>
    <style type="text/css">
    	table tr:last{
    		background: #fff;
    	}
    </style>
</head>
<body style="height:100%;">

	<div class="main  choice_box">
		<form id="queryForm"><!-- 查询区 表单 -->
			<div class="search border-bottom">
				<ul>
				<li><input type="text" name="stuName" id="stuName" class="search_choose"> <span>学员姓名:</span></li><!-- 输入框-->
				<li style="width:160px;">
							<select class="search_choose" name="subjectName" id="subjectName" mainid="subjectName" style="width:80px;">
							<option value="">-请选择-</option>
							<c:forEach var="mr" items="${er.subject}">
								<option value="${mr.name}"> <c:out value="${mr.name}"></c:out> </option>
				            </c:forEach>
						</select><span>报名学科:</span>
					</li><!-- 输入框-->
					<li class="date_area">
					<span>报名日期:</span>
					<div class="time_bg">
						<input id="joinStartDate" type="text" class="search_time150" name="propsMap['joinStartDate']" mainid="joinStartDate">			
						<i class="search_time_ico2"></i>
					</div>
					<i>至</i>
					<div class="time_bg">
						<input id="joinEndDate" type="text" class="search_time150" name="propsMap['joinEndDate']" mainid="joinEndDate">
						<i class="search_time_ico2"></i>
					</div></li>	
				<li class="date_area">
					<span>退款日期:</span>
					<div class="time_bg">
						<c:choose>
							<c:when test="${condition=='month'}">
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
					<li>
						<select class="search_choose" name="isCount" id="isCount" mainid="isCount">
						<option value="">--请选择--</option>
							<option value="未分配业绩">未分配业绩</option>
							<option value="已分配业绩">已分配业绩</option>
					</select><span>业绩分配:</span>
				</li><!-- 输入框-->
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
<%-- 						<c:if test="${edit}"> --%>
<%-- 							<li><a title="<m:message code="button.edit"/>" href="javascript:;" --%>
<%-- 								onclick="edit();"><i class="icon_bg icon_edit"></i> <span><m:message --%>
<%-- 											code="button.edit" /></span> </a></li> --%>
<%-- 						</c:if> --%>
<%-- 						<c:if test="${delete}"> --%>
<%-- 							<li><a title="<m:message code="button.delete"/>" href="javascript:;" --%>
<%-- 								onclick="batchDelete();"> <i class="icon_bg icon_del"></i> <span><m:message --%>
<%-- 											code="button.delete" /></span> --%>
<!-- 							</a></li> -->
<%-- 						</c:if> --%>
						<li><a title="<m:message code="button.view"/>" href="javascript:"
							onclick="show();"> <i class="icon_bg icon_ckxq"></i> <span><m:message
										code="button.view" /></span>
						</a></li>
						<li><a href="javascript:;" onClick="expExcelWinShow();"> <i
							class="icon_bg icon_download"></i> <span>导出</span>
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
<script type="text/javascript">
var gridObj = {};
var jsion_sumColumns = {};	
jsion_sumColumns["sumColumns"] = "rn,refund";  
	$(function(){
  		gridObj = new biz.grid({
            id:"#remote_rowed",/*html部分table id*/
            url: "<m:url value='/vipRefund/listVipRefund.do'/>",/*grid初始化请求数据的远程地址*/
            datatype: "json",/*数据类型，设置为json数据，默认为json*/
           	sortname:"time",
           	sortorder:"desc",
           	multiselect:true,
           	multiboxonly:true,
           	footerrow:true,
           	pager: '#remote_prowed' /*分页栏id*/,
     		rowList:[10,20,50,100],//每页显示记录数
    		rowNum:20,//默认显示15条
            colModel:[
				{name : "id",hidden : true,key : true,label:"主键",index : "id"},				
				{name : "stuId",hidden : true},				
				{name : "qq",label:"退款学员QQ",index : "qq"},
				{name : "stuName",label:"退款学员姓名"},	
				{name : "stuJointime",label:"报名时间",index :"stuJointime"},
				{name : "refund",label:"退款金额",index : "refund"},	
				{name : "operator",label:"录入人",index : "operator"},
				{name : "subjectName",label:"退款科目",index : "subjectName"},	
				{name : "courseName",label:"退款课程",index : "courseName"},	
				{name : "time",label:"退款时间",index : "time"},
				{name : "reason",label:"退款原因",index : "reason"},	
           	],
           	serializeGridData:function(postData){//添加查询条件值
				var obj = getQueryCondition();
    			$ .extend(true,obj,postData);//合并查询条件值与grid的默认传递参数
    			return obj;
    		},
	  		gridComplete:function(){
               	getFooterJsonData($(this));
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
		var url="<m:url value='/vipRefund/toAddVipRefund.do'/>";
		add_iframe_dialog = new biz.dialog({
			id:$('<div id="addwindow_iframe"></div>').html('<iframe id="iframeAdd" name="iframeAdd" src="'+url+'" width="100%" frameborder="no" border="0" height="97%"></iframe>'),  
			modal: true,
			width: $(window).width()*0.6,
			height:$(window).height()*0.8,
			title: "退款信息增加"
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
		var url="<m:url value='/vipRefund/toEditVipRefund.do'/>?key="+key;
		edit_iframe_dialog = new biz.dialog({
		 	id:$('<div id="editwindow_iframe"></div>').html('<iframe id="iframeEdit" name="iframeEdit" src="'+url+'" width="100%" frameborder="no" border="0" height="97%"></iframe>'),  
			modal: true,
			width: $(window).width()*0.6,
			height:$(window).height()*0.5,
			title: "退款信息编辑"
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
		var url="<m:url value='/vipRefund/toShowVipRefund.do'/>?key="+key;
		show_iframe_dialog = new biz.dialog({
		 	id:$('<div id="showwindow_iframe"></div>').html('<iframe id="iframeShow" name="iframeShow" src="'+url+'" width="100%" frameborder="no" border="0" height="97%"></iframe>'),  
			modal: true,
			width: $(window).width()*0.6,
			height:$(window).height()*0.5,
				title: "退款信息详情"
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
        				url: "<m:url value='/vipRefund/deleteVipRefund.do'/>?key="+ids,
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
    
    
    
  		//总计
  		//@param jqGridObj
	  function getFooterJsonData(jqGridObj){
		  	var addFootData = {} ;
		  	var resObj = ajaxGetStatistic();
				var _strColumns = jsion_sumColumns.sumColumns.split(",");
	            for(var k = 0;k<_strColumns.length; k++){
	            	k == 0?addFootData[_strColumns[k]] = "总计":addFootData[_strColumns[k]] = Math.round(resObj[_strColumns[k]]) ||0;
	            }
	   		jqGridObj.jqGrid('footerData','set',addFootData,false);
	  	}
		//根据条件从数据库获取结果集
		function ajaxGetStatistic(){
			var resObj = {};
	       	$.ajax({
	   			url : "<m:url value='/vipRefund/staticVipRefund.do'/>",
	   			cache : false,
	   			data: getQueryCondition(),
	   			async : false,
	   			dataType:"json",
	   			success : function(data) {
	   				resObj.refund= parseFloat(data.statics[0].refund);
	   			}
	   		});
	       	return resObj;
		};
    
    
    
    
    function expExcelWinShow(){
    	ExpExcel.showWin(gridObj,baseUrl+"/vipRefund/exportExcel.do",'grid','queryForm');
    }
 </script>
</body>
</html>
