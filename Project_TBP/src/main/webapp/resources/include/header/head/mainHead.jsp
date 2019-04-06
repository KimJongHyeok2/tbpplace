<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/resources/include/combineScript.jsp"/>
<script>
$(document).ready(function() {
	$("#searchInput").focus(function() {
		$("#searchImg").attr("src", "${pageContext.request.contextPath}/resources/img/main/search2_after(1).png");
	});
	$("#searchInput").blur(function() {
		$("#searchImg").attr("src", "${pageContext.request.contextPath}/resources/img/main/search2_before(1).png");
	}); 
	if(${not empty sessionScope.loginCheck}) {
		noticeList();
	}
	$("#myNotice").click(function() {
		$(".myNoticeBoard").slideToggle();
	});
	$("#deleteNoticeAll").click(function() {
/* 		var noticeCount = parseInt($("#noticeCount").html());
		if(noticeCount == 0) {
			return false;
		} */
		$(".innerBottom .confirmPanel").css("display", "block");
	});
	$(".top .cancle").click(function() {
		$(".innerBottom .confirmPanel").css("display", "none");
	});
	$("#deleteCancle").click(function() {
		$(".innerBottom .confirmPanel").css("display", "none");
	});
	$("#deleteOk").click(function() {
		var memberNo = ${empty sessionScope.memberNo? 0:sessionScope.memberNo};
		
		$.ajax({
			url: "${pageContext.request.contextPath}/notice/deleteAll",
			type: "POST",
			cache: false,
			data: {
				"memberNo" : memberNo
			},
			success: function(data, status) {
				if(data == "Ok") {
					noticeList();
				} else {
					alert("이미 삭제되었거나 읽은 알림이 존재하지 않습니다.");
				}
				$(".innerBottom .confirmPanel").css("display", "none");
			}
		});
	});
});
function noticeList() {
	var memberNo = ${empty sessionScope.memberNo? 0:sessionScope.memberNo};
	$.ajax({
		url: "${pageContext.request.contextPath}/notice/select",
		type: "POST",
		cache: false,
		data: {
			"memberNo" : memberNo
		},
		success: function(data, status) {
			if(status == "success") {
				if(data.status == "Ok") {
					var notices = "";
					for(var i=0; i<data.count; i++) {
							notices += "<li>";
							notices += "<div class='readCheck'>";							
								notices += "<div class='check" + (data.list[i].noticeStatus==1? '':' r') + "'></div>";					
							notices += "</div>";
							notices += "<div class='content'>";
								/* notices += "<div class='info1'><a href='${pageContext.request.contextPath}/product/" + data.list[i].productNo + "?n=n'>" + checkNoticeTitle(data.list[i].noticeWay) + "</a></div>"; */
								notices += "<div class='info1'><a class='" + (data.list[i].noticeStatus==1? '':' r') + "' onclick='checkNotice(" + data.list[i].noticeNo + ", " + data.list[i].productNo + ", " + data.list[i].noticeWay + ", " + data.list[i].memberNo + ");'>" + checkNoticeTitle(data.list[i].noticeWay) + "</a></div>";
								notices += "<div class='info2'>";					
								notices += "<span class='way'>" + checkNoticeWay(data.list[i].noticeWay) + "</span><span class='regDate'>" + formatDate(data.list[i].noticeRegDate) + "</span>";
								notices += "</div>";
							notices += "</div>";						
							notices += "<div class='delete' onclick='deleteNotice(" + data.list[i].noticeNo + ")' >X</div>";						
						notices += "</li>";
					}
					$("ul#notices").html(notices);
				} else {
					var notices = "";
					$("ul#notices").html("<div class='emptyNotice'>알림이 없습니다.</div>");	
				}
				$(".conversation").css("display", "block");
				if(data.noticeCount > 99) {
					$(".conversation").html(99 + "+");
				} else {					
					$(".conversation").html(data.noticeCount);
				}
				$("#noticeCount").html(data.noticeCount);
			}
		}
	});
}
function checkNotice(noticeNo, productNo, noticeWay, memberNo) {
	$.ajax({
		url: "${pageContext.request.contextPath}/notice/read",
		type: "POST",
		cache: false,
		data: {
			"noticeNo" : noticeNo
		},
		success: function(data, status) {
			if(status == "success") {
				if(data == "Ok") {
					if(noticeWay == 1 || noticeWay == 2) {					
						location.href = "${pageContext.request.contextPath}/product/" + productNo + "?n=n";
					} else if(noticeWay == 3 || noticeWay == 5) {
						location.href = "${pageContext.request.contextPath}/myPage/salesManagement?pageType=salesControl&memberNo=" + memberNo;
					} else if(noticeWay == 7) {
						location.href = "${pageContext.request.contextPath}/product/" + productNo + "?s=s";						
					} else if(noticeWay == 8) {
						location.href = "${pageContext.request.contextPath}/customer/customerService?q=q";												
					} else if(noticeWay == 9) {
						location.href = "${pageContext.request.contextPath}/myPage/salesManagement?pageType=salesControl&memberNo=" + memberNo;
					} else if(noticeWay == 10 || noticeWay == 11 || noticeWay == 12) {
						location.href = "${pageContext.request.contextPath}/myPage";
					} else if(noticeWay == 13) {
						noticeList();
						tbptalk();
					}
				} else {
					alert("알 수 없는 오류입니다.");
				}
			}
		}
	});
}
function deleteNotice(noticeNo) {
	$.ajax({
		url: "${pageContext.request.contextPath}/notice/delete",
		type: "POST",
		cache: false,
		data: {
			"noticeNo" : noticeNo
		},
		success: function(data, status) {
			if(status == "success") {
				if(data == "Ok") {
					noticeList();
				} else {
					alert("이미 삭제되었거나 존재하지 않습니다.");
				}
			}
		}
	});
}
function tbptalk() {
	var pop = window.open("${pageContext.request.contextPath}/tbptalk/chat_list","pop","width=570,height=800, scrollbars=yes, resizable=yes");
}
function checkNoticeTitle(noticeWay) {
	if(noticeWay == 1) {
		return "등록하신 상품에 문의가 등록되었습니다.";
	} else if(noticeWay == 2) {
		return "문의하신 상품에 답변이 등록되었습니다.";
	} else if(noticeWay == 3) {
		return "등록하신 상품의 거래가 시작되었습니다.";
	} else if(noticeWay == 5) {
		return "등록하신 상품의 거래가 완료되었습니다.";
	} else if(noticeWay == 7) {
		return "거래완료 상품에 후기가 등록되었습니다.";
	} else if(noticeWay == 8) {
		return "고객센터 문의에 답변이 등록되었습니다.";
	} else if(noticeWay == 9) {
		return "구매자가 구매취소 요청을 하였습니다.";
	} else if(noticeWay == 10) {
		return "판매자가 거래취소 요청을 하였습니다.";
	} else if(noticeWay == 11) {
		return "거래가 정상적으로 취소되었습니다.";
	} else if(noticeWay == 12) {
		return "거래취소 요청이 반려되었습니다.";
	} else if(noticeWay == 13) {
		return "TBP TALK이 도착하였습니다.";
	}
}
function checkNoticeWay(noticeWay) {
	if(noticeWay == 1) {
		return "상품문의";
	} else if(noticeWay == 2) {
		return "상품답변";
	} else if(noticeWay == 3) {
		return "거래진행";
	} else if(noticeWay == 5) {
		return "거래완료";
	} else if(noticeWay == 7) {
		return "상품후기";
	} else if(noticeWay == 8) {
		return "고객센터";
	} else if(noticeWay == 9 || noticeWay == 10) {
		return "취소요청";
	} else if(noticeWay == 11) {
		return "취소승인";
	} else if(noticeWay == 12) {
		return "취소반려";
	} else if(noticeWay == 13) {
		return "TBP TALK";
	}
}
function searchClick() {
	if($("#searchInput").val() == "" || $("#searchInput").val().length == 0) {
		alert("검색할 단어를 입력해주세요.");
		return false;
	} else {
		var encodeValue = urlencode($("#searchInput").val());
		location.href="${pageContext.request.contextPath}/search/product?searchValue=" + encodeValue;			
	}
}
function searchEnter() {
	if(event.keyCode == 13) {
		if($("#searchInput").val() == "" || $("#searchInput").val().length == 0) {
			alert("검색할 단어를 입력해주세요.");
			return false;
		}
		var encodeValue = urlencode($("#searchInput").val());
		location.href="${pageContext.request.contextPath}/search/product?searchValue=" + encodeValue;
	}
}
function urlencode(str) {
    str = (str + '').toString();
    return encodeURIComponent(str)
        .replace(/!/g, '%21')
        .replace(/'/g, '%27')
        .replace(/\(/g, '%28')
        .replace(/\)/g, '%29')
        .replace(/\*/g, '%2A')
        .replace(/%20/g, '+');
}
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
<style type="text/css">
.headWrapper {
	font-family: "나눔고딕";
	color: gray;
}
.headWrapper .headWrapperInner {
	position: relative;
	display: flex;
	width: 1000px;
	margin: 0 auto;
}
.headWrapper .headWrapperInner .myNoticeBoard {
	display: none;
	position: absolute;
	right: -250px;
	width: 270px;
	height: 308px;
	border: 1px solid #D5D5D5;
	background-color: white;
	box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.1);
	font-size: 10pt;
	color: black;
	z-index: 1;
}
.headWrapper .headWrapperInner .myNoticeBoard .innerTop {
	border-bottom: 1px solid #D5D5D5;
}
.headWrapper .headWrapperInner .myNoticeBoard .innerTop:after {
	content: "";
	display: block;
	clear: both;
}
.headWrapper .headWrapperInner .myNoticeBoard .innerTop .left {
	float: left;
	padding: 7px;
}
.headWrapper .headWrapperInner .myNoticeBoard .innerTop .right {
	float: right;
	border: 1px solid #D5D5D5;	
	margin: 5px;
	padding: 2px;
	cursor: pointer;
}
.headWrapper .headWrapperInner .myNoticeBoard .innerTop .right:hover {
	border-color: gray;
}
.headWrapper .headWrapperInner .myNoticeBoard .innerBottom {
	position: relative;
	height: 89.5%;
	overflow: auto;
}
.headWrapper .headWrapperInner .myNoticeBoard .innerBottom .confirmPanel {
	display: none;
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	overflow: hidden;
}
.headWrapper .headWrapperInner .myNoticeBoard .innerBottom .confirmPanel .confirmBox {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	border: 1px solid #D5D5D5;
	background-color: white;
	box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.1);
	width: 200px;
	height: 70px;
}
.headWrapper .headWrapperInner .myNoticeBoard .innerBottom .confirmPanel .confirmBox .top {
	margin: 3px;
}
.headWrapper .headWrapperInner .myNoticeBoard .innerBottom .confirmPanel .confirmBox .top:after {
	content: "";
	display: block;
	clear: both;
}
.headWrapper .headWrapperInner .myNoticeBoard .innerBottom .confirmPanel .confirmBox .top .cancle {
	float: right;
	color: #D5D5D5;
	cursor: pointer;
}
.headWrapper .headWrapperInner .myNoticeBoard .innerBottom .confirmPanel .confirmBox .top .cancle:hover {
	color: gray;
}
.headWrapper .headWrapperInner .myNoticeBoard .innerBottom .confirmPanel .confirmBox .middle {
	margin: 3px;
	text-align: center;
}
.headWrapper .headWrapperInner .myNoticeBoard .innerBottom .confirmPanel .confirmBox .bottom {
	margin: 5px;
	text-align: center;
}
.headWrapper .headWrapperInner .myNoticeBoard .innerBottom .confirmPanel .confirmBox .bottom .bottomBtn {
	display: inline-block;
	width: 50px;
	height: 20px;
	line-height: 20px;
	margin-right: 2px;
	border: 1px solid #D5D5D5;
	cursor: pointer;
}
.headWrapper .headWrapperInner .myNoticeBoard .innerBottom .confirmPanel .confirmBox .bottom .bottomBtn:hover {
	border-color: gray;
}
.headWrapper .headWrapperInner .myNoticeBoard .innerBottom ul {
	list-style-type: none;
	margin: 0;
	padding: 0;
	overflow: hidden;
}
.headWrapper .headWrapperInner .myNoticeBoard .innerBottom ul .emptyNotice {
	height: 274px;
	line-height: 274px;
	text-align: center;
}
.headWrapper .headWrapperInner .myNoticeBoard .innerBottom ul li {
	padding: 5px;
}
.headWrapper .headWrapperInner .myNoticeBoard .innerBottom ul li:hover {
	background-color: rgba(246, 246, 246, 0.8);
}
.headWrapper .headWrapperInner .myNoticeBoard .innerBottom ul li div.delete, div.content, div.readCheck {
	display: inline-block;
	vertical-align: middle;
	height: 30px;
}
.headWrapper .headWrapperInner .myNoticeBoard .innerBottom ul li div.readCheck {
	line-height: 30px;
}
.headWrapper .headWrapperInner .myNoticeBoard .innerBottom ul li div.readCheck .check {
	display: inline-block;
	width: 5px;
	height: 5px;
	margin-right: 5px;
	vertical-align: middle;
	border: 1px solid #003399;
	background-color: #003399;
	border-radius: 1em;
}
.headWrapper .headWrapperInner .myNoticeBoard .innerBottom ul li div.readCheck .check.r {
	background-color: white;
}
.headWrapper .headWrapperInner .myNoticeBoard .innerBottom ul li div.content {
}
.headWrapper .headWrapperInner .myNoticeBoard .innerBottom ul li div.content .info1 {
	width: 210px;
	margin-bottom: 3px;
	white-space: nowrap;
	text-overflow: ellipsis;
	overflow: hidden;
	font-size: 9pt;
}
.headWrapper .headWrapperInner .myNoticeBoard .innerBottom ul li div.content .info1 a {
	text-decoration: none;
	color: black;
	cursor: pointer;
}
.headWrapper .headWrapperInner .myNoticeBoard .innerBottom ul li div.content .info1 a.r {
	color: gray;
}
.headWrapper .headWrapperInner .myNoticeBoard .innerBottom ul li div.content .info2 {
	font-size: 8pt;
	color: gray;
}
.headWrapper .headWrapperInner .myNoticeBoard .innerBottom ul li div.content .info2 span.way {
	border-right: 1px solid #D5D5D5;
	padding-right: 5px;
}
.headWrapper .headWrapperInner .myNoticeBoard .innerBottom ul li div.content .info2 span.regDate {
	padding-left: 5px;
}
.headWrapper .headWrapperInner .myNoticeBoard .innerBottom ul li div.delete {
	float: right;
	line-height: 30px;
	color: #D5D5D5;
	cursor: pointer;
}
.headWrapper .headWrapperInner .myNoticeBoard .innerBottom ul li div.delete:hover {
	color: gray;
}
.headWrapper .headWrapperInner .headWrapperLeft {
	flex-grow: 0;
	height: 80px;
	line-height: 115px;
}
.headWrapper .headWrapperInner .headWrapperCenter {
	position: relative;
	display: flex;
	flex-grow: 1;
}
.headWrapper .headWrapperInner .headWrapperCenter .searchBox {
	width: 412px;
	height: 41px;
	position: relative;
	margin: auto;
}
.headWrapper .headWrapperInner .headWrapperCenter .searchBox .searchBoxInner {
	position: absolute;
}
.headWrapper .headWrapperInner .headWrapperCenter .searchBox .searchBoxInner input {
	width: 365px;
	line-height: 31px;
	margin: 5px;
	border: none;
	outline: 0;
	z-index: 1;
	box-sizing: border-box;
}
.headWrapper .headWrapperInner .headWrapperCenter .searchBox img {
	position: absolute;
	width: 100%;
	height: 100%;
	box-sizing: border-box;
	left: 0;
	z-index: -1;
}
.headWrapper .headWrapperInner .headWrapperCenter .searchBox label {
	position: absolute;
	top: 17%;
	right: 5%;
	cursor: pointer;
}
.headWrapper .headWrapperInner .headWrapperCenter .searchBtn:hover {
	cursor: pointer;
}
.headWrapper .headWrapperInner .headWrapperRight {
	flex-grow: 1;
	text-align: center;
	height: 80px;
	line-height: 80px;
}
.headWrapper .headWrapperInner .headWrapperRight span {
	font-size: 10pt;
}
.headWrapper .headWrapperInner .headWrapperRight span a {
	text-decoration: none;
	color: #4F5C74;
	font-weight: bold;
}
.headWrapper .headWrapperInner .headWrapperRight span a:active {
	color: #003399;
}
.headWrapper .headWrapperInner .headWrapperRight span#tbptalk {
	border-right: 1px solid #D5D5D5;
	padding-right: 5px;
	cursor: pointer;
}
.headWrapper .headWrapperInner .headWrapperRight span#myShop {
	border-right: 1px solid #D5D5D5;
	padding-right: 5px;
}
.headWrapper .headWrapperInner .headWrapperRight span#myNotice {
	cursor: pointer;
}
.headWrapper .headWrapperInner .conversation {
	display: none;
	position: absolute;
	top: 10px;
	right: 23px;
	width: 24px;
	height: 24px;
	line-height: 20px;
	text-align: center;
	font-size: 8pt;
	font-weight: bold;
	color: #003399;
	background-image: url("${pageContext.request.contextPath}/resources/img/main/conversation.png");
	background-repeat: no-repeat;
}
</style>
<div class="headWrapper">
	<div class="headWrapperInner">
		<div class="headWrapperLeft">
			<a href="${pageContext.request.contextPath}/main/index"><img src="${pageContext.request.contextPath}/resources/img/main/logo.png" width="300" height="41"/></a>
		</div>
		<div class="headWrapperCenter">
			<div class="searchBox">
				<div class="searchBoxInner">
					<input id="searchInput" type="text" onkeyup="searchEnter();"/>
				</div>
				<label onclick="searchClick();">&nbsp;&nbsp;&nbsp;</label>
				<img id="searchImg" src="${pageContext.request.contextPath}/resources/img/main/search2_before(1).png"/>
			</div>
		</div>
		<div class="headWrapperRight">
			<c:if test="${not empty sessionScope.loginCheck}">				
				<span id="tbptalk" onclick="tbptalk();"><a>TBP TALK</a></span>
				<span id="myShop"><a href="${pageContext.request.contextPath}/shop/${sessionScope.memberNo}">상점</a></span>
				<span id="myNotice"><a>알림</a></span>
			</c:if>
		</div>
		<div class="conversation"></div>
		<div class="myNoticeBoard">
			<div class="innerTop">
				<span class="left">전체 알림(<span id="noticeCount">0</span>)</span><span id="deleteNoticeAll" class="right">읽은 알림 삭제</span>
			</div>
			<div class="innerBottom">
			<div class="confirmPanel">
				<div class="confirmBox">
					<div class="top">
						<div class="cancle">X</div>
					</div>
					<div class="middle">
						알림을 모두 삭제하시겠습니까?
					</div>
					<div class="bottom">
						<div id="deleteOk" class="bottomBtn">삭제</div><div id="deleteCancle" class="bottomBtn">취소</div>
					</div>					
				</div>
			</div>
				<ul id="notices">
				</ul>
			</div>
		</div>
	</div>
</div>