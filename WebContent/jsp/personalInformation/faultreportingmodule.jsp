<%@page import="java.util.UUID"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>报障模块</title>
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
		System.out.println("在faultreportingmodule中生成的token："+token);
		session.setAttribute("token", token);  //在服务器使用session保存token(令牌)
	%>
	<input type="hidden" id="token" value='${token}'/>
	<!-- 顶部导航 -->
	<div id="top">
		&nbsp;&nbsp; <a class="selet">我要报障</a> &nbsp;&nbsp;&nbsp;&nbsp; <a>已处理报障</a>&nbsp;&nbsp;&nbsp;&nbsp; <a>未处理报障</a>
	</div>

	<!-- 我要报障表格 -->
	<div id="repair" class="table-responsive">
		<table class="table table-bordered table-hover">
			<tr>
				<td>#</td>
				<td>房屋id</td>
				<td>地址</td>
				<td>租金</td>
				<td>租赁人</td>
				<td>身份证号</td>
				<td>电话</td>
				<td>操作</td>
			</tr>
		</table>
		<table id="repairData" class="table table-bordered table-hover"></table>
	</div>

	<!-- 已处理报障表格 -->
	<div id="repaired" class="table-responsive" style="display: none;">
		<table class="table table-bordered">
			<tr>
				<td>#</td>
				<td>房屋id</td>
				<td>地址</td>
				<td>报障日期</td>
				<td>租赁人</td>
				<td>报障内容</td>
				<td>状态</td>
				<td>操作</td>
			</tr>
		</table>
		<table id="repairedData" class="table table-bordered table-hover"></table>
	</div>

	<!-- 未处理报障表格 -->
	<div id="notRepaired" class="table-responsive" style="display: none;">
		<table class="table table-bordered">
			<tr>
				<td>#</td>
				<td>房屋id</td>
				<td>地址</td>
				<td>报障日期</td>
				<td>租赁人</td>
				<td>身份证号</td>
				<td>状态</td>
			</tr>
		</table>
		<table id="notRepairedData" class="table table-bordered table-hover"></table>
	</div>

	<!-- 分页栏 -->
	<div class="row" style="float: right;margin-right: 5%;">
		<!-- 解析显示分页条 -->
		<div class="col-md-12" id="house_nav"></div>
	</div>
	<p style="border-bottom: 1px solid silver; padding-bottom: 70px; width: 95%; margin: auto;"></p>
	
<!-- <form action="${app_path}/personacentermvc/contentofthereport.do" method="post">-->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">网上报修</h4>
					</div>
					<div class="modal-body">
						<div class="form-group">
							<label for="txt_departmentname">时间</label> 
							<input type="text" readonly="readonly" name="date" class="form-control" value="">
						</div>
						<div class="form-group">
							<label for="txt_departmentname">房屋编号</label> 
							<input type="text" readonly="readonly" name="housecall" class="form-control" value="">
						</div>
						<div class="form-group">
							<label for="txt_parentdepartment">房屋地址</label> 
							<input type="text" readonly="readonly" class="form-control" value="">
						</div>
						<div class="form-group">
							<label for="txt_departmentlevel">租赁人</label> 
							<input type="text" readonly="readonly" class="form-control" value="">
						</div>
						<div class="form-group">
							<label for="txt_statu">故障描述</label>
							<textarea style="resize: none;" class="form-control" name="contentofthe" rows="5"></textarea>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">
							<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>关闭
						</button>
						<button type="button" id="btn_submit" class="btn btn-primary" data-dismiss="modal">
							<span class="glyphicon glyphicon glyphicon-ok" aria-hidden="true">
						</span>提交</button>
					</div>
				</div>
			</div>
		</div>
	<!--  </form>-->
   
</body>
<script type="text/javascript">
$(function() {
	var str="我要报障";
	//选择功能
	$('#top a').click(function() {
		thislen = $('#top a').index(this);//获取当前长度
		$('#top a').eq(thislen).addClass("selet").siblings("a").removeClass("selet");
		if ($('#top a').eq(thislen).text() == "已处理报障") {
			$('#repaired').show();
			$('#repair').hide();
			$('#notRepaired').hide();
			str="已处理";
		}else if($('#top a').eq(thislen).text() == "未处理报障"){
			$('#notRepaired').show();
			$('#repair').hide();
			$('#repaired').hide();
			str="未处理";
		}else {
			$('#repair').show();
			$('#notRepaired').hide();
			$('#repaired').hide();
			str="我要报障";
		};
		to_page(1);
	});
	
	to_page(1);
	function to_page(pn){
		$.ajax({
			url : "${app_path}/personacentermvc/repairList.do",
			data : {"pn":pn,"str":str},
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
		$("#repair #repairData").empty();
		$("#repaired #repairedData").empty();
		$("#notRepaired #notRepairedData").empty();
		var house = result.extend.pageInfo.list;
		$.each(house, function(index, item) {
			var tr=$("<tr></tr>");
			var tdfid=$("<td></td>").append(++cunont);
			var tdleaseinformation_housecall=$("<td></td>");
			var tdleaseinformation_houseaddress=$("<td></td>");
			var tdleaseinformation_housemoney=$("<td></td>");
			var tdusername=$("<td></td>");
			var tduserid=$("<td></td>");
			var tduserphone=$("<td></td>");
			var tdfstate=$("<td></td>");
			
			var tdfdatetemp=$("<td></td>");
			var tdfcontent=$("<td></td>");
			
			if(str=="我要报障"){
				tdleaseinformation_housecall.append(item.leaseinformation.housecall);
				tdleaseinformation_houseaddress.append(item.leaseinformation.houseaddress);
				tdleaseinformation_housemoney.append(item.leaseinformation.housemoney);
				tdusername.append(item.username);
				tduserid.append(item.userid);
				tduserphone.append(item.userphone);
				//创建传递数据数组
				var myArray=new Array()
				myArray[0]=item.leaseinformation.housecall;
				myArray[1]=item.leaseinformation.houseaddress;
				myArray[2]=item.username;
				var a=$("<a data-toggle='modal' data-target='#myModal'><input type='hidden' value='"+ myArray +"'/>报障</a>");
				tr.append(tdfid).append(tdleaseinformation_housecall).append(tdleaseinformation_houseaddress)
				.append(tdleaseinformation_housemoney).append(tdusername).append(tduserid)
				.append(tduserphone).append(a).appendTo("#repair #repairData");
			}else {
				tdleaseinformation_housecall.append(item.fhouseid);
				tdleaseinformation_houseaddress.append(item.fhouseaddress);
				tdfdatetemp.append(item.fdatetemp);
				tdfcontent.append(item.fcontent);
				tdusername.append(item.fusername);
				tdfstate.append(item.fstate);
				tduserphone.append(item.fuserphone);
				tduserid.append(item.fuserid);
			}
			var token=$("#token").val();
			if(str=="已处理"){
				var a=$("<a href='${app_path}/personacentermvc/deleterepair.do?fid="+ item.fid +"&token="+ token +"'>删除</a>");
				tr.append(tdfid).append(tdleaseinformation_housecall).append(tdleaseinformation_houseaddress)
				.append(tdfdatetemp).append(tdusername).append(tdfcontent)
				.append(tdfstate).append(a).appendTo("#repaired #repairedData");
			}else if(str=="未处理"){
				tr.append(tdfid).append(tdleaseinformation_housecall).append(tdleaseinformation_houseaddress)
				.append(tdfdatetemp).append(tdusername).append(tduserid)
				.append(tdfstate).appendTo("#notRepaired #notRepairedData");
			}
		});
	}
	
	$("#btn_submit").on("click",function(){
		var temp=$(".modal-body").children().children("input");
		var date=$(temp).eq(0).val();
		var housecall=$(temp).eq(1).val();
		var contentofthe=$("[name='contentofthe']").eq(0).val();
		var token=$("#token").val();
		//如果填写内容是空
		if(contentofthe.match(/^\s*$/)){
			alert("不能输入为空的值");
		}else{
			$.ajax({
				url : "${app_path}/personacentermvc/contentofthereport.do",
				data : {"date":date,"housecall":housecall,"contentofthe":contentofthe,"token":token},
				type : "post",
				success : function(result) {
					alert("报障成功！");
					window.location.reload();
				}
			});
		}
	});
	
	//a标签点击触发模态退出窗口，传输相关数据
	$('#myModal').on('show.bs.modal', function (event) {
		//获取点击a标签
		var btnThis = $(event.relatedTarget);
		var str=$(btnThis).children("input").val();
		
		//分割
		var strtemp = new Array();
		strtemp = str.split(","); 
		var date = new Date();
		var year = date.getFullYear() // 年
		var month = date.getMonth() + 1; // 月
		var day  = date.getDate(); // 日
		var temp=$(".modal-body").children().children("input");
		$(temp).eq(0).val(year+'年'+month+'月'+day+'日');
		$(temp).eq(1).val(strtemp[0]);
		$(temp).eq(2).val(strtemp[1]);
		$(temp).eq(3).val(strtemp[2]);
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