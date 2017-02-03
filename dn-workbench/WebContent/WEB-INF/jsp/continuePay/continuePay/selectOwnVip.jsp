<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE HTML>
<html>
<head>
<%@ include file="../../common/header.jsp"%>
<title><m:message code="moduleRes.list.title" /></title>
</head>
<body>
	<div class="main  choice_box" >
		<form id="queryForm"><!-- 查询区 表单 -->
			<div class="search border-bottom">
				<ul>
					<li style="width:320px;float:left;"><span>模糊查询:</span>
						<input type="hidden" name="owePay" value="1" />
						<input id="name" type="text" class="search_choose100"  value="" name="name"  placeholder="学员姓名" />
						<input id="qq" type="text" class="search_choose100"  value="" name="qq"  placeholder="学员QQ" />
					</li>
					
					<li>
						<input type="reset" value="重置" id="reset" onClick="resetForm('queryForm')" class="reset_btn"><!-- 重置 -->
						<input type="button" value="查询"  id="query" class="search_btn mr22 " onclick="doSearch();"/>
					</li><!-- 查询-->
				</ul>
		   </div>
	    </form>
	
		<div class="listtable_box">
					<!--此处放表格-->
			<table id="mrSelect_rowed" ></table>
			<div id="mrSelect_prowed"></div>	
		</div>
		<div class="btn_area">
			<input type="button" id="submit" class="add_save" value="确定" />
		</div>
	</div>
</body>
<script type="text/javascript">
var mrSelectGrid = {};
	$(function(){
  		mrSelectGrid = new biz.grid({
            id:"#mrSelect_rowed",/*html部分table id*/
            //url: "<m:url value='/vipStudent/listOwnVipStudent.do'/>",/*grid初始化请求数据的远程地址*/
            url: "<m:url value='/vipStudent/listVipStudent.do'/>",
            datatype: "json",/*数据类型，设置为json数据，默认为json*/
            sortname:"join_time",
           	sortorder:"desc",
           	autowidth:true,
			shrinkToFit:true,
			singleselect : true,
           	pager: '#mrSelect_prowed' /*分页栏id*/,
     		rowList:[10,20,30,50,100,200],//每页显示记录数
    		rowNum:10,//默认显示15条
    		rownumbers: true, //是否显示行号
            colModel:[
               	{name : "id", hidden:true,key:true}, 
    			{name : "name",label:"姓名",width:40}, 
				{name : "subjectName",label:"报名学科",width:40},			
				{name : "courseName",label:"报名课程",width:40},
    			{name : "shouldPay",label:"应付学费",width:40},
    			{name : "actualPay",label:"实付学费",width:40},
				{name : "owePay",label:"欠缴学费",width:40},
				{name : "currStatus",label:"目前状态",width:40},
				{name : "subjectId",hidden:true},
				{name : "courseId",hidden:true},
				{name : "followerId",hidden:true},
				{name : "followerPosition",hidden:true},
				{name : "followerName",hidden:true},
    			{name : "followerType",hidden:true},
    			{name : "followerRate",hidden:true},
    			{name : "comSource",hidden:true},
				{name : "sourceSubclass",hidden:true},
				{name : "comSourceName",hidden:true},
        		{name : "joinTime",hidden:true},
				
           	],
           	serializeGridData:function(postData){//添加查询条件值
           		var obj = getQueryCondition();
    			$.extend(true,obj,postData);//合并查询条件值与grid的默认传递参数
    			return obj;
    		},
    		gridComplete:function(){
    			//数据加载完毕后，调整样式
    			var ids = mrSelectGrid.getDataIDs();
    			if(ids==""){
    				$("#next_remote_prowed").attr("class","ui-pg-button ui-corner-all ui-state-disabled");
    				$("#last_remote_prowed").attr("class","ui-pg-button ui-corner-all ui-state-disabled");
    			}
    	  	}
     	 });
  		
  		// 重置查询表单
  		$("#reset").click(function(){
  			$("#queryForm").reset();
  		});
  		
  		//绑定提交按钮click事件
  		$("#submit").click(function() {
  	    	rowid = mrSelectGrid.getGridParam("selarrrow");
  	    	if(rowid == null || rowid.length == 0){
  				showInfo("<m:message code='grid.dealwith.chooseColAlert'/>",3000);
  				return ;
  			}
  			var ids="";
  			for(var i=0; i < rowid.length;i++){
  				var id = mrSelectGrid.getCell(rowid[i],'id');
  				if(i>0){
  					ids +=',';
  				}
  				ids += id;
  			}
  			var rowData = $("#mrSelect_rowed").jqGrid('getRowData',rowid);
  			drawParentForm(rowData);
  		});
	 });
	function drawParentForm(rowData){
		window.parent.closeOwnVip();
		window.parent.drawForm(rowData);
	};
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
    	if(!isStayCurrentPage)mrSelectGrid.setGridParam({"page":"1"});
    	mrSelectGrid.trigger('reloadGrid');
    	//连带查询grid数据统计
    }
</script>
</html>
