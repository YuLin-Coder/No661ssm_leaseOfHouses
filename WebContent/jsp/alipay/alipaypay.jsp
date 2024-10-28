<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.util.UUID"%>
<%@page import="com.javabean.AlipayConfig"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>付款</title>
</head>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.alipay.api.*"%>
<%@ page import="com.alipay.api.request.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
	//获得初始化的AlipayClient
	AlipayClient alipayClient = new DefaultAlipayClient(AlipayConfig.gatewayUrl, AlipayConfig.app_id, AlipayConfig.merchant_private_key, "json", AlipayConfig.charset, AlipayConfig.alipay_public_key, AlipayConfig.sign_type);
	
	//设置请求参数
	AlipayTradePagePayRequest alipayRequest = new AlipayTradePagePayRequest();
	alipayRequest.setReturnUrl(AlipayConfig.return_url);
	alipayRequest.setNotifyUrl(AlipayConfig.notify_url);
	
	//生成随机Id
    String out_trade_no = UUID.randomUUID().toString();
	//付款金额，必填
	String total_amount = new String(request.getParameter("rchousemoney").getBytes("ISO-8859-1"),"UTF-8");
	//订单名称，必填
	String subject ="房租";
	//商品描述
	String body ="菜鸟沙箱支付";
	//楼房rcid
	String rcid=new String(request.getParameter("rcid").getBytes("ISO-8859-1"),"UTF-8");
	AlipayConfig.rcid=rcid;
	AlipayConfig.usercall=(String)session.getAttribute("user");
	alipayRequest.setBizContent("{\"out_trade_no\":\""+ out_trade_no +"\"," 
			+ "\"total_amount\":\""+ total_amount +"\"," 
			+ "\"subject\":\""+ subject +"\"," 
			+ "\"body\":\""+ body +"\"," 
			+ "\"timeout_express\":\"10m\"," 
			+ "\"product_code\":\"FAST_INSTANT_TRADE_PAY\"}");
	
	//请求
	String result = alipayClient.pageExecute(alipayRequest).getBody();
	//输出
	out.println(result);
%>
<body>
</body>
</html>