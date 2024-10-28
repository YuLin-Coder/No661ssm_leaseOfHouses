<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>在租列表</title>
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
			<!-- 在租列表 -->
			<div id="page" style="width:100%;height:850px;background-color:white;border:1px solid #A8A8A8;border-bottom: none;">
				<h1 style="font-size:20px;font-weight: bold;margin-left: 100px;">在租列表</h1>
					<table style="text-align: center;" class="table table-hover">
					<tr class=info>
							<td>房屋id</td>
							<td>地址</td>
							<td>价格</td>
							<td>租赁人</td>
							<td>租赁人身份证号</td>
							<td>租赁人联系电话</td>
							<td>操作</td>
						</tr>
						<c:forEach var="cs" items="${cs.list}"> 
							<tr>
								<td>${cs.housecall}</td>
								<td>${cs.houseaddress}</td>
								<td>${cs.housemoney}</td>
								<td>${cs.userlist.username}</td>
								<td>${cs.userlist.userid}</td>
								<td>${cs.userlist.userphone}</td>
								<td>
									<%-- <a id="${cs.houseid}" href="${app_path}/admin/viewcontractadmin.do?username=
									${cs.userlist.username}&userid=${cs.userlist.userid}&userphone=
									${cs.userlist.userphone}&houseaddress=${cs.houseaddress}&housestartingdatetemp=
									${cs.housestartingdatetemp}&houseclosingdatetemp=${cs.houseclosingdatetemp}&housemoney=
									${cs.housemoney}&houseid=${cs.houseid}" class="a">查看合同</a>&nbsp; --%>
									<a id="${cs.houseid}" class="delect" href="">终止合同</a>
								</td>
							</tr>
						</c:forEach>
					</table>
	
							<nav aria-label="Page navigation" style="float: right;margin-right: 50px;">
				
								  <ul class="pagination">
								  	
								  <li><a href="${app_path}/admin/rentinglist.do?pn=1">首页</a></li>
								  	<c:if test="${cs.hasPreviousPage }">
									    <li>
									      <a href="${app_path}/admin/rentinglist.do?pn=${cs.pageNum-1}" aria-label="Previous">
									        <span aria-hidden="true">&laquo;</span>
									      </a>
									    </li>
								    </c:if>
								    <c:forEach items="${cs.navigatepageNums }" var="css">
								    	<c:if test="${css==cs.pageNum }">
								    		<li class="active"><a href="#">${css}</a></li>
								    	</c:if>
								    	<c:if test="${css!=cs.pageNum }">
								    		<li><a href="${app_path}/admin/rentinglist.do?pn=${css}">${css}</a></li>
								    	</c:if>
								    </c:forEach>
								    
								    <c:if test="${cs.hasNextPage }">
									    <li>
									      <a href="${app_path}/admin/rentinglist.do?pn=${cs.pageNum+1}" aria-label="Next">
									        <span aria-hidden="true">&raquo;</span>
									      </a>
									    </li>
								    </c:if>
								    <li><a href="${app_path}/admin/rentinglist.do?pn=${cs.pages}">末页</a></li>
								  </ul>
								</nav>							
			</div>	
		</div>
	</div>
</body>
<script type="text/javascript">
	$(function(){
		$(".delect").click(function(){
			var name=$(this).parents("tr").find("td:eq(3)").text();
			var id=$(this).attr("id");
			if(confirm("确认终止："+name+"的合同吗？")){
				//确认发送ajax请求删除
				$.ajax({
					url:"${app_path}/admin/delectcontract.do?id="+id,
					type:"get",
					success:function(result){
						alert("成功终止合同");
						window.location.reload();
					}		
				})
			}
		});
		
		//查看合同
		$(".a").on("click",function(){
			var houseid=$(this).attr("id");
			window.open("${app_path}/jsp/viewcontract/viewcontract.jsp?"+ houseid);
		});
	});
</script>

</html>