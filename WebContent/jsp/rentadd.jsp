<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.javabean.rentcollection" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>添加收租信息</title>
<!--  Bootstrap 核心 CSS 文件 -->
<link rel="stylesheet" href="../static/bootstrap-3.3.7-dist/css/bootstrap.css">
<!-- 引用css -->
<style type="text/css">
@import url("../css/administrators.css");
</style>
<!-- 引用css -->
<style type="text/css">
@import url("../css/housingadd.css");
</style>
<!-- 引用js -->
<script type="text/javascript" src="../static/jquery/jquery-1.11.0.min.js"></script>
<!-- Bootstrap 核心 JavaScript 文件 -->
<script src="../static/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
</head>
<body>
<%
	pageContext.setAttribute("app_path", request.getContextPath());
%>
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
			<!-- 添加收租信息 -->
			<div id="page" style="width:100%;height:500px;background-color:white;border:1px solid #A8A8A8; ">
				<h1 style="font-size:20px;font-weight: bold;margin-left: 100px;">添加收租信息</h1>
					<!-- 添加收租信息 -->
					<form action="${app_path}/admin/adminrentadd.do" method="post">
						<table>
							<tr>
								<td align="right"><span style="color:red;">*</span>房屋id:</td>
								<td><input  name="rchouseid" class="form-control" style="width:350px;" value="${addrent.leaseinformation.housecall }" readonly="readonly"></td>
							</tr>
							<tr>
								<td align="right"><span style="color:red;">*</span>地址:</td>
								<td><input  name="rchouseaddress" class="form-control" style="width:350px;" value="${addrent.leaseinformation.houseaddress}" readonly="readonly"></td>
							</tr>
							<tr>
								<td align="right"><span style="color:red;">*</span>应缴租金:</td>
								<td><input  name="rchousemoney" class="form-control" style="width:350px;" value="${addrent.leaseinformation.housemoney}" readonly="readonly"></td>
							</tr>
							<tr>
								<td align="right"><span style="color:red;">*</span>租金交付截止日期:</td>
								<td><input type="date" name="rcdate" class="form-control" style="width:350px;" required="required" value=""></td>
							</tr>
							<tr>
								<td align="right"><span style="color:red;">*</span>租客姓名:</td>
								<td><input  name="rcusername" class="form-control" style="width:350px;" value="${addrent.username}" readonly="readonly"></td>
							</tr>
							<tr>
								<td colspan="2">
									<input type="submit" value="提交" class="btn btn-primary" style="margin-left: 130px;width:120px"/>
									<input type="button" value="返回" onclick="location.assign('${app_path}/admin/adminrentshou.do')" class="btn btn-default" style="width:120px;"/>  
								</td>
							</tr>
						</table>
					</form>
			</div>
				
		</div>
	</div>
</body>
</html>