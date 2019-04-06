<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TBP - 주문완료</title>
<jsp:include page="/resources/include/combineScript.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/productOrderOk.css"/>
</head>
<body>
<jsp:include page="/resources/include/header/otherHeader.jsp"/>
<div class="orderTopWrapper">
	<div class="orderTopInner">
		<div class="orderTopInnerLeft">
		주문완료
		</div>
		<div class="orderTopInnerRight">
		<span id="cartPage">장바구니</span> > <span id="orderPage">주문결제</span> > <span id="orderOkPage" class="active">주문완료</span>
		</div>
	</div>
</div>
<div class="orderCenterWrapper">
	<div class="orderCenterInner">
		<c:choose>
			<c:when test="${status == 'paymentSuccess'}">
				<div class="orderExplain">주문/결제가 완료되었습니다.</div>
				<div class="orderExplainImg"><img src="${pageContext.request.contextPath}/resources/img/product/paymentOk.png"/></div>
				<div class="orderExplainBtnBox"><div class="orderExplainBtnBoxInner"><div class="orderExplainBtn" onclick="location.href='${pageContext.request.contextPath}/myPage'">구매확인</div> <div class="orderExplainBtn" onclick="location.href='${pageContext.request.contextPath}/main/index'" >메인으로</div></div></div>
			</c:when>
			<c:when test="${status == 'moneyShortage'}">
				<div class="orderExplain">보유 TBP페이가 부족합니다.</div>
				<div class="orderExplainImg"><img src="${pageContext.request.contextPath}/resources/img/product/paymentFail.png"/></div>
				<div class="orderExplainBtnBox"><div class="orderExplainBtnBoxInner"><div class="orderExplainBtn" onclick="location.href='${pageContext.request.contextPath}/main/index'">메인으로</div> <div class="orderExplainBtn" onclick="history.back();">이전으로</div></div></div>
			</c:when>
			<c:when test="${status == 'stockChange'}">
				<div class="orderExplain">상품의 재고가 부족하거나 변동이 있습니다.</div>
				<div class="orderExplainImg"><img src="${pageContext.request.contextPath}/resources/img/product/paymentFail.png"/></div>
				<div class="orderExplainBtnBox"><div class="orderExplainBtnBoxInner"><div class="orderExplainBtn" onclick="location.href='${pageContext.request.contextPath}/main/index'">메인으로</div> <div class="orderExplainBtn" onclick="history.back();">이전으로</div></div></div>
			</c:when>
			<c:otherwise>
				<div class="orderExplain">알 수 없는 오류입니다.</div>
				<div class="orderExplainImg"><img src="${pageContext.request.contextPath}/resources/img/product/paymentFail.png"/></div>
				<div class="orderExplainBtnBox"><div class="orderExplainBtnBoxInner"><div class="orderExplainBtn" onclick="location.href='${pageContext.request.contextPath}/main/index'">메인으로</div> <div class="orderExplainBtn" onclick="history.back();">이전으로</div></div></div>
			</c:otherwise>
		</c:choose>
	</div>
</div>
<jsp:include page="/resources/include/footer/mainFooter.jsp"/>
</body>
</html>