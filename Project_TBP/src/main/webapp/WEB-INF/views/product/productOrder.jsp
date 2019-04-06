<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TBP - 주문하기</title>
<jsp:include page="/resources/include/combineScript.jsp"/>
<script type="text/javascript">
	$(document).ready(function() {
		if(salesWayCount2 == 1) {
			if($("#dName").html().length == 0) {
				$("#tab1").removeClass("active");
				$("#tab1").addClass("none");
				$("#tab2").addClass("active");
				$(".contentBox2").addClass("on");
				$("input[type=radio][name=radioT][id=radio1]").removeAttr("checked", "checked");
				$("input[type=radio][name=radioT][id=radio2]").attr("checked", "checked");
				if(salesWayCount1 == 1) {	
					$(".comment").addClass("on");
				}
			} else {
				if(${not empty myDelivery}) {
					$(".contentBox1").addClass("on");
					$("#tab1").click(function() {
						$("#tab2").removeClass("active");
						$("#tab1").addClass("active");
						$(".contentBox2").removeClass("on");
						$(".contentBox1").addClass("on");
						$("input[type=radio][name=radioT][id=radio2]").removeAttr("checked", "checked");
						$("input[type=radio][name=radioT][id=radio1]").attr("checked", "checked");
					});
				} else {
					$(".contentBox2").addClass("on");
					$("input[type=radio][name=radioT][id=radio2]").attr("checked", "checked");
				}
			}
			$("#tab2").click(function() {
				$("#tab1").removeClass("active");
				$("#tab2").addClass("active");
				$(".contentBox1").removeClass("on");
				$(".contentBox2").addClass("on");
				$("input[type=radio][name=radioT][id=radio1]").removeAttr("checked", "checked");
				$("input[type=radio][name=radioT][id=radio2]").attr("checked", "checked");
			});
		} else {
			$("#tab1").removeClass("active");
			$("#tab2").removeClass("active");
			$("#tab1").addClass("none");
			$("#tab2").addClass("none");
			$("#tab1").css("border-bottom", "none");
			$("#tab1").css("border-right", "none");
			$("#tab2").css("border-bottom", "none");
			$(".bottomLeftContentBottom").css("border-top", "none");
			$(".comment").addClass("on");
		}
		if(salesWayCount1 == 1) {
			$(".contentBox3").addClass("on");
			$(".comment").addClass("on");
		}
		$(".paymentOkBtn").click(function() {
			if(salesWayCount2 == 1 && salesWayCount1 == 1) { // 직접/택배 모두 포함
				if($("input[type=radio][name=radioT][id=radio1]").is(":checked")) {
					/* alert("최근 배송지 선택(모두포함)"); */
					var dName = $("#dName").html(); 
					var dAddr = $("#dAddr").html(); 
					var dTel = $("#dTel").html();
					$("#orderName").val(dName);
					$("#orderAddr").val(dAddr);
					$("#orderTel").val(dTel);
					$("#orderOk").submit();
				} else {
					/* alert("새로운 배송지 선택(모두포함)"); */
					if(dnameFlag && $("#newdAddr").val() != "" && $("#newdAddr").val().length != 0 && dtel1Flag && dtel2Flag) {
						var newdName = $("#newdName").val();
						var newdAddr = $("#newdAddr").val();
						var newdTel = $("#newdTel0").val() + "-" + $("#newdTel1").val() + "-" + $("#newdTel2").val();
						$("#orderName").val(newdName);
						$("#orderAddr").val(newdAddr);
						$("#orderTel").val(newdTel);
 						$("#orderOk").submit();
					} else {
						$("#confirmPanel").css("display", "block");
						$("#confirmText").html("배송지 입력 정보를 확인해주세요.");
						$("#confirmBtn").attr("onclick", "$('#confirmPanel').css('display', 'none')"); 
					}
				}
			} else if(salesWayCount1 == 1 && salesWayCount2 == 0) { // 직접거래
					$("#orderOk").submit();
			} else if(salesWayCount1 == 0 && salesWayCount2 == 1) { // 택배거래
				if($("input[type=radio][name=radioT][id=radio1]").is(":checked")) {
					var dName = $("#dName").html(); 
					var dAddr = $("#dAddr").html(); 
					var dTel = $("#dTel").html();
					$("#orderName").val(dName);
					$("#orderAddr").val(dAddr);
					$("#orderTel").val(dTel);
					$("#orderOk").submit();
				} else {
					if(dnameFlag && $("#newdAddr").val() != "" && $("#newdAddr").val().length != 0 && dtel1Flag && dtel2Flag) {
						var newdName = $("#newdName").val();
						var newdAddr = $("#newdAddr").val();
						var newdTel = $("#newdTel0").val() + "-" + $("#newdTel1").val() + "-" + $("#newdTel2").val();
						$("#orderName").val(newdName);
						$("#orderAddr").val(newdAddr);
						$("#orderTel").val(newdTel);
 						$("#orderOk").submit();
					} else {
						$("#confirmPanel").css("display", "block");
						$("#confirmText").html("배송지 입력 정보를 확인해주세요.");
						$("#confirmBtn").attr("onclick", "$('#confirmPanel').css('display', 'none')"); 
					}
				}
			} else {
				$("#confirmPanel").css("display", "block");
				$("#confirmText").html("배송지 입력 정보를 확인해주세요.");
				$("#confirmBtn").attr("onclick", "$('#confirmPanel').css('display', 'none')");
				return false;
			}
		});
	});
function goPopup() {
	var pop = window.open(getContextPath() + "/product/jusoPopup","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
}
function jusoCallBack(roadFullAddr) {
	$("#newdAddr").val(roadFullAddr);
	$("#newdAddr").attr("disabled", "disabled");
}
function dnameCheck() {
	var dname = $("#newdName").val();
	if(dname.length > 10) {
		$("#confirmPanel").css("display", "block");
		$("#confirmText").html("수령자 이름은 10자를 넘을 수 없습니다.");
		$("#confirmBtn").attr("onclick", "$('#confirmPanel').css('display', 'none')");
		dnameFlag = false;
		return false;
	} else if(dname.length >= 3 && dname.length <= 10) {
		dnameFlag = true;
	} else {
		dnameFlag = false;		
	}
}
function dtel1Check() {
	var dtel1 = $("#newdTel1").val();
	var tel_regExp = /^[\d]{3,4}$/;
	
	if(new RegExp(tel_regExp).test(dtel1)) {
		dtel1Flag = true;
		if(dtel1.length >= 4) {
			return false;
		}
	} else {
		dtel1Flag = false;
		if(dtel1.length >= 4) {
			return false;
		}
	}
}
function dtel2Check() {
	var dtel2 = $("#newdTel2").val();
	var tel_regExp = /^[\d]{3,4}$/;

	if(new RegExp(tel_regExp).test(dtel2)) {
		dtel2Flag = true;
		if(dtel2.length >= 4) {
			return false;
		}
	} else {
		dtel2Flag = false;
		if(dtel2.length >= 4) {
			return false;
		}
	}
}
function getContextPath() {
	var set = location.href.indexOf(location.host)+location.host.length;
	var Path = location.href.substring(set, location.href.indexOf("/", set+1));
	return Path;
}
function allFormat() {
	var orderProductLength = ${fn:length(productOrderDto.list)};
	var paymentPrice = 0;
	for(var i=0; i<orderProductLength; i++) {
 		$("#orderNumber" + (i+1)).html($("#orderNumber" + (i+1)).html().replace(/\B(?=(\d{3})+(?!\d))/g,","));
		$("#orderPrice" + (i+1) + " span").html($("#orderPrice" + (i+1) + " span").html().replace(/\B(?=(\d{3})+(?!\d))/g,","));
		paymentPrice += parseInt($("#orderPrice" + (i+1) + " span").html().replace(/,/g, ""));
	}
	$(".allPrice").html((paymentPrice + "").replace(/\B(?=(\d{3})+(?!\d))/g,",") + "원");
	$(".paymentPrice").html((paymentPrice + "").replace(/\B(?=(\d{3})+(?!\d))/g,",") + "원");
	$("#orderTotalPrice").val(paymentPrice);
};
</script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/productOrder.css"/>
</head>
<body onload="allFormat();">
<jsp:include page="/resources/include/header/otherHeader.jsp"/>
<div class="orderTopWrapper">
	<div class="orderTopInner">
		<div class="orderTopInnerLeft">
		주문결제
		</div>
		<div class="orderTopInnerRight">
		<span id="cartPage">장바구니</span> > <span id="orderPage" class="active">주문결제</span> > <span id="orderOkPage">주문완료</span>
		</div>
	</div>
</div>
<script>
	var salesWayCount1 = 0;
</script>
<script>
	var salesWayCount2 = 0;
</script>
<form action="orderPayment" id="orderOk" method="post">
<div class="orderCenterWrapper">
	<div class="orderCenterInner">
		<div id="orderInfoTitle">주문상품 정보</div>
		<div class="centerInnerTop">
			<table id="orderInfoTable">
				<thead>
					<tr>
						<td id="orderProductNoTD">상품번호</td><td id="orderProductInfoTitle">상품정보</td><td id="numberTD">상품수량</td><td id="priceTD">상품금액</td>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="i" items="${productOrderDto.list}" varStatus="index">
						<c:if test="${i.salesWayId == 1}">
							<script>
								salesWayCount1 = 1;
							</script>
						</c:if>
						<c:if test="${i.salesWayId == 2}">
							<script>
								salesWayCount2 = 1;
							</script>
						</c:if>
						<tr>
							<td>${i.productNo}
							<input type="hidden" id="productNo${index.count}" name="productNo" value="${i.productNo}"/>	
							<input type="hidden" id="cartNo${index.count}" name="cartNo" value="${productOrderDto.cartNo[index.index]}"/>	
							</td>
							<td id="orderProductInfoContent">
								<div class="orderProductInfoBox">
									<div class="orderProductThumbnail">
										<img class="preview" src="${pageContext.request.contextPath}/resources/upload/${i.productThumb}"/>
									</div>
									<div class="orderProductContents">
										<div id="orderProductSubject"><a href="${pageContext.request.contextPath}/product/${i.productNo}">${i.productSubject}</a>
											<div class="subContents">
												<span id="orderProductState">
													<c:choose>
														<c:when test="${i.productStateId == 1}">
															미개봉 새제품
														</c:when>
														<c:when test="${i.productStateId == 2}">
															새제품
														</c:when>
														<c:when test="${i.productStateId == 3}">
															중고
														</c:when>
														<c:when test="${i.productStateId == 4}">
															중고(하자있음)
														</c:when>
														<c:when test="${i.productStateId == 5}">
															중고(하자심함)
														</c:when>
													</c:choose>
												</span>
												<span id="orderProudctWay">
													<c:choose>
														<c:when test="${i.salesWayId == 1}">
															직접거래
														</c:when>
														<c:when test="${i.salesWayId == 2}">
															택배거래
														</c:when>
													</c:choose>
													<input type="hidden" id="salesWayId" value="${i.salesWayId}" />
												</span>
											</div>
										</div>
									</div>
								</div>
							</td>
							<td id="orderNumber${index.count}">${i.orderNumber}
							<input type="hidden" id="orderNumber${index.count}" name="orderNumber" value="${i.orderNumber}"/>
							</td>
							<td id="orderPrice${index.count}"><span>${i.productPrice * i.orderNumber}</span>원</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="centerInnerBottom">
			<div class="innerBottomLeft">
				<div id="bottomLeftTitle">배송지 선택</div>
				<div class="bottomLeftContentTop">
					<c:choose>
						<c:when test="${empty myDelivery}">
							<div id="tab1" class="tabs none">최근 배송지</div>					
							<div id="tab2" class="tabs active">새로운 배송지</div>
						</c:when>
						<c:otherwise>
							<div id="tab1" class="tabs active">최근 배송지</div>					
							<div id="tab2" class="tabs">새로운 배송지</div>
						</c:otherwise>
					</c:choose>
				</div>
				<div class="bottomLeftContentBottom">
					<div class="contentBox1">
						<c:if test="${not empty myDelivery}">											
							<div class="info"><span class="infoHead">수령자</span><span id="dName" class="infoTd">${myDelivery.deliveryName}</span></div>
							<div class="info"><span id="secondHead1" class="infoHead">주소</span><span id="dAddr" class="infoTd">${myDelivery.deliveryAddr}</span></div>
							<div class="info"><span class="infoHead">연락처</span><span id="dTel" class="infoTd">${myDelivery.deliveryTel}</span></div>
						</c:if>
						<c:if test="${empty myDelivery}">
							<div class="info"><span class="infoHead">수령자</span><span id="dName" class="infoTd"></span></div>
							<div class="info"><span id="secondHead1" class="infoHead">주소</span><span id="dAddr" class="infoTd"></span></div>
							<div class="info"><span class="infoHead">연락처</span><span id="dTel" class="infoTd"></span></div>
						</c:if>
					</div>
					<div class="contentBox2">
						<div class="info"><span class="infoHead">수령자</span><input type="text" id="newdName" onkeypress="return dnameCheck();" onkeyup="dnameCheck();"/></div>
						<div class="info"><span id="secondHead2" class="infoHead">주소</span><input type="text" id="newdAddr" disabled/><div class="addrSearchBtn" onclick="goPopup();">주소찾기</div></div>
						<div class="info"><span class="infoHead">연락처</span>
							<select id="newdTel0">
								<option>010</option>
								<option>011</option>
								<option>016</option>
								<option>017</option>
								<option>018</option>
								<option>019</option>
							</select>
							<input type="text" id="newdTel1" onkeypress="return dtel1Check();" onkeyup="dtel1Check();"/> -<input type="text" id="newdTel2" onkeypress="return dtel2Check();" onkeyup="dtel2Check();"/>
						</div>
					</div>
					<div class="contentBox3">
						<c:forEach var="i" items="${productOrderDto.list}" varStatus="index">
							<c:choose>
								<c:when test="${i.salesWayId == 1}">
									<script>
										$(".contentBox3").css("display", "block");
									</script>
									<div class="salesWay1">
									<div class="info"><span class="infoHead">상품번호</span><span class="infoTd">${i.productNo}</span></div>
									<div class="info"><span class="infoHead">상품제목</span><span class="infoTd">${i.productSubject}</span></div>
									<div class="info"><span class="infoHead">거래지역</span><span class="infoTd">${i.productAddr}</span></div>
									</div>
								</c:when>
							</c:choose>
						</c:forEach>
					</div>
					<div class="comment">
						위의 상품은 판매자가 거래방식을 직접거래로 지정한 상품입니다.<br>
						최종결제전 꼭 확인하시기 바랍니다.
					</div>
					<input type="radio" name="radioT" id="radio1" checked/>
					<input type="radio" name="radioT" id="radio2"/>
					<input type="hidden" id="memberNo" name="memberNo" value="${sessionScope.memberNo}"/>
					<input type="hidden" id="orderName" name="orderName" value=""/>
					<input type="hidden" id="orderAddr" name="orderAddr" value=""/>
					<input type="hidden" id="orderTel" name="orderTel" value=""/>
				</div>
			</div>
			<div class="innerBottomRight">
				<div id="bottomRightTitle">최종결제 정보</div>
				<div class="bottomRightContent">
					<div class="contentTop">
						<span>종합금액</span><div class="allPrice"></div>
					</div>
					<div class="contentBottom">
						<span>결제 예정액</span><div class="paymentPrice"></div>
					</div>
					<input type="hidden" id="orderTotalPrice" name="orderTotalPrice" value=""/>
					<div class="paymentOkBtn">
						결제하기
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</form>
<div id="confirmPanel">
	<div id="confirmBox">
		<div id="confirmText"></div>
		<div id="confirmBtn">확인</div>
	</div>
</div>
<jsp:include page="/resources/include/footer/mainFooter.jsp"/>
<script type="text/javascript">
	var dnameFlag = false;
	var dtel1Flag = false;
	var dtel2Flag = false;
</script>
</body>
</html>