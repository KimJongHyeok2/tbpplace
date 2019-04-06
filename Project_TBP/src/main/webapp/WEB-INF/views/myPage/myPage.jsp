<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TBP - 마이페이지</title>
<jsp:include page="/resources/include/combineScript.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/myPage.css"/>
<script type="text/javascript">
$(document).ready(function() {
	// ContextPath
	function getContextPath() {
		var set = location.href.indexOf(location.host)+location.host.length;
		var Path = location.href.substring(set, location.href.indexOf("/", set+1));
		return Path;
	}
	// 구매내역 클릭시 요청
	$("#purchases").click(function() {
		location.href = getContextPath() + "/myPage?pageType=purchases";
	});
	$("#myGrade").click(function() {
		location.href = getContextPath() + "/myPage?pageType=myGrade";
	});
/* 	// 판매내역 클릭시 요청
	$("#sales").click(function() {
		location.href = getContextPath() + "/myPage?pageType=sales";
	}); */
	// 판매관리 클릭시 요청
	$("#salesManagement").click(function() {
		$("#purchases").removeClass("active");
		$("#sales").removeClass("active");
		$("#salesManagement").addClass("active");
		location.href = getContextPath() + "/myPage/salesManagement";
	});
	var myPageInnerLeftTop = $(".myPageMainInnerLeft .Title").offset().top;
	$(window).scroll(function() {
		var docScrollTop = $(document).scrollTop();
		if(docScrollTop >= myPageInnerLeftTop) {
			$(".myPageMainInnerLeft .leftBox").addClass("fixedOn");
		} else {
			$(".myPageMainInnerLeft .leftBox").removeClass("fixedOn");			
		}
	});
});
</script>
</head>
<body>
<jsp:include page="/resources/include/header/otherHeader.jsp"/>
<div class="myPageMainWrapper">
	<div class="myPageMainInner">
		<div class="myPageMainInnerLeft">
			<div class="leftBox">
			<div class="Title">
				마이페이지
			</div>
			<div class="functionList">
				<div class="memberProfile">
					<div>
						<img style="width: 100%; height: 100%;" src="${pageContext.request.contextPath}/resources/img/main/profile.png"/>
					</div>
					${sessionScope.memberName}님<br><br>
					<div class="myMoneyT">보유 TBP페이</div>
					<div class="myMoney">${sessionScope.memberMoney}</div>
				</div>
				<ul>
					<li id="purchases" class="${param.pageType == 'purchases'? 'active':'' || empty param.pageType? 'active':''}">구매내역</li>
					<li id="myGrade" class="${param.pageType == 'myGrade'? 'active':''}">회원등급</li>
					<li id="salesManagement">판매관리</li>
					<li>정보수정</li>
				</ul>
			</div>
			</div>
		</div>
		<c:choose>
			<c:when test="${param.pageType == 'purchases' || empty param.pageType}">
				<jsp:include page="purchases.jsp"/>	
			</c:when>
			<c:when test="${param.pageType == 'myGrade'}">
				<jsp:include page="myGrade.jsp"/>
			</c:when>
			<c:otherwise>
			알 수 없는 오류입니다.
			</c:otherwise>
		</c:choose>
	</div>
</div>
<jsp:include page="/resources/include/footer/mainFooter.jsp"/>
</body>
</html>