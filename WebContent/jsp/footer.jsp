<!-- 页脚 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>页脚</title>
<style type="text/css">
* {
	padding: 0px;
	margin: 0px;
	font-family: "微软雅黑";
}

a {
	text-decoration: none;
}

ul li {
	list-style: none;
}

body {
	width: 100%;
	height: 100%;
}

#footermain {
	width: 100%;
	background-color: #3d3d45;
	padding-top: 40px;
}

#footermain table {
	width: 100%;
	height: 100%;
	margin: auto;
}

#footermain table tr td.txttop{
	text-align: center;
	border-bottom: 0.1px solid #999999;
	padding-bottom: 30px;
}

#footermain table tr td.txttop a{
	font-size: 20px;
	color: silver;
}

#footermain table tr td.txttop a:hover{
	color: white;
}

#footermain table tr td.txtmiddle{
	color: silver;
	font-size: 14px;
	text-align: center;
	padding-top: 40px;
	padding-bottom: 10px;
}

#footerbottom {
	width: 100%;
	height: 24px;
	background-color: silver;
	text-align: center;
	font-size: 14px;
	padding-top: 3px;
}

.butimg img{
	width: 100%;
	margin-top: -34px;
}

@media screen and (max-width: 1200px) {
	#footermain,#footerbottom,.butimg img{
		width: 1200px;
	}
}
</style>
</head>
<body>
	<div id="footermain">
		<table>
			<tr>
				<td colspan="2" class="txttop">
					<a href="#">关于菜鸟租赁</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="#">联系我们</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="#">房产问答</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="#">人才招聘</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="#">用户协议</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="#">使用帮助</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="#">友情链接</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="#">网站地图</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
			
			<tr>
				<td class="txtmiddle" colspan="2">
					菜鸟租赁网是国内房地产交易网络平台，提供楼房，平房，别墅，小区类型的租赁房屋信息！租房上菜鸟租赁！
					<br/>
					Copyright © 2020~2021 qfang.com All Rights Reserved ICP号：粤ICP备05067219号 服务热线：1010 6888
				</td>
			</tr>
			<tr>
				<td><img src="../img/菜鸟起飞logo.jpg"
					style="text-align: center; float: right;"></td>
				<td><img src="../img/学校logo.jpg" style="float: left;"></td>
			</tr>
		</table>
		<div class="butimg">
			<img src="../img/底部图标.png">
		</div>
	</div>
	<div id="footerbottom">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		为生活充电在线&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		招商热线&nbsp;:&nbsp;1352_7134212&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		客服热线&nbsp;:&nbsp;4261_2334629&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	</div>
</body>
</html>