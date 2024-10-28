<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>添加日程</title>
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
			<!-- 添加日程 -->
			<div id="page" style="width:100%;height:850px;background-color:white;border:1px solid #A8A8A8; ">
				<h1 style="font-size:20px;font-weight: bold;margin-left: 100px;">添加日程</h1>
					<!-- 添加日程 -->
					<form action="${app_path}/admin/addmydailylife.do" method="post">
						<table>
							<tr>
								<td align="right" style="padding-right: 10px;"><span style="color:red;">*</span>日期:</td>
								<td><input type="date" name="mdldate" class="form-control" style="width:350px;margin-left: 20px;" required="required"></td>
							</tr>
							<tr>
								<td align="right" style="padding-right: 10px;"><span style="color:red;">*</span>日程:</td>
								<td><textarea name="mdlcontent" style="width:350px;height: 80px;margin-left: 20px;" class="form-control" required="required"></textarea></td>
							</tr>
							<tr>
								<td colspan="2">
									<input type="submit" value="提交" class="btn btn-primary" style="margin-left: 130px;width:120px"/>
									<input type="button" value="返回" onclick="location.assign('${app_path}/admin/schedulelist.do')" class="btn btn-default" style="width:120px;"/>  
								</td>
							</tr>
						</table>
					</form>
			</div>
				
		</div>
	</div>
</body>
</html>