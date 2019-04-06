<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TBP - 대화방 목록</title>
<jsp:include page="/resources/include/combineScript.jsp"/>
<script>
$(document).ready(function() {
	sizes();
	formatRegDate();
});
$(window).resize(sizes);
function sizes() {
	var newHeight = $("html").height() - $(".talkTitle").height() + "px";
	$(".talkContent").css("height", newHeight);
	var newHeight2 = $(".talkContent").height() - $(".profile").height() - $(".talkBottom").height() - 20 + "px";
	$(".chat").css("height", newHeight2);
	var newHeight3 = $(".talkContent").height() - 4.5 + "px";
	$("li.emptyDto").css("height", newHeight3);
	$("li.emptyDto").css("line-height", newHeight3);
}
function formatRegDate() {
	today = new Date();
	for(var i=0; i<${fn:length(talkListDto)}; i++) {
		var resultDate = new Date($("#regDate" + (i+1)).html().replace(/-/g, "/").replace(".0", ""));
		
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
				var hours = resultDate.getHours();
				hours = (hours + "").length == 1? ("0" + hours):hours;
				var minutes = resultDate.getMinutes();
				minutes = (minutes + "").length == 1? ("0" + minutes):minutes;
				
				resultDate = hours + ":" + minutes;
			}
		} else {
			if(today.getFullYear() == currYear) {
				resultDate = currMonth + "월 " + currDay + "일"; 
			} else {
				resultDate = currYear + "-" + currMonth + "-" + currDay;
			}
		}
	 	
	 	$("#regDate" + (i+1)).html(resultDate);
	}
}
</script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/tbptalk_list.css">
</head>
<body>
<div class="talkContentWrapper">
	<div class="talkTitle">
		TBP TALK
	</div>
	<div class="talkContent">
		<div class="contentInner">
			<ul>
				<c:choose>
					<c:when test="${not empty talkListDto}">
						<c:forEach var="i" items="${talkListDto}" varStatus="index">
							<li onclick="location.href='chat/${i.memberNo}'">
								<div class="list">
									<img src="${pageContext.request.contextPath}/resources/img/tbptalk/user_list.png"/>
								</div>
								<div class="list">
									<div class="shopName">
										${empty i.shopName? 'TBP SHOP ' += i.memberNo += '호':i.shopName}
									</div>
									<div class="lastContent">
										${i.tbptalkContent}
									</div>
								</div>
								<div class="list otherBox">
									<div id="regDate${index.count}" class="regDate">
										${i.tbptalkRegDate}
									</div>
									<div class="notReadCount" id="notReadCount${index.count}" >
										<c:choose>
											<c:when test="${i.tbptalkNotReadCount != 0}">
												<script>
													$("#notReadCount${index.count}").css("display", "block");
												</script>
												<c:if test="${i.tbptalkNotReadCount >= 100}">
													99+
												</c:if>
												<c:if test="${i.tbptalkNotReadCount < 100}">
													${i.tbptalkNotReadCount}
												</c:if>
											</c:when>
										</c:choose>
									</div>
								</div>
							</li>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<li class="emptyDto">
							진행 중인 대화가 없습니다.
						</li>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>
	</div>
</div>
</body>
</html>