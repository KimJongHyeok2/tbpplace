<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="/resources/include/combineScript.jsp"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
$(document).ready(function() {
	$("#merchandiseControl").click(function() {
		location.href="salesManagement?pageType=merchandiseControl&memberNo=${sessionScope.memberNo}";
	});
	$("#salesRegistration").click(function() {
		location.href="salesManagement?pageType=registration";
	});
	$("#salesControl").click(function() {
		location.href="salesManagement?pageType=salesControl&memberNo=${sessionScope.memberNo}";
	});
});
</script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/salesManagement.css"/>
<title>TBP - 판매관리</title>
</head>
<body>
<div class="allWrapper">
	<div class="allWrapperInnerLeft">
		<div class="cmLogoBox"><a href="${pageContext.request.contextPath}/main/index"><img style="width: 100%; height: 100%;" id="cmLogos" src="${pageContext.request.contextPath}/resources/img/main/salesLogo.png"/></a></div>
		<div class="cmTitle"><a href="${pageContext.request.contextPath}/shop/${sessionScope.memberNo}">${empty sessionScope.shopName? 'TBP SHOP ' += sessionScope.memberNo += '호':sessionScope.shopName}</a></div>
		<div class="myShopProfile"><img src="${pageContext.request.contextPath}/resources/img/main/profile.png"/></div>
		<div class="myShopInfo">${sessionScope.memberName}님</div>
		<div class="navigation">
			<ul>
				<li id="salesRegistration" class="${param.pageType == 'registration'? 'active':'' || empty param.pageType? 'active':''}">상품등록</li>
				<li id="merchandiseControl" class="${param.pageType == 'merchandiseControl'? 'active':''}">상품관리</li>
				<li id="salesControl" class="${param.pageType == 'salesControl'? 'active':''}">판매내역</li>
			</ul>
		</div>
	</div>
	<div class="allWrapperInnerRight">
		<c:choose>
			<c:when test="${param.pageType == 'registration'}">
				<jsp:include page="salesRegistration.jsp"/>
			</c:when>
			<c:when test="${param.pageType == 'merchandiseControl'}">
				<jsp:include page="merchandiseControl.jsp"/>
			</c:when>
			<c:when test="${param.pageType == 'salesControl'}">
				<jsp:include page="salesControl.jsp"/>
			</c:when>
			<c:when test="${param.pageType == 'salesUpdate'}">
				<jsp:include page="salesUpdate.jsp"/>
			</c:when>
			<c:otherwise>
				<jsp:include page="salesRegistration.jsp"/>
			</c:otherwise>
		</c:choose>
	</div>
</div>
<div id="registerPanel">
	<div id="registerBox">
		<div id="registerText"></div>
		<div id="tbpRegisterCheckBtn">확인</div>
	</div>
</div>
<div class="confirmPanel2">
	<div class="confirmBox2">
		<div id="confirmText2"></div>
		<div class="confirmBtn2" id="confirmOk">확인</div>
		<div class="confirmBtn2" id="confirmCancle">취소</div>
	</div>
</div>
</body>
</html>