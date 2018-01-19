<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE HTML>
<html>
<head>
<%@ include file="../../common/header.jsp"%>
<title></title>
<script type="text/javascript">
var gridObj = {};
var gridTotalObj = {};
	$(function(){
		 $("#startDate").val(new Date().format('yyyy-MM-01'));
		 $("#endDate").val(new Date().format('yyyy-MM-dd'));
  		 gridObj = new biz.grid({
            id:"#remote_rowed",/*html部分table id*/
            url: "<m:url value='/empPerformance/listTeacPerformance.do'/>",/*grid初始化请求数据的远程地址*/
            datatype: "json",/*数据类型，设置为json数据，默认为json*/
           	sortname:"stuJoinTime",
           	sortorder:"desc",
           	footerrow:true,
           	pager: '#remote_prowed' /*分页栏id*/,
     		rowList:[10,15,50,100],//每页显示记录数
    		rowNum:20,//默认显示15条
            colModel:[
				{name : "employeeName",label:"员工姓名",index : "employeeName",width:20, frozen : true},	 
				{name : "nickName",label:"员工昵称",index : "nickName",width:20, frozen : true},
				{name : "position",label:"参与岗位",width:40},	
				{name : "stuName",label:"学生姓名",index : "stuName",width:30},
				{name : "stuQq",label:"学生QQ",index : "stuQq",width:40},
				{name : "actualPay",label:"已付",index : "actualPay",width:30},				
				{name : "performance",label:"营收额",index : "performance",width:20,
					formatter : "number",
					formatoptions : {
					decimalSeparator : ".",
					thousandsSeparator : ",",
					decimalPlaces : 1,
					defaulValue : 0
					},},
				{name : "stuJoinTime",label:"报名时间",index : "stuJoinTime",width:30}	
           	],
           	serializeGridData:function(postData){//添加查询条件值
				var obj = getQueryCondition();
    			$ .extend(true,obj,postData);//合并查询条件值与grid的默认传递参数
    			return obj;
    		},
    		gridComplete:function(){//表格加载执行  
			    $(this).closest(".ui-jqgrid-bdiv").css({'overflow-x' : 'hidden'});
			 		$(".ui-jqgrid-sdiv").show();
				 	var footerObj = {};
			 		footerObj["performance"]=$(this).getCol("performance",false,"sum").toFixed(3);
				 	footerObj['raw'] = true;
				 	footerObj['rn'] = "合";
				 	footerObj['cb'] = "计"; 
			    	$(this).footerData("set",footerObj);  //将合计值显示出来
			}
      	});
        
  		gridTotalObj = new biz.grid({
            id:"#total_table",/*html部分table id*/
          	url: "<m:url value='/empPerformance/listTeacTotal.do'/>",
            datatype: "json",/*数据类型，设置为json数据，默认为json*/
           	multiselect:true,
           	multiboxonly:true,
           	pager: '#total_prowed' /*分页栏id*/,
     		rowList:[10,15,50,100],//每页显示记录数
    		rowNum:20,//默认显示15条
 			colModel:[
				{name : "employeeName",label:"员工姓名",index : "employee_name",width:20, frozen : true},	 
				{name : "nickName",label:"员工昵称",index : "nickName",width:20, frozen : true},
				{name : "sum",label:"营收总额",index : "sum",width:25,
					formatter : "number",
					formatoptions : {
					decimalSeparator : ".",
					thousandsSeparator : ",",
					decimalPlaces : 1,
					defaulValue : 0
					},},	
           	],
           	serializeGridData:function(postData){//添加查询条件值
				var obj = getQueryCondition();
    			$ .extend(true,obj,postData);//合并查询条件值与grid的默认传递参数
    			return obj;
    		},
    		gridComplete:function(){//表格加载执行  
			    $(this).closest(".ui-jqgrid-bdiv").css({'overflow-x' : 'hidden'});
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
    	doSearchForTotalObj(isStayCurrentPage);
    }
    
    function doSearchForTotalObj(isStayCurrentPage){
    	if(!isStayCurrentPage)
    	gridTotalObj.setGridParam({"page":"1"});
    	gridTotalObj.trigger('reloadGrid');
    }
    //重置查询表单
    function resetForm(formId){
		document.getElementById(formId).reset();
	}
    
    </script>
</head>
<body style="height:100%;">
	<div class="main  choice_box">
		<form id="queryForm"><!-- 查询区 表单 -->
			<div class="search border-bottom">
				<ul>
				<li style="width:auto;float:left;"><span>关键字:</span>
				<c:if test="${!isAdmin}">
					<input type="hidden" name="employeeId" id="employeeId" value="${user.id}">
				</c:if>
				<c:if test="${isAdmin}">
					<select class="search_choose" name="empDept" id="empDept">
					<c:if test="${!leader}">
						<option value="">所有部门</option>
					</c:if>
						<c:forEach var="org" items="${org}">
							<option value="${org.orgNo}"> <c:out value="${org.orgName}"></c:out> </option>
			            </c:forEach>
					</select>
					<input type="text" name="employeeName" id="employeeName"  class="search_choose100" placeholder="员工姓名" autocomplete="off">
					<input type="text" name="nickName" id="nickName"  class="search_choose100" placeholder="员工昵称" autocomplete="off">
				</c:if>
					<input type="text" name="stuName" id="stuName" class="search_choose100" placeholder="学生姓名">
				</li>
				<li class="date_area">
					<span>发生时间:</span>
					<div class="time_bg">
						<input id="startDate" type="text" class="search_time150" name="propsMap['startDate']" >
						<i class="search_time_ico2"></i>
					</div>
					<i>至</i>
					<div class="time_bg">
						<input id="endDate" type="text" class="search_time150" name="propsMap['endDate']">
						<i class="search_time_ico2"></i>
					</div></li>	
					
				<li><input type="reset" class="reset_btn" onclick="resetForm('queryForm')" value="重置"><!-- 重置 -->
						<input type="button" class="search_btn mr22 " onclick="doSearch();" value="查询"></li><!-- 查询-->
				</ul>
		   </div>
	    </form>
		<div class="listplace">
			<!--功能按钮end-->
				<div class="listtable_box">
					<!--此处放表格-->
					<div style="display:inline-block;width:69%;vertical-align: top;">
						<table  id="remote_rowed" ></table>
						<div  id="remote_prowed"></div>		
					</div>		
					<div style="display:inline-block;width:30%;vertical-align: top;">
						<table id="total_table"></table>
						<div id="total_prowed"></div>
					</div>		
				</div>
		</div>
	</div>
		
</body>
</html>
