<%@page import="com.javabean.AlipayConfig"%>
<%@page import="com.alipay.api.request.AlipayTradePagePayRequest"%>
<%@page import="com.alipay.api.AlipayClient"%>
<%@ page import="com.alipay.api.*"%>
<%@ page import="com.alipay.api.request.*"%>
<%@page import="java.util.UUID"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>代缴租金</title>
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
		System.out.println("在rentpayment中生成的token："+token);
		session.setAttribute("token", token);  //在服务器使用session保存token(令牌)
	%>
	
	<input type="hidden" id="token" value='${token}'/>
	<!-- 顶部导航 -->
	<div id="top">
		&nbsp;&nbsp; <a class="selet">待缴租金</a> &nbsp;&nbsp;&nbsp;&nbsp; <a>已缴租金记录</a>
	</div>

	<!-- 待缴租金表格 -->
	<div id="rentToBePaid" class="table-responsive">
		<table class="table table-bordered table-hover">
			<tr>
				<td>#</td>
				<td>房屋id</td>
				<td>地址</td>
				<td>租金</td>
				<td>租金应缴日期</td>
				<td>租客姓名</td>
				<td>状态</td>
				<td>操作</td>
			</tr>
		</table>
		<table id="rentToBePaidData" class="table table-bordered table-hover"></table>
	</div>

	<!-- 已缴租金记录表格 -->
	<div id="rentPaidRecords" class="table-responsive" style="display: none;">
		<table class="table table-bordered">
			<tr>
				<td>#</td>
				<td>房屋id</td>
				<td>地址</td>
				<td>租金</td>
				<td>租金应缴日期</td>
				<td>租金实缴日期</td>
				<td>租客姓名</td>
				<td>状态</td>
				<td>操作</td>
			</tr>
		</table>
		<table id="rentPaidRecordsData" class="table table-bordered table-hover"></table>
	</div>

	<div class="col-md-8 col-md-offset-1" id="coPaymentOfRent" style="display: none; font-size: 17px; font-weight: bold;">共缴纳租金:<span id="num"></span></div>
	<!-- 分页栏 -->
	<div class="row" style="float: right;margin-right: 5%;">
		<!-- 解析显示分页条 -->
		<div class="col-md-12" id="house_nav"></div>
	</div>
	<p id="botp" style="border-bottom: 1px solid silver; padding-bottom: 70px; width: 95%; margin: auto;"></p>
</body>
<script type="text/javascript">
$(function() {
	//选择功能判断
	var flag=true;
	//选择功能
	$('#top a').click(function() {
		thislen = $('#top a').index(this);//获取当前长度
		$('#top a').eq(thislen).addClass("selet").siblings("a").removeClass("selet");
		if ($('#top a').eq(thislen).text() == "已缴租金记录") {
			$('#rentPaidRecords').show();
			$('#rentToBePaid').hide();
			$("#coPaymentOfRent").show();
			$("#botp").css("padding-bottom","90px");
			flag=false;
		} else {
			$('#rentPaidRecords').hide();
			$('#rentToBePaid').show();
			$("#coPaymentOfRent").hide();
			$("#botp").css("padding-bottom","70px");
			flag=true;
		};
		to_page(1);
	});
	
	to_page(1);
	function to_page(pn){
		var state;
		if(flag){
			state="未缴纳";
		}else{
			state="已缴纳";
			$.ajax({
				url : "${app_path}/personacentermvc/copaymentfee.do",
				data : {"state":state},
				type : "get",
				success : function(result) {
					$("#num").text(result.extend.num);
				}
			});
		}
		$.ajax({
			url : "${app_path}/personacentermvc/rentpaymentList.do",
			data : {"pn":pn,"state":state},
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
		var cunont=0;
		//加载清空数据
		$("#rentToBePaid #rentToBePaidData").empty();
		$("#rentPaidRecords #rentPaidRecordsData").empty();
		var house = result.extend.pageInfo.list;
		$.each(house, function(index, item) {
			var tr=$("<tr></tr>");
			var tdrcid=$("<td></td>").append(++cunont);
			var tdrchouseid=$("<td></td>").append(item.rchouseid);
			var tdrchouseaddress=$("<td></td>").append(item.rchouseaddress);
			var tdrchousemoney=$("<td></td>").append(item.rchousemoney);
			var tdrcdate=$("<td></td>").append(item.rcdatetemp);
			var tdrcpaiddate=$("<td></td>").append(item.rcpaiddatetemp);
			var tdrcusername=$("<td></td>").append(item.rcusername);
			var tdrcstate=$("<td></td>").append(item.rcstate);
			var a;
			var token=$("#token").val();
			if(flag){
/* 				var a=$("<a href='${app_path}/jsp/alipay/alipaypay.jsp?rchousemoney="+ item.rchousemoney +"&rcid="+ item.rcid +"'>支付租金</a>");*/
 				var a=$("<a href='${app_path}/personacentermvc/payrentmvc.do?rcid="+ item.rcid +"&token="+ token +"'>支付租金</a>");
				tr.append(tdrcid).append(tdrchouseid).append(tdrchouseaddress)
				.append(tdrchousemoney).append(tdrcdate).append(tdrcusername)
				.append(tdrcstate)
			}else{
				var a=$("<a href='${app_path}/personacentermvc/paidrent.do?rcid="+ item.rcid +"&token="+ token +"'>删除</a>");
				tr.append(tdrcid).append(tdrchouseid).append(tdrchouseaddress)
				.append(tdrchousemoney).append(tdrcdate).append(tdrcpaiddate)
				.append(tdrcusername).append(tdrcstate)
			}
			
			tr.append(a);
			if(flag){
				tr.appendTo("#rentToBePaid #rentToBePaidData");
			}else{
				tr.appendTo("#rentPaidRecords #rentPaidRecordsData");
			}
		});
	}
	
	//a标签点击触发模态退出窗口，传输相关数据
	$('#myModal').on('show.bs.modal', function (event) {
		//获取点击a标签
		var btnThis = $(event.relatedTarget);
		var str=$(btnThis).children("input").val();
		var rcid=$(btnThis).attr("class");//获取class值
		$("#rchousemoney").attr("class",rcid);
		$("#rchousemoney").text(str);
	});
	
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