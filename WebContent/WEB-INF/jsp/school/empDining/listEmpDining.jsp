<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE HTML>
<html>
<head>
<%@ include file="../../common/header.jsp"%>
<title></title>
<script type="text/javascript">
var gridObj = {};
	$(function(){
		 $("#startDate").val(new Date().format('yyyy-MM-dd'));
		 $("#endDate").val(new Date().format('yyyy-MM-dd'));
  		gridObj = new biz.grid({
            id:"#remote_rowed",/*html部分table id*/
            url: "<m:url value='/empDining/listEmpDining.do'/>",/*grid初始化请求数据的远程地址*/
            datatype: "json",/*数据类型，设置为json数据，默认为json*/
           	sortname:"empNo",
           	sortorder:"asc",
           	pager: '#remote_prowed' /*分页栏id*/,
     		rowList:[10,15,50,100],//每页显示记录数
    		rowNum:15,//默认显示15条
            colModel:[
				{name : "id",hidden : true,key : true,label:"主键",index : "id"},
				{name : "empDept",label:"员工部门",index : "empDept"},
				{name : "empNo",label:"员工编号",index : "empNo"},	
				{name : "empNickName",label:"员工姓名",index : "emp_id"},				
				{name : "diningTime",label:"退订日期",index : "dining_time"},
				{name : "orderType",label:"餐别",index : "order_type",
					formatter:function(cellvalue, options, rowObject){
		 				 if (cellvalue==1) {
		 				 	return '中餐';
		 				 }else if (cellvalue==2) {
		 				 	return '晚餐';
		 				 }
		 		}}
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
  			dateFmt:'yyyy-MM-dd',
  		});
  	    
  	    new biz.datepicker({
  			id : "#endDate",
  			minDate:'#F{$dp.$D(\'startDate\',{d:0});}',
  			dateFmt:'yyyy-MM-dd',
  		});
    });

    //新增的弹出框
	var add_iframe_dialog;
  	
  	function add(){
  	//xin zeng iframe 弹出框
		var url="<m:url value='/empDining/toAddEmpDining.do'/>";
		add_iframe_dialog = new biz.dialog({
			id:$('<div id="addwindow_iframe"></div>').html('<iframe id="iframeAdd" name="iframeAdd" src="'+url+'" width="100%" frameborder="no" border="0" height="97%"></iframe>'),  
			modal: true,
			width: $(window).width()*0.6,
			height: $(window).height()*0.8,
			title: "员工退餐增加"
		});
		add_iframe_dialog.open();
  	}
  	
  	//关闭新增页面，供子页面调用
  	function closeAdd(){
		add_iframe_dialog.close();
  	}
    
    //关闭编辑页面，供子页面调用
    function closeEdit(){
    	edit_iframe_dialog.close();
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
    	var diningTime = ICSS.utils.getSelectRowData("diningTime").split(",");
    	if(ids==""){
    		showMessage("请至少选择一条数据！");
    		return ;
    	}else{
    		var flag = true;
    		for(var i = 0;i<diningTime.length;i++){
    			if(new Date(diningTime[i]).getTime()<=new Date().getTime()){
    				flag = false;
    				break;
    			}
    		}
    		if(flag){
    			new biz.alert({type:"confirm",message:I18N.msg_del_confirm,title:I18N.promp,callback:function(result){
        			if(result){
        				$ .ajax({
            				url: "<m:url value='/empDining/deleteEmpDining.do'/>?key="+ids,
            				cache:false,
            				success: function(data, textStatus, jqXHR){
            					doSearch();
        						showInfo("删除成功",3000);
            				}
            			});
        			}
        		}}) ;   
    		}else{
    			showMessage("数据已生效，不能删除！");
    		}
    		
    	}
    }
 	//总计
	//@param jqGridObj
	function getFooterJsonData(jqGridObj){
 			//获取数据
		  	var lunchOrder = [] ;
		  	var supperOrder= [] ; 
		  	//把数据拼接到span里面显示
		  	$.ajax({
	   			url : "<m:url value='/empDining/staticEmpDining.do'/>",
	   			cache : false,
	   			data: getQueryCondition(),
	   			async : false,
	   			dataType:"json",
	   			success : function(data) {
	   				for(var i = 0; i<data.lunch.length ;i++){
	   					lunchOrder.push(data.lunch[i].empNo);
	   				}
	   				for(var i = 0; i<data.supper.length ;i++){
	   					supperOrder.push(data.supper[i].empNo);
	   				}
	   				$("#lunch_order_list").text(lunchOrder);
	   				$("#supper_order_list").text(supperOrder);
	   			}
	   		});
 	
 	}
    
	//导出
    function expExcelWinShow(){
    	ExpExcel.showWin(gridObj,baseUrl+"/empDining/exportExcel.do",'grid','queryForm');
    }
    </script>
</head>
<body style="height:100%;">

	<div class="main  choice_box">
		<form id="queryForm"><!-- 查询区 表单 -->
			<div class="search border-bottom">
				<ul>
				<li><input type="text" name="empNickName" id="empNickName" class="search_choose"> <span>员工姓名:</span></li><!-- 输入框-->
				<li class="date_area">
					<span>退订日期:</span>
					<div class="time_bg">
						<input id="startDate" type="text" class="search_time150" name="propsMap['startDate']" mainid="startDate"/>
						<i class="search_time_ico2"></i>
					</div>
					<i>至</i>
					<div class="time_bg">
						<input id="endDate" type="text" class="search_time150" name="propsMap['endDate']" mainid="endDate">
						<i class="search_time_ico2"></i>
					</div></li>	
				 <li>
					 <select class="search_select" name="orderType" id="orderType" >
						 <option value="">--请选择--</option>
						 <option value="1">中餐</option>
						 <option value="2">晚餐</option>
					 </select>
				<span>餐别:</span></li><!--下拉 -->
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
						<%-- <c:if test="${edit}">
							<li><a title="<m:message code="button.edit"/>" href="javascript:;"
								onclick="edit();"><i class="icon_bg icon_edit"></i> <span><m:message
											code="button.edit" /></span> </a></li>
						</c:if> --%>
						<c:if test="${delete}">
							<li><a title="<m:message code="button.delete"/>" href="javascript:;"
								onclick="batchDelete();"> <i class="icon_bg icon_del"></i> <span><m:message
											code="button.delete" /></span>
							</a></li>
						</c:if>
						<li>
							<a href="javascript:;" onClick="expExcelWinShow();"> 
							<i class="icon_bg icon_download"></i> 
							<span>导出</span>
							</a>
						</li>
					</ul>
				</div>
			<!--功能按钮end-->
				<div class="listtable_box">
					<!--此处放表格-->
					<table  id="remote_rowed" ></table>
					<div  id="remote_prowed"></div>		
				</div>
				<div class="listtable_box" style="width:100%;font-size: 13px;font-weight: bold;background: #f9f9f9;color: #2a84ff;">
					<div><span>订餐员工列表：</span></div>
					<div id="lunch_order" style="margin: 20px 0;">中餐：<span id="lunch_order_list" ></span></div>
					<div id="supper_order" >晚餐：<span id="supper_order_list" ></span></div>
				</div>
		</div>
	</div>
		
</body>
</html>
