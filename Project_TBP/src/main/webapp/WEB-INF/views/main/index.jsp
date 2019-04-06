<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TBP PLACE</title>
<jsp:include page="/resources/include/combineScript.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/index.css"/>
<script type="text/javascript">
$(document).ready(function() {
	// ContextPath
	function getContextPath() {
		var set = location.href.indexOf(location.host)+location.host.length;
		var Path=location.href.substring(set, location.href.indexOf("/", set+1));
		return Path;
	}
	 $(".themaSection").css("background-color", "rgb(162, 227, 229)");
	 $(".themaBigBanner img").eq(0).css("display", "block");
	// 검색 버튼 영역에 마우스 위치시
	$(".searchBtn img").mouseenter(function() {
		$(this).attr("src", getContextPath() + "/resources/img/main/search1.png");
	});
	// 검색 버튼 영역에서 마우스 벗어날 시
	$(".searchBtn img").mouseleave(function() {
		$(this).attr("src", getContextPath() + "/resources/img/main/search2.png");
	});
	var auto_slide;
	var auto_time = 3000;  // 슬라이드 시간 1000 = 1초
	var auto_num = 0;

	$(".themaBigBanner img").eq(auto_num).css({"left":"0%"});  // 처음로드시 첫이미지 보이기
	auto_slide = setInterval(function(){ slide_start() },auto_time);

	function slide_start(){  // 슬라이드 구현
	   var no = auto_num + 1;
	   if(no >= $(".themaBigBanner img").length) {
	     no = 0;
	   }
	   if(no == 1) {
		   $(".themaSection").css("background-color", "rgb(15, 33, 71)");
	   } else if(no == 2) {
		   $(".themaSection").css("background-color", "rgb(255, 197, 90)");
	   } else if(no == 3) {
		   $(".themaSection").css("background-color", "rgb(226, 241, 210)");		   		   
	   } else if(no == 4) {
		   $(".themaSection").css("background-color", "rgb(222, 236, 249)");		   		   		   
	   } else {
		   $(".themaSection").css("background-color", "rgb(162, 227, 229)");
	   }
	   $(".themaBigBanner img").eq(no).css({"left":"-100%"}).stop().animate({"left":"0%"});
	   $(".themaBigBanner img").eq(no).css("display", "block");
	   $(".themaBigBanner img").eq(auto_num).stop().animate({"left":"100%"});
	   $(".themaBigBanner img").eq(auto_num).css("display", "none");
	   auto_num = no;
	}
	$(".themaBigBanner").hover(function(){  // 마우스 오버시 슬라이드 멈춤
		clearInterval(auto_slide);
		$(".slideBtnLeft").css("background-color", "rgba(0, 0, 0, 0.3)");
		$(".slideBtnRight").css("background-color", "rgba(0, 0, 0, 0.3)");
	},function(){  // 마우스 아웃시 다시 시작
	   auto_slide = setInterval(function(){ slide_start() },auto_time);
		$(".slideBtnLeft").css("background-color", "transparent");
		$(".slideBtnRight").css("background-color", "transparent");
	});
	$(".slideBtnLeft").hover(function() {
		clearInterval(auto_slide);
		$(".slideBtnLeft").css("background-color", "rgba(0, 0, 0, 0.3)");
		$(".slideBtnLeft").css("color", "white");		
	},function(){
		$(".slideBtnLeft").css("background-color", "transparent");
		$(".slideBtnLeft").css("color", "#D5D5D5");
		auto_slide = setInterval(function(){ slide_start() },auto_time);
	});
	$(".slideBtnRight").hover(function() {
		clearInterval(auto_slide);
		$(".slideBtnRight").css("background-color", "rgba(0, 0, 0, 0.3)");
		$(".slideBtnRight").css("color", "white");		
	},function(){
		$(".slideBtnRight").css("background-color", "transparent");
		$(".slideBtnRight").css("color", "#D5D5D5");
		auto_slide = setInterval(function(){ slide_start() },auto_time);
	});
	$(".slideBtnRight").click(function() {
		var no = auto_num + 1;
		if(no >= $(".themaBigBanner img").length) {
			no = 0;
		}
		if(no == 1) {
			$(".themaSection").css("background-color", "rgb(15, 33, 71)");
		} else if(no == 2) {
			$(".themaSection").css("background-color", "rgb(255, 197, 90)");		   
		} else if(no == 3) {
			$(".themaSection").css("background-color", "rgb(226, 241, 210)");		   		   
		} else if(no == 4) {
			$(".themaSection").css("background-color", "rgb(222, 236, 249)");		   		   		   
		} else {
			$(".themaSection").css("background-color", "rgb(162, 227, 229)");
		}
		$(".themaBigBanner img").eq(no).css({"left":"-100%"}).stop().animate({"left":"0%"});
		$(".themaBigBanner img").eq(no).css("display", "block");
		$(".themaBigBanner img").eq(auto_num).stop().animate({"left":"100%"});
		$(".themaBigBanner img").eq(auto_num).css("display", "none");
		auto_num = no;
	});
	$(".slideBtnLeft").click(function() {
		var no = auto_num - 1;
		if(no == -1) {
			no = 4;
		}
		if(no == 1) {
			$(".themaSection").css("background-color", "rgb(15, 33, 71)");
		} else if(no == 2) {
			$(".themaSection").css("background-color", "rgb(255, 197, 90)");		   
		} else if(no == 3) {
			$(".themaSection").css("background-color", "rgb(226, 241, 210)");		   		   
		} else if(no == 4) {
			$(".themaSection").css("background-color", "rgb(222, 236, 249)");		   		   		   
		} else {
			$(".themaSection").css("background-color", "rgb(162, 227, 229)");
		}
		$(".themaBigBanner img").eq(no).css({"left":"-100%"}).stop().animate({"left":"0%"});
		$(".themaBigBanner img").eq(no).css("display", "block");
		$(".themaBigBanner img").eq(auto_num).stop().animate({"left":"100%"});
		$(".themaBigBanner img").eq(auto_num).css("display", "none");
		auto_num = no;
	});
	$.ajax({
		url: "${pageContext.request.contextPath}/product/selectNew",
		type: "POST",
		cache: false,
		success: function(data, status) {
			if(status == "success") {
				var newProduct = "";
 				if(data.status == "Ok" && data.count != 0) {
 					for(var i=0; i<data.count; i++) {
						newProduct += "<div class='productBox" + (data.count==5? '':' not') + "' onclick=location.href='${pageContext.request.contextPath}/product/" + data.list[i].productNo + "'>";
						newProduct += "<div class='thumb'>";
						newProduct += "<img class='imgs' src='${pageContext.request.contextPath}/resources/upload/" + data.list[i].productThumb + "'>";
						newProduct += "</div>";
						newProduct += "<div class='subject'>";
						newProduct += data.list[i].productSubject;
						newProduct += "</div>";
						newProduct += "<div class='otherBox'>";
						newProduct += "<div class='price'>" + formatPrice(data.list[i].productPrice) + "</div>";
						newProduct += "<div class='regDate'>" + formatDate(data.list[i].productRegDate) + "</div>";
						newProduct += "</div>";
						newProduct += "</div>";
					}
 					if(data.count == 5) {
 						$(".newProductContent").css("justify-content", "space-between");
 					}
					$(".newProductContent").html(newProduct);
				} else {
					newProduct += "<div class='newProductEmpty'>등록된 상품이 없습니다.</div>"
					$(".newProductContent").html(newProduct);
	  			}
			}
		}
	});
	
	for(var i=0; i<${fn:length(categoryPopularDto.c100_product)}; i++) {
		formatCategoryPoupularPrice("c100", (i+1), $("#c100_" + (i+1) + "_price").html().trim());
	}
	for(var i=0; i<${fn:length(categoryPopularDto.c200_product)}; i++) {
		formatCategoryPoupularPrice("c200", (i+1), $("#c200_" + (i+1) + "_price").html().trim());
	}
	for(var i=0; i<${fn:length(categoryPopularDto.c300_product)}; i++) {
		formatCategoryPoupularPrice("c300", (i+1), $("#c300_" + (i+1) + "_price").html().trim());
	}
	for(var i=0; i<${fn:length(categoryPopularDto.c400_product)}; i++) {
		formatCategoryPoupularPrice("c400", (i+1), $("#c400_" + (i+1) + "_price").html().trim());
	}
	for(var i=0; i<${fn:length(categoryPopularDto.c500_product)}; i++) {
		formatCategoryPoupularPrice("c500", (i+1), $("#c500_" + (i+1) + "_price").html().trim());
	}
	var title_c100 = $("#title_c100").offset().top;
	var title_c200 = $("#title_c200").offset().top;
	var title_c300 = $("#title_c300").offset().top;
	var title_c400 = $("#title_c400").offset().top;
	var title_c500 = $("#title_c500").offset().top;
	var hType = 100;
	
	$(window).scroll(function() {
		var scrollTop = $(document).scrollTop();
		
		if(scrollTop >= (title_c100+200)) {
			$(".categoryPopularNav .navInner").addClass("on");
		} else {
			$(".categoryPopularNav .navInner").removeClass("on");			
		}
		
		if(scrollTop <= title_c100) {
			$("#nav_c200").removeClass("active_c200");
			$("#nav_c300").removeClass("active_c300");
			$("#nav_c400").removeClass("active_c400");
			$("#nav_c500").removeClass("active_c500");
			$("#nav_c100").addClass("active_c100");
		} else if(scrollTop > title_c100 && scrollTop >= title_c200 && scrollTop < title_c300) {
			$("#nav_c100").removeClass("active_c100");
			$("#nav_c300").removeClass("active_c300");
			$("#nav_c400").removeClass("active_c400");
			$("#nav_c500").removeClass("active_c500");
			$("#nav_c200").addClass("active_c200");
		} else if(scrollTop > title_c200 && scrollTop >= title_c300 && scrollTop < title_c400) {
			$("#nav_c100").removeClass("active_c100");
			$("#nav_c200").removeClass("active_c200");
			$("#nav_c400").removeClass("active_c400");
			$("#nav_c500").removeClass("active_c500");
			$("#nav_c300").addClass("active_c300");
		} else if(scrollTop > title_c300 && scrollTop >= title_c400 && scrollTop < title_c500) {
			$("#nav_c100").removeClass("active_c100");
			$("#nav_c200").removeClass("active_c200");
			$("#nav_c300").removeClass("active_c300");
			$("#nav_c500").removeClass("active_c500");
			$("#nav_c400").addClass("active_c400");
		} else if(scrollTop > title_c300 && scrollTop >= title_c400) {
			$("#nav_c100").removeClass("active_c100");
			$("#nav_c200").removeClass("active_c200");
			$("#nav_c300").removeClass("active_c300");
			$("#nav_c400").removeClass("active_c400");
			$("#nav_c500").addClass("active_c500");
		}
	});
	
	$(document).on("click", ".navInner ul li", function() {
		var navType = $(this).data('value');
		
		if(navType == "c100") {
			$("html,body").animate({scrollTop:title_c100}, 500);
		} else if(navType == "c200") {
			$("html,body").animate({scrollTop:title_c200}, 500);
		} else if(navType == "c300") {
			$("html,body").animate({scrollTop:title_c300}, 500);
		} else if(navType == "c400") {
			$("html,body").animate({scrollTop:title_c400}, 500);			
		} else if(navType == "c500") {
			$("html,body").animate({scrollTop:title_c500}, 500);
		}
	});
});
function productView(productNo) {
	location.href = "${pageContext.request.contextPath}/product/" + productNo;
}
function searchCategory(categoryId) {
	location.href = "${pageContext.request.contextPath}/search/product/category?categoryId=" + categoryId + "&type=depth2";
}
// 상품 가격 변환
function formatPrice(productPrice) {
	return productPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g,",") + "원";
}
function formatCategoryPoupularPrice(type, count, price) {
	$("#" + type + "_" + count + "_price").html(price.toString().replace(/\B(?=(\d{3})+(?!\d))/g,",") + "원");
}
// 상품 등록일시 변환
function formatDate(productRegDate) {
	var today, resultDate;
	
	today = new Date();
	resultDate = new Date(productRegDate);
	timegap = (today-resultDate)/(60*60*1000);
	
	var currYear = resultDate.getFullYear();
	var currMonth = (resultDate.getMonth() + 1);
	var currDay = resultDate.getDate();
	
	if(timegap <= 24) {
		if(Math.floor(timegap) == 0) {
			if(resultDate = Math.floor(timegap*24) == 0) {			
				resultDate = "방금";
			} else {				
				resultDate = Math.floor(timegap*24) + "분전";
			}
		} else {
			resultDate = Math.floor(timegap) + "시간전";
		}
	} else {
		if(today.getFullYear() == currYear) {
			resultDate = currMonth + "월 " + currDay + "일"; 
		} else {
			resultDate = currYear + "-" + currMonth + "-" + currDay;
		}
	}

	return resultDate;
}
</script>
</head>
<body>
<jsp:include page="/resources/include/header/mainHeader.jsp"/>
<div class="themaSection">
	<div class="mainThema">
		<div class="slideBtnLeft"><</div>
		<div class="themaBigBanner">
			<a href="#"><img src="${pageContext.request.contextPath}/resources/img/main/tab1.jpg"></a>
            <a href="#"><img src="${pageContext.request.contextPath}/resources/img/main/tab2.jpg"></a>
            <a href="#"><img src="${pageContext.request.contextPath}/resources/img/main/tab3.jpg"></a>
            <a href="#"><img src="${pageContext.request.contextPath}/resources/img/main/tab4.jpg"></a>
            <a href="#"><img src="${pageContext.request.contextPath}/resources/img/main/tab5.jpg"></a>
		</div>
		<div class="slideBtnRight">></div>
	</div>
</div>
<div class="newProductSection">
	<div class="newProductSectionInner">
		<div class="newProductTitle">
			최신 등록 상품
		</div>
		<div class="newProductContent">
		</div>
	</div>
</div>
<div class="categoryBestSection">
	<div class="categoryBestInner">
		<div class="categoryBestTitle">
			카테고리별 인기상품
		</div>
		<div class="categoryPopularNav">
			<div class="navInner">
				<ul>
					<li id="nav_c100" class="active_c100" data-value="c100">디지털/가전</li>
					<li id="nav_c200" data-value="c200">의류/잡화</li>
					<li id="nav_c300" data-value="c300">레저/자동차</li>
					<li id="nav_c400" data-value="c400">뷰티</li>
					<li id="nav_c500" class="last" data-value="c500">도서/취미</li>
				</ul>
			</div>
		</div>
		<div class="categoryBestContent">
			<div class="contentLeft">
				<div id="title_c100" class="leftTitle c100">
					디지털/가전
				</div>
				<ul class="categoryList">
					<c:forEach var="i" items="${categoryPopularDto.c100}" varStatus="index">
						<li class="c100 ${index.last? 'last':''}" onclick="searchCategory(${i.categoryId});">${i.categoryName}</li>
					</c:forEach>
				</ul>
			</div>
			<div class="contentRight">
				<c:forEach var="i" items="${categoryPopularDto.c100_product}" varStatus="index">
					<div class="productBox ${index.count%5==0? 'last':''}" onclick="productView(${i.productNo});">
						<div class="thumbnail">
							<img class="thumb" src="${pageContext.request.contextPath}/resources/upload/${i.productThumb}"/>
						</div>
						<div class="subject">
							${i.productSubject}
						</div>
						<div class="otherBox">
							<div id="c100_${index.count}_price" class="price">
 								${i.productPrice}
							</div>
							<div class="rank c100">
								${i.rank}
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
		<div class="categoryBestContent">
			<div class="contentLeft">
				<div id="title_c200" class="leftTitle c200">
					의류/잡화
				</div>
				<ul class="categoryList">
					<c:forEach var="i" items="${categoryPopularDto.c200}" varStatus="index">
						<li class="c200 ${index.last? 'last':''}" onclick="searchCategory(${i.categoryId});">${i.categoryName}</li>
					</c:forEach>
				</ul>
			</div>
			<div class="contentRight">
				<c:forEach var="i" items="${categoryPopularDto.c200_product}" varStatus="index">
					<div class="productBox ${index.count%5==0? 'last':''}" onclick="productView(${i.productNo});">
						<div class="thumbnail">
							<img class="thumb" src="${pageContext.request.contextPath}/resources/upload/${i.productThumb}"/>
						</div>
						<div class="subject">
							${i.productSubject}
						</div>
						<div class="otherBox">
							<div id="c200_${index.count}_price" class="price">
								${i.productPrice}
							</div>
							<div class="rank c200">
								${i.rank}
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
		<div class="categoryBestContent">
			<div class="contentLeft">
				<div id="title_c300" class="leftTitle c300">
					레저/자동차
				</div>
				<ul class="categoryList">
					<c:forEach var="i" items="${categoryPopularDto.c300}" varStatus="index">
						<li class="c300 ${index.last? 'last':''}" onclick="searchCategory(${i.categoryId});">${i.categoryName}</li>
					</c:forEach>
				</ul>
			</div>
			<div class="contentRight">
				<c:forEach var="i" items="${categoryPopularDto.c300_product}" varStatus="index">
					<div class="productBox ${index.count%5==0? 'last':''}" onclick="productView(${i.productNo});">
						<div class="thumbnail">
							<img class="thumb" src="${pageContext.request.contextPath}/resources/upload/${i.productThumb}"/>
						</div>
						<div class="subject">
							${i.productSubject}
						</div>
						<div class="otherBox">
							<div id="c300_${index.count}_price" class="price">
								${i.productPrice}
							</div>
							<div class="rank c300">
								${i.rank}
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
		<div class="categoryBestContent">
			<div class="contentLeft">
				<div id="title_c400" class="leftTitle c400">
					뷰티
				</div>
				<ul class="categoryList">
					<c:forEach var="i" items="${categoryPopularDto.c400}" varStatus="index">
						<li class="c400 ${index.last? 'last':''}" onclick="searchCategory(${i.categoryId});">${i.categoryName}</li>
					</c:forEach>
				</ul>
			</div>
			<div class="contentRight">
				<c:forEach var="i" items="${categoryPopularDto.c400_product}" varStatus="index">
					<div class="productBox ${index.count%5==0? 'last':''}" onclick="productView(${i.productNo});">
						<div class="thumbnail">
							<img class="thumb" src="${pageContext.request.contextPath}/resources/upload/${i.productThumb}"/>
						</div>
						<div class="subject">
							${i.productSubject}
						</div>
						<div class="otherBox">
							<div id="c400_${index.count}_price" class="price">
								${i.productPrice}
							</div>
							<div class="rank c400">
								${i.rank}
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
		<div class="categoryBestContent">
			<div class="contentLeft">
				<div id="title_c500" class="leftTitle c500">
					도서/취미
				</div>
				<ul class="categoryList">
					<c:forEach var="i" items="${categoryPopularDto.c500}" varStatus="index">
						<li class="c500 ${index.last? 'last':''}" onclick="searchCategory(${i.categoryId});">${i.categoryName}</li>
					</c:forEach>
				</ul>
			</div>
			<div class="contentRight">
				<c:forEach var="i" items="${categoryPopularDto.c500_product}" varStatus="index">
					<div class="productBox ${index.count%5==0? 'last':''}" onclick="productView(${i.productNo});">
						<div class="thumbnail">
							<img class="thumb" src="${pageContext.request.contextPath}/resources/upload/${i.productThumb}"/>
						</div>
						<div class="subject">
							${i.productSubject}
						</div>
						<div class="otherBox">
							<div id="c500_${index.count}_price" class="price">
								${i.productPrice}
							</div>
							<div class="rank c500">
								${i.rank}
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
</div>
<jsp:include page="/resources/include/footer/mainFooter.jsp"/>
</body>
</html>