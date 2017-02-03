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
            url: "<m:url value='/salCheckBatch/listSalCheckBatch.do'/>",/*grid初始化请求数据的远程地址*/
            datatype: "json",/*数据类型，设置为json数据，默认为json*/
           	sortname:"SERIAL_INDEX",
           	sortorder:"asc",
           	//navtype:"top" /*导航栏类型*/,
           	//height: gridHeight,
           	pager: '#remote_prowed' /*分页栏id*/,
     		rowList:[10,15,50,100],//每页显示记录数
    		rowNum:10,//默认显示15条
            colModel:[
				{name : "id",formatter:"showlink",formatoptions:{baseLinkUrl:"javascript:;",click:show},label:"工资批次ID"},				
				{name : "batchname",label:"批次名称"},				
				{name : "ym",label:"年月"},				
				{name : "salaryInfoIds",label:"包含工资ID字符串"},				
				{name : "sumMoney",label:"批次合计金额"},				
				{name : "orgId",label:"所属部门ID"},				
				{name : "orgName",label:"所属部门名称"},				
				{name : "remark",label:"备注"},				
				{name : "createdby",label:"创建人ID"},				
				{name : "createdbyname",label:"创建人名称"},				
				{name : "created",label:"创建时间"},				
				{name : "branchCkUserId",label:"分公司审核人ID"},				
				{name : "branchCkUserName",label:"分公司审核人名字"},				
				{name : "branchCkTime",label:"分公司审核时间"},				
				{name : "branchCkStatus",label:"分公司审核状态(0是未审核，1是已审核，2是审核未通过)"},				
				{name : "branchCkRemark",label:"分公司审核备注"},				
				{name : "provinceCkUserId",label:"省级审核人ID"},				
				{name : "provinceCkUserName",label:"省级审核人名字"},				
				{name : "provinceCkTime",label:"省级审核时间"},				
				{name : "provinceCkStatus",label:"省级审核状态(0是未审核，1是已审核，2是审核未通过)"},				
				{name : "provinceCkRemark",label:"省级审核备注"},				
				{name : "groupCkUserId",label:"集团审核人ID"},				
				{name : "groupCkUserName",label:"集团审核人名字"},				
				{name : "groupCkTime",label:"集团审核时间"},				
				{name : "groupCkStatus",label:"集团审核状态(0是未审核，1是已审核，2是审核未通过)"},				
				{name : "groupCkRemark",label:"集团审核备注"}				
           	],
           	serializeGridData:function(postData){//添加查询条件值
				var obj = getQueryCondition();
    			$ .extend(true,obj,postData);//合并查询条件值与grid的默认传递参数
    			return obj;
    		}
      });
        
    });

    /**
    * 获取查询条件值
    */
    function getQueryCondition(){
        var obj = {};
		//addAttrToObject(obj,"moduleName");
		return obj;
    }

	function addAttrToObject(obj,name){
		element = document.getElementById(name);
		var notInputValue="";
		if(element!=null){
			if(element.value==null||element.value == ""){
				if($(element).attr("uiType")!=null){
					if($(element).attr("uiType")=="checkbox"){
						var tempCheckBoxObj = $(element).find(".checkbox");
						if(tempCheckBoxObj!=null && tempCheckBoxObj.length>0){
							tempCheckBoxObj.each(function(){
								if(this.checked) {
									notInputValue  += this.value+",";
								}
							  });
							if(notInputValue!=null && notInputValue.indexOf(",")!=-1){
								notInputValue = notInputValue.substring(0,notInputValue.length-1);
							}
					
						}
					}else if($(element).attr("uiType")=="radio"){
						var tempRadioObj = $(element).find(".radio");
						if(tempRadioObj!=null && tempRadioObj.length>0){
							  tempRadioObj.each(function(){
								if(this.checked) {
									notInputValue  = this.value;
									return;
								}
							  });
						}		  
					}
					if(notInputValue == null || notInputValue == "" ){
						  return;
					}
				}else{
                   return;
				}
			}

		}else{
			return;
		}

		obj = obj || {}; 
		var value = element.value!=null?element.value:notInputValue;
		obj[name] = value;
	}

    //新增的弹出框
	var add_iframe_dialog;
	//修改的弹出框
   	var edit_iframe_dialog;
	//查看的弹出框
	var show_iframe_dialog;
  	
  	function add(){
  	//xin zeng iframe 弹出框
		var url="<m:url value='/salCheckBatch/toAddSalCheckBatch.do'/>";
		add_iframe_dialog = new biz.dialog({
			id:$('<div id="addwindow_iframe"></div>').html('<iframe id="iframeAdd" name="iframeAdd" src="'+url+'" width="100%" frameborder="no" border="0" height="97%"></iframe>'),  
			modal: true,
			width: 800,
			height: 235,
			title: "工资批次增加"
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
		var url="<m:url value='/salCheckBatch/toEditSalCheckBatch.do'/>?key="+key;
		edit_iframe_dialog = new biz.dialog({
		 	id:$('<div id="editwindow_iframe"></div>').html('<iframe id="iframeEdit" name="iframeEdit" src="'+url+'" width="100%" frameborder="no" border="0" height="97%"></iframe>'),  
			modal: true,
			width: 800,
			height: 235,
			title: "工资批次编辑"
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
		var url="<m:url value='/salCheckBatch/toShowSalCheckBatch.do'/>?key="+key;
		show_iframe_dialog = new biz.dialog({
		 	id:$('<div id="showwindow_iframe"></div>').html('<iframe id="iframeShow" name="iframeShow" src="'+url+'" width="100%" frameborder="no" border="0" height="97%"></iframe>'),  
			modal: true,
			width: 800,
			height: 235,
				title: "工资批次详情"
		});
  		show_iframe_dialog.open();
    }
    
    //关闭查看页面，供子页面调用
    function closeShow(){
    	show_iframe_dialog.close();
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
        				url: "<m:url value='/salCheckBatch/deleteSalCheckBatch.do'/>?key="+ids,
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
<body>

<div class="main  choice_box" >
	<div id="conditions" class="ui-table ui-widget ui-corner-all ui-margin ui-rightDiv"  style="display:block;">
		<form id="queryForm">
			<div class="equal">
				<table  width="100%" border="0" cellspacing="0" cellpadding="0" class="top_table">
					<tr>
						<td width="80%" style="padding: 0;border: none;">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td class="rightSide"></td>
									<td></td>
									<td class="rightSide"></td>
									<td></td>
									<td class="rightSide"></td>
									<td></td>
								</tr>
							</table>
						</td>
						<td width="20%">
						<div class="btnArea">
							<button class="btnBox btn-primary" type="button" style="text-align: right;" onclick="doSearch();">
								<i class="icon-white icon-search"></i><span style="margin-left: 1px; margin-right: 1px">查询</span>
						    </button>
						    <button class="btnBox btn-primary" type="reset" style="text-align: right;">
							    <i class="icon-white icon-reset"></i><span style="margin-left: 1px; margin-right: 1px">重置</span>
						    </button>
						</div>
						</td>
					</tr>
				</table>
			</div>
		</form>
			
		<div class="ti_box2 ">
			<c:if test="${add}">
				<a title="<m:message code="button.add"/>" href="#" onclick="add();" class="tool_btn">
					<span>
						<div class="back_icon add_icon"></div>
						<em class="btn_con">增加</em>
					</span>
				</a>
			</c:if>
			<c:if test="${edit}">
				<a title="<m:message code="button.edit"/>" href="#" onclick="edit();" class="tool_btn">
					<span>
						<div class="back_icon edit_icon"></div>
						<em class="btn_con">编辑</em>
					</span>
				</a>
			</c:if>
			<c:if test="${delete}">
				<a title="<m:message code="button.delete"/>" href="#" onclick="batchDelete();" class="tool_btn">
					<span>
						<div class="back_icon delete_icon"></div>
						<em class="btn_con">删除</em>
					</span>
				</a>
			</c:if>
				<a title="<m:message code="button.view"/>" href="#" onclick="show();" class="tool_btn">
					<span>
						<div class="back_icon show_icon"></div>
						<em class="btn_con">查看</em>
					</span>
				</a>
		</div>
		
	<table  id="remote_rowed" ></table>
	<div  id="remote_prowed"></div>		
	</div>
</div>
	
	
</body>
</html>
