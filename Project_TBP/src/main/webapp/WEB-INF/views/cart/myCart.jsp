<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TBP - 장바구니</title>
<jsp:include page="/resources/include/combineScript.jsp"/>
<script type="text/javascript">
$(document).ready(function() {
	var rightBoxHeight = $(".innerRight .rightBox").height() + 32;
	$(".cartCenterInner .innerRight").css("height", rightBoxHeight + "px");
	var productAllCount = 0;
	var productAllPrice = 0;
	var selectCount = 0;
	$("#selectAll").click(function() {
		if(selectCount == 0) {
			$("input[type=checkbox][name=select]").each(function() {
/* 				$("input[type=checkbox][name=select]").each(function() {
					$(this).attr("checked", false);
					productAllCount = 0;
					proudctAllPrice = 0;
					$("#paymentPrice").html(productAllPrice);
				}); */
				var index = $(this).val();
				if(!$(this).is(":checked")) {
					$(this).prop("checked", true);
					productAllCount += parseInt($("#productNumber" + index).html().trim());
					productAllPrice += parseInt($("#productPrice" + index).html().trim().replace(/,/g, ""));
					$("#productAllCount").html(productAllCount);
					$("#productAllPrice").html(productAllPrice);
					$("#paymentPrice").html(productAllPrice);
					$("#allImg").attr("src", "${pageContext.request.contextPath}/resources/img/join/after_all.png");
					$("#img" + index).attr("src", "${pageContext.request.contextPath}/resources/img/join/after_all.png");
					selectCount = 1;
					allFormat();	
				}
			});
		} else {
			$("input[type=checkbox][name=select]").each(function() {
				var index = $(this).val();
				$(this).prop("checked", false);
		 		productAllCount = 0;
		 		productAllPrice = 0;
/* 		 		productAllCount -= parseInt($("#productNumber" + index).html().trim());
		 		productAllPrice -= parseInt($("#productPrice" + index).html().trim().replace(/,/g, "")); */
				$("#productAllCount").html(productAllCount);
				$("#productAllPrice").html(productAllPrice);
				$("#paymentPrice").html(productAllPrice);
				$("#allImg").attr("src", "${pageContext.request.contextPath}/resources/img/join/before_all.png");
				$("#img" + index).attr("src", "${pageContext.request.contextPath}/resources/img/join/before_all.png");
				selectCount = 0;
				allFormat();	
			});
		}
	});
	$("input[type=checkbox][name=select]").click(function() {
		if($(this).is(":checked")) {
			var index = $(this).val();
			productAllCount += parseInt($("#productNumber" + index).html().trim());
			productAllPrice += parseInt($("#productPrice" + index).html().trim().replace(/,/g, ""));
			$("#productAllCount").html(productAllCount);
			$("#productAllPrice").html(productAllPrice);
			$("#paymentPrice").html(productAllPrice);
			$("#img" + index).attr("src", "${pageContext.request.contextPath}/resources/img/join/after_all.png");
			allFormat();
		} else {
			var index = $(this).val();
 			productAllCount -= parseInt($("#productNumber" + index).html().trim());
			productAllPrice -= parseInt($("#productPrice" + index).html().trim().replace(/,/g, ""));
			$("#productAllCount").html(productAllCount);
			$("#productAllPrice").html(productAllPrice);
			$("#paymentPrice").html(productAllPrice);
			$("#img" + index).attr("src", "${pageContext.request.contextPath}/resources/img/join/before_all.png");
			allFormat();
		}
	});
	$(".numberMinus").click(function() {
		var index = $(this).find("input[type=hidden]").val();
		var currNumber = parseInt($("#productNumber" + index).html().replace());
		var productPrice = parseInt($("#price" + index).val());
		if(currNumber == 1) {
			return false;
		} else {
			currNumber -= 1;
			$("#productNumber" + index).html(currNumber);
			$("#productPrice" + index).html(currNumber * productPrice);
			var checkFlag = $("input[type=checkBox][id=select"+index+"]").is(":checked");
			if(checkFlag) {
				productAllCount -= 1;
				productAllPrice -= productPrice;
				$("#productAllCount").html(productAllCount);
				$("#productAllPrice").html(productAllPrice);
				$("#paymentPrice").html(productAllPrice);
			}
		}
		allFormat();
	});
	$(".numberPlus").click(function() {
		var index = $(this).find("input[type=hidden]").val();
		var currNumber = parseInt($("#productNumber" + index).html());
		var productStock = $("#productStock" + index).val();
/* 		if(productStock <= currNumber) {
			$("#confirmPanel").css("display", "block");
			$("#confirmText").html("상품의 재고가 부족합니다.");
			$("#confirmBtn").attr("onclick", "$('#confirmPanel').css('display', 'none')");
			return false;
		} */
		var productPrice = parseInt($("#price" + index).val());
		currNumber += 1;
		var checkFlag = $("input[type=checkBox][id=select"+index+"]").is(":checked");
		if(checkFlag) {
			productAllCount += 1;
			productAllPrice += productPrice;
			$("#productAllCount").html(productAllCount);
			$("#productAllPrice").html(productAllPrice);
			$("#paymentPrice").html(productAllPrice);
		}
		$("#productNumber" + index).html(currNumber);
		$("#productPrice" + index).html(currNumber * productPrice);
		allFormat();
	});
	// 상품주문
	$(".orderBtn").click(function() {
		$("#orderForm").html("");
		if($("input[type=checkbox][name=select]:checked").length == 0) {
			$("#confirmPanel").css("display", "block");
			$("#confirmText").html("선택한 상품이 없습니다.");
			$("#confirmBtn").attr("onclick", "$('#confirmPanel').css('display', 'none')");
			return false;
		}
		$("input[type=checkbox][name=select]").each(function() {
			if($(this).is(":checked")) {
				var index = $(this).val();
				var productNumber = parseInt($("#productNumber" + index).html());
				var productNo = $("#productNo" + index).val();
				var cartNo = $("#cartNo" + index).val();
				$("#orderForm").append("<input type='hidden' id='productNo" + index + "' name='productNo' value='" + productNo + "'/>");
				$("#orderForm").append("<input type='hidden' id='orderNumber" + index + "' name='orderNumber' value='" + productNumber + "'/>");
				$("#orderForm").append("<input type='hidden' id='cartNo" + index + "' name='cartNo' value='" + cartNo +"'/>");
			}
		});
		$("#orderForm").append("<input type='hidden' id='memberNo' name='memberNo' value='${sessionScope.memberNo}'/>");
		$("input[type=checkbox][name=select]").each(function() {
			$(this).prop("checked", false);
		});
		$("#orderForm").submit();
	});
	$(".cartDelete").click(function() {
		$(".confirmPanel3").css("display", "block");
		$("#confirmText3").html("정말로 해당 상품을 삭제하시겠습니까?");
		$("#cartDelete").attr("onclick", "cartDelete(" + $(this).find("input[type=hidden]").val() + ");");
		$("#goCancle").attr("onclick", "$('.confirmPanel3').css('display', 'none')");
	});
	var cartPaymentInfoTop = $(".innerRight").offset().top;
	$(window).scroll(function() {
		var docScrollTop = $(document).scrollTop();
 		if(docScrollTop >= cartPaymentInfoTop) {
			$(".innerRight .rightBox").addClass("fixedOn");
		} else {
			$(".innerRight .rightBox").removeClass("fixedOn");			
		}
	});
});
function cartDelete(cartNo) {
	$.ajax({
		url: "${pageContext.request.contextPath}/cart/delete",
		type: "POST",
		cache: false,
		data : {
			"cartNo" : cartNo
		},
		success: function(data, status) {
			if(status == "success") {
				if(data == "Ok") {
					location.reload();
				} else {
					$("#confirmPanel").css("display", "block");
					$("#confirmText").html("알 수 없는 오류입니다.");
					$("#confirmBtn").attr("onclick", "$('#confirmPanel').css('display', 'none')");
					return false;
				}
			}
		}
	});
}
function allFormat() {
	var cartDtoLength = ${fn:length(cartDto)};
	for(var i=0; i<cartDtoLength; i++) {
		$("#productPrice" + (i+1)).html($("#productPrice" + (i+1)).html().trim().replace(/\B(?=(\d{3})+(?!\d))/g,","));
	}
	$("#productAllPrice").html($("#productAllPrice").html().trim().replace(/\B(?=(\d{3})+(?!\d))/g,","));
	$("#paymentPrice").html($("#paymentPrice").html().trim().replace(/\B(?=(\d{3})+(?!\d))/g,","));
};
</script>
<style type="text/css">
</style>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/myCart.css"/>
</head>
<body onload="allFormat();">
<jsp:include page="/resources/include/header/otherHeader.jsp"/>
<div class="cartTopWrapper">
	<div class="cartTopInner">
		<div class="cartTopInnerLeft">
		장바구니
		</div>
		<div class="cartTopInnerRight">
		<span id="cartPage" class="active">장바구니</span> > <span id="orderPage">주문결제</span> > <span id="orderOkPage">주문완료</span>
		</div>
	</div>
</div>
<div class="cartCenterWrapper">
	<div class="cartCenterInner">
		<div class="cartSelectWrapper">
			<div class="selectBox">
				<div class="selectImgBox">
					<label for="selectAll"><img id="allImg" src="${pageContext.request.contextPath}/resources/img/join/before_all.png"/></label>
					<input type="checkbox" name="selectAll" id="selectAll"/>
				</div>
				<div>
					전체선택
				</div>
			</div>
		</div>
		<div class="innerLeft">
			<ul>
				<c:choose>
					<c:when test="${empty cartDto || fn:length(cartDto) == 0}">
						<li class="emptyDto">장바구니에 상품이 없습니다.</li>
					</c:when>
					<c:otherwise>
						<c:forEach var="i" items="${cartDto}" varStatus="index">
							<c:choose>
								<c:when test="${index.count == fn:length(cartDto)}">
									<li class="cartProduct last" id="cartNo${index.count}" value="${i.cartNo}">
										<div class="shopNameBox">
											<div class="selectImgBox">
												<label for="select${index.count}"><img id="img${index.count}" src="${pageContext.request.contextPath}/resources/img/join/before_all.png"/></label>
												<input type="checkbox" name="select" id="select${index.count}" value="${index.count}"/>
											</div>
											<div>
												<a href="${pageContext.request.contextPath}/shop/${i.shopNo}">${empty i.shopName? 'TBP SHOP ' += i.shopNo += '호':i.shopName}</a>
											</div>
											<div class="cartDelete">
												X
												<input type="hidden" value="${i.cartNo}"/>
											</div>
										</div>
										<hr>
										<div class="cartContentBox">
											<input type="hidden" id="productNo${index.count}" value="${i.productNo}"/>
											<div class="cartThumb">
												<img src="${pageContext.request.contextPath}/resources/upload/${i.productThumb}"/>
											</div>
											<div class="cartSubject">
												<a href="${pageContext.request.contextPath}/product/${i.productNo}">${i.productSubject}</a>
											</div>
											<div class="cartNumberBox">
												<input type="hidden" id="productStock${index.count}" value="${i.productStock}"/>
											<div class="numberMinus" id="numberMinus">-
												<input type="hidden" value="${index.count}"/>
											</div>
											<div class="productNumber" id="productNumber${index.count}">${i.cartStock}</div>
											<div class="numberPlus" id="numberPlus">+
												<input type="hidden" value="${index.count}"/></div>
												<input type="hidden" id="price${index.count}" value="${i.productPrice}"/>						
											</div>
											<div class="cartPrice">
												<span id="productPrice${index.count}">${i.productPrice * i.cartStock}</span>원
											</div>
										</div>
									</li>		
								</c:when>
								<c:otherwise>
									<li class="cartProduct" id="cartNo${index.count}" value="${i.cartNo}">
										<div class="shopNameBox">
											<div class="selectImgBox">
												<label for="select${index.count}"><img id="img${index.count}" src="${pageContext.request.contextPath}/resources/img/join/before_all.png"/></label>
												<input type="checkbox" name="select" id="select${index.count}" value="${index.count}"/>
											</div>
											<div>
												<a href="${pageContext.request.contextPath}/shop/${i.shopNo}">${empty i.shopName? 'TBP SHOP ' += i.shopNo += '호':i.shopName}</a>
											</div>
											<div class="cartDelete">
												X
												<input type="hidden" value="${i.cartNo}"/>
											</div>
										</div>
										<hr>
									<div class="cartContentBox">
										<input type="hidden" id="productNo${index.count}" value="${i.productNo}"/>
										<div class="cartThumb">
											<img src="${pageContext.request.contextPath}/resources/upload/${i.productThumb}"/>
										</div>
										<div class="cartSubject">
											<a href="${pageContext.request.contextPath}/product/${i.productNo}">${i.productSubject}</a>
										</div>
										<div class="cartNumberBox">
											<input type="hidden" id="productStock${index.count}" value="${i.productStock}"/>
											<div class="numberMinus" id="numberMinus">-
											<input type="hidden" value="${index.count}"/>
											</div>
											<div class="productNumber" id="productNumber${index.count}">${i.cartStock}</div>
											<div class="numberPlus" id="numberPlus">+
											<input type="hidden" value="${index.count}"/></div>
											<input type="hidden" id="price${index.count}" value="${i.productPrice}"/>						
										</div>
										<div class="cartPrice">
											<span id="productPrice${index.count}">${i.productPrice * i.cartStock}</span>원
										</div>
									</div>
									</li>		
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</ul>
			<form id="orderForm" action="${pageContext.request.contextPath}/product/order" method="post">
			</form>
		</div>
		<div class="innerRight">
		<div class="rightBox">
			<div class="allCountTitle">
				전체합계
			</div>
			<hr>
			<div class="allCountContentBox">
				<div class="productContent">
					<div class="contentLeft">
						상품수량
					</div>
					<div class="contentRight">
						<span id="productAllCount">0</span>개
					</div>
				</div>
			</div>
			<div class="allCountContentBox">
				<div class="productContent">
					<div class="contentLeft">
						종합금액
					</div>
					<div class="contentRight">
						<span id="productAllPrice">0</span>원
					</div>
				</div>
			</div>
			<hr>
			<div class="allCountContentBox">
				<div class="productContent">
					<div class="contentLeft">
						결제 예정액
					</div>
					<div class="contentRight">
						<span class="paymentPrice" id="paymentPrice">0</span><span class="paymentPrice">원</span>
					</div>
				</div>
			</div>
			<div class="orderBtn">
			주문하기
			</div>
		</div>
		</div>
	</div>
</div>
<div id="confirmPanel">
	<div id="confirmBox">
		<div id="confirmText"></div>
		<div id="confirmBtn">확인</div>
	</div>
</div>
<div class="confirmPanel3">
	<div class="confirmBox3">
		<div id="confirmText3"></div>
		<div class="confirmBtn3" id="cartDelete">삭제</div>
		<div class="confirmBtn3" id="goCancle">취소</div>
	</div>
</div>
<jsp:include page="/resources/include/footer/mainFooter.jsp"/>
</body>
</html>