<!-- 详情页面 -->
<%@page import="java.util.UUID"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>详细信息</title>
<%
	pageContext.setAttribute("app_path", request.getContextPath());
%>
<!--  Bootstrap 核心 CSS 文件 -->
<link rel="stylesheet"
	href="../static/bootstrap-3.3.7-dist/css/bootstrap.css">
<!-- 引用js -->
<script type="text/javascript"
	src="../static/jquery/jquery-1.11.0.min.js"></script>
<!-- Bootstrap 核心 JavaScript 文件 -->
<script src="../static/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
<style type="text/css">
@import url("../css/load.css");
</style>
<style type="text/css">
	*{
		padding: 0px;
		margin: 0px;
		font-family: "微软雅黑";
	}
	a{
		text-decoration: none;
	}
	#text {
		margin-top:30px;
	}
	#hy{
		margin-top:30px; 
	}
	#zhong {
		height:600px;
		margin-top:25px;
	}
	#zhong1 {
		height:400px;
	}
	#zhong2 {
		height:600px;
	}
	.container img{
		height: 100%;
		width: 100%;
	}
	.money{
		font-size: 50px;
		font-weight: 700;
		color: red;
	}
	.money1{
		color: red;
	}
	ul {
		list-style: none;
	}
	#tb1{
		width: 200px;
	}
	#zhong2-2{
		margin-top: 20px;
		border-top: 1px solid #ccc;
		border-bottom: 1px solid #ccc;
		padding: 20px 0px 20px 0px;
		font-size: 16px;
	}
	#zhong2-2 table tr td{
		padding: 5px 0px;
	}
	#ann {
		width: 200px;
		margin: 50px auto;
	}
</style>
</head>
<body>
	<%
		String token =  UUID.randomUUID().toString() ;//创建令牌
		System.out.println("在details中生成的token："+token);
		session.setAttribute("token", token);  //在服务器使用session保存token(令牌)
	%>

	<!-- 加载动画 -->
	<div class="loader-wrapper">
		<span class="loader"><span class="loader-inner"></span></span>
	</div>
	
	<form action="${app_path}/userlistmvc/apply.do" method="post">
	<input type="hidden" name="token" value='${token}'/>
	<c:forEach var="cs" items="${cs}">      
	<div id="loadmain">
		<!-- 导航栏 -->
		<%@ include file="navigationbar.jsp"%>
		<div class="container">
			<div class="row">
				<div class="col-xs-12 col-sm-6 col-md-8">
					<h3 id="hy">东方花园&nbsp;<span class="label label-warning">${cs.housestate}</span></h3>
				</div>
				<div class="col-xs-6 col-md-4">
					<div id="text" class="input-group">
						<input type="text" class="form-control" placeholder="请输入新的房名" aria-describedby="basic-addon2">
						<span class="input-group-addon" id="basic-addon2"><a href="#">搜索</a></span>
					</div>
				</div>
			</div>
			<div id="zhong" class="row">
				<div id="zhong1" class="col-xs-12 col-sm-6 col-md-8">
					<!-- <img alt="" src="../img/地球.jpg"/> -->
					<img alt="" src="/leaseimg/${cs.leaseimg.imgroute}"/>
				</div>
				<div id="zhong2" class="col-xs-6 col-md-4">
					<div id="zhong2-1">
						<p>
		                    <span class="text fl">租金&nbsp;&nbsp;</span>
		                    <span class="money">${cs.housemoney}</span>
		                    <input id="housemoney" name="housemoney" type="hidden" value="${cs.housemoney}" >
		                    <input id="housecall" name="housecall" type="hidden" value="${cs.housecall}" >
		                    <input id="houseaddress" name="houseaddress" type="hidden" value="${cs.houseaddress}" >
		                    <input id="housesize" name="housesize" type="hidden" value="${cs.housesize}" >
		                    <em class="money1">元</em>
	                    </p>
	                    <p id="zhong2-1-1">租金有效期：2020.11.30 - 2021.01.17</p>
	                    <p></p>
					</div>
					<div id="zhong2-2">
						<table id="tb1">
							<tr>
								<td>预约证号</td>
								<td>1938</td>
							</tr>
							<tr>
								<td>房屋类型</td>
								<td>${cs.housetype}</td>
							</tr>
							<tr>
								<td>住房面积</td>
								<td>${cs.housesize}㎡</td>
							</tr>
							<tr>
								<td>房屋地址</td>
								<td>${cs.houseaddress}</td>
							</tr>
						</table>
					</div>
			</c:forEach>		
					<div id="ann">
						<button type="submit" class="btn btn-default" >预约看房</button>
						<button type="button" class="btn btn-default">关注房源</button>
					</div>	
				</div>
			</div>
		</div>
		</form>
		<%@ include file="footer.jsp"%>
	</div>
</body>
<script type="text/javascript">
	window.onload = function(){
		var date = new Date();
   		var n=date.getFullYear();
   		var y=date.getMonth()+1;
   		var r=date.getDate();
   		var yy;
   		var nn;
   		if(y==12){
   			yy=1;
   			nn=n+1;
   		}else{
   			yy=y+1;
   		}
		if(yy==1){
			document.getElementById("zhong2-1-1").innerHTML="租金有效期："+n+"."+y+"."+r+" - "+nn+"."+yy+"."+r
		}else{
			document.getElementById("zhong2-1-1").innerHTML="租金有效期："+n+"."+y+"."+r+" - "+n+"."+yy+"."+r
		}
		
	}
	
	$("#ann #butapply").on("click",function(){
		var temp1=$('#housemoney').val();
		var temp2=$('#housecall').val();
		var temp3=$('#houseaddress').val();
		var temp4=$('#housesize').val();
		$.ajax({
			url : "${app_path}/userlistmvc/apply.do",
			data : {"housemoney":temp1,
					"housecall":temp2,
					"houseaddress":temp3,
					"housesize":temp4
					
			},
			type : "post",
		});
		
	});
</script>
<script type="text/javascript" src="../js/load.js"></script>
</html>