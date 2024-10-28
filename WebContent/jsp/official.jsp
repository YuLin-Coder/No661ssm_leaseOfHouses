<!-- 官网 -->
<%@page import="java.util.UUID"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>菜鸟租赁网</title>
<%
	pageContext.setAttribute("app_path", request.getContextPath());
%>
<!--  Bootstrap 核心 CSS 文件 -->
<link rel="stylesheet"
	href="../static/bootstrap-3.3.7-dist/css/bootstrap.css">
<!-- 引用css -->
<style type="text/css">
@import url("../css/officialcss.css");
@import url("../css/load.css");
</style>
<!-- 引用js -->
<script type="text/javascript"
	src="../static/jquery/jquery-1.11.0.min.js"></script>
<!-- Bootstrap 核心 JavaScript 文件 -->
<script src="../static/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
</head>
<body>
	<!-- 加载动画 -->
	<div class="loader-wrapper">
		<span class="loader"><span class="loader-inner"></span></span>
	</div>
	
	<%
		String token =  UUID.randomUUID().toString() ;//创建令牌
		System.out.println("在officialjs中生成的token："+token);
		session.setAttribute("token", token);  //在服务器使用session保存token(令牌)
	%>
	
	<div id="loadmain">
		<!-- 导航栏 -->
		<%@ include file="navigationbar.jsp"%>
	
		<!-- 巨屏显示 -->
		<div class="jumbotron">
			<div class="giantScreen">
				<div class="list-group" id="recommend">
					<a href="#" class="list-group-item active"> 推荐房屋 </a>
				</div>
				<h1>菜鸟房屋租赁网</h1>
				<p>
					<a class="understand">了解我们</a>
				</p>
				<p>
					<a class="btn btn-primary btn-lg" href="#" role="button">Get to know us</a>
				</p>
	
			</div>
		</div>
	
		<!-- 轮播图 -->
		<div id="carousel-example-generic" class="carousel slide"
			data-ride="carousel" data-interval="2200">
			<!-- 指示符 -->
			<ul class="carousel-indicators">
				<li data-target="#carousel-example-generic" data-slide-to="0"
					class="active"><input type="hidden" value="0"></li>
				<li data-target="#carousel-example-generic" data-slide-to="1">
				<input type="hidden" value="1">
				</li>
				<li data-target="#carousel-example-generic" data-slide-to="2">
				<input type="hidden" value="2">
				</li>
				<li data-target="#carousel-example-generic" data-slide-to="3">
				<input type="hidden" value="3">
				</li>
				<li data-target="#carousel-example-generic" data-slide-to="4">
				<input type="hidden" value="4">
				</li>
			</ul>
	
			<div class="carousel-inner" role="listbox">
				<!-- 轮播房屋信息 -->
				<div id="rotatehouseinf">
					<div class="rotatehouseinftyp">
						<h1 class="carousel-title">南&nbsp;&nbsp;宁</h1>
							<span class="carousel-content">
								凤岭北 枫林蓝岸别墅 业主直租-独栋别
								墅-家具齐全-精装现代化风格——
								生活配套完善-有学校-商业-超市
								2客厅3卧室-大阳台
							</span>
					</div>
				</div>
				<div class="item active">
					<img class="img-inner"
						src="../img/scv.png">
				</div>
	
			</div>
	
			<!-- 左右切换按钮 -->
			<a class="left carousel-control" href="#carousel-example-generic"
				role="button" data-slide="prev"> <span
				class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span> <span
				class="sr-only">Previous</span>
			</a> <a class="right carousel-control" href="#carousel-example-generic"
				role="button" data-slide="next"> <span
				class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
				<span class="sr-only">Next</span>
			</a>
		</div>
	
		<div id="search">
			<div class="col-sm-10">
				<div class="input-group">
					<span class="input-group-addon"> <a href="#" id="housequery"
						style="text-decoration: none;">搜索</a>
					</span> <input type="text" class="form-control" id="inputGroupSuccess4"
						aria-describedby="inputGroupSuccess4Status">
				</div>
	
				<span style="padding-right: 20px; color: #337ab7;"
					class="glyphicon glyphicon-search form-control-feedback"
					aria-hidden="true"></span><span id="inputGroupSuccess4Status"
					class="sr-only">(success)</span> <span id="promptinput"
					class="btn btn-default" data-toggle="tooltip" data-placement="right"
					title="Tooltip on right">输入关键词查询房屋信息</span>
			</div>
		</div>
		
		<!-- 房源信息 -->
		<div id="houseslist">
			<h2 style="letter-spacing: 10px;">全部房源</h2>
			<div id="house" class="row"></div>
	
			<!-- 分页栏 -->
			<div class="row">
				<!-- 解析并显示分页信息 -->
				<div class="col-md-12" id="house_info"></div>
				<!-- 解析显示分页条 -->
				<div class="col-md-12" id="house_nav"></div>
			</div>
		</div>
	
	
		<!-- 页脚 -->
		<%@ include file="footer.jsp"%>
	</div>
</body>
<script type="text/javascript">
	$(function(){
		var checkSubmitFlg = false;
	    function checkSubmit() {
	      if (checkSubmitFlg == true) {
	         return false;
	      }
	      checkSubmitFlg = true;
	      return true;
	   }
	   document.ondblclick = function docondblclick() {
	    window.event.returnValue = false;
	   }
	   document.onclick = function doconclick() {
	       if (checkSubmitFlg) {
	         window.event.returnValue = false;
	       }
	   } 
		
		var tt='${apply}';
		if(tt!=""){
			alert(tt);
			<%request.removeAttribute("apply");%>
			tt="";
		}
		
		to_page(1);

		function to_page(pn){
			$.ajax({
				url : "${app_path}/officialmvc/listByPage.do",
				data : "pn="+pn,
				type : "get",
				success : function(result) {
					//解析并显示楼房数据
					house_table(result);
					//解析并显示分页信息
					build_info(result);
					//解析并显示分页条信息
					build_nav(result);
				}
			});
		}
			
		//解析并显示楼房数据
		function house_table(result) {
			$("#houseslist #house").empty();
			var house = result.extend.pageInfo.list;
			$.each(house, function(index, item) {
				var img = $("<img class='imgtemp' style='width: 100%;height: 195.8px' src='/leaseimg/"+item.leaseimg.imgroute+"' alt='通用的占位符缩略图' />");
				var d=$("<div style='overflow: hidden;width: 100%;height: 195.8px'></div>").append(img);
				var h3 = $("<h3></h3>").append(item.houseaddress);
				var p = $("<p></p>").append(item.housetype + "类型-" + item.housesize + "平方面积-现在是"+ item.housestate + "状态");
				//var a = $("<a href='${app_path}/jsp/details.jsp?id=1' class='thumbnail'></a>").append(img).append(h3).append(p);
				var a = $("<a name='atemp' style='box-shadow:0px 15px 10px -15px #000;' href='${app_path}/leaseinformationmvc/details.do?id="+item.houseid+"'"+ " class='thumbnail'></a>").append(d).append(h3).append(p);
				var div = $("<div class='col-xs-3 col-sm-3 col-md-3'></div>").append(a).appendTo("#houseslist #house");
			});
			$("[name='atemp']").on("mouseover",function(){
				$(this).children().children('.imgtemp').css("transform","scale(1.2)");
				$(this).children().children('.imgtemp').css("transition","all 0.4s ease 0s");
			}).mouseout(function(){
				$(this).children().children('.imgtemp').css("transform","scale(1)");
				$(this).children().children('.imgtemp').css("transition","all 0.4s ease 0s");
			});
		}
		//解析并显示分页信息
		function build_info(result) {
			$("#house_info").empty();
			var tempresult=result.extend.pageInfo;
			$("#house_info").append("当前"+tempresult.pageNum+"页，总"+tempresult.pages+"页，总"+tempresult.total+"条记录")
		}
		//解析显示分页条
		function build_nav(result) {
			$("#house_nav").empty();
			var ul=$("<ul></ul>").addClass("pagination");
			var lifirst=$("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
			var lilast=$("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
			var lipre=$("<li></li>").append($("<a></a>").append("&laquo;"));
			var linext=$("<li></li>").append($("<a></a>").append("&raquo;"));
				
			//判断元素是否为第一个，如果是禁止点击
			if(result.extend.pageInfo.hasPreviousPage==false){
				lifirst.addClass("disabled");
				lipre.addClass("disabled");
			}
			//判断元素是否为最后一个，如果是禁止点击
			if(result.extend.pageInfo.hasNextPage==false){
				lilast.addClass("disabled");
				linext.addClass("disabled");
			}
				
			//为元素添加点击翻页的事件
			//首页
			lifirst.click(function(){
				to_page(1);
			});
			//前一页
			lipre.click(function(){
				if(result.extend.pageInfo.pageNum==1){
				}else{
					to_page(result.extend.pageInfo.pageNum-1);
				}
			});
			//末页
			lilast.click(function(){
				to_page(result.extend.pageInfo.pages);
			});
			//后一页
			linext.click(function(){
				if(result.extend.pageInfo.pageNum==result.extend.pageInfo.pages){
				}else{
					to_page(result.extend.pageInfo.pageNum+1);
				}
			});
				
			ul.append(lifirst).append(lipre);
				
			$.each(result.extend.pageInfo.navigatepageNums,function(index, item){
				var numLi=$("<li></li>").append($("<a></a>").append(item).attr("href","#"));
				if(result.extend.pageInfo.pageNum==item){
					numLi.addClass("active");
				}
				numLi.click(function(){
					to_page(item);
				});
				ul.append(numLi);
			});
				
			ul.append(linext).append(lilast);
				
			var navEle=$("<nav></nav>").append(ul);
			navEle.appendTo("#house_nav");
		}
		
		to_page2(1);
		function to_page2(pn){
			$.ajax({
				url : "${app_path}/officialmvc/recommend.do",
				data :"pn="+pn,
				type : "get",
				success : function (result) {
					recommend_table(result);
				}
					
			});
		}

		//解析并显示楼房数据
		function recommend_table(result) {
			var recommend_table = result.extend.pages.list;
			$.each(recommend_table, function(index, item) {
			var p = $("<p style='font-size: 16px; font-weight: 400; font-family:微软雅黑;' ></p>").append(item.houseaddress+":"+item.housetype + "类型房屋," + item.housesize + "平方面积，现在是"+ item.housestate + "状态");
			var a = $("<a style='padding-bottom:0px;' href='${app_path}/leaseinformationmvc/details.do?id="+item.houseid+"'"+ " class='list-group-item'></a>").append(p);
			a.appendTo("#recommend");
			});
		}
		
		//搜索功能 $("#houseslist #house").empty();
		$("#housequery").on("click",function(){
			var queryValue=$("#inputGroupSuccess4").val();
			$.ajax({
				url : "${app_path}/officialmvc/housequery.do",
				data : {"queryValue":queryValue},
				type : "get",
				success : function(result) {
					$("#inputGroupSuccess4").val("");
					//解析并显示楼房数据
					house_table(result);
					//解析并显示分页信息
					build_info(result);
					//解析并显示分页条信息
					build_nav(result);
				}
			});
		});
	});
</script>
<script type="text/javascript" src="../js/officialjs.js"></script>
<script type="text/javascript" src="../js/load.js"></script>
</html>