<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>管理员个人中心</title>
<!--  Bootstrap 核心 CSS 文件 -->
<link rel="stylesheet" href="../static/bootstrap-3.3.7-dist/css/bootstrap.css">
<!-- 引用css -->
<style type="text/css">
@import url("../css/administrators.css");
</style>
<!-- 引用js -->
<script type="text/javascript" src="../static/jquery/jquery-1.11.0.min.js"></script>
<!-- Bootstrap 核心 JavaScript 文件 -->
<script src="../static/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
</head>
<body>
	<!-- 导航栏 -->
	<%@ include file="navigation.jsp" %>
	<div id="main">
		<!-- 菜单栏 -->
	<%@ include file="menu.jsp" %>	
		<!-- 主体 -->
		<div id="middle">
			<!-- 欢迎 -->
			<div id="welcome">
				<span><i class="glyphicon glyphicon-volume-up"></i>欢迎使用本系统！</span>
			</div>
			<!-- 首页 -->
			<div id="page" style="width:100%; background-color: white;border:1px solid #A8A8A8; ">
				<h1 id="page1" style="font-size: 20px;font-weight: bold;">首页</h1>

				<h1 id="page2">欢迎来到房屋管理中心系统！</h1>
			</div>
				
		</div>
	</div>
</body>
</html>