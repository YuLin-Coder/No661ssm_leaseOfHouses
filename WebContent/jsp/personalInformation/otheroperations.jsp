<%@page import="java.util.UUID"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>其他操作</title>
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
	cursor: pointer;
}

#top .selet {
	color: #337ab7;
	border-bottom: 2px solid #337ab7;
}

#personalInformation {
	width: 95%;
	margin: auto;
	padding-top: 20px;
}

#butother{
	font-size: 24px;
	padding: 10px 40px;
}
</style>
</head>
<body>
	<%
		String token =  UUID.randomUUID().toString() ;//创建令牌
		System.out.println("在information中生成的token："+token);
		session.setAttribute("token", token);  //在服务器使用session保存token(令牌)
	%>

	<!-- 顶部导航 -->
	<div id="top">
		&nbsp;&nbsp; <a class="selet">完善个人资料</a>
	</div>

	<!-- 完善个人信息 -->
	<div id="personalInformation">
		<form action="${app_path }/personacentermvc/file.do" method="post" enctype="multipart/form-data">
			<input type="hidden" name="token" value='${token}'/>
			<div class="form-group has-feedback">
				<label for="exampleInputEmail1">姓名</label>
				<label class="control-label" for="inputSuccess2"></label>
				<input type="text" class="form-control" name="username" id="RealName" placeholder="user">
				<span class="" aria-hidden="true"></span>
			</div>
			<div class="form-group has-feedback">
				<label for="exampleInputPassword1">身份证号</label> 
				<label class="control-label" for="inputSuccess2"></label>
				<input type="text" class="form-control" name="userid" id="CardNo"
					placeholder="userid">
				<span class="" aria-hidden="true"></span>
			</div>
			<div class="form-group has-feedback">
				<label for="exampleInputPassword1">手机号</label> 
				<label class="control-label" for="inputSuccess2"></label>
				<input type="text" class="form-control" name="userphone" id="Phone"
					placeholder="phone">
				<span class="" aria-hidden="true"></span>
			</div>
			<div class="row">
				<div class="form-group col-md-4">
					<label for="exampleInputFile">上传头像</label> 
					<input type="file" id="exampleInputFile" name="file" />
					<p class="help-block">上传您想更改的头像</p>
				</div>
				<div style="margin-top: 20px;" class="col-md-offset-9">
					<button id="butother" type="submit" class="btn btn-default btn-lg active disabled" disabled="disabled">提交</button>
				</div>
			</div>
		</form>
	</div>
</body>
<script type="text/javascript">
$(function(){
	var flag=true;
	
	// 真实姓名         不包含数字及特殊字符，支持空格 不支持（汉字和字母组合）
	var RealName = $("#personalInformation #RealName");
	var RealName_reg =/^[\u4e00-\u9fa5]{2,6}$/;
	
	// 身份证      18位和15位
    var CardNo = $("#personalInformation #CardNo");
    var CardNo_reg = /(^[1-9]\d{5}(18|19|([23]\d))\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{3}[0-9Xx]$)|(^[1-9]\d{5}\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{2}[0-9Xx]$)/

    // 手机号码         11位号码
	var Phone = $("#personalInformation #Phone");
    var Phone_reg = /^((1[3,5,8][0-9])|(14[5,7])|(17[0,6,7,8])|(19[7]))\d{8}$/;
    
    //真实姓名光标移出后事件
    RealName.blur(function(){
    	if(!RealName_reg.test($(this).val())){
    		$(this).prev("label").text("请输入真实姓名!");
    		flagtemp(true,$(RealName));
    		
		}else{
			$(this).prev("label").text("");
    		flagtemp(false,$(RealName));
		}
   	}); 
    
  	//身份证光标移出后事件
    CardNo.blur(function(){
    	if(!CardNo_reg.test($(this).val())){
    		$(this).prev("label").text("输入身份证号有误!");
    		flagtemp(true,$(CardNo));
		}else{
			$(this).prev("label").text("");
			flagtemp(false,$(CardNo));
		}
   	}); 
  
  	//手机号码光标移出后事件
    Phone.blur(function(){
    	if(!Phone_reg.test($(this).val())){
    		$(this).prev("label").text("输入手机号有误!");
    		flagtemp(true,$(Phone));
		}else{
			$(this).prev("label").text("");
			flagtemp(false,$(Phone));
		}
   	}); 
  	
  	//判断显示颜色
  	function flagtemp(flag,obj){
  		if(flag){
  			$(obj).parent().removeClass("has-success")
    		$(obj).next("span").removeClass("glyphicon glyphicon-ok form-control-feedback")
	    	$(obj).parent().addClass("has-error");
  			$(obj).next("span").addClass("glyphicon glyphicon-remove form-control-feedback");
  		}else{
  			$(obj).parent().removeClass("has-error")
			$(obj).next("span").removeClass("glyphicon glyphicon-remove form-control-feedback")
			$(obj).parent().addClass("has-success");
  			$(obj).next("span").addClass("glyphicon glyphicon-ok form-control-feedback");
  		}
  		setTimtemp();
  	}
  	
  	//延迟一秒后提示按钮可操作
  	$("input").bind('change',function(){
  		setTimtemp();
  	});
  	
  	function setTimtemp(){
  		setTimeout(function(){
	  		if(RealName.parent().attr("class")=="form-group has-feedback has-success" 
	  				&& CardNo.parent().attr("class")=="form-group has-feedback has-success" 
	  					&& Phone.parent().attr("class")=="form-group has-feedback has-success"){
	  			
	    		$("#butother").removeClass("disabled");
	    		$("#butother").attr("disabled",false);
	    	}else{
	    		$("#butother").addClass("disabled");
	    		$("#butother").attr("disabled",true);
	    	}
  		}, 200);
  	}
  	
  	$("#exampleInputFile").change(function() {
  		verificationPicFile(this);
  		verificationPicFile(this);
	});
  	
  	//图片类型验证
  	function verificationPicFile(file) {
  	    var fileTypes = [".jpg", ".png"];
  	    var filePath = file.value;
  	    //当括号里面的值为0、空字符、false 、null 、undefined的时候就相当于false
  	    if(filePath){
  	        var isNext = false;
  	        var fileEnd = filePath.substring(filePath.indexOf("."));
  	        for (var i = 0; i < fileTypes.length; i++) {
  	            if (fileTypes[i] == fileEnd) {
  	                isNext = true;
  	                break;
  	            }
  	        }
  	        if (!isNext){
  	            alert('不接受此文件类型，只允许上传jpg或png格式的图片!');
  	            file.value = "";
  	            return false;
  	        }
  	    }else {
  	        return false;
  	    }
  	}
  	
  	//图片大小验证
  	function verificationPicFile(file) {
  	    var fileSize = 0;
  	    var fileMaxSize = 5120;//5M
  	    var filePath = file.value;
  	    if(filePath){
  	        fileSize =file.files[0].size;
  	        var size = fileSize / 1024;
  	        if (size > fileMaxSize) {
  	            alert("文件大小不能大于5M！");
  	            file.value = "";
  	            return false;
  	        }else if (size <= 0) {
  	            alert("文件大小不能为0M！");
  	            file.value = "";
  	            return false;
  	        }
  	    }else{
  	        return false;
  	    }
  	}
  	
});
</script>
</html>