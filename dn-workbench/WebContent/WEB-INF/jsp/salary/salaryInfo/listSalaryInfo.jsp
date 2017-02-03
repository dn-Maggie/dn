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
            url: "<m:url value='/salaryInfo/listSalaryInfo.do'/>",/*grid初始化请求数据的远程地址*/
            datatype: "json",/*数据类型，设置为json数据，默认为json*/
           	sortname:"id",
           	sortorder:"asc",
           	//navtype:"top" /*导航栏类型*/,
          // 	height:'100%',
           	pager: '#remote_prowed' /*分页栏id*/,
     		rowList:[10,15,50,100],//每页显示记录数
    		rowNum:10,//默认显示15条
    		shrinkToFit:false,
            colModel:[
{name : "id",hidden : true,key : true,},							
{name : "userName",label:"姓名",frozen:true,index : "USER_NAME",width:100},				
{name : "standName",label:"薪酬标准",frozen:true,index : "STAND_NAME",width:100},			
{name : "orgName",label:"所在部门",frozen:true,index : "ORG_NAME",width:100},				
{name : "factSalary",label:"实发工资",frozen:true,index : "FACT_SALARY",width:70},				
{name : "ym",label:"工资年月",frozen:true,index : "YM",width:70},
{name : "created",label:"创建时间",index : "CREATED",width:120},				
{name : "state",label:"状态:未申，已审，发放",index : "STATE",width:120},				
{name : "approvedSalary",label:"核定工资",index : "APPROVED_SALARY",width:120},				
{name : "assessSalary",label:"考核工资",index : "ASSESS_SALARY",width:120},				
{name : "deduct",label:"扣款",index : "DEDUCT",width:120},				
{name : "duesSalary",label:"应付工资",index : "DUES_SALARY",width:120},				
{name : "payrollUsername",label:"工资发放人",index : "PAYROLL_USERNAME",width:120},				
{name : "payrollTime",label:"工资发放时间",index : "PAYROLL_TIME",width:120},				
{name : "reward",label:"奖励",index : "REWARD",width:120},				
{name : "punish",label:"处罚",index : "PUNISH",width:120},				
{name : "other",label:"其它",index : "OTHER",width:120},				
{name : "overtimeSalary",label:"加班工资",index : "OVERTIME_SALARY",width:120},				
{name : "welfare",label:"社保福利",index : "WELFARE",width:120},				
{name : "ageSalary",label:"工龄工资",index : "AGE_SALARY",width:120},				
{name : "diplomaSalary",label:"文凭工资",index : "DIPLOMA_SALARY",width:120},				
{name : "timecardDeduct",label:"考勤扣款",index : "TIMECARD_DEDUCT",width:120},				
{name : "oneSocialSecurity",label:"个人社保",index : "ONE_SOCIAL_SECURITY",width:120},				
{name : "livesAccommodation",label:"生活住宿",index : "LIVES_ACCOMMODATION",width:120},				
{name : "basicSalary",label:"基本工资",index : "BASIC_SALARY",width:120},				
{name : "dutySalary",label:"岗位工资",index : "DUTY_SALARY",width:120},				
{name : "socialSecuritySalary",label:"社保工资",index : "SOCIAL_SECURITY_SALARY",width:120},				
{name : "performanceSalary",label:"绩效工资",index : "PERFORMANCE_SALARY",width:120}	,
{name : "createdbyname",label:"创建人",index : "CREATEDBYNAME",width:120},
{name : "remark",label:"备注",index : "REMARK",width:120}
           	],
           	serializeGridData:function(postData){//添加查询条件值
				var obj = getQueryCondition();
    			$ .extend(true,obj,postData);//合并查询条件值与grid的默认传递参数
    			return obj;
    		}
      });
  		gridObj.setFrozenColumns();  

  		 new biz.datepicker({
   			id : "#startDate",
   			maxDate:'#F{$dp.$D(\'endDate\',{d:0});}',
   			dateFmt:'yyyy-MM'
   		});
   	    
   	    new biz.datepicker({
   			id : "#endDate",
   			minDate:'#F{$dp.$D(\'startDate\',{d:0});}',
   			dateFmt:'yyyy-MM'
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
		var url="<m:url value='/salaryInfo/toAddSalaryInfo.do'/>";
		add_iframe_dialog = new biz.dialog({
			id:$('<div id="addwindow_iframe"></div>').html('<iframe id="iframeAdd" name="iframeAdd" src="'+url+'" width="100%" frameborder="no" border="0" height="97%"></iframe>'),  
			modal: true,
			width: 750,
			height: 500,
			title: "工资信息增加"
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
		var url="<m:url value='/salaryInfo/toEditSalaryInfo.do'/>?key="+key;
		edit_iframe_dialog = new biz.dialog({
		 	id:$('<div id="editwindow_iframe"></div>').html('<iframe id="iframeEdit" name="iframeEdit" src="'+url+'" width="100%" frameborder="no" border="0" height="97%"></iframe>'),  
			modal: true,
			width: 750,
			height: 500,
			title: "工资信息编辑"
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
		var url="<m:url value='/salaryInfo/toShowSalaryInfo.do'/>?key="+key;
		show_iframe_dialog = new biz.dialog({
		 	id:$('<div id="showwindow_iframe"></div>').html('<iframe id="iframeShow" name="iframeShow" src="'+url+'" width="100%" frameborder="no" border="0" height="97%"></iframe>'),  
			modal: true,
			width: 750,
			height: 500,
				title: "工资信息详情"
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
		addAttrToObject(obj, "createdbyname");
		obj["propsMap['startDate']"]=$('#startDate').val();
		obj["propsMap['endDate']"]=$('#endDate').val();
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
        				url: "<m:url value='/salaryInfo/deleteSalaryInfo.do'/>?key="+ids,
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
			
				<li style="width:310px;float:left;"><span>关键字:</span>
			<input id="userName" type="text" placeholder="姓名" 
			class="search_choose100"  value="" name="userName" autocomplete="off">
			<input id="createdbyname" type="text" placeholder="创建人" 
			class="search_choose100"  value="" name="createdbyname" autocomplete="off">
			</li>
					<li class="date_area">
					<span>日期范围:</span>
					<div class="time_bg">
						<input id="startDate" type="text" class="search_time150" name="propsMap['startDate']" mainid="startDate">
						<i class="search_time_ico2"></i>
					</div>
					<i>至</i>
					<div class="time_bg">
						<input id="endDate" type="text" class="search_time150" name="propsMap['endDate']" mainid="endDate">
						<i class="search_time_ico2"></i>
					</div>
					</li>		
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
