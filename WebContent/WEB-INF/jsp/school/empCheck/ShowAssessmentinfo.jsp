<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE HTML>
<html>
<head>
<%@ include file="../../common/header.jsp"%>
<title></title>
<script type="text/javascript">
var gridObj = {};
	$(function(){
  		gridObj = new biz.grid({
            id:"#remote_rowed",/*html部分table id*/
            url: "<m:url value='/empCheck/listEmpCheck.do'/>",/*grid初始化请求数据的远程地址*/
            datatype: "json",/*数据类型，设置为json数据，默认为json*/
           	sortname:"create_time",
           	sortorder:"desc",
           	multiselect:true,
           	multiboxonly:true,
           	forceFit:true,
           	pager: '#remote_prowed' /*分页栏id*/,
     		rowList:[10,15,50,100],//每页显示记录数
    		rowNum:10,//默认显示15条
            colModel:[
				{name : "id",hidden : true,key : true,label:"主键",index : "id"},	
				{name : "checkPoint",label:"考核分",index : "check_point",width:'20'},
				/* {name : "basePoints",label:"基础分",index : "base_points",width:'20'},	 */
				{name : "checkMonth",label:"考核月份",index : "check_month",width:'40'},
				{name : "createTime",label:"考核时间",index : "create_time",width:'40'},
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
  			dateFmt:'yyyy-MM',
  			maxDate:'%y-%M'
  		});
  	    
  	    new biz.datepicker({
  			id : "#endDate",
  			minDate:'#F{$dp.$D(\'startDate\',{d:0});}',
  			dateFmt:'yyyy-MM',
  			maxDate:'%y-%M'
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
					<li style="width:100px;margin:10px;"><span>员工姓名:</span> <label style="color: red;">${empCheck.empName}</label>
						<input id="empName" type="hidden" class="" name="empName"
						value="${empCheck.empName}" readOnly="true"></li>
					<li class="date_area"><span>考核时间:</span>
						<div class="time_bg">
							<input id="startDate" type="text" class="search_time150"
								name="propsMap['startDate']" mainid="startDate"> <i
								class="search_time_ico2"></i>
						</div> <i>至</i>
						<div class="time_bg">
							<input id="endDate" type="text" class="search_time150"
								name="propsMap['endDate']" mainid="endDate"> <i
								class="search_time_ico2"></i>
						</div></li>

					<li><input type="reset" class="reset_btn"
						onclick="resetForm('queryForm')" value="重置"> <input
						type="button" class="search_btn mr22 " onclick="doSearch();"
						value="查询"></li>
				</ul>
			</div>
		</form>
		<div class="listplace">
				<!--功能按钮begin-->
				<div class="list_btn_bg fl"><!--功能按钮 div-->

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