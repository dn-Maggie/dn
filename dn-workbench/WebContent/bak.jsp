<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<title>index</title>
<meta name="description" content=" and Validation" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<!-- basic styles -->
<link rel="stylesheet"
	href="static/plugins/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="static/plugins/font-awesome/css/font-awesome.css" />
<!--[if IE 7]>
		  <link rel="stylesheet" href="css/font-awesome-ie7.min.css" />
		<![endif]-->
<!-- page specific plugin styles -->

<link rel="stylesheet" href="static/css/chosen.css" />
<!-- ace styles -->
<link rel="stylesheet" href="static/css/ace.min.css" />
<link rel="stylesheet" href="static/css/ace-responsive.min.css" />
<link rel="stylesheet" href="static/css/ace-skins.min.css" />
<!--[if lt IE 9]>
		  <link rel="stylesheet" href="css/ace-ie.min.css" />
		<![endif]-->
</head>
<body>
	<div class="navbar navbar-inverse">
		<div class="navbar-inner">
			<div class="container-fluid">
				<a class="brand" href="#"><small><i class="icon-leaf"></i>
						Ace Admin</small> </a>
				<ul class="nav ace-nav pull-right">
					<li class="grey"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown"> <i class="icon-tasks"></i> <span
							class="badge">4</span>
					</a>
						<ul
							class="pull-right dropdown-navbar dropdown-menu dropdown-caret dropdown-closer">
							<li class="nav-header"><i class="icon-ok"></i> 4 Tasks to
								complete</li>

							<li><a href="#">
									<div class="clearfix">
										<span class="pull-left">Software Update</span> <span
											class="pull-right">65%</span>
									</div>
									<div class="progress progress-mini">
										<div class="bar" style="width: 65%"></div>
									</div>
							</a></li>

							<li><a href="#">
									<div class="clearfix">
										<span class="pull-left">Hardware Upgrade</span> <span
											class="pull-right">35%</span>
									</div>
									<div class="progress progress-mini progress-danger">
										<div class="bar" style="width: 35%"></div>
									</div>
							</a></li>

							<li><a href="#">
									<div class="clearfix">
										<span class="pull-left">Unit Testing</span> <span
											class="pull-right">15%</span>
									</div>
									<div class="progress progress-mini progress-warning">
										<div class="bar" style="width: 15%"></div>
									</div>
							</a></li>

							<li><a href="#">
									<div class="clearfix">
										<span class="pull-left">Bug Fixes</span> <span
											class="pull-right">90%</span>
									</div>
									<div
										class="progress progress-mini progress-success progress-striped active">
										<div class="bar" style="width: 90%"></div>
									</div>
							</a></li>

							<li><a href="#"> See tasks with details <i
									class="icon-arrow-right"></i>
							</a></li>
						</ul></li>
					<li class="purple"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown"> <i
							class="icon-bell-alt icon-animated-bell icon-only"></i> <span
							class="badge badge-important">8</span>
					</a>
						<ul
							class="pull-right dropdown-navbar navbar-pink dropdown-menu dropdown-caret dropdown-closer">
							<li class="nav-header"><i class="icon-warning-sign"></i> 8
								Notifications</li>

							<li><a href="#">
									<div class="clearfix">
										<span class="pull-left"><i
											class="icon-comment btn btn-mini btn-pink"></i> New comments</span>
										<span class="pull-right badge badge-info">+12</span>
									</div>
							</a></li>

							<li><a href="#"> <i
									class="icon-user btn btn-mini btn-primary"></i> Bob just signed
									up as an editor ...
							</a></li>

							<li><a href="#">
									<div class="clearfix">
										<span class="pull-left"><i
											class="icon-shopping-cart btn btn-mini btn-success"></i> New
											orders</span> <span class="pull-right badge badge-success">+8</span>
									</div>
							</a></li>

							<li><a href="#">
									<div class="clearfix">
										<span class="pull-left"><i
											class="icon-twitter btn btn-mini btn-info"></i> Followers</span> <span
											class="pull-right badge badge-info">+4</span>
									</div>
							</a></li>

							<li><a href="#"> See all notifications <i
									class="icon-arrow-right"></i>
							</a></li>
						</ul></li>
					<li class="green"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown"> <i
							class="icon-envelope-alt icon-animated-vertical icon-only"></i> <span
							class="badge badge-success">5</span>
					</a>
						<ul
							class="pull-right dropdown-navbar dropdown-menu dropdown-caret dropdown-closer">
							<li class="nav-header"><i class="icon-envelope"></i> 5
								Messages</li>

							<li><a href="#"> <img alt="Alex's Avatar"
									class="msg-photo" src="avatars/avatar.png" /> <span
									class="msg-body"> <span class="msg-title"> <span
											class="blue">Alex:</span> Ciao sociis natoque penatibus et
											auctor ...
									</span> <span class="msg-time"> <i class="icon-time"></i> <span>a
												moment ago</span>
									</span>
								</span>
							</a></li>

							<li><a href="#"> <img alt="Susan's Avatar"
									class="msg-photo" src="avatars/avatar3.png" /> <span
									class="msg-body"> <span class="msg-title"> <span
											class="blue">Susan:</span> Vestibulum id ligula porta felis
											euismod ...
									</span> <span class="msg-time"> <i class="icon-time"></i> <span>20
												minutes ago</span>
									</span>
								</span>
							</a></li>

							<li><a href="#"> <img alt="Bob's Avatar"
									class="msg-photo" src="avatars/avatar4.png" /> <span
									class="msg-body"> <span class="msg-title"> <span
											class="blue">Bob:</span> Nullam quis risus eget urna mollis
											ornare ...
									</span> <span class="msg-time"> <i class="icon-time"></i> <span>3:15
												pm</span>
									</span>
								</span>
							</a></li>

							<li><a href="#"> See all messages <i
									class="icon-arrow-right"></i>
							</a></li>

						</ul></li>
					<li class="light-blue user-profile"><a
						class="user-menu dropdown-toggle" href="#" data-toggle="dropdown">
							<img alt="Jason's Photo" src="avatars/user.jpg"
							class="nav-user-photo" /> <span id="user_info"> <small>Welcome,</small>
								Jason
						</span> <i class="icon-caret-down"></i>
					</a>
						<ul id="user_menu"
							class="pull-right dropdown-menu dropdown-yellow dropdown-caret dropdown-closer">
							<li><a href="#"><i class="icon-cog"></i> Settings</a></li>
							<li><a href="#"><i class="icon-user"></i> Profile</a></li>
							<li class="divider"></li>
							<li><a href="#"><i class="icon-off"></i> Logout</a></li>
						</ul></li>
				</ul>
				<!--/.ace-nav-->
			</div>
			<!--/.container-fluid-->
		</div>
		<!--/.navbar-inner-->
	</div>
	<!--/.navbar-->
	<div class="container-fluid" id="main-container">
		<a href="#" id="menu-toggler"><span></span></a>
		<!-- menu toggler -->



		<div id="sidebar">



			<div id="sidebar-shortcuts">

				<div id="sidebar-shortcuts-large">

					<button class="btn btn-small btn-success">
						<i class="icon-signal"></i>
					</button>

					<button class="btn btn-small btn-info">
						<i class="icon-pencil"></i>
					</button>

					<button class="btn btn-small btn-warning">
						<i class="icon-group"></i>
					</button>

					<button class="btn btn-small btn-danger">
						<i class="icon-cogs"></i>
					</button>

				</div>

				<div id="sidebar-shortcuts-mini">

					<span class="btn btn-success"></span> <span class="btn btn-info"></span>

					<span class="btn btn-warning"></span> <span class="btn btn-danger"></span>

				</div>

			</div>
			<!-- #sidebar-shortcuts -->



			<ul class="nav nav-list">



				<li><a href="index.html"> <i class="icon-dashboard"></i> <span>Dashboard</span>



				</a></li>





				<li><a href="typography.html"> <i class="icon-text-width"></i>

						<span>Typography</span>



				</a></li>





				<li><a href="#" class="dropdown-toggle"> <i
						class="icon-desktop"></i> <span>UI Elements</span> <b
						class="arrow icon-angle-down"></b>

				</a>
					<ul class="submenu">
						<li><a href="elements.html"><i
								class="icon-double-angle-right"></i> Elements</a></li>
						<li><a href="buttons.html"><i
								class="icon-double-angle-right"></i> Buttons & Icons</a></li>
					</ul></li>





				<li><a href="tables.html"> <i class="icon-list"></i> <span>Tables</span>



				</a></li>





				<li class="active open"><a href="#" class="dropdown-toggle">

						<i class="icon-edit"></i> <span>Forms</span> <b
						class="arrow icon-angle-down"></b>

				</a>
					<ul class="submenu">
						<li><a href="form-elements.html"><i
								class="icon-double-angle-right"></i> Form Elements</a></li>
						<li class="active"><a href="form-wizard.html"><i
								class="icon-double-angle-right"></i> Wizard & Validation</a></li>
					</ul></li>





				<li><a href="widgets.html"> <i class="icon-list-alt"></i> <span>Widgets</span>



				</a></li>





				<li><a href="calendar.html"> <i class="icon-calendar"></i>

						<span>Calendar</span>



				</a></li>





				<li><a href="gallery.html"> <i class="icon-picture"></i> <span>Gallery</span>



				</a></li>





				<li><a href="grid.html"> <i class="icon-th"></i> <span>Grid</span>



				</a></li>





				<li><a href="#" class="dropdown-toggle"> <i
						class="icon-file"></i> <span>Other Pages</span> <b
						class="arrow icon-angle-down"></b>

				</a>
					<ul class="submenu">
						<li><a href="pricing.html"><i
								class="icon-double-angle-right"></i> Pricing Tables</a></li>
						<li><a href="invoice.html"><i
								class="icon-double-angle-right"></i> Invoice</a></li>
						<li><a href="login.html"><i
								class="icon-double-angle-right"></i> Login & Register</a></li>
						<li><a href="error-404.html"><i
								class="icon-double-angle-right"></i> Error 404</a></li>
						<li><a href="error-500.html"><i
								class="icon-double-angle-right"></i> Error 500</a></li>
						<li><a href="blank.html"><i
								class="icon-double-angle-right"></i> Blank Page</a></li>
					</ul></li>





			</ul>
			<!--/.nav-list-->



			<div id="sidebar-collapse">
				<i class="icon-double-angle-left"></i>
			</div>





		</div>
		<!--/#sidebar-->




		<div id="main-content" class="clearfix">


			<div id="breadcrumbs">

				<ul class="breadcrumb">

					<li><i class="icon-home"></i> <a href="#">Home</a><span
						class="divider"><i class="icon-angle-right"></i></span></li>

					<li><a href="#">Forms</a> <span class="divider"><i
							class="icon-angle-right"></i></span></li>
					<li class="active">Wizard & Validation</li>
				</ul>
				<!--.breadcrumb-->



				<div id="nav-search">

					<form class="form-search">

						<span class="input-icon"> <input autocomplete="off"
							id="nav-search-input" type="text"
							class="input-small search-query" placeholder="Search ..." /> <i
							id="nav-search-icon" class="icon-search"></i>

						</span>

					</form>

				</div>
				<!--#nav-search-->

			</div>
			<!--#breadcrumbs-->



			<div id="page-content" class="clearfix">

			
			<!--/#page-content-->

			<div id="ace-settings-container">
				<div class="btn btn-app btn-mini btn-warning" id="ace-settings-btn">
					<i class="icon-cog"></i>
				</div>
				<div id="ace-settings-box">
					<div>
						<div class="pull-left">
							<select id="skin-colorpicker" class="hidden">
								<option data-class="default" value="#438EB9">#438EB9</option>
								<option data-class="skin-1" value="#222A2D">#222A2D</option>
								<option data-class="skin-2" value="#C6487E">#C6487E</option>
								<option data-class="skin-3" value="#D0D0D0">#D0D0D0</option>
							</select>
						</div>
						<span>&nbsp; Choose Skin</span>
					</div>
					<div>
						<input type="checkbox" class="ace-checkbox-2"
							id="ace-settings-header" /><label class="lbl"
							for="ace-settings-header"> Fixed Header</label>
					</div>
					<div>
						<input type="checkbox" class="ace-checkbox-2"
							id="ace-settings-sidebar" /><label class="lbl"
							for="ace-settings-sidebar"> Fixed Sidebar</label>
					</div>
				</div>
			</div>
			<!--/#ace-settings-container-->
		</div>
		<!-- #main-content -->
	</div>
	<!--/.fluid-container#main-container-->
	<a href="#" id="btn-scroll-up" class="btn btn-small btn-inverse"> <i
		class="icon-double-angle-up icon-only"></i>
	</a>
	<!-- basic scripts -->
	<script src="static/plugins/jQuery/jquery-2.1.1.min.js"></script>
	<script src="static/plugins/bootstrap/js/bootstrap.min.js"></script>
	<!-- page specific plugin scripts -->

	<script type="text/javascript" src="static/js/fuelux.wizard.js"></script>
	<script type="text/javascript" src="static/js/jquery.validate.min.js"></script>
	<script type="text/javascript" src="static/js/bootbox.min.js"></script>
	<script type="text/javascript" src="static/js/jquery.maskedinput.min.js"></script>
	<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script>
	<!-- ace scripts -->
	<script src="static/js/ace-elements.min.js"></script>
	<script src="static/js/ace.min.js"></script>
	<!-- inline scripts related to this page -->

	<script type="text/javascript">
		$(function() {
			$('[data-rel=tooltip]').tooltip();
			$(".chzn-select").css('width', '150px').chosen({
				allow_single_deselect : true,
				no_results_text : "No such state!"
			}).on('change', function() {
				$(this).closest('form').validate().element($(this));
			});
			var $validation = false;
			$('#fuelux-wizard')
					.ace_wizard()
					.on('change', function(e, info) {
						if (info.step == 1 && $validation) {
							if (!$('#validation-form').valid())
								return false;
						}
					})
					.on(
							'finished',
							function(e) {
								bootbox
										.dialog(
												"Thank you! Your information was successfully saved!",
												[ {
													"label" : "OK",
													"class" : "btn-small btn-primary",
												} ]);
							});

			$('#validation-form').hide();
			$('#skip-validation').removeAttr('checked').on('click', function() {
				$validation = this.checked;
				if (this.checked) {
					$('#sample-form').hide();
					$('#validation-form').show();
				} else {
					$('#validation-form').hide();
					$('#sample-form').show();
				}
			});

			//documentation : http://docs.jquery.com/Plugins/Validation/validate

			$.mask.definitions['~'] = '[+-]';
			$('#phone').mask('(999) 999-9999');
			jQuery.validator.addMethod("phone", function(value, element) {
				return this.optional(element)
						|| /^\(\d{3}\) \d{3}\-\d{4}( x\d{1,6})?$/.test(value);
			}, "Enter a valid phone number.");

			$('#validation-form')
					.validate(
							{
								errorElement : 'span',
								errorClass : 'help-inline',
								focusInvalid : false,
								rules : {
									email : {
										required : true,
										email : true
									},
									password : {
										required : true,
										minlength : 5
									},
									password2 : {
										required : true,
										minlength : 5,
										equalTo : "#password"
									},
									name : {
										required : true
									},
									phone : {
										required : true,
										phone : 'required'
									},
									url : {
										required : true,
										url : true
									},
									comment : {
										required : true
									},
									state : {
										required : true
									},
									platform : {
										required : true
									},
									subscription : {
										required : true
									},
									gender : 'required',
									agree : 'required'
								},
								messages : {
									email : {
										required : "Please provide a valid email.",
										email : "Please provide a valid email."
									},
									password : {
										required : "Please specify a password.",
										minlength : "Please specify a secure password."
									},
									subscription : "Please choose at least one option",
									gender : "Please choose gender",
									agree : "Please accept our policy"
								},
								invalidHandler : function(event, validator) { //display error alert on form submit   
									$('.alert-error', $('.login-form')).show();
								},
								highlight : function(e) {
									$(e).closest('.control-group').removeClass(
											'info').addClass('error');
								},
								success : function(e) {
									$(e).closest('.control-group').removeClass(
											'error').addClass('info');
									$(e).remove();
								},
								errorPlacement : function(error, element) {
									if (element.is(':checkbox')
											|| element.is(':radio')) {
										var controls = element
												.closest('.controls');
										if (controls.find(':checkbox,:radio').length > 1)
											controls.append(error);
										else
											error.insertAfter(element.nextAll(
													'.lbl').eq(0));
									} else if (element.is('.chzn-select')) {
										error.insertAfter(element.nextAll(
												'[class*="chzn-container"]')
												.eq(0));
									} else
										error.insertAfter(element);
								},
								submitHandler : function(form) {
								},
								invalidHandler : function(form) {
								}
							});

		})
	</script>
</body>
</html>
