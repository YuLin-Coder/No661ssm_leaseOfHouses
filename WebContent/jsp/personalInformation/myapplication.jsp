<%@page import="java.util.UUID"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>我的申请</title>
<%
	pageContext.setAttribute("app_path", request.getContextPath());
%>
<style type="text/css">
* {
	padding: 0px;
	margin: 0px;
}

#top {
	width: 95%;
	margin: auto;
	line-height: 60px;
	font-size: 18px;
	font-family: "微软雅黑";
	border-bottom: 1px silver solid;
}

#top a {
	color: black;
	text-decoration: none;
	padding-bottom: 17px;
}

#top a:hover {
	color: #337ab7;
	cursor: pointer;
}

#top .selet {
	color: #337ab7;
	border-bottom: 2px solid #337ab7;
}

.table-responsive {
	width: 95%;
	margin: auto;
	padding-top: 10px;
	font-size: 14px;
	font-family: "微软雅黑";
}

table{
	text-align: center;
}

table a{
	line-height: 35px;
	text-align: center;
	cursor: pointer;
}
</style>
</head>
<body>
	<%
		String token =  UUID.randomUUID().toString() ;//创建令牌
		System.out.println("在myapplication中生成的token："+token);
		session.setAttribute("token", token);  //在服务器使用session保存token(令牌)
	%>
	<input type="hidden" id="token" value='${token}'/>
	<!-- 顶部导航 -->
	<div id="top">
		&nbsp;&nbsp; <a class="selet">申请状态</a>&nbsp;&nbsp;&nbsp;&nbsp; <a>退租申请记录</a>
	</div>

	<!-- 看房申请状态表格 -->
	<div id="applicationAtatus" class="table-responsive">
		<table class="table table-bordered table-hover">
			<tr>
				<td>#</td>
				<td>租赁人</td>
				<td>身份证号</td>
				<td>电话</td>
				<td>房屋id</td>
				<td>地址</td>
				<td>状态</td>
				<td>操作</td>
			</tr>
		</table>
		<table id="applicationAtatusData" class="table table-bordered table-hover"></table>
	</div>
	
	<!-- 退租申请记录 -->
	<div id="applicationRecordOfRent" class="table-responsive" style="display: none;">
		<table class="table table-bordered table-hover">
			<tr>
				<td>#</td>
				<td>租赁人</td>
				<td>身份证号</td>
				<td>电话</td>
				<td>房屋id</td>
				<td>地址</td>
				<td>状态</td>
				<td>操作</td>
			</tr>
		</table>
		<table id="applicationRecordOfRentData" class="table table-bordered table-hover"></table>
	</div>
	
	<!-- 分页栏 -->
	<div class="row" style="float: right;margin-right: 5%;">
		<!-- 解析显示分页条 -->
		<div class="col-md-12" id="house_nav"></div>
	</div>
	<p style="border-bottom: 1px solid silver; padding-bottom: 70px; width: 95%; margin: auto;"></p>
</body>
<script type="text/javascript">
	$(function() {
		
		//选择功能判断
		var flag=true;
		//选择功能
		$('#top a').click(function() {
			thislen = $('#top a').index(this);//获取当前长度
			$('#top a').eq(thislen).addClass("selet").siblings("a").removeClass("selet");
			if ($('#top a').eq(thislen).text() == "退租申请记录") {
				$('#applicationRecordOfRent').show();
				$('#applicationAtatus').hide();
				flag=false;
			} else {
				$('#applicationRecordOfRent').hide();
				$('#applicationAtatus').show();
				flag=true;
			};
			to_page(1);
		});
		
		to_page(1);
		function to_page(pn){
			$.ajax({
				url : "${app_path}/personacentermvc/applicationAtatusList.do",
				data : {"pn":pn,"flag":flag},
				type : "get",
				success : function(result) {
					//解析并显示楼房数据
					house_table(result);
					//解析并显示分页条信息
					build_nav(result);
				}
			});
		}
	
	//解析并显示楼房数据
	function house_table(result) {
		//加载清空数据
		$("#applicationAtatus #applicationAtatusData").empty();
		$("#applicationRecordOfRent #applicationRecordOfRentData").empty();
		var house = result.extend.pageInfo.list;
		var cunont=0;
		$.each(house, function(index, item) {
			var tr=$("<tr></tr>");
			var tdcoaid=$("<td></td>").append(++cunont);
			var tdcoausername=$("<td></td>").append(item.coausername);
			var tdcoauserid=$("<td></td>").append(item.coauserid);
			var tdcoauserphone=$("<td></td>").append(item.coauserphone);
			var tdcoahouseid=$("<td></td>").append(item.coahouseid);
			var tdcoahouseaddress=$("<td></td>").append(item.coahouseaddress);
			var tdcoastate=$("<td></td>").append(item.coastate);
			var a;
			
			var token=$("#token").val();
			if(flag){
				a=$("<a href='${app_path}/personacentermvc/stopapplying.do?call="+ item.coahouseid +"&token="+ token +"'>终止申请</a>");
			}else{
				a=$("<a href='${app_path}/personacentermvc/deleterecord.do?coaid="+ item.coaid +"&token="+ token +"'>删除</a>");
			}
			
			tr.append(tdcoaid).append(tdcoausername).append(tdcoauserid)
			.append(tdcoauserphone).append(tdcoahouseid).append(tdcoahouseaddress)
			.append(tdcoastate).append(a);
			if(flag){
				tr.appendTo("#applicationAtatus #applicationAtatusData");
			}else{
				tr.appendTo("#applicationRecordOfRent #applicationRecordOfRentData");
			}
		});
		
	};
	//解析显示分页条
	function build_nav(result) {
		$("#house_nav").empty();
		var ul=$("<ul></ul>").addClass("pagination");
		var lifirst=$("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
		var lilast=$("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
				
		//判断元素是否为第一个，如果是禁止点击
		if(result.extend.pageInfo.hasPreviousPage==false){
			lifirst.addClass("disabled");
		}
		//判断元素是否为最后一个，如果是禁止点击
		if(result.extend.pageInfo.hasNextPage==false){
			lilast.addClass("disabled");
		}
				
		//为元素添加点击翻页的事件
		//首页
		lifirst.click(function(){
			to_page(1);
		});
		//末页
		lilast.click(function(){
			to_page(result.extend.pageInfo.pages);
		});
				
		ul.append(lifirst);
				
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
				
		ul.append(lilast);
				
		var navEle=$("<nav></nav>").append(ul);
		navEle.appendTo("#house_nav");
	}
	
});

</script>
</html>