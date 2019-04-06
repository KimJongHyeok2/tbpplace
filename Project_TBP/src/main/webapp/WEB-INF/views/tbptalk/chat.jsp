<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TBP - 대화방</title>
<jsp:include page="/resources/include/combineScript.jsp"/>
<script type="text/javascript">
$(document).ready(function() {
	sizes();
	callMessage();
	$(".prev").click(function() {
		location.href = "${pageContext.request.contextPath}/tbptalk/chat_list";
	});
});
$(window).resize(sizes);
function scrollTopChat() {
	var chatHeight = document.getElementById("chatList");
	chatHeight.scrollTop = chatHeight.scrollHeight;
}
function sizes() {
	var newHeight = $("html").height() - $(".talkTitle").height() + "px";
	$(".talkContent").css("height", newHeight);
	var newHeight2 = $(".talkContent").height() - $(".profile").height() - $(".talkBottom").height() - 20 + "px";
	$(".chat").css("height", newHeight2);
}
function checkVal(message) {
	if(message.value.length > 10) {
		if(message.value.length <= 100) {
			$(".sendBtn").addClass("on");
			$(".sendBtn").attr("onclick", "writeMessage()");
		} else {
			$(".sendBtn").removeClass("on");		
			$(".sendBtn").removeAttr("onclick");
		}
	} else {
		$(".sendBtn").removeClass("on");		
		$(".sendBtn").removeAttr("onclick");
	}
}
function writeMessage() {
	var message = $("#message").val();
	$.ajax({
		url: "${pageContext.request.contextPath}/rTbptalk/send",
		type: "POST",
		cache: false,
		data: {
			"memberNo1" : ${empty sessionScope.memberNo? 0:sessionScope.memberNo},
			"memberNo2" : ${memberNo},
			"tbptalkContent" : message
		},
		success: function(data, status) {
			if(status = "success") {
				if(data == "Ok") {
					callMessage();
					$("#message").val("");
				}
			}
		}
	});
}
function callMessage() {
	$.ajax({
		url: "${pageContext.request.contextPath}/rTbptalk/call",
		type: "POST",
		cache: false,
		data: {
			"memberNo1" : ${empty sessionScope.memberNo? 0:sessionScope.memberNo},
			"memberNo2" : ${memberNo},
		},
		success: function(data, status) {
			if(status = "success") {
				if(data.status == "Ok") {
					var messages = "";
					var tempRegDate = "";
					var tempRegDate2 = "";
					var tempRegDate3 = "";
					var tempRegDateArr = new Array();
					var tempRegDateArrMe = new Array();
					var k = 0;
					var j = 0;
					for(var i=0; i<data.count; i++) {
						if(tempRegDate != formatMessageDivRegDate(data.list[i].tbptalkRegDate)) {							
							messages += "<div class='messageDiv'>" + formatMessageDivRegDate(data.list[i].tbptalkRegDate) + "</div>";
						}
						tempRegDate = formatMessageDivRegDate(data.list[i].tbptalkRegDate);
						if(data.list[i].memberNo != ${empty sessionScope.memberNo? 0:sessionScope.memberNo}) {
	 						messages += "<div class='message'>";
								messages += "<img class='" + (tempRegDate2==formatMessageRegDate(data.list[i].tbptalkRegDate)? 'overlap':'') + "' src='${pageContext.request.contextPath}/resources/img/tbptalk/user.png'/>";
								if(tempRegDate2 == formatMessageRegDate(data.list[i].tbptalkRegDate)) {
									tempRegDateArr.push(k);
								}
								messages += "<div class='content'>";
								messages += data.list[i].tbptalkContent.replace(/\n/g, "<br>");
								messages += "</div>";
								messages += "<div id='regDate" + k + "' class='regDate'>" + formatMessageRegDate(data.list[i].tbptalkRegDate) + "</div>";
								messages += "<div id='viewCheck " + k + "' class='viewCheck'>" + viewCheck(data.list[i].tbptalkViewcnt) + "</div>";
								tempRegDate2 = formatMessageRegDate(data.list[i].tbptalkRegDate);
							messages += "</div>";
							k++;
						} else {
	 						messages += "<div class='message me'>";
								messages += "<div id='viewCheckMe" + j + "' class='viewCheck'>" + viewCheck(data.list[i].tbptalkViewcnt) + "</div>";
								messages += "<div id='regDateMe" + j + "' class='regDate'>" + formatMessageRegDate(data.list[i].tbptalkRegDate) + "</div>";
								messages += "<div class='content'>";
								messages += data.list[i].tbptalkContent.replace(/\n/g, "<br>");
								messages += "</div>";
								messages += "<img class='" + (tempRegDate3==formatMessageRegDate(data.list[i].tbptalkRegDate)? 'overlap':'') + "' src='${pageContext.request.contextPath}/resources/img/tbptalk/user.png'/>";
								if(tempRegDate3 == formatMessageRegDate(data.list[i].tbptalkRegDate)) {
									tempRegDateArrMe.push(j);
								}
								tempRegDate3 = formatMessageRegDate(data.list[i].tbptalkRegDate);
							messages += "</div>";
							j++;
						}
					}
					$("#chatList").html(messages);
					for(var i=0; i<tempRegDateArr.length; i++) {
						$("#regDate" + (tempRegDateArr[i]-1)).addClass("overlap");
					}
					for(var i=0; i<tempRegDateArrMe.length; i++) {
						$("#regDateMe" + (tempRegDateArrMe[i]-1)).addClass("overlap");
					}
					scrollTopChat();
				}
			}
		}
	});
}
function formatMessageDivRegDate(regDate) {
	var talkRegDate = new Date(regDate);
	var talkYear = talkRegDate.getFullYear();
	var talkMonth = (talkRegDate.getMonth()+1);
	var days = ["일", "월", "화", "수", "목", "금", "토", "일"];
	talkMonth = (talkMonth + "").length==1? ("0" + talkMonth):talkMonth;
	var talkDate = talkRegDate.getDate();
	talkDate = (talkDate + "").length==1? ("0" + talkDate):talkDate;
	
	return (talkYear + "-" + talkMonth + "-" + talkDate + "(" + days[talkRegDate.getDay()] + ")");
}
function formatMessageRegDate(regDate) {
	today = new Date();
 	resultDate = new Date(regDate);
 	timegap = (today-resultDate)/(60*60*1000);
 	
	var currYear = resultDate.getFullYear();
	var currMonth = (resultDate.getMonth() + 1);
	var currDay = resultDate.getDate();
	
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
 	
 	return resultDate;
}
function viewCheck(viewCount) {
	if(viewCount != 1) {
		viewCount = '';
	}
	return viewCount;
}
</script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/tbptalk_chat.css">
</head>
<body>
<div class="talkContentWrapper">
	<c:if test="${empty shopInfoDto}">
		<script>
			location.href = "${pageContext.request.contextPath}/tbptalk/chat_list";
		</script>
	</c:if>
	<c:if test="${memberNo == sessionScope.memberNo}">
		<script>
			location.href = "${pageContext.request.contextPath}/tbptalk/chat_list";
		</script>
	</c:if>
	<div class="talkTitle">
		<img class="prev" src="${pageContext.request.contextPath}/resources/img/tbptalk/back.png"/>	TBP TALK
	</div>
	<div class="talkContent">
		<div class="profile">
			<div class="pImg">
				<img src="${pageContext.request.contextPath}/resources/img/tbptalk/user.png"/>
			</div>
			<div class="shopName">
				<div>${empty shopInfoDto.shopName? 'TBP SHOP ' += memberNo += '호':shopInfoDto.shopName}</div>
				<div class="shopIntro">${shopInfoDto.shopIntroduction}</div>
			</div>
		</div>
		<div id="chatList" class="chat">
		</div>
		<div class="talkBottom">
			<div class="inputBox">
				<textarea id="message" onkeyup="checkVal(this);"></textarea>
			</div>
			<div class="sendBtn">
				전송
			</div>
		</div>
	</div>
</div>
<input type="hidden" id="memberNo" value="${empty sessionScope.memberNo? 0:sessionScope.memberNo}"/>
</body>
</html>