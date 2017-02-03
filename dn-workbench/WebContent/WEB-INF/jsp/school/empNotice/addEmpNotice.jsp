<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<%@ include file="../../common/head.jsp"%>
	</head>
	<body>
		<div class="main-container" id="main-container">
			<script type="text/javascript">
				try{ace.settings.check('main-container' , 'fixed')}catch(e){}
			</script>

			<div class="main-container-inner">
					<div class="page-content">

						<div class="row">
							<div class="col-xs-12">
								<!-- PAGE CONTENT BEGINS -->
								<form id="empNoticeFormEdit" >
								<h4 class="header green clearfix">
									公告标题：<input id="edit_noticeTitle" name="noticeTitle" type="text" class="noticeTitle text" value="${empNotice.noticeTitle}"/>
									<span class="block pull-right">
										<small class="grey middle">选择编辑器样式:</small>

										<span class="btn-toolbar inline middle no-margin">
											<span data-toggle="buttons" class="btn-group no-margin">
												<label class="btn btn-sm btn-yellow">1<input type="radio" value="1" />
												</label>

												<label class="btn btn-sm btn-yellow active">2<input type="radio" value="2" />
												</label>

												<label class="btn btn-sm btn-yellow">3<input type="radio" value="3" />
												</label>
											</span>
										</span>
									</span>
								</h4>
								<div class="wysiwyg-editor" id="noticeContent"></div>
								</form>
								<div class="widget-toolbox padding-4 clearfix">
									<div class="btn-group pull-left">
										<button class="btn btn-sm btn-grey" id="reset">
											<i class="icon-remove bigger-125"></i>
											清空
										</button>
									</div>

									<div class="btn-group pull-right">
										<button class="btn btn-sm btn-success" id="submit">
											<i class="icon-globe bigger-125"></i>
											发布
											<i class="icon-arrow-right icon-on-right bigger-125"></i>
										</button>
									</div>
								</div>
								<!-- PAGE CONTENT ENDS -->
							</div><!-- /.col -->
						</div><!-- /.row -->
					</div><!-- /.page-content -->
			</div><!-- /.main-container-inner -->
		
		</div><!-- /.main-container -->

		<!-- basic scripts -->

		<!--[if !IE]> -->

		<script type="text/javascript">
			window.jQuery || document.write("<script src='<%=request.getContextPath() %>/static/js/jquery-2.0.3.min.js'>"+"<"+"/script>");
		</script>

		<!-- <![endif]-->

		<!--[if IE]>
			<script type="text/javascript">
			 window.jQuery || document.write("<script src='<%=request.getContextPath() %>/static/js/jquery-1.10.2.min.js'>"+"<"+"/script>");
			</script>
		<![endif]-->

		<script type="text/javascript">
			if("ontouchend" in document) document.write("<script src='<%=request.getContextPath() %>/static/js/jquery.mobile.custom.min.js'>"+"<"+"/script>");
		</script>
		<script src="<%=request.getContextPath() %>/static/js/bootstrap.min.js"></script>
		<script src="<%=request.getContextPath() %>/static/js/typeahead-bs2.min.js"></script>

		<!-- page specific plugin scripts -->

		<script src="<%=request.getContextPath() %>/static/js/jquery-ui-1.10.3.custom.min.js"></script>
		<script src="<%=request.getContextPath() %>/static/js/jquery.ui.touch-punch.min.js"></script>
		<script src="<%=request.getContextPath() %>/static/js/markdown/markdown.min.js"></script>
		<script src="<%=request.getContextPath() %>/static/js/markdown/bootstrap-markdown.min.js"></script>
		<script src="<%=request.getContextPath() %>/static/js/jquery.hotkeys.min.js"></script>
		<script src="<%=request.getContextPath() %>/static/js/bootstrap-wysiwyg.min.js"></script>
		<script src="<%=request.getContextPath() %>/static/js/bootbox.min.js"></script>

		<!-- ace scripts -->

		<script src="<%=request.getContextPath() %>/static/js/ace-elements.min.js"></script>
		<script src="<%=request.getContextPath() %>/static/js/ace.min.js"></script>

		<!-- inline scripts related to this page -->

<script type="text/javascript">
/* var createDate = new Date().format('yyyy-MM-dd hh:mm:ss');//获取今日时间 */
jQuery(function($){
	/* $("#edit_createTime").val(createDate); */
	function showErrorAlert (reason, detail) {
		var msg='';
		if (reason==='unsupported-file-type') { msg = "Unsupported format " +detail; }
		else {
			console.log("error uploading file", reason, detail);
		}
		$('<div class="alert"> <button type="button" class="close" data-dismiss="alert">&times;</button>'+ 
		 '<strong>File upload error</strong> '+msg+' </div>').prependTo('#alerts');
	}

	//$('#noticeContent').ace_wysiwyg();//this will create the default editor will all buttons

	//but we want to change a few buttons colors for the third style
	$('#noticeContent').ace_wysiwyg({
		toolbar:
		[
			'font',
			null,
			'fontSize',
			null,
			{name:'bold', className:'btn-info'},
			{name:'italic', className:'btn-info'},
			{name:'strikethrough', className:'btn-info'},
			{name:'underline', className:'btn-info'},
			null,
			{name:'insertunorderedlist', className:'btn-success'},
			{name:'insertorderedlist', className:'btn-success'},
			{name:'outdent', className:'btn-purple'},
			{name:'indent', className:'btn-purple'},
			null,
			{name:'justifyleft', className:'btn-primary'},
			{name:'justifycenter', className:'btn-primary'},
			{name:'justifyright', className:'btn-primary'},
			{name:'justifyfull', className:'btn-inverse'},
			null,
			{name:'createLink', className:'btn-pink'},
			{name:'unlink', className:'btn-pink'},
			null,
			{name:'insertImage', className:'btn-success'},
			null,
			'foreColor',
			null,
			{name:'undo', className:'btn-grey'},
			{name:'redo', className:'btn-grey'}
		],
		'wysiwyg': {
			fileUploadError: showErrorAlert
		}
	}).prev().addClass('wysiwyg-style2');



	$('[data-toggle="buttons"] .btn').on('click', function(e){
		var target = $(this).find('input[type=radio]');
		var which = parseInt(target.val());
		var toolbar = $('#noticeContent').prev().get(0);
		if(which == 1 || which == 2 || which == 3) {
			toolbar.className = toolbar.className.replace(/wysiwyg\-style(1|2)/g , '');
			if(which == 1) $(toolbar).addClass('wysiwyg-style1');
			else if(which == 2) $(toolbar).addClass('wysiwyg-style2');
		}
	});

	$('#submit').on('click', function(){
		var paramDatas = {
				noticeTitle:$("#edit_noticeTitle").val(),
				noticeContent:$("#noticeContent").html(),
		}
		$.ajax({
			   type: "post",
			   url: "<%=request.getContextPath() %>/empNotice/addEmpNotice.do",
			   data: paramDatas,
			   cache: false,
			   dataType:"json",
			   success:function(response){
				   window.parent.showMessage("操作成功","","",function(){
			     		window.parent.doSearch();
					});
			   }
			});
		
	});
	$('#reset').on('click', function(){
			$("#edit_noticeTitle").val("");
			$("#noticeContent").html("");
	});
	//Add Image Resize Functionality to Chrome and Safari
	//webkit browsers don't have image resize functionality when content is editable
	//so let's add something using jQuery UI resizable
	//another option would be opening a dialog for user to enter dimensions.
		if ( typeof jQuery.ui !== 'undefined' && /applewebkit/.test(navigator.userAgent.toLowerCase()) ) {
			
			var lastResizableImg = null;
			function destroyResizable() {
				if(lastResizableImg == null) return;
				lastResizableImg.resizable( "destroy" );
				lastResizableImg.removeData('resizable');
				lastResizableImg = null;
			}
	
			var enableImageResize = function() {
				$('.wysiwyg-editor')
				.on('mousedown', function(e) {
					var target = $(e.target);
					if( e.target instanceof HTMLImageElement ) {
						if( !target.data('resizable') ) {
							target.resizable({
								aspectRatio: e.target.width / e.target.height,
							});
							target.data('resizable', true);
							
							if( lastResizableImg != null ) {//disable previous resizable image
								lastResizableImg.resizable( "destroy" );
								lastResizableImg.removeData('resizable');
							}
							lastResizableImg = target;
						}
					}
				})
				.on('click', function(e) {
					if( lastResizableImg != null && !(e.target instanceof HTMLImageElement) ) {
						destroyResizable();
					}
				})
				.on('keydown', function() {
					destroyResizable();
				});
	    	}
			enableImageResize();
		}
	});
	</script>
	</body>
</html>
