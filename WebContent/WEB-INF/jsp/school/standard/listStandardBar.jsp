<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../../common/header.jsp"%>
<title>数据统计图</title>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/echarts-2.2.7/echarts.js" ></script>
<style>
	@charset "utf-8";
	#monthMap{
		display: none;
	    position: relative;
	    z-index:-1;
	    left:96px;
	}
	.timeWrapper{
		display: none;
	    position: relative;
        z-index: -1;
        left: 94px;
		width: 200px;
		height: 200px;
		box-sizing: border-box;
		border: 1px solid #ccc;
		font-family:"comic sans ms";
		font-size: 0.8em;
	}
	.timeWrapper ul{
		list-style: none;
	}
	
	.timeYear{
		height: 90%;
		width:100%;
		position: relative;
	    overflow: hidden;
	}
	.timeYear ul{
		height: 100%;
		
	}
	.timeYear>ul>li{
		height: 20%;
		background: #eee;
	    margin: 0;
        position: static;
	}
	.timeYear>ul>li>.yearItem{
		display: inline-block;
		text-align: center;
		height: 100%;
	    line-height: 3em;
		width: 25%;
		border: 1px #fff solid;
		box-sizing: border-box;
		cursor: pointer;
	    position: relative;
		top: 0;
  		margin: 0;
    	border: 0;
	}
	.timeMon{
	    display: none;
	    position: absolute;
	    left: 25%;
	    top: 0;
        height: 100%;
	    z-index: 999;
	}
	.timeMon>ul>li{
		float: left;
		width: 33%;
	    height: 25%;
		background: #ddd;
		border: 1px #fff solid;
		box-sizing: border-box;
		margin: 0;
	}
	.timeMon>ul>li>.monItem{
		display: inline-block;
		width: 100%;
		height: 100%;
		line-height:3.5em;
		cursor: pointer;
		text-align: center;
	}
	.timeMon>ul>li>.monItem:hover{
		background: #fff;
	}
	.yearItem.active+.timeMon{
		display: block;
	}
	ul li:hover{
		background: #fff;
	}
	.btn-area{
	    display: block;
	    height: 10%;
	    line-height: 10%;
	    border-top: #ccc solid 1px;
	    background: #DDDDDD;
	    position: relative;
	    bottom: 0;
	    text-align: center;
	}
	.btn-area a{
	    text-decoration: none;
	    display: inline-block;
	    text-align: center;
	    height: 100%;
	    line-height: 1.5em;
	    width: 48%;
	    box-sizing: border-box;
	    background: #CCCCCC;
	    color: #fff;
	    font-weight: bold;
	}
	.btn-area a:hover{
		color: #333;
	}
	#main{
		position:absolute;
		top:100px;
		left:0;
		right:0;
		bottom:5%;
	}
	#subchart{
		position:absolute;
		top:100px;
		left:0;
		right:0;
		bottom:5%;
	}
</style>
</head>
<body style="height:100%;">
	<div class="main  choice_box">
		<form id="queryForm"><!-- 查询区 表单 -->
			<div class="search border-bottom">
				<ul>
				<li style="width:160px;">
						<select class="search_choose" name="subjectName" id="subjectName" mainid="subjectName" style="width:88px;">
						<option value="">全部</option>
						<c:forEach var="subject" items="${subject}">
							<option value="${subject.name}"> <c:out value="${subject.name}"></c:out> </option>
			            </c:forEach>
					</select><span>学科:</span>
					</li><!-- 输入框-->
					
					<li style="width: 300px">
						<span>月份:</span>
						<input type="text" id="monthChoose" class="search_choose" style="width: 200px;float:left;"/>
						<div class="timeWrapper">
							<div class="timeYear">
								<ul>
									
								</ul>
							</div>
							<div class="btn-area">
								<a href="javascript:0" id="confirm">确定</a>
								<a href="javascript:0" id="reset">清空</a>
							</div>
						</div>
					</li>	
					<li><input type="reset" class="reset_btn" onclick="resetForm('queryForm');months=[]" value="重置"><!-- 重置 -->
						<input type="button" class="search_btn mr22 " onclick="arr=[];ajaxGetStatistic();drawMainChart();" value="查询">
					</li><!-- 查询-->
				</ul>
		   </div>
	    </form>
		
		<div id="main"></div>
	</div>
	
		<script type="text/template" id="yearTemp">
				<li><span class="yearItem " data-key="{{year}}" style="top:0;">{{year}}年</span></li>
		</script>
		<script type="text/template" id="monTemp">
			<div class='timeMon'>
				<ul>
					<li><span class='monItem ' data-key='1'>一月</span></li>
					<li><span class='monItem ' data-key='2'>二月</span></li>
					<li><span class='monItem ' data-key='3'>三月</span></li>
					<li><span class='monItem ' data-key='4'>四月</span></li>
					<li><span class='monItem ' data-key='5'>五月</span></li>
					<li><span class='monItem ' data-key='6'>六月</span></li>
					<li><span class='monItem ' data-key='7'>七月</span></li>
					<li><span class='monItem ' data-key='8'>八月</span></li>
					<li><span class='monItem ' data-key='9'>九月</span></li>
					<li><span class='monItem ' data-key='10'>十月</span></li>
					<li><span class='monItem ' data-key='11'>十一月</span></li>
					<li><span class='monItem ' data-key='12'>十二月</span></li>
				</ul>
			</div>
		</script>
	<script type="text/javascript">
	var arr = [];
	var months =[];
	$(document).ready(function(){
		Array.prototype.in_array = function(e){  //?
			for(i=0;i<this.length;i++){  
				if(this[i] == e)return true;  
			}  
			return false;  
		};
		//获取数据库结果集并把结果放入arr[]中
		ajaxGetStatistic();
		//绘制图表
		drawMainChart();
	})
	.on('mouseover', '.yearItem', function() {
		//给带有yearItem类的标签绑定鼠标划动事件，清除其他年份上的active类
		var yearItem = $(".yearItem")
		//console.log(yearItem.length);
		for(var j = 0;j<yearItem.length;j++){
			yearItem[j].parentNode.style.backgroundColor="#eee";
			yearItem[j].className =yearItem[j].className.replace(/active/, '');//?
		}
		//给当前年份添加active类
		this.className +="active";
		this.parentNode.style.backgroundColor="#FFFFFF";
		//在选择年份的情况下选择月份
		var monItem = $(".monItem");
		
		for(var i = 0;i<monItem.length;i++){
			monItem[i].onclick = function(e){
				if(/choosed/.test(this.className)){
					this.className = this.className.replace(/choosed/, '');
					this.parentNode.style.backgroundColor="#ddd";
					months.splice(months.indexOf(this.getAttribute("data-key")),1);
				}else{
					this.className +="choosed";
					this.parentNode.style.backgroundColor="#FFFFFF";
					months.push($(".active")[0].getAttribute("data-key")+"-"+this.getAttribute("data-key"));
				}
				$("#monthChoose").val(months);
			}
		}
		//滚动年份
		this.onmousewheel = function(e){
			var direct = 0;
			e = e || window.event;
			if (e.wheelDelta) {  //判断浏览器IE，谷歌滑轮事件             
	            if (e.wheelDelta > 0) { //当滑轮向上滚动时
	            	var firstYear = parseInt($(".timeYear>ul>li:first-child>.yearItem")[0].getAttribute("data-key"));
					$(".timeYear>ul>li:first-child").before($('#yearTemp').html().replace(/{{year}}/g,firstYear-1));
					$(".timeYear>ul>li:first-child").append(($('#monTemp').html()));
					//最下面的被挤下去
					$(".timeYear>ul>li:last-child").remove();
	            }
	            if (e.wheelDelta < 0) { //当滑轮向下滚动时
	              	var lastYear = parseInt($(".timeYear>ul>li:last-child>.yearItem")[0].getAttribute("data-key"));
					$(".timeYear>ul>li:last-child").after($('#yearTemp').html().replace(/{{year}}/g,lastYear+1));
					$(".timeYear>ul>li:last-child").append(($('#monTemp').html()));
					//最上面的被挤上去
					$(".timeYear>ul>li:first-child").remove();
	            }
	        } else if (e.detail) {  //Firefox滑轮事件
	            if (e.detail> 0) { //当滑轮向上滚动时
	                var firstYear = parseInt($(".timeYear>ul>li:first-child>.yearItem")[0].getAttribute("data-key"));
					$(".timeYear>ul>li:first-child").before($('#yearTemp').html().replace(/{{year}}/g,firstYear-1));
					$(".timeYear>ul>li:first-child").append(($('#monTemp').html()));
					//最下面的被挤下去
					$(".timeYear>ul>li:last-child").remove();
	            }
	            if (e.detail< 0) { //当滑轮向下滚动时
              		var lastYear = parseInt($(".timeYear>ul>li:last-child>.yearItem")[0].getAttribute("data-key"));
					$(".timeYear>ul>li:last-child").after($('#yearTemp').html().replace(/{{year}}/g,lastYear+1));
					$(".timeYear>ul>li:last-child").append(($('#monTemp').html()));
					//最上面的被挤上去
					$(".timeYear>ul>li:first-child").remove();
	            }
	        }
		}
	})
	.on('click', '#confirm', function() {
		$("#monthChoose").val(months);
		$(".timeWrapper").css("display", "none"); 
	})
	.on('click', '#reset', function() {
		months=[];
		var monItem = $(".monItem");
		for(var i = 0;i<monItem.length;i++){
			monItem[i].className = monItem[i].className.replace(/choosed/, '');
			monItem[i].parentNode.style.backgroundColor="#ddd";
		}
		$("#monthChoose").val(months);
	})
	.on('click', '#monthChoose', function() { 
		$(".timeWrapper").css("display", "block"); 
		//自动添加近五年年份
		var currYear = new Date().getFullYear();
		if($(".timeYear>ul>li").length<1){
			for(var i = 4;i>=0;i--){
				$(".timeYear>ul")[0].innerHTML += $('#yearTemp').html().replace(/{{year}}/g,currYear-i);
			}
			$(".timeYear>ul>li:last-child>.yearItem")[0].className +="active";
			//自动添加月份
			var yearItem = $(".yearItem");
			yearItem.after($('#monTemp').html());
		}
	});
		
	function drawMainChart(){
		//初始化变量
		var names = [];
		var actualPay = []
		var allCome = [];
		var shouldPay = [];
		var profit = [];
		var pay = [];
		//先判断结果集是否存在，通过遍历结果集，分别获得月份名、实收报名费、总业绩、应收学费
		if(arr.length>0){
			for(var key in arr[0]){//遍历data数据放入names 
				names.push(key);//names存放的是key值 ：比如2016-09
			}
			names.sort(function compare(v1,v2){
				return  v1.split("-")[0]==v2.split("-")[0]?v1.split("-")[1]-v2.split("-")[1]:v1.split("-")[0]>v2.split("-")[0];
			});
			var name;
			for(var j=0;j<names.length;j++){    
				name = arr[0][names[j]];
				if(name){
					actualPay.push(Math.round(name.xfsr));
					allCome.push(Math.round(name.xfbk+name.xfsr));
					shouldPay.push(Math.round(name.shouldPay));
					profit.push(Math.round(name.xfbk+name.xfsr-name.pay));
					pay.push(Math.round(name.pay));
				}else{
					actualPay.push(0);allCome.push(0);profit.push(0);pay.push(0);shouldPay.push(0);
				}
	        } 
		}
		var mainChart = echarts.init(document.getElementById("main"));
		$(window).on('resize',function(){//大小自适应
			mainChart.resize();
		});
		var option = {
			tooltip: {
				show:true,
		        trigger: 'axis'
		    },
		     toolbox: {
		        feature: {
		            dataView: {show: true, readOnly: true,title:'数据视图'},//右侧小图标
		            magicType: {show: true, type: ['line', 'bar']},
		            saveAsImage: {show: true}//保存为图片
		        }
		    },
			title: {
	            text: ''
	        },
	        legend: {
	            data:['总业绩','应收总额','实收报名费','总成本','总利润','业绩增长比']//更换成指标项 ：总业绩、应收总额、实收报名费
	        },
	        //x坐标
	        xAxis: [
	        	{
	   				type: 'category', //坐标轴类型
	   				axisLabel:{
	        			show:true
	        		},
	                data:  names //更换成动态数据，最近6个月
				}
	        ],
	        //y坐标
	        yAxis: {
	            type: 'value',
	            name: '金额',
	            min: 0,
	            axisLabel: {
	                formatter: '$ {value}'
	            }
	        },
			series: [{
	                name: '总业绩',
	                type: 'bar',
	                data: allCome //更换成动态数据
	          	},
		        {
		            name:'应收总额',
		            type:'bar',
		            data:shouldPay //更换成动态数据
		        },
		        {
		            name:'实收报名费',
		            type:'bar',
		            data:actualPay //更换成动态数据
		        },
		        {
		            name:'总成本',
		            type:'bar',
		            data:pay //更换成动态数据
		        },
		        {
		            name:'总利润',
		            type:'bar',
		            data:profit //更换成动态数据
		        },
		        {
		            name:'业绩增长比',
		            type:'line',
		            data:allCome //更换成动态数据
		        }
		    ],
		    color:['#f68484',  '#75b9e6', 'rgb(135, 184, 127)','#ae91e1', '#f6ac61', '#c4ccd3'],
		}
		mainChart.setOption(option);
	}
	
	function hideMonthMap(){
		$(".timeWrapper").css("display", "none"); 
	} 
	//根据条件从数据库获取结果集
	function ajaxGetStatistic(){
			var paramDatas = {months:$("#monthChoose").val(),subjectName:encodeURI($("#subjectName").val())};
	       	$.ajax({
	   			url : "<m:url value='/standard/getBarStatistic.do'/>",
	   			cache : false,
	   			data: paramDatas,
	   			async : false,
	   			dataType:"json",
	   			success : function(data) {
	   				arr.push(data);
	   				//console.log(arr);
	   			}
	   		});
    };
    </script>	
</body>
</html>
