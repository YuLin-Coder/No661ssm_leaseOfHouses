<%@page import="java.util.UUID"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>租赁信息</title>
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

table {
	text-align: center;
}

table a {
	line-height: 35px;
	text-align: center;
	cursor: pointer;
}
</style>
</head>
<body>
	<%
		String token =  UUID.randomUUID().toString() ;//创建令牌
		System.out.println("在information中生成的token："+token);
		session.setAttribute("token", token);  //在服务器使用session保存token(令牌)
	%>
	<input type="hidden" id="token" value='${token}'/>

	<!-- 顶部导航 -->
	<div id="top">
		&nbsp;&nbsp; <a class="selet">我的租赁</a> &nbsp;&nbsp;&nbsp;&nbsp; <a>已退租赁记录</a>
	</div>

	<!-- 我的租赁表格 -->
	<div id="myRental" class="table-responsive">
		<table class="table table-bordered table-hover">
			<tr>
				<td>#</td>
				<td>租赁人</td>
				<td>身份证号</td>
				<td>电话</td>
				<td>房屋id</td>
				<td>地址</td>
				<td>价格</td>
				<td>操作</td>
			</tr>
		</table>
		<table id="myRentalData" class="table table-bordered table-hover"></table>
	</div>

	<!-- 已退租表格 -->
	<div id="refundedLease" class="table-responsive" style="display: none;">
		<table class="table table-bordered">
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
		<table id="refundedLeaseData" class="table table-bordered table-hover"></table>
	</div>

	<!-- 分页栏 -->
	<div class="row" style="float: right; margin-right: 5%;">
		<!-- 解析显示分页条 -->
		<div class="col-md-12" id="house_nav"></div>
	</div>
	<p
		style="border-bottom: 1px solid silver; padding-bottom: 70px; width: 95%; margin: auto;"></p>

	<!--弹窗 start -->
	<div class="modal fade" id="mymodal" role="dialog"
		style="font-size: 17px; font-weight: '微软雅黑';">
		<div class="modal-dialog" style="width: 70%">
			<div class="modal-content">
				<div id="embed" class="modal-header" style="font-weight: bold;">
					<!--  <embed id="embed" src="" type="application/pdf" width="100%" height="800px" internalinstanceid="81" />-->
				</div>
				<div class="modal-footer">
					<button data-dismiss="modal" style="padding: 0px 10px">关闭</button>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
	$(function() {
		//模态框数组
		var list=new Array();
		var array = [];

		//选择功能判断
		var flag = true;
		//选择功能
		$('#top a').click(
				function() {
					thislen = $('#top a').index(this);//获取当前长度
					$('#top a').eq(thislen).addClass("selet").siblings("a")
							.removeClass("selet");
					if ($('#top a').eq(thislen).text() == "已退租赁记录") {
						$('#refundedLease').show();
						$('#myRental').hide();
						flag = false;
					} else {
						$('#refundedLease').hide();
						$('#myRental').show();
						flag = true;
					}
					;
					to_page(1);
				});

		to_page(1);
		function to_page(pn) {
			var URL;
			if (flag) {
				URL = "${app_path}/personacentermvc/myRentalList.do";
			} else {
				URL = "${app_path}/personacentermvc/refundedLeaseList.do";
			}
			$.ajax({
				url : URL,
				data : "pn=" + pn,
				type : "get",
				success : function(result) {
					//解析并显示楼房数据
					if (flag) {
						house_table_my(result);
					} else {
						house_table_re(result);
					}

					//解析并显示分页条信息
					build_nav(result);
				}
			});
		}

		//解析并显示楼房数据
		function house_table_my(result) {
			var cunont = 0;
			//加载清空数据
			$("#myRental #myRentalData").empty();
			var house = result.extend.pageInfo.list;
			$.each(
					house,
					function(index, item) {
						var tr = $("<tr></tr>");
						var tdid = $("<td></td>").append(++cunont);
						var tdusername = $("<td></td>").append(
								item.username);
						var tduserid = $("<td></td>").append(
								item.userid);
						var tduserphone = $("<td></td>").append(
								item.userphone);
						var tdleaseinformation_housecall = $(
								"<td></td>").append(
								item.leaseinformation.housecall);
						var tdleaseinformation_houseaddress = $(
								"<td></td>").append(
								item.leaseinformation.houseaddress);
						var td = $("<td></td>").append(
								item.leaseinformation.housemoney);
						array = [
								item.username,
								item.userid,
								item.leaseinformation.houseaddress,
								item.leaseinformation.housestartingdatetemp,
								item.leaseinformation.houseclosingdatetemp,
								item.leaseinformation.housemoney,
								item.userphone,
								item.leaseinformation.houseid ];
						list[cunont]=array;
						var token=$("#token").val();
						var a = $("<a href='${app_path}/personacentermvc/termination.do?call="
								+ item.leaseinformation.housecall
								+ "&token="+ token +"' >终止合同</a>");
						tr.append(tdid).append(tdusername).append(
								tduserid).append(tduserphone).append(
								tdleaseinformation_housecall).append(
								tdleaseinformation_houseaddress)
								.append(td).append(a);
						tr.appendTo("#myRental #myRentalData");
						//data-toggle='modal' data-target='#mymodal'  href='${app_path}/personacentermvc/viewcontract.do?array="+ array +"'
			});
			
			$(".a").on("click",function(){
				//加载清空数据
				$("#embed").empty();
				var count=$(this).children('input').val();
				$.ajax({
					url : "${app_path}/personacentermvc/viewcontract.do",
					async: true,
					type : "post",
					xhrFields: {withCredentials: true},
					data : {
						'username' : list[count][0],
						'userid' : list[count][1],
						'houseaddress' : list[count][2],
						'housestartingdatetemp' : list[count][3],
						'houseclosingdatetemp' : list[count][4],
						'housemoney' : list[count][5],
						'userphone' : list[count][6],
						'houseid' : list[count][7]
					},
					success : function(result) {
						var embed=$("<embed src='/contract/pdf/" +(list[count][0]+list[count][7])+ "pdf.pdf' type='application/pdf' width='100%' height='800px' internalinstanceid='81' />");
						setTimeout(() => {
							//$("#embed").load(location.href + " #embed ");
							$("#mymodal").modal("show");//显示某个模态框
							embed.appendTo("#embed");
						}, 500);
					},
					error:function(result){
						alert("异常"+result);
					}
				});
			});
		}

		//解析并显示楼房数据
		function house_table_re(result) {
			var cunont = 0;
			//加载清空数据
			$("#refundedLease #refundedLeaseData").empty();
			var house = result.extend.pageInfo.list;
			$
					.each(
							house,
							function(index, item) {
								var tr = $("<tr></tr>");
								var tdid = $("<td></td>").append(++cunont);
								var tdrwusername = $("<td></td>").append(
										item.rwusername);
								var tdrwuserid = $("<td></td>").append(
										item.rwuserid);
								var tdrwuserphone = $("<td></td>").append(
										item.rwuserphone);
								var tdrwhouseid = $("<td></td>").append(
										item.rwhouseid);
								var tdrwhouseaddress = $("<td></td>").append(
										item.rwhouseaddress);
								var tdrwstate = $("<td></td>").append(
										item.rwstate);
								var token=$("#token").val();
								var a = $("<a href='${app_path}/personacentermvc/deleterentrefund.do?rwid="
										+ item.rwid + "&token="+ token +"'>删除</a>");

								tr.append(tdid).append(tdrwusername).append(
										tdrwuserid).append(tdrwuserphone)
										.append(tdrwhouseid).append(
												tdrwhouseaddress).append(
												tdrwstate).append(a);

								tr
										.appendTo("#refundedLease #refundedLeaseData");
							});
		}

		//解析显示分页条
		function build_nav(result) {
			$("#house_nav").empty();
			var ul = $("<ul></ul>").addClass("pagination");
			var lifirst = $("<li></li>").append(
					$("<a></a>").append("首页").attr("href", "#"));
			var lilast = $("<li></li>").append(
					$("<a></a>").append("末页").attr("href", "#"));

			//判断元素是否为第一个，如果是禁止点击
			if (result.extend.pageInfo.hasPreviousPage == false) {
				lifirst.addClass("disabled");
			}
			//判断元素是否为最后一个，如果是禁止点击
			if (result.extend.pageInfo.hasNextPage == false) {
				lilast.addClass("disabled");
			}

			//为元素添加点击翻页的事件
			//首页
			lifirst.click(function() {
				to_page(1);
			});
			//末页
			lilast.click(function() {
				to_page(result.extend.pageInfo.pages);
			});

			ul.append(lifirst);

			$.each(result.extend.pageInfo.navigatepageNums, function(index,
					item) {
				var numLi = $("<li></li>").append(
						$("<a></a>").append(item).attr("href", "#"));
				if (result.extend.pageInfo.pageNum == item) {
					numLi.addClass("active");
				}
				numLi.click(function() {
					to_page(item);
				});
				ul.append(numLi);
			});

			ul.append(lilast);

			var navEle = $("<nav></nav>").append(ul);
			navEle.appendTo("#house_nav");
		}
	});
</script>
</html>