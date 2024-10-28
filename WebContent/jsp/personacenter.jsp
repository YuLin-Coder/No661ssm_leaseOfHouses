<!-- 个人中心 -->
<%@page import="java.util.UUID"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>个人中心</title>
<%
	pageContext.setAttribute("app_path", request.getContextPath());
%>
<!--  Bootstrap 核心 CSS 文件 -->
<link rel="stylesheet"
	href="../static/bootstrap-3.3.7-dist/css/bootstrap.css">
<!-- 引用css -->
<style type="text/css">
@import url("../css/personalcenter.css");
@import url("../css/load.css");
</style>
<!-- 引用js -->
<script type="text/javascript"
	src="../static/jquery/jquery-1.11.0.min.js"></script>
<!-- Bootstrap 核心 JavaScript 文件 -->
<script src="../static/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
</head>
<body>
<%
	String user=null;
	user=(String)session.getAttribute("user");
	if(user==null){
		response.sendRedirect("official.jsp");
	}
	String token =  UUID.randomUUID().toString() ;//创建令牌
	System.out.println("在personacenter中生成的token："+token);
	session.setAttribute("token", token);  //在服务器使用session保存token(令牌)
%>
	<!-- 加载动画 -->
	<div class="loader-wrapper">
		<span class="loader"><span class="loader-inner"></span></span>
	</div>
	
	<div id="loadmain">
		<!-- 导航栏 -->
		<nav id="navigation" class="navbar navbar-default" role="navigation">
			<div class="container-fluid">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse"
						data-target="#example-navbar-collapse">
						<span class="sr-only">切换导航</span> <span class="icon-bar"></span> <span
							class="icon-bar"></span> <span class="icon-bar"></span>
					</button>
					<a class="navbar-brand" href="${app_path}/jsp/official.jsp">官网</a>
				</div>
				<div class="collapse navbar-collapse" id="example-navbar-collapse">
					<ul class="nav navbar-nav">
						<li class="active"><a href="${app_path}/jsp/official.jsp">首页</a></li>
						<li><a href="#">欢迎您！<%=session.getAttribute("user") %></a></li>
						<li><a href="${app_path}/userlistmvc/cancellation.do">注销 </a></li>
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown"> 指南<b class="caret"></b>
						</a>
							<ul class="dropdown-menu">
								<li><a href="#">了解我们</a></li>
								<li><a href="#">租赁信息</a></li>
								<li><a href="#">投诉</a></li>
								<li class="divider"></li>
								<li><a href="#">用户协议</a></li>
								<li class="divider"></li>
								<li><a href="#">房产知识</a></li>
							</ul></li>
					</ul>
				</div>
			</div>
		</nav>
	
		<c:if test="${news!=null}">
			<c:if test="${news.warningJudge==0}">
				<div class="alert alert-success">
			</c:if>
			<c:if test="${news.warningJudge==1}">
				<div class="alert alert-warning">
			</c:if>
			<c:if test="${news.warningJudge==2}">
				<div class="alert alert-danger">
			</c:if>
			<c:if test="${news.warningJudge==3}">
				<div class="alert alert-danger">
			</c:if>
			    <a href="#" class="close" data-dismiss="alert">
			        &times;
			    </a>
			    <strong>警告！</strong>${news.warningContent}
			</div>
		</c:if>
	
		<!-- 主体 -->
		<div id="main">
			<!-- 颜色填充显示 -->
			<ul class="informationfunctiontien" style="float: left;">
				<li></li>
				<li></li>
				<li></li>
				<li></li>
				<li></li>
			</ul>
			
			<!-- 功能信息栏 -->
			<div id="pcleft">
				<div class="headportrait">
					<ul>
						<li>
						<%
							String headPortraitimg=null;
							headPortraitimg=(String)session.getAttribute("headportraitimg");
							if(headPortraitimg!=null){
						%>
							<img src="/leaseimg/<%=headPortraitimg %>" class="img-circle" id="headPortrait"/>
						<%}else{ %>
							<img src="../img/头像.jpg" class="img-circle" id="headPortrait"/>
						<%} %>
						</li>
						<li style="line-height: 0px;"><a><%=user %>用户</a></li>
					</ul>
				</div>
				<ul class="informationfunction" style="float: right;">
					<li value="0"><a href="#">租赁信息</a></li>
					<li value="1"><a href="#">我的申请</a></li>
					<li value="2"><a href="#">代缴租金</a></li>
					<li value="3"><a href="#">报障模块</a></li>
					<li value="4"><a href="#">其他操作</a></li>
				</ul>
			</div>
			
			<div id="pcrighttop">
				<div style="padding-top: 20px; width: 90%; margin: auto; font-size: 18px; font-weight: bold;">
					<span style="float: left;">欢迎来到菜鸟租赁网</span>
	  				<span class="pcrighttopApp popover-show" data-placement="bottom" data-toggle="popover" data-content="">
	  				<span class="glyphicon glyphicon-download-alt" aria-hidden="true" ></span>
	  				&nbsp;APP下载</span>
				</div>
			</div>
			<div id="pcrightbottom"></div>
		</div>
		
		<%@ include file="footer.jsp"%>
	</div>
</body>
<script type="text/javascript">
	$(function(){
	    $('.popover-show').popover({
	        trigger : 'hover',//鼠标以上时触发弹出提示框
	        html:true,//开启html 为true的话，data-content里就能放html代码了
	        content:"<img src='../img/app.jpg'>",
	        title:"用菜鸟租赁APP找房更方便扫描二维码进行下载"
	    });
	    
		$("#main .informationfunction li a").click(function(){
			var txt=$(this).text();
			$.ajax({
	            url:"${app_path}/personacentermvc/personal_switch.do",
	            data:{txt},
	            type:"get",
	            success:function(msg){
	            	//显示返回值页面
	            	$("#pcrightbottom").load("${app_path}"+msg);
	            }
	        });
		});
	});
</script>
<script type="text/javascript" src="../js/personacenter.js"></script>
<script type="text/javascript" src="../js/load.js"></script>
</html>