 /*
 * 加载动画
 */
 
$("#loadmain").hide();

$(window).on("load",function(){
	$(".loader-wrapper").fadeOut("slow");
	setTimeout(function () { $("#loadmain").show(); }, 500);
});

