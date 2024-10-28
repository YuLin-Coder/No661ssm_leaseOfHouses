<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>添加房源</title>
<%
	pageContext.setAttribute("app_path", request.getContextPath());
%>
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
			<!-- 添加房源 -->
			<div id="page" style="width:100%;height:850px;background-color:white;border:1px solid #A8A8A8; ">
				<h1 style="font-size:20px;font-weight: bold;margin-left: 100px;">添加房源</h1>
				<%if(request.getAttribute("sessce")!=null){ %>
				<h2 style="width:150px;font-size:20px;font-weight: bold;margin-left: 100px;background-color: #00BB00;color:white;">
				<i class="glyphicon glyphicon-ok-sign"></i>
				<%=request.getAttribute("sessce") %></h2>	
				<%} %>
				<%if(request.getAttribute("erro")!=null){ %>
				<h2 style="width:320px; font-size:20px;font-weight: bold;margin-left: 100px;background-color: red;color:white;">
				<i class="glyphicon glyphicon-remove-sign"></i>
				<%=request.getAttribute("erro") %></h2>	
				<%} %>		
					<!-- 添加房源信息 -->
					<form action="${app_path }/admin/addhouse.do" method="post"  enctype="multipart/form-data" >
						<table>
							<tr>
								<td align="right"><span style="color:red;">*</span>房屋编号:</td>
								<td><input name="housecall" class="form-control" style="width:350px;"/></td>
							</tr>
							<tr>
								<td align="right"><span style="color:red;">*</span>地址:</td>
								<td><input name="address" class="form-control" style="width:350px;"/></td>
							</tr>
							<tr>
								<td align="right"><span style="color:red;">*</span>面积:</td>
								<td><input name="area" class="form-control" style="width:350px;"/></td>
							</tr>
							<tr>
								<td align="right"><span style="color:red;">*</span>租金:</td>
								<td><input name="rent" class="form-control" style="width:350px;"/></td>
							</tr>
							<tr>
								<td align="right"><span style="color:red;">*</span>房屋类型:</td>
								<td><input name="housetype" class="form-control" style="width:350px;"/></td>
							</tr>
							<tr>
								<td align="right"><span style="color:red;">*</span>状态:</td>
								<td>
									<select name="state" style="height: 30px;">
									<option value=""></option>
										<option value="可租凭">可租凭</option>
										<option value="出租中">出租中</option>
									</select>
								</td>
							</tr>
							<tr>
								<td align="right"><span style="color:red;">*</span>房源图片：</td>
								<td><input type="file" name="file" /></td>
							</tr>
							<tr>
								<td colspan="2">
									<input type="submit" value="提交" class="btn btn-primary" style="margin-left: 130px;width:120px"/>
									<input type="button" value="返回" onclick="history.go(-1)" class="btn btn-default" style="width:120px;"/>  
								</td>
							</tr>
						</table>
					</form>
			</div>
				
		</div>
	</div>
</body>
</html>