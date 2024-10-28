<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	pageContext.setAttribute("app_path", request.getContextPath());
%>
<!-- 导航栏 -->
	<nav class="navbar navbar-default navbar-static-top" id="navigation">
		<img src="../img/菜鸟白色.jpg" style="width:75px;height: auto;margin-top: -12px;margin-left: -10px;"/>
		<span class="leftnav" style="padding-bottom: 14px;margin-left: -3px;">
			<a href="#"><span class="glyphicon glyphicon-home" style="height: 30px;">
			</span>&nbsp;管理中心</a>
		</span>
		<span class="rightnav">
			<span>欢迎！<%=session.getAttribute("admin") %>用户</span>
			<a href="${app_path}/admin/admincancel.do">退出</a>
		</span>
	</nav>