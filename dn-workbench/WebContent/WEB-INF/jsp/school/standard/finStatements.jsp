<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE HTML>
<html>
<head>
<%@ include file="../../common/header.jsp"%>
<%@ include file="../../common/head.jsp"%>
<title></title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/chosen.css" />
<style type="text/css">
	.ui-jqgrid-htable{
		width: 100%;
	}
	.ui-jqgrid-labels{
	    height: 34px;
    	padding: 0 2px;
		text-align: center;
	}
	
	.ui-jqgrid-labels>th{
		width:6.5%;
	    border-right: 1px solid #D3DCEF;
	    background: #4d92f0;
	    font-weight: 500;
	    color: #fff;
    	text-align: center;
	}
	.ui-jqgrid-labels>th.first{
		width:9.9%;
	}
	.ui-row-ltr{
		height:30px;
	 	border-bottom: 1px solid #D3DCEF;
	}
	.ui-row-ltr>td{
		text-align: center;
		border-right: 1px solid #D3DCEF;
	}
	.ui-row-ltr>td.first{
		text-align: center;
		font-weight: bold;
	}
	.checkbox{
		display: inline-block;
		float: left;
	} 
	.profit td{
		color:#ff0000;
	}
</style>
</head>
<body style="height:100%;background: #fff">
	<div class="main  choice_box">
		<form id="queryForm"><!-- 查询区 表单 -->
			<div class="search border-bottom">
				<ul>
				<li style="width:200px;">
					<span>发生年份:</span>
					<div class="time_bg">
						<input id="r_year" type="text" class="search_time150" name="r_year" >
						<i class="search_time_ico2"></i>
					</div>
				</li>	
				<li style="width:600px;">
		           	<select multiple class="width-100 chosen-select tag-input-style" id="form-field-select-4" name="deptname" data-placeholder="选择科目">
						<c:forEach var="subject" items="${subjectList}">
							<option value="${subject.name}" ><c:out value="${subject.name}"></c:out></option>
						</c:forEach>
					</select>
				</li><!-- 输入框-->	
				<li style="width:400px;">
						<span>选择类别:</span>
						<input type="checkbox" name="classType" id="achieve" checked><label for="achieve">总业绩</label>
						<input type="checkbox" name="classType" id="cost" checked> <label for="cost">总成本</label>
						<input type="checkbox" name="classType" id="profit" checked><label for="profit">总利润</label>
				</li><!-- 输入框-->	
				<li>
				<input type="reset" class="reset_btn" onclick="resetQueryForm()" value="重置"><!-- 重置 -->
				<input type="button" class="search_btn mr22 " onclick="doSearch();" value="查询"></li><!-- 查询-->
				</ul>
		   </div>
	    </form>
	    <div class="listtable_box">
			<!--此处放表格-->
			<table  id="remote_rowed" class="ui-jqgrid-htable">
				<thead >
					<tr class="ui-jqgrid-labels">
						<th colspan="2" class="first">科目</th>
						<th>一月</th><th>二月</th><th>三月</th>
						<th>四月</th><th>五月</th><th>六月</th>
						<th>七月</th><th>八月</th><th>九月</th>
						<th>十月</th><th>十一月</th><th>十二月</th><th>总计</th>
					</tr>
				</thead>
				<tbody class="item-tbody">
					
				</tbody>
			</table>
		</div>
	</div>
	<iframe id="iframeAdd" name="iframeAdd" src="<%=request.getContextPath() %>/standard/toListStandardBar.do" width="100%" frameborder="no" border="0" height="51%"></iframe>
	<script type="text/template" id="subject-tpl">
					<tr class="ui-widget-content jqgrow ui-row-ltr {{class}}">
						<td class="first" style="color:#444444">{{subject}}</td><td>{{classType}}</td>
						<td>{{jan}}</td><td>{{feb}}</td>
						<td>{{mar}}</td><td>{{apr}}</td>
						<td>{{may}}</td><td>{{jun}}</td>
						<td>{{jul}}</td><td>{{aug}}</td>
						<td>{{sep}}</td><td>{{oct}}</td>
						<td>{{nov}}</td><td>{{dec}}</td><td>{{total}}</td>
					</tr>
    </script>
    <script type="text/javascript">
    $(function() {
	    	new biz.datepicker({
	  			id : "#r_year",
	  			maxDate:'#F{$dp.$D(\'r_year\');}',
	  			dateFmt:'yyyy'
	  		});
	    	$ .ajax({
				url: "<m:url value='/standard/listFinStatements.do'/>",
				cache:false,
				success: function(data){
					drawGrid(data.rows);
				}
			});
	    	//select多选 初始化方法
	    	$(".chosen-select").chosen(); 
			
    	});
    //根据查询条件请求后台查询
    function doSearch(){
    	var paramArray = [];
    	var paramObj = {};
    	var arr = [];
    	paramObj.r_year = $("#r_year").val();
        $(".chosen-choices>.search-choice").each(function(){
        	arr.push($(this).children('span').text())
        })
        paramObj.deptArr=arr.toString();
        paramObj.zyjcolunm = $("#achieve")[0].checked;
        paramObj.zcbcolunm = $("#cost")[0].checked;
        paramArray.push(paramObj);
    	 $.ajax({
             url: "<m:url value='/standard/listFinStatements.do'/>",
             type: 'post',
             dataType:"json",
             data: JSON.stringify(paramArray),
             processData: false,// 告诉jQuery不要去处理发送的数据
             contentType: false, // 告诉jQuery不要去设置Content-Type请求头
             success: function(rs) {
            	 drawGrid(rs.rows)
             }
         });
    	 
    }
   	//填充表格
	function drawGrid(data){
		var subArr = [];
		var subNameArr = [];
		var htmlTemp = [];//临时存放html数组
    	
    	for(var i = 0;i<data.length;i++){
    		//取到科目,判断科目是否已经拿到
    		if($.inArray(data[i].j_subject, subNameArr)>-1){
    			//科目存在，则不需要新建科目对象
    			//拿到后台传递的某个对象，判断传递的class类型，将月份数据放在模板对象对应的class类型行
    			//遍历subArr集合，判断后台此时拿到的数据属于哪个subject对象，拿到该subject对象
    			for(var m = 0;m < subArr.length;m++){
					// 获取模板对象subject属性，根据subject属性值获取对象
					var subject = subArr[m].j_subject;
					if(subject == data[i].j_subject){
						var subObj = subArr[m]; //拿到对象
						//对对象进行处理
						//判断数据类型
		    			switch (data[i].classType) {
		    				//新建一个achieve子对象
							case "achieve":
								subObj.achieve = {};
				    			subObj.achieve.classType=data[i].classType;
				    			subObj.achieve.monthData=[data[i].jan,data[i].feb,data[i].mar,data[i].apr,data[i].may,data[i].jun,
				    			                  data[i].jul,data[i].aug,data[i].sep,data[i].oct,data[i].nov,data[i].dec];
								break;
							//新建一个cost子对象
							case "cost":
								subObj.cost = {};
				    			subObj.cost.classType=data[i].classType;
				    			subObj.cost.monthData=[data[i].jan,data[i].feb,data[i].mar,data[i].apr,data[i].may,data[i].jun,
				    			                  data[i].jul,data[i].aug,data[i].sep,data[i].oct,data[i].nov,data[i].dec];
								break;
							default:
								break;
						}
					}
				}
    			
    		}else{//不存在，新建一个科目对象
    			var subObj = {};
    			subObj.j_subject = data[i].j_subject;
    			switch (data[i].classType) {
    				//新建一个achieve子对象
					case "achieve":
						subObj.achieve = {};
		    			subObj.achieve.classType=data[i].classType;
		    			subObj.achieve.monthData=[data[i].jan,data[i].feb,data[i].mar,data[i].apr,data[i].may,data[i].jun,
		    			                  data[i].jul,data[i].aug,data[i].sep,data[i].oct,data[i].nov,data[i].dec];
		    			subArr.push(subObj);
		    			subNameArr.push(data[i].j_subject);
						break;
					//新建一个cost子对象
					case "cost":
						subObj.cost = {};
		    			subObj.cost.classType=data[i].classType;
		    			subObj.cost.monthData=[data[i].jan,data[i].feb,data[i].mar,data[i].apr,data[i].may,data[i].jun,
		    			                  data[i].jul,data[i].aug,data[i].sep,data[i].oct,data[i].nov,data[i].dec];
		    			subArr.push(subObj);
		    			subNameArr.push(data[i].j_subject);
						break;
					default:
						break;
				}
    		}
    	}
    	//最后把模板添加到html里面
    	//将该对象模板进行替换
    	for(var i = 0;i<subArr.length;i++){
    		var achieveTotal = 0,costTotal=0;
    		if(typeof(subArr[i].achieve)!="undefined"){
    			achieveTotal = getTotal(subArr[i].achieve);
    			if($('#achieve')[0].checked){
    				replaceTml(subArr[i].j_subject,subArr[i].achieve,'总业绩',achieveTotal);
    			}
    		}
    		if(typeof(subArr[i].cost)!="undefined"){
    			costTotal  = getTotal(subArr[i].cost);
    			if($('#cost')[0].checked){
    				replaceTml(subArr[i].j_subject,subArr[i].cost,'总成本',costTotal);
    			}
    		}
    		if ($('#profit')[0].checked) {
    			var trTpl = $('#subject-tpl').html();//获取模板
    		 	htmlTemp.push(trTpl
    		 		   .replace('{{class}}', 'profit')
   				       .replace('{{subject}}', subArr[i].j_subject)
   				       .replace('{{classType}}', '总利润')
   				       .replace('{{jan}}', subArr[i].achieve.monthData[0]-subArr[i].cost.monthData[0]||0)
   				       .replace('{{feb}}', subArr[i].achieve.monthData[1]-subArr[i].cost.monthData[1]||0)
   				       .replace('{{mar}}', subArr[i].achieve.monthData[2]-subArr[i].cost.monthData[2]||0)
   				       .replace('{{apr}}', subArr[i].achieve.monthData[3]-subArr[i].cost.monthData[3]||0)
   				       .replace('{{may}}', subArr[i].achieve.monthData[4]-subArr[i].cost.monthData[4]||0)
   				       .replace('{{jun}}', subArr[i].achieve.monthData[5]-subArr[i].cost.monthData[5]||0)
   				       .replace('{{jul}}', subArr[i].achieve.monthData[6]-subArr[i].cost.monthData[6]||0)
   				       .replace('{{aug}}', subArr[i].achieve.monthData[7]-subArr[i].cost.monthData[7]||0)
   				       .replace('{{sep}}', subArr[i].achieve.monthData[8]-subArr[i].cost.monthData[8]||0)
   				       .replace('{{oct}}', subArr[i].achieve.monthData[9]-subArr[i].cost.monthData[9]||0)
   				       .replace('{{nov}}', subArr[i].achieve.monthData[10]-subArr[i].cost.monthData[10]||0)
   				       .replace('{{dec}}', subArr[i].achieve.monthData[11]-subArr[i].cost.monthData[11]||0)
   				       .replace('{{total}}',(achieveTotal-costTotal).toFixed(2)||0)
	    		) 
    		}
    	}
    	$('.item-tbody').html(htmlTemp.join('')); //通过''连接数组元素
    	//获取总值
    	function getTotal(subObj){
    		var total = 0;
    		for(var i = 0;i<subObj.monthData.length;i++){
 			   total  += Number(subObj.monthData[i]);
 		   }
    		return total;
    	}
    	//替换模板
    	function replaceTml(subName,subObj,classType,total){
    		   var trTpl = $('#subject-tpl').html();//获取模板
    		   htmlTemp.push(trTpl
    				   .replace('{{class}}', '')
    			       .replace('{{subject}}', subName)
    			       .replace('{{classType}}', classType)
    			       .replace('{{jan}}', subObj.monthData[0]||0)
    			       .replace('{{feb}}', subObj.monthData[1]||0)
    			       .replace('{{mar}}', subObj.monthData[2]||0)
    			       .replace('{{apr}}', subObj.monthData[3]||0)
    			       .replace('{{may}}', subObj.monthData[4]||0)
    			       .replace('{{jun}}', subObj.monthData[5]||0)
    			       .replace('{{jul}}', subObj.monthData[6]||0)
    			       .replace('{{aug}}', subObj.monthData[7]||0)
    			       .replace('{{sep}}', subObj.monthData[8]||0)
    			       .replace('{{oct}}', subObj.monthData[9]||0)
    			       .replace('{{nov}}', subObj.monthData[10]||0)
    			       .replace('{{dec}}', subObj.monthData[11]||0)
    			       .replace('{{total}}',total.toFixed(2))
    				)
    	   }
    	}
    	//重置查询条件
	   function resetQueryForm(){
		   resetForm('queryForm');
		   $(".chosen-container .chosen-choices li.search-choice .search-choice-close","#queryForm").trigger("click");//触发被选元素的指定事件类型。
	   }
   
   
	</script>
</body>
</html>
