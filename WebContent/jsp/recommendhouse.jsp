<%@page import="com.javabean.leaseinformation"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>推荐房源设置</title>
<%
	pageContext.setAttribute("app_path", request.getContextPath());
%>
<!--  Bootstrap 核心 CSS 文件 -->
<link rel="stylesheet" href="../static/bootstrap-3.3.7-dist/css/bootstrap.css">
<!-- 引用css -->
<style type="text/css">
@import url("../css/administrators.css");
</style>
<style type="text/css">
@import url("../css/list.css");
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
			<!-- 房源列表 -->
			<div id="page" style="width:100%;height:850px;background-color:white;border:1px solid #A8A8A8; ">
				<h1 style="font-size:20px;font-weight: bold;margin-left: 100px;">推荐房源设置</h1>
				<table style="text-align: center;" class="table table-hover">
					<tr class=info>
						<td>房屋id</td>
						<td>地址</td>
						<td>面积</td>
						<td>价格</td>
						<td>状态</td>
						<td>设置</td>
					</tr>
					<!-- 全部房源信息 -->
					<c:forEach items="${p.list}" var="leaseinformation">
					<tr>
						<td>${leaseinformation.houseid}</td>
						<td>${leaseinformation.houseaddress}</td>
						<td>${leaseinformation.housesize}</td>
						<td>${leaseinformation.housemoney}</td>
						<td>${leaseinformation.houserecommend}</td>	
						<td>
						<c:if test="${leaseinformation.houserecommend=='已推荐' }">
						<a href="${app_path }/admin/updaterecommend.do?houseid=${leaseinformation.houseid}">取消推荐</a>
						</c:if>
						<c:if test="${leaseinformation.houserecommend!='已推荐' }">
						<a href="${app_path }/admin/updaterecommend.do?houseid=${leaseinformation.houseid}">设为推荐</a>
						</c:if>
						</td>				
					</tr>
					</c:forEach>
				</table>
				
				<nav aria-label="Page navigation" style="float: right;margin-right: 50px;">
				  <ul class="pagination">
				  <li><a href="${app_path }/admin/recommendlist.do?pn=1">首页</a></li> 
				    <c:if test="${p.hasPreviousPage}">
				     <li ><a href="${app_path }/admin/recommendlist.do?pn=${p.pageNum-1}">  <span aria-hidden="true">&laquo;</span></a></li>
				     </c:if> 
				    <c:forEach items="${p.navigatepageNums}" var="pn">
				     <c:if test="${pn==p.pageNum }">
				     <li class="active"><a href="${app_path }/admin/recommendlist.do?pn=${p.pageNum-1}">${pn}</a></li>
				     </c:if>
				     <c:if test="${pn!=p.pageNum }">
				     <li><a href="${app_path }/admin/recommendlist.do?pn=${pn}">${pn}</a></li>
				     </c:if>
				    </c:forEach>
				    <c:if test="${p.hasNextPage}">
				     <li ><a href="${app_path }/admin/recommendlist.do?pn=${p.pageNum+1}"> <span aria-hidden="true">&raquo;</span></a></li>
				     </c:if> 
				  <li><a href="${app_path }/admin/recommendlist.do?pn=${p.pages}">尾页</a></li>
				  </ul>
</nav>
			</div>
		</div>
	</div>
<script language=javascript>
</script>
</body>

</html>