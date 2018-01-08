<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE HTML>
<html>
<head>
<%@ include file="../../common/header.jsp"%>
<title></title>
</head>
<body style="height:100%;">
	<div class="main  choice_box">
		<form id="queryForm"><!-- 查询区 表单 -->
			<div class="search border-bottom">
				<ul>
				<li><input type="text" name="qq" id="qq" class="search_choose"> <span>QQ号码:</span></li><!-- 输入框-->
 				<li class="date_area">
					<span>录入日期:</span>
						<div class="time_bg">
						<c:choose>
							<c:when test="${condition=='month'}">
								<input id="startDate" type="text" class="search_time150" name="propsMap['startDate']" mainid="startDate" value="${currDate}">	
							</c:when>
							<c:when test="${condition=='year'}">
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
						</div>
					</li>
					<li>
						<select class="search_choose" name="course" id="course" mainid="course">
						<option value="">--请选择--</option>
						<c:forEach var="mr" items="${couList}">
							<option value="${mr.name}"> <c:out value="${mr.name}"></c:out> </option>
			            </c:forEach>
					</select><span>意向课程:</span>
				</li><!--下拉 -->	
				<li>
					<%-- <select class="search_choose" name="entry_emp" id="entry_emp" mainid="entry_emp" >
						<option value="">-请选择-</option>
						<c:forEach var="emp" items="${emplist}">
							<option value="${emp.id}"> <c:out value="${emp.nickName}"></c:out> </option>
			            </c:forEach>
					</select><span>录入人:</span> --%>
					<span>录入人:</span>
					<input id="entry_emp" name="entry_emp" type="text"
						class="text" list="employeeList" style="width:120px;"/>
						<datalist id="employeeList">
							<c:forEach var="tutor" items="${tutor}">
								<option did="${tutor.name}" value="${tutor.name}"
									label="${tutor.nickName}"></option>
							</c:forEach>
						</datalist>
				</li>
				<li>
					<input type="reset" class="reset_btn" onclick="resetForm('queryForm')" value="重置"><!-- 重置 -->
					<input type="button" class="search_btn mr22 " onclick="doSearch();" value="查询">
				</li><!-- 查询-->
				</ul>
		   </div>
	    </form>
		<div class="listplace">
				<!--功能按钮begin-->
				<div class="list_btn_bg fl"><!--功能88按钮 div-->
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
						<li><a title="报名" href="javascript:"
							onclick="baomin();"> <i class="icon_bg icon_ckxq"></i> <span>报名</span>
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
	$(function(){
  		gridObj = new biz.grid({
            id:"#remote_rowed",/*html部分table id*/
            url: "<m:url value='/marketStudent/listPromotionalInfo.do'/>",/*grid初始化请求数据的远程地址*/
            datatype: "json",/*数据类型，设置为json数据，默认为json*/
           	sortname:"entry_time",
           	sortorder:"desc",
           	multiselect:true,
           	multiboxonly:true,
           	pager: '#remote_prowed' /*分页栏id*/,
     		rowList:[10,20,50,100],//每页显示记录数
    		rowNum:20,//默认显示15条
            colModel:[
				{name : "id",hidden : true,key : true,label:"",index : "id"},				
				{name : "qq",label:"QQ号码",index : "qq"},				
				{name : "course",label:"意向课程",index : "course"},				
				{name : "level",label:"意向等级",index : "level"}, 			
				{name : "entry_emp",label:"录入人",index : "entry_emp"},				
				{name : "entry_time",label:"录入时间",index : "entry_time"},
				{name : "is_buy",label:"是否报名",index : "is_buy"},	
				{name : "auxiliary",label:"辅助转化人",index : "auxiliary"}				
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
  		var url="<m:url value='/marketStudent/toAddPromotionalInfo.do'/>";
		add_iframe_dialog = new biz.dialog({
			id:$('<div id="addwindow_iframe"></div>').html('<iframe id="iframeAdd" name="iframeAdd" src="'+url+'" width="100%" frameborder="no" border="0" height="97%"></iframe>'),  
			modal: true,
			width: 800,
			height: 445,
			title: "添加一条意向信息"
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
		var url="<m:url value='/marketStudent/toEditPromotionalInfo.do'/>?key="+key;
		edit_iframe_dialog = new biz.dialog({
		 	id:$('<div id="editwindow_iframe"></div>').html('<iframe id="iframeEdit" name="iframeEdit" src="'+url+'" width="100%" frameborder="no" border="0" height="97%"></iframe>'),  
			modal: true,
			width: 800,
			height: 465,
			title: "编辑意向信息"
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
		var url="<m:url value='/marketStudent/toShowMarketStudent.do'/>?key="+key;
		show_iframe_dialog = new biz.dialog({
		 	id:$('<div id="showwindow_iframe"></div>').html('<iframe id="iframeShow" name="iframeShow" src="'+url+'" width="100%" frameborder="no" border="0" height="97%"></iframe>'),  
			modal: true,
			width: $(window).width()*0.6,
			height:$(window).height()*0.8,
				title: "录入学员信息表详情"
		});
  		show_iframe_dialog.open();
    }
    //跟踪
    function genzong(){
    	var key = ICSS.utils.getSelectRowData("id");
		if(key.indexOf(",")>-1||key==""){
			showMessage("请选择一条数据！");
			return ;
		}
		var url="<m:url value='/marketStudent/toGenZongMarketStudent.do'/>?key="+key;
		show_iframe_dialog = new biz.dialog({
		 	id:$('<div id="showwindow_iframe"></div>').html('<iframe id="iframeShow" name="iframeShow" src="'+url+'" width="100%" frameborder="no" border="0" height="97%"></iframe>'),  
			modal: true,
			width: $(window).width()*0.6,
			height:$(window).height()*0.8,
				title: "跟踪信息详情"
		});
  		show_iframe_dialog.open();
    }
  //报名
    function baomin(){
    	var key = ICSS.utils.getSelectRowData("id");
		if(key.indexOf(",")>-1||key==""){
			showMessage("请选择一条数据！");
			return ;
		}
		var url="<m:url value='/marketStudent/toBaoMinMarketStudent.do'/>?key="+key;
		show_iframe_dialog = new biz.dialog({
		 	id:$('<div id="showwindow_iframe"></div>').html('<iframe id="iframeShow" name="iframeShow" src="'+url+'" width="100%" frameborder="no" border="0" height="97%"></iframe>'),  
			modal: true,
			width: $(window).width()*0.6,
			height:$(window).height()*0.8,
				title: "报名信息详情"
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
        				url: "<m:url value='/marketStudent/deleteMarketStudent.do'/>?key="+ids,
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
  //录入人员随录入管理员二级联动
   function enterChange(val){
    	if(val){
    		$("#userId option").remove();
    		$ .ajax({
    			url: "<m:url value='/marketStudent/getEnterUser.do'/>?createdby="+val,
    			cache:false,
    			dataType:"json",
    			success: function(data, textStatus, jqXHR){
    				 $('#userId').append('<option value="">所有</option>'); 
    				 for(var i in data.userlist){
    					if(data.userlist[i].id){
    						$('#userId').append('<option value="'+data.userlist[i].id+'">'+data.userlist[i].fullName+'</option>');
    					}
    				} 
    			},
    			error:function(){
    				$('#userId option').remove();
    			}
    		});
    	}else{$('#userId option').remove();}
    }
</script>
</body>
</html>
