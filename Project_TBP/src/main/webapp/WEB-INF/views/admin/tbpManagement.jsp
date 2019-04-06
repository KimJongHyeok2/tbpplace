<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>TBP - Management</title>
<jsp:include page="/resources/include/combineScript.jsp"/>
<script type="text/javascript">
$(document).ready(function() {
	$("#aName").click(function() {
		$("#aDrop").slideToggle(100);
	});
	$(".service").click(function() {
		var type = $(this).find("input[type=hidden]").val();
		$("#" + type).slideToggle(100);
	});
	$(".service-list li").click(function() {
		var pageType = $(this).find("input[type=hidden]").val();
		if(pageType == "notice") {
			$(this).find(".list-drop").slideToggle(100);
			return false;
		}
		location.href = "${pageContext.request.contextPath}/admin/tbpManagement?pageType=" + pageType;
	});
	$(".list-drop div").click(function() {
		var pageType = $(this).find("input[type=hidden]").val();
		location.href = "${pageContext.request.contextPath}/admin/tbpManagement?pageType=" + pageType;
	});
	if(${not empty param.pageType}) {
		var pageType = $("#pageType").val();
		if(pageType == "question" || pageType == "writeNotice" || pageType == "noticeList") {
			pageType = "customer";
		} else if(pageType == "orderCancle") {
			pageType = "order";
		}
		$("#" + pageType).css("display", "block");
	} else {
		$("#customer").css("display", "block");
	}
	$(".emptyDto").hover(function() {
		$(this).css("background-color", "white");
	});
});
</script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/tbpManagement.css">
</head>
<body>
<div class="topWrapper">
	<div class="leftNav">
		<div class="title">
			<a href="${pageContext.request.contextPath}/main/index"><img src="${pageContext.request.contextPath}/resources/img/main/logo.png"/></a>
		</div>
	</div>
	<div class="rightNav">
		<div class="name">
			<span id="aName"><s:authentication property="name"/>님</span>
			<ul id="aDrop">
				<li class="last"><a href="${pageContext.request.contextPath}/auth_logout">로그아웃</a></li>
			</ul>
		</div>
	</div>	
</div>
<div class="bottomWrapper">
	<div class="leftNav">
		<ul>
			<li class="service">
			고객 관련 서비스
			<input type="hidden" value="customer"/>
			</li>
		</ul>
		<ul id="customer" class="service-list">
			<li id="customer-list-1">공지사항
			<input type="hidden" value="notice"/>
				<div class="list-drop">
					<div id="writeNotice">공지사항 작성
					<input type="hidden" value="writeNotice"/>
					</div>
					<div id="noticeList">공지사항 목록
					<input type="hidden" value="noticeList"/>
					</div>
				</div>
			</li>
			<li id="customer-list-2">문의답변
			<input type="hidden" value="question"/>
			</li>
		</ul>
		<ul>
			<li class="service">
			회원 관리 서비스
			<input type="hidden" value="member"/>
			</li>
		</ul>
		<ul id="member" class="service-list">
			<li id="member-list-1" value="member">회원관리
			<input type="hidden" value="member"/>
			</li>
		</ul>
		<ul>
			<li class="service">
			거래 관리 서비스
			<input type="hidden" value="order"/>
			</li>
		</ul>
		<ul id="order" class="service-list">
			<li id="order-list-1" value="orderCancle">구매/거래취소
			<input type="hidden" value="orderCancle"/>
			</li>
		</ul>
	</div>
	<div class="rightContent">
		<c:choose>
			<c:when test="${param.pageType == 'writeNotice'}">				
				<jsp:include page="writeNotice.jsp"/>
			</c:when>
			<c:when test="${empty param.pageType || param.pageType == 'noticeList'}">				
				<jsp:include page="noticeList.jsp"/>
			</c:when>
			<c:when test="${param.pageType == 'question'}">
				<jsp:include page="question.jsp"/>
			</c:when>
			<c:when test="${param.pageType == 'member'}">
				<jsp:include page="member.jsp"/>
			</c:when>
			<c:when test="${param.pageType == 'orderCancle'}">
				<jsp:include page="orderCancle.jsp"/>
			</c:when>
		</c:choose>
		<input type="hidden" id="pageType" value="${param.pageType}"/>
	</div>
</div>
<div class="confirmPanel">
	<div class="confirmBox">
		<div id="confirmText"></div>
		<div id="confirmBtn">확인</div>
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