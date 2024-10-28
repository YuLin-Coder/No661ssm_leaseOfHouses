<!-- 登录 -->
<%@page import="com.code.Code"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>用户登录</title>
<%
	pageContext.setAttribute("app_path", request.getContextPath());
%>
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

body {
	height: 100%;
	width: 100%;
	background: url(../img/s.png) no-repeat;
	background-size: 100% 100%;
	background-attachment: fixed;
	    margin-left: 530px;
    margin-top: 250px;
}

input {
	border-radius: 5px;
}

#login {
	width: 400px;
	height: 430px;
	background-color: white;
	margin: 50px auto;
	border-radius: 3px;
	box-shadow:0px 25px 20px -25px #000;
}

#login #choose {
	width: 400px;
	height: 80px;
	position: relative;
	top: 70px;
	margin: 0 auto;
	background-color: white;
}

#choose span {
	width: 100px;
	height: 80px;
	line-height: 80px;
	font-size: 20px;
	background-color: white;
	border-bottom: 1px solid black;
}

#choose span:hover {
	cursor: pointer;
}

#choose #userlogin {
	position: relative;
	left: 50px;
	border-color: #337ab7;
	color: #337ab7;
}

#choose #phonelogin {
	position: relative;
	left: 160px;
}

#information {
	width: 400px;
	height: 260px;
	position: relative;
	background-color: white;
	top: 50px;
}

#information form {
	width: 400px;
	height: 260px;
	background-color: white;
}


#information form .information {
	width: 300px;
	height: 40px;
	font-size: 15px;
	position: relative;
	left: 50px;
	margin-top: 30px;
	border: 2px solid lightgrey;
	background-color: white;
}
#information form .information2 {
	width: 130px;
	height: 40px;
	font-size: 15px;
	position: relative;
	left: 50px;
	margin-top: 30px;
	margin-right:10px;
	border: 2px solid lightgrey;
	background-color: white;
}
#information form .information3 {
	width: 130px;
	height: 42px;
	font-size: 15px;
	position: relative;
	left: 50px;
	margin-top: 30px;
	margin-right:10px;
	border: 2px solid lightgrey;
	background-color: lightblue;
	color:white;
}
#information form .login {
	width: 300px;
	height: 40px;
	position: relative;
	left: 50px;
	margin-top: 30px;
	background-color: #337ab7;
	font-size: 20px;
	color: white;
	border: none;
}

#information form .login:hover {
	background-color: rgba(91, 169, 251, 0.9);
	cursor: pointer;
}

#information #phone {
	display: none;
}

.identity {
	background-color: white;
	margin-right: 20px;
	position: relative;
	left: 55px;
	top: 10px;
}

.identity  input:hover {
	cursor: pointer;
}

#foot {
	width: 400px;
	height: 40px;
	position: relative;
	top: 50px;
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

#foot #register {
	margin: auto 0px 30px;
	position: relative;
	line-height: 40px;
	font-size: 17px;
	float: right;
}

.identity {
	font-size: 15px;
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
	<div id="login">
		
			
		<div id="choose">
			<span id="userlogin" onclick="switchs(id)">用户名登陆</span> 
			<span id="phonelogin" onclick="switchs(id)">手机登陆</span><br />
		</div>
		<div id="information">
			<form action="${app_path }/userlistmvc/userpwd.do" method="post" id="name">
				<input class="information" name="username" placeholder="  用户名" /><br />
				<input class="information" type="password" name="pwd" placeholder="  密码" /><br /> 
				<span class="identity">
				<input type="radio" value="user" name="identity" />
				用户登录</span> 
				<span class="identity">
				<input type="radio" value="admin" name="identity" />
				管理员登录</span>
				<span class="identity">
				<a href="${app_path }/jsp/updatepwd.jsp" >忘记密码</a></span>
				<br /> 
				<input type="submit" value="登陆" class="login" />
			</form>
			<form action="${app_path }/userlistmvc/phonecod.do" method="post" id="phone">
				<input class="information" name="userphone" id="p1" placeholder="  手机号" onblur="getCode()" /><br />
				<input class="information2" name="code" placeholder="  验证码" /><input class="information3" type="button" style="cursor: pointer;" id="getcode" value="获取验证码"/><br />
				<br /> <input type="submit" value="登陆" class="login" />
			</form>
		</div>
		<div id="foot">
			<a href="${app_path }/jsp/official.jsp" id="homepage">返回首页</a> <a href="${app_path }/jsp/register.jsp" id="register">前往注册</a>
		</div>
	</div>
	<script>
		function switchs(chose) {
			if (chose == "userlogin") {
				//改对应的颜色
				document.getElementById('phone').style.display = 'none';
				document.getElementById('name').style.display = 'block';
				document.getElementById('userlogin').style.color = '#337ab7';
				document.getElementById('phonelogin').style.color = 'black';
				document.getElementById('userlogin').style.borderColor = '#337ab7';
				document.getElementById('phonelogin').style.borderColor = 'black';
			} else {
				document.getElementById('name').style.display = 'none';
				document.getElementById('phone').style.display = 'block';
				document.getElementById('phonelogin').style.color = '#337ab7';
				document.getElementById('userlogin').style.color = 'black';
				document.getElementById('phonelogin').style.borderColor = '#337ab7';
				document.getElementById('userlogin').style.borderColor = 'black';
			}
		}
		
	</script>
	<script type="text/javascript" >
	$(function(){
		$("#getcode").click(function(){
			var userphone=$("#p1").val();
			$.ajax({
		          url:"${app_path}/userlistmvc/getcode.do",
		          data:{userphone},
		           type:"get",
		           success:function(){
		            	alert("发送成功")
		            }		           
		        });
		});
		$("#aniu").click(function(){
			$("#cwzs").hide("slow");
		});
	})
	
	</script>
</body>
<script type="text/javascript" src="../js/load.js"></script>
</html>
