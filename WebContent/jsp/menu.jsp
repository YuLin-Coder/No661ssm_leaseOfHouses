<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <!--  Bootstrap 核心 CSS 文件 -->
<link rel="stylesheet" href="../static/bootstrap-3.3.7-dist/css/bootstrap.css">
<!DOCTYPE html>
<%
	pageContext.setAttribute("app_path", request.getContextPath());
%>
		<!-- 菜单栏 -->
		<div id="menu" class="list-group">
				<a href="#" class="list-group-item active" style="font-size: 20px;">菜单</a>
				<ul class="menu-list">
					<li>
						<!--房源信息  -->
						<a href="#" ><i class="glyphicon glyphicon-th-list"></i>房源信息</a>
						
						<div class="p" class="list-group">

								<a href="${app_path }/admin/pagingselecthouse.do?"  class="list-group-item"><i class="glyphicon glyphicon-align-justify"></i>房源列表</a>
								<a href="${app_path }/jsp/housingadd.jsp"  class="list-group-item"><i class="glyphicon glyphicon-plus"></i>添加房源</a>

						</div>
					</li>
					<li>
						<!--租赁及合同信息  -->
						<a href="#" ><i class="glyphicon glyphicon-file"></i>租赁及合同信息</a>
						
						<div class="p"  class="list-group-item">
			
								<a href="${app_path}/admin/rentinglist.do?pn=1"  class="list-group-item"><i class="glyphicon glyphicon-home"></i>在租列表</a>
								<a href="${app_path}/admin/details.do?pn=1"  class="list-group-item"><i class="glyphicon glyphicon-trash"></i>已退租列表</a>

						</div>
					</li>
					<li>
						<!--申请列表  -->
						<a href="#" ><i class="glyphicon glyphicon-road"></i>申请列表</a>
						
						<div class="p"  class="list-group-item">
							
								<a href="${app_path}/admin/houseapply.do?pn=1"  class="list-group-item"><i class="glyphicon glyphicon-eye-open" ></i>看房申请</a>
								<a href="${app_path}/admin/tzshenqing.do?pn=1"  class="list-group-item"><i class="glyphicon glyphicon-trash" ></i>退租申请</a>
						
						</div>
					</li>
					<li>
						<!--报障模块  -->
						<a href="#" ><i class="glyphicon glyphicon-cog"></i>报障模块</a>
						
						<div class="p"  class="list-group-item">
							
								<a href="${app_path}/admin/Adminselectrepairwait.do?pn=1"  class="list-group-item"><i class="glyphicon glyphicon-time"></i>待处理报障</a>
								<a href="${app_path}/admin/Adminselectrepairdone.do?pn=1"  class="list-group-item"><i class="glyphicon glyphicon-ok"></i>已处理报障</a>
							
						</div>
					</li>
					<li>
						<!--租金信息  -->
						<a href="#" ><i class="glyphicon glyphicon-yen"></i>租金信息</a>
						
						<div class="p"  class="list-group-item">
							
								<a href="${app_path}/admin/adminrentshou.do?pn=1"  class="list-group-item"><i class="glyphicon glyphicon-piggy-bank"></i>我要收租</a>
								<a href="${app_path}/admin/adminrentwait.do?pn=1"  class="list-group-item"><i class="glyphicon glyphicon-question-sign"></i>租客待缴租金</a>
								<a href="${app_path}/admin/adminselectPaidAll.do?pn=1"  class="list-group-item"><i class="glyphicon glyphicon-ok-sign"></i>租客已缴租金</a>
							
						</div>
					</li>
					<li>
						<!--我的日程  -->
						<a href="#" ><i class="glyphicon glyphicon-send"></i>我的日程</a>
						
						<div class="p"  class="list-group-item">
							
								<a href="${app_path}/admin/schedulelist.do?pn=1"  class="list-group-item"><i class="glyphicon glyphicon-edit"></i>查看日程</a>
								<a href="${app_path}/jsp/scheduleadd.jsp"  class="list-group-item"><i class="glyphicon glyphicon-plus-sign"></i>添加日程</a>
							
						</div>
					</li>
					<li>
						<!--官网设置  -->
						<a href="#" ><i class="glyphicon glyphicon-tasks"></i>官网设置</a>
						
						<div class="p"  class="list-group-item">
							
								<a href="${app_path }/admin/recommendlist.do?"  class="list-group-item"><i class="glyphicon glyphicon-thumbs-up"></i>推荐设置</a>
							
						</div>
					</li>
					<li>
						<!--其他操作  -->
						<a href="#" ><i class="glyphicon glyphicon-th-large"></i>其他操作</a>
						
						<div class="p"  class="list-group-item">
							
							<a href="${app_path }/admin/pagingselectuser.do"  class="list-group-item"><i class="glyphicon glyphicon-user"></i>账户管理</a>
							
						</div>
					</li>
				</ul>
			</div>