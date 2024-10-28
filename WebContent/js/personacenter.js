/**
 * 个人中心样式
 */
$(function(){
	$(".informationfunction li a").click(function(){
		var lencur=$(".informationfunction li a").index(this);
		$(".informationfunctiontien li").eq(lencur).css('background-color','#337ab7').siblings("li").css('background-color','#eeeeee');
		$(".informationfunction li").eq(lencur).css('background-color','#eeeeee').siblings("li").css('background-color','#FFFFFF');
	});
});