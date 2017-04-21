<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE HTML>
<html>
<head>
<%@ include file="../../common/header.jsp"%>
<title></title>
<script type="text/javascript">
var gridObj = {};
	$(function(){
		document.getElementById("checkMonth").value = today();
  		gridObj = new biz.grid({
            id:"#remote_rowed",/*html部分table id*/
            url: "<m:url value='/empCheck/listEmpCheck.do'/>",/*grid初始化请求数据的远程地址*/
            datatype: "json",/*数据类型，设置为json数据，默认为json*/
           	sortname:"department",
           	sortorder:"desc",
           	multiselect:true,
           	multiboxonly:true,
           	forceFit:true,
           	pager: '#remote_prowed' /*分页栏id*/,
     		rowList:[20,50,100],//每页显示记录数
    		rowNum:20,//默认显示15条
            colModel:[
				{name : "id",hidden : true,key : true,label:"主键",index : "id"},	
				{name : "empNo",label:"员工编号",index : "emp_no",width:'20'},
				{name : "empName",label:"员工姓名",index : "emp_name",width:'20'},		
				{name : "nickName",label:"昵称",index : "nickname",width:'30'},	
				{name : "post",label:"岗位",index : "post",width:'30'},		
				{name : "department",label:"部门",index : "department",width:'20'},
				/* {name : "basePoints",label:"基础分",index : "base_points",width:'20'},	 */
				{name : "checkPoint",label:"考核分",index : "check_point",width:'20'},
				{name : "checkMonth",label:"考核月份",index : "check_month",width:'30'},
				{name : "createTime",label:"考核时间",index : "create_time",width:'30'},
				{name : "checkPeople",label:"考核人",index : "checkpeople",width:'20'},
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
	//查看单个员工考核数据的弹出框
	var show_iframe_dialog;
  	 
    function ShowAssessmentinfo(){
    	var key = ICSS.utils.getSelectRowData("id");
		if(key.indexOf(",")>-1||key==""){
			showMessage("请选择一条数据！");
			return ;
		}
		var url="<m:url value='/empCheck/toShowAssinfo.do'/>?key="+key;
		show_iframe_dialog = new biz.dialog({
		 	id:$('<div id="showwindow_iframe"></div>').html('<iframe id="iframeShow" name="iframeShow" src="'+url+'" width="100%" frameborder="no" border="0" height="97%"></iframe>'),  
			modal: true,
			width: $(window).width()*0.4,
			height:$(window).height()*0.55,
				title: "员工考核信息"
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
    
	//员工考核的弹出框
	var ass_iframe_dialog;
    function Assessment(){
    	var url="<m:url value='/empCheck/toAssessment.do'/>";
    	ass_iframe_dialog = new biz.dialog({
		 	id:$('<div id="showwindow_iframe"></div>').html('<iframe id="iframeShow" name="iframeShow" src="'+url+'" width="100%" frameborder="no" border="0" height="97%"></iframe>'),  
			modal: true,
			width: $(window).width()*0.6,
			height:$(window).height()*0.7,
				title: "员工考核"
		});
		ass_iframe_dialog.open();
    }
    //关闭查看页面，供子页面调用
    function closeAss(){
    	ass_iframe_dialog.close();
    }
    
    //设置日期选择控件默认显示当前日期
    function today(){
   	    var today=new Date();
   	    var h=today.getFullYear();
   	    var m=today.getMonth();
   	    var d=today.getDate();
   	    m= m<10?"0"+m:m;   //  这里判断月份是否<10,如果是在月份前面加'0'
   	    d= d<10?"0"+d:d;   //  这里判断日期是否<10,如果是在日期前面加'0'
   	    return h+"-"+m;
   	}
    </script>
</head>
<body style="height:100%;">
	<div class="main  choice_box">
		<form id="queryForm"><!-- 查询区 表单 -->
			<div class="search border-bottom">
				<ul>
				<li>
				<span>员工姓名:</span>
					<div>
						<input id="empName" type="text" class="search_choose" name="empName" >
					</div>
				</li>
					<c:if test="${isResponsible}">
						<li class="date_area"><span>考核月份:</span>
							<div class="time_bg">
								<input id="checkMonth" name="checkMonth" type="text"
									class="search_time150"
									onClick="WdatePicker({maxDate:'%y-%M',dateFmt:'yyyy-MM'})" /> <i
									class="search_time_ico2"
									onclick="WdatePicker({el:'checkMonth',maxDate:'%y-%M',dateFmt:'yyyy-MM'})"></i>
							</div></li>
					</c:if>
					<c:if test="${isCheckview}">
						<li>
						<input id="checkMonth" name="checkMonth" type="hidden"/>
					<select style="float:none" class="search_select" name="department" id="edit_department" mainid="department" >
							<option value="">--所有--</option>
						<c:forEach var="org" items="${org}">
							<option value="${org.orgName}" ><c:out value="${org.orgName}"></c:out></option>
			             </c:forEach>
			        </select>
				<span>部门:</span>
				</li>
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
					</c:if>
					<li><input type="reset" class="reset_btn" onclick="resetForm('queryForm')" value="重置">
						<input type="button" class="search_btn mr22 " onclick="doSearch();" value="查询"></li>
				</ul>
		   </div>
	    </form>
		<div class="listplace">
				<!--功能按钮begin-->
				<div class="list_btn_bg fl"><!--功能按钮 div-->
					<ul>	
					<c:if test="${isResponsible}">				
							<li><a href="javascript:;" onClick="Assessment();"> <i
							class="icon_bg import_icon"></i> <span>员工考核</span>
							</a>
							</li>
							<li><a href="javascript:;" onClick="ShowAssessmentinfo();"> <i
							class="icon_bg icon_ckxq"></i> <span>查看单个员工历史考核信息</span>
							</a></li>
					</c:if>
					</ul>
				</div>
	
			<!--功能按钮end-->
				<div class="listtable_box">
				<table  id="remote_rowed" ></table>
				<div  id="remote_prowed"></div>		
				</div>
		</div>
	</div>
</body>
</html>