<!-- 导航栏 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>导航栏</title>
<!--  Bootstrap 核心 CSS 文件 -->
<link rel="stylesheet"
	href="../static/bootstrap-3.3.7-dist/css/bootstrap.css">
<!-- 引用css -->
<style type="text/css">
@import url("../css/officialcss.css");
</style>
<!-- 引用js -->
<script type="text/javascript"
	src="../static/jquery/jquery-1.11.0.min.js"></script>
<!-- Bootstrap 核心 JavaScript 文件 -->
<script src="../static/bootstrap-3.3.7-dist/js/bootstrap.js"></script>

<style type="text/css">
* {
	padding: 0px;
	margin: 0px;
	font-size: 16px;
	font-family: "微软雅黑";
}

#navigation {
	margin-bottom: 0px;
	background-color: #3d3d45;
	line-height: 50px;
	width: 100%;
	height: 50px;
}

#navigation #rightnav {
	float: right;
	margin-right: 30px;
}

#navigation #rightnav a {
	color: #6f7770;
	font-size: 16px;
	text-decoration: none;
	padding: 0px 10px;
}

#navigation #leftnav {
	float: left;
	margin-left: 30px;
}

#navigation #leftnav a {
	color: #6f7770;
	font-size: 16px;
	text-decoration: none;
	padding: 0px 10px;
}

#navigation #rightnav a:hover {
	color: white;
	text-decoration: underline;
}

#navigation #leftnav a:hover {
	color: white;
	text-decoration: underline;
}
@media screen and (max-width: 1200px) {
	#navigation {
		width: 1200px;
	}
}
</style>
</head>
<body>
<%	
	String user=null;
	pageContext.setAttribute("app_path", request.getContextPath());
%>
	<!-- 导航栏 -->
	<nav class="navbar navbar-default navbar-static-top" id="navigation">
		<span id="leftnav"> 
			<a href="${app_path}/jsp/official.jsp">首页</a> 
			<a href="#">联系客服</a>
			<a href="#">帮助中心</a>
		</span> 
		<span id="rightnav">
		<%
			user=(String)session.getAttribute("user");
			if(user!=null){
	    %>
	    	<a href="${app_path}/jsp/personacenter.jsp">欢迎<%=user %>用户</a> 
			<a href="${app_path }/jsp/personacenter.jsp">个人中心</a>
	    <%}else{ %>
	    	<a href="${app_path}/jsp/login.jsp"> 
			<span class="glyphicon glyphicon-user"></span> 
			登录 </a> 
			<a href="${app_path}/jsp/register.jsp">注册</a> 
			<a href="#" onclick="personclick()">个人中心</a>	
		<%}; %>
		</span>
	</nav>
</body>
<script type="text/javascript">
	function personclick() {
		alert("请先登录!");
	}
</script>
</html>