<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>看房申请</title>
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
<style type="text/css">
	table tr {
		text-align: center;
	}
	#fy {
		margin-bottom: -15px;
	}
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
			<!-- 看房申请 -->
			<div id="page" style="width:100%;height:850px;background-color:white;border:1px solid #A8A8A8;border-bottom: none;">
				<h1 style="font-size:20px;font-weight: bold;margin-left: 100px;">看房申请</h1>
					<table style="text-align: center;" class="table table-hover">
					<tr class=info>
							<td>房屋id</td>
							<td>地址</td>
							<td>面积</td>
							<td>价格</td>
							<td>申请人姓名</td>
							<td>申请人身份证号</td>
							<td>申请人电话号码</td>
							<td>操作</td>
						</tr>
						<c:forEach var="cs" items="${cs.list}"> 
							<tr>
								<td>${cs.coahouseid}</td>
								<td>${cs.coahouseaddress}</td>
								<td>${cs.coahousesize}</td>
								<td>${cs.coahouseprice}</td>
								<td>${cs.coausername}</td>
								<td>${cs.coauserid}</td>
								<td>${cs.coauserphone}</td>
								<td>
									<a id1="${cs.coaid}" class="ty">同意租赁</a>&nbsp;
									<a id2="${cs.coaid}" class="jj">拒绝租赁</a>
								</td>
							</tr>
						</c:forEach>
					</table>
					
							<nav aria-label="Page navigation" style="float: right;margin-right: 50px;">
								  <ul class="pagination">
								  <li><a href="${app_path}/admin/houseapply.do?pn=1">首页</a></li>
								  	<c:if test="${cs.hasPreviousPage }">
									    <li>
									      <a href="${app_path}/admin/houseapply.do?pn=${cs.pageNum-1}" aria-label="Previous">
									        <span aria-hidden="true">&laquo;</span>
									      </a>
									    </li>
								    </c:if>
								    <c:forEach items="${cs.navigatepageNums }" var="css">
								    	<c:if test="${css==cs.pageNum }">
								    		<li class="active"><a href="#">${css}</a></li>
								    	</c:if>
								    	<c:if test="${css!=cs.pageNum }">
								    		<li><a href="${app_path}/admin/houseapply.do?pn=${css}">${css}</a></li>
								    	</c:if>
								    </c:forEach>
								    
								    <c:if test="${cs.hasNextPage }">
									    <li>
									      <a href="${app_path}/admin/houseapply.do?pn=${cs.pageNum+1}" aria-label="Next">
									        <span aria-hidden="true">&raquo;</span>
									      </a>
									    </li>
								    </c:if>
								    <li><a href="${app_path}/admin/houseapply.do?pn=${cs.pages}">末页</a></li>
								  </ul>
							</nav>
					
			</div>		
		</div>
	</div>
</body>
<script type="text/javascript">
	$(function(){
		$(".ty").click(function(){
			var name=$(this).parents("tr").find("td:eq(4)").text();
			var id=$(this).attr("id1");
			var housecall=$(this).parents("tr").find("td:eq(0)").text();
			if(confirm("确认同意："+name+"的租凭吗？")){
				//确认发送ajax请求删除
				$.ajax({
					url:"${app_path}/admin/tonyizp.do",
					data:{id,housecall,name},
					type:"get",
					success:function(result){
						alert("已同意");
						window.location.reload();
					}		
				})
			}
			
		});
		$(".jj").click(function(){
			var name=$(this).parents("tr").find("td:eq(4)").text();
			var id=$(this).attr("id2");
			if(confirm("是否拒绝："+name+"的租凭吗？")){
				//确认发送ajax请求删除
				$.ajax({
					url:"${app_path}/admin/jujzp.do?id="+id,
					type:"get",
					success:function(result){
						alert("拒绝成功");
						window.location.reload();
					}		
				})
			}
			
		});
	});
</script>
</html>