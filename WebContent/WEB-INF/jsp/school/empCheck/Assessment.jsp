<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../../common/header.jsp"%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/styles/extends/css/expenseAccount.css"/>
<script type="text/javascript">
var gridObj = {};
$(function(){
	//调用方法为日期选择控件赋值为当前月份
	  document.getElementById("checkMonth").value = today();
		gridObj = new biz.grid({
        id:"#remote_rowed",/*html部分table id*/
        url: "<m:url value='/empCheck/saveAssinfo.do'/>",/*grid初始化请求数据的远程地址*/
        datatype: "json",/*数据类型，设置为json数据，默认为json*/
       	sortname:"create_time",
       	sortorder:"desc",
       	multiselect:true,
       	multiboxonly:true,
/*      cellEdit:true,//是否开启单元格的编辑功能  
       	cellsubmit:'remote',//or 'clientArray',remote代表每次编辑提交后进行服务器保存，  clientArray只保存到数据表格不保存到服务器  
       	cellurl:'<m:url value='/empCheck/update.do'/>',//cellsubmit要提交的后台路径 */  
       	forceFit:true,
 		pager: '#remote_prowed' ,/*,分页栏id，这里特殊不适用分页，操作完一页数据选择刷新表格*/
 		rowList:[10,20,50,100],//每页显示记录数
		rowNum:10,//默认显示15条
        colModel:[
			{name : "id",hidden : true,key : true,label:"主键",index : "id"},	
			{name : "empNo",label:"员工编号",index : "emp_no",width:'10'},
			{name : "empName",label:"员工姓名",index : "emp_name",width:'10'},		
			{name : "nickName",label:"昵称",index : "nickname",width:'10'},	
			{name : "department",label:"部门",index : "department",width:'20'},
			{name : "post",label:"岗位",index : "post",width:'10'},		
			{name : "",label:"考核",index : "operate",width:'20',align: 'center',formatter: function (cellvalue, options, rowObject) {
				return "<input id=\"begaincheck\" type=\"button\" class=\"ti_bottom\" value=\"开始考核\" onclick=\"begaincheck(\'" +rowObject.id+"\')\"/>"; 
				},
            },
       	],
       	serializeGridData:function(postData){//添加查询条件值
			var obj = getQueryCondition();
			$ .extend(true,obj,postData);//合并查询条件值与grid的默认传递参数
			return obj;
		},
		beforeEditCell:function(rowid,cellname,value,iRow,iCol){
            businessplanmag_iRow=iRow;//全局变量
            businessplanmag_iCol=iCol;
        },
  });
		
	//为下一页按钮绑定click事件触发savecell，有效！（但是这里更好的选择是不分页，操作完成重新刷新表格）
/* 	$('.ui-icon-seek-next').on('click', function() {
		console.log(1);
		$("#remote_rowed").jqGrid("saveCell", businessplanmag_iRow,businessplanmag_iCol);
		gridObj.trigger('reloadGrid');
		console.log(2);
	});*/
	}); 
	
	function getQueryCondition() {
		var obj = {};
		jQuery.each($("#queryForm").serializeArray(), function(i, o) {
			if (o.value) {
				obj[o.name] = o.value;
			}
		});
		return obj;
	}
	//查询Grid数据
	function doSearch(isStayCurrentPage) {
		if (!isStayCurrentPage)
			gridObj.setGridParam({
				"page" : "1"
			});
		gridObj.trigger('reloadGrid');
		
	}
	//重置查询表单
	function resetForm(formId) {
		document.getElementById(formId).reset();
	}
	//设置日期选择控件默认显示当前日期
	function today() {
		var today = new Date();
		var h = today.getFullYear();
		var m = today.getMonth();
		var d = today.getDate();
		m = m < 10 ? "0" + m : m; //  这里判断月份是否<10,如果是在月份前面加'0'
		d = d < 10 ? "0" + d : d; //  这里判断日期是否<10,如果是在日期前面加'0'
		return h + "-" + m;
	}
	function test() {//打开单元格编辑功能时使用这个方法
		//最后一条数据在关闭窗口前要用saveCell函数结束文本编辑状态，不然
		$("#remote_rowed").jqGrid("saveCell", businessplanmag_iRow,
				businessplanmag_iCol);
/* 		gridObj.trigger('reloadGrid'); 这个刷新无效要用下面的*****/
		window.location.reload();
	}
	function closeass() {
		window.parent.closeAss();
		window.location.reload();
	}
	
	function begaincheck(value){//跳转到在线考核页面，value是该条记录的主键
		console.log(value);
	}
	
	
	//考核表格弹出框
	var check_iframe_dialog;
  	 
    function begaincheck(key){
/*     	var key = ICSS.utils.getSelectRowData("id");
		if(key.indexOf(",")>-1||key==""){
			showMessage("请选择一条员工数据！");
			return ;
		} */
		var url="<m:url value='/empCheck/toCheckTable.do'/>?key="+key;
		check_iframe_dialog = new biz.dialog({
		 	id:$('<div id="checkwindow_iframe"></div>').html('<iframe id="iframeShow" name="iframeShow" src="'+url+'" width="100%" frameborder="no" border="0" height="97%"></iframe>'),  
			modal: true,
			width: $(window).width(),
			height:$(window).height(),
				title: "员工考核表"
		});
		check_iframe_dialog.open();
    }
    
    //关闭查看页面，供子页面调用
    function closeCheck(){
    	check_iframe_dialog.close();
    	window.location.reload();
    }
</script>
</head>

<body>
	<div id="editDialog" style="margin-bottom:15px;">
		<form id="queryForm">
			<div class="wrap">
<%-- 				<input type="hidden" id="department" name="department" 
					value="${org.orgName}" /> --%>
				<div class="top_head" style="margin-bottom:10px;">
					<h2 class="top_name">员工考核</h2>
				</div>
				<div class="search border-bottom">
					<ul>		
						<li><span>考核月份:</span>
							<div class="time_bg">
								<input id="checkMonth" name="checkMonth" type="text" class="search_time150" readonly="true"/>
								<!-- <i class="search_time_ico2"
									onclick="WdatePicker({el:'checkMonth',maxDate:'%y-%M',dateFmt:'yyyy-MM'})"></i> -->
									
							</div></li>
					</ul>
				</div>
			</div>
		</form>
	</div>
	<div class="main  choice_box" >
		<div class="listplace" style="padding-top:15px;">
			<div class="listtable_box">
				<table id="remote_rowed"></table>
				<div id="remote_prowed"></div>
			</div>
		</div>
	</div>
	<div class="inputTd"  style="display:block;margin-top:50px; text-align:center;">
<!-- 	<input id="savereload" type="button" class="ti_bottom" value="保存数据" onclick="test()"/> -->
	<input id="closewindow" type="button" class="ti_bottom" value="关闭" onclick="closeass()"/>
	</div>
</body>
</html>