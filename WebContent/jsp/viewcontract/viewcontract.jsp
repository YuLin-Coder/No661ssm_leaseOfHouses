<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>查看合同</title>
<style type="text/css">
*{
	padding: 0px;
	margin: 0px;
}
body{
	width: 100%;
	height: 100%;
}
</style>
<script type="text/javascript" src="../../static/jquery/jquery-1.11.0.min.js"></script>
</head>
<body>
</body>
<script type="text/javascript">
	$(function(){
		window.onerror = function(message, source, lineno, colno, error) {
			   console.log('捕获到异常：',{message, source, lineno, colno, error});
		}
		//房屋id
	    var query = location.search.substring(1);
	    (function() { 
	    	try {
	    		$("<embed src='/contract/pdf/" +query+ "pdf.pdf' type='application/pdf' width='100%' height='1080px' internalinstanceid='81' />").appendTo("body");
	    	} catch(e) {
	    		 console.log('捕获到异常：',e);
	    		 alert("异常"+e);
	    	}
	    })(); 
	});
</script>
</html>