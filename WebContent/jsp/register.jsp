<!-- 注册 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>用户注册</title>
<!-- 引用js -->
<script type="text/javascript"
	src="../static/jquery/jquery-1.11.0.min.js"></script>
<style type="text/css">
@import url("../css/load.css");
</style>
<style type="text/css">
* {
	margin: 0;
	padding: 0;
	font-family: "微软雅黑";
}

input {
	border-radius: 5px;
}

.information {
	width: 300px;
	height: 40px;
	font-size: 15px;
	position: relative;
	left: 50px;
	margin-top: 30px;
	border: 2px solid lightgrey;
	background-color: white;
}

#information2 {
	width: 200px;
}

#information3 {
	height: 42px;
	width: 100px;
	position: relative;
	cursor: pointer;
	outline: none;
	left: 45px;
	outline: none;
}

#information3:hover{
	background-color: rgba(216,216,216,0.2);
}

body {
	height: 100%;
	width: 100%;
	background: url(../img/东京.jpg) no-repeat;
	background-size: 100% 100%;
	background-attachment: fixed;
}

#main {
	width: 400px;
	height: 430px;
	background-color: white;
	margin: 50px auto;
	border-radius: 3px;
}

#register {
	width: 400px;
	height: 260px;
	position: relative;
	top: 50px;
}

#register form {
	width: 400px;
	height: 260px;
	background-color: white;
	font-size: 20px;
	margin-top: 30px;
}

#register .register {
	width: 302px;
	height: 42px;
	position: relative;
	left: 50px;
	margin-top: 30px;
	background-color: #337ab7;
	font-size: 20px;
	color: white;
	border: none;
	cursor: pointer;
}

#register .register:hover {
	background-color: rgba(91, 169, 251, 0.9);
}

#foot {
	width: 400px;
	height: 40px;
	margin: 0 auto;
	position: relative;
	top: 160px;
	background-color: gainsboro;
	border-radius: 0 0 3px 3px;
}

#foot a {
	width: 5rem;
	height: 20px;
	text-decoration: none;
	color: black;
}

#foot a:hover {
	text-decoration: underline;
	color: #337ab7;
}

#foot #homepage {
	margin: auto 30px 0px;
	position: relative;
	line-height: 40px;
	font-size: 17px;
	float: left;
}

#foot #login {
	margin: auto 0px 30px;
	position: relative;
	line-height: 40px;
	font-size: 17px;
	float: right;
}
#cwzs{
	width: 100%;
	height:40px;
	background-color: #a6cfe2;
}
#cwzs #cwxx{
	height:30px;
	line-height: 30px;
	font-size: 24px;
	list-style: none;
	margin-top:5px;
	float: left;
	width:100%;
	text-align: center;
	font-family: "微软雅黑";
}
#cwzs #aniu{
	float:right;
	margin-right: 5px;
	width: 24px;
	height: 24px;
	background-color: LightCoral;
	border: 1px solid LightCoral;
	margin-top: 3px; 
}
</style>
</head>
<body>
<%
	pageContext.setAttribute("app_path", request.getContextPath());
%>
	<!-- 加载动画 -->
	<div class="loader-wrapper">
		<span class="loader"><span class="loader-inner"></span></span>
	</div>
	<%
		if(request.getAttribute("erorr")!=null){
	%>
	<div id ="cwzs">
		<li id="cwxx"><%=request.getAttribute("erorr") %><button id="aniu">&times;</button></li>
	</div>
		
			
	<%} %>
	<div id="main">
		<div id="register">
			<form action="${app_path }/userlistmvc/register.do" method="post">
				<input class="information" name="usercall" placeholder="  用户名" /><br />			
				<input class="information" type="password" name="userpwd"
					placeholder="  密码" /><br /> 
				<input class="information" name="userphone" placeholder="  手机号" /><br /> 
					<input type="submit" value="注册"
					class="register"/>
			</form>
		</div>
		<div id="foot">
			<a href="${app_path }/jsp/official.jsp" id="homepage">返回首页</a> <a href="${app_path }/jsp/login.jsp" id="login">返回登录</a>
		</div>
	</div>
</body>
<script type="text/javascript" src="../js/load.js"></script>
<script type="text/javascript">
	$(function(){
		$("#aniu").click(function(){
			$("#cwzs").hide("slow");
		});
	})
</script>
</html>
