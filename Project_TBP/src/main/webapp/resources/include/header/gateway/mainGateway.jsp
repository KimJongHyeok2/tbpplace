<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(document).ready(function() {
	if(${not empty loginCheck}) {
		moneyFormat();
	}
/* 	$("#myPageMini").mouseenter(function() {
 		$(".simpleMyInfoWrapper").slideToggle();
	});
	$("#myPageMini").mouseleave(function() {
 		$(".simpleMyInfoWrapper").slideToggle();
	}); */
});
function infoView() {
	document.getElementsByClassName("simpleMyInfoWrapper")[0].style.display = "block";
}
function infoHide() {
	document.getElementsByClassName("simpleMyInfoWrapper")[0].style.display = "none";
}
function moneyFormat() {
	var myMoney = $(".myMoney").html();
	myMoney = myMoney.replace(/\B(?=(\d{3})+(?!\d))/g,",") + "원";
	$(".myMoney").html(myMoney);
}
</script>
<style type="text/css">
.gatewayWrapper {
	border-top: 1px solid #D5D5D5;
	background-color: #F6F6F6;
	font-family: "나눔고딕";
	font-size: 10pt;
}
.gatewayWrapper .gatewayWrapperInner {
	width: 1000px;
	margin: 0 auto;
}
.gatewayWrapper .gatewayWrapperInner:after {
  	content: "";
  	display: block;
 	clear: both;
}
.gatewayWrapper .gatewayWrapperInner .gatewayWrapperLeft {
	float: left;
}
.gatewayWrapper .gatewayWrapperInner .gatewayWrapperLeft a.active {
	font-weight: bold;
	color: #003399;
	background-color: white;
}
.gatewayWrapper .gatewayWrapperInner .gatewayWrapperLeft a {
	text-decoration: none;
	color: gray;
}
.gatewayWrapper .gatewayWrapperInner .gatewayWrapperLeft ul {
	list-style-type: none;
	margin: 0;
	padding: 0;
}
.gatewayWrapper .gatewayWrapperInner .gatewayWrapperLeft li {
	float: left;
	text-align: center;
}
.gatewayWrapper .gatewayWrapperInner .gatewayWrapperLeft li:first-child {
	border-left: 1px solid #D5D5D5;
}
.gatewayWrapper .gatewayWrapperInner .gatewayWrapperLeft a {
	display: block;
	width: 80px;
	border-right: 1px solid #D5D5D5;
	padding: 10px 10px;
}
.gatewayWrapper .gatewayWrapperInner .gatewayWrapperLeft a:hover:not(.active) {
	text-decoration: underline;
	color: #003399;
}
.gatewayWrapper .gatewayWrapperInner .gatewayWrapperRight {
	float: right;
}
.gatewayWrapper .gatewayWrapperInner .gatewayWrapperRight ul {
	list-style-type: none;
	margin: 0;
	padding: 0;
}
.gatewayWrapper .gatewayWrapperInner .gatewayWrapperRight li {
	float: left;
	text-align: center;
}
.gatewayWrapper .gatewayWrapperInner .gatewayWrapperRight li#myPage {
	position: relative;
}
.gatewayWrapper .gatewayWrapperInner .gatewayWrapperRight a {
	display: block;
	width: 80px;
	padding: 10px 0px;
	text-decoration: none;
	color: gray;
}
.gatewayWrapper .gatewayWrapperInner .gatewayWrapperRight li .simpleMyInfoWrapper {
	display: none;
	position: absolute;
	left: -100%;
	background-color: white; 
 	box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.1);
	z-index: 1;
}
.gatewayWrapper .gatewayWrapperInner .gatewayWrapperRight li .simpleMyInfoWrapper table {
	width: 250px;
	border-collapse: collapse;	
}
.gatewayWrapper .gatewayWrapperInner .gatewayWrapperRight li .simpleMyInfoWrapper td {
	border: 1px solid #D5D5D5;
}
.gatewayWrapper .gatewayWrapperInner .gatewayWrapperRight li .simpleMyInfoWrapper td.myInfo1 {
	width: 70px;
}
.gatewayWrapper .gatewayWrapperInner .gatewayWrapperRight li .simpleMyInfoWrapper td.myInfo2 {
	width: 150px;
}
.gatewayWrapper .gatewayWrapperInner .gatewayWrapperRight li .simpleMyInfoWrapper td.myInfo2 div {
	margin: 5px;
}
.gatewayWrapper .gatewayWrapperInner .gatewayWrapperRight li .simpleMyInfoWrapper td.myInfo2 .gradeBox {
	text-align: center;
}
.gatewayWrapper .gatewayWrapperInner .gatewayWrapperRight li .simpleMyInfoWrapper td.myInfo2 .gradeBox .grade {
	display: inline-block;
	width: 30px;
	height: 30px;
}
.gatewayWrapper .gatewayWrapperInner .gatewayWrapperRight li .simpleMyInfoWrapper td.myInfo2 .gradeBox .grade img {
	width: 100%;
	height: 100%;
}
.gatewayWrapper .gatewayWrapperInner .gatewayWrapperRight a:hover {
	text-decoration: underline;
	color: #003399;
}
</style>
<div class="gatewayWrapper">
	<div class="gatewayWrapperInner">
		<div class="gatewayWrapperLeft">
			<ul>
				<li><a class="active" href="${pageContext.request.contextPath}/main/index">홈</a></li>
<!-- 				<li><a href="#">커뮤니티</a></li> -->
				<c:if test="${sessionScope.memberStatus==5}">
					<li><a href="${pageContext.request.contextPath}/admin/tbpManagement">관리자</a></li>
				</c:if>
			</ul>
		</div>
		<div class="gatewayWrapperRight">
			<ul>
				<c:if test="${empty sessionScope.loginCheck}">
				<li><a href="${pageContext.request.contextPath}/main/memberLogin">로그인</a></li>				
				<li><a href="${pageContext.request.contextPath}/join/memberClause">회원가입</a></li>
				</c:if>
				<c:if test="${!empty sessionScope.loginCheck}">
				<li><a href="${pageContext.request.contextPath}/member/logout">로그아웃</a></li>
				</c:if>
				<li><a href="${pageContext.request.contextPath}/myCart">장바구니</a></li>
				<li id="myPage">
				<c:if test="${empty sessionScope.loginCheck}">
				<a href="${pageContext.request.contextPath}/myPage">마이페이지</a>
				</c:if>
				<c:if test="${!empty sessionScope.loginCheck}">
 				<a href="${pageContext.request.contextPath}/myPage" id="myPageMini" onmouseover="infoView();" onmouseout="infoHide();">마이페이지</a>
<%-- 				<a href="${pageContext.request.contextPath}/myPage" id="myPageMini">마이페이지</a> --%>
					<div id="simpleMyInfoWrapper" class="simpleMyInfoWrapper">
						<table>
							<tr>
								<td class="myInfo1" rowspan="3">${sessionScope.memberName}님</td><td class="myInfo2"><div>TBP페이</div><div class="myMoney">${sessionScope.memberMoney}</div></td>
							</tr>
							<tr>
								<td class="myInfo2"><div>구매등급</div>
								<div>
								<c:choose>
									<c:when test="${sessionScope.memberBgrade==0}">
										<div class="gradeBox">
											<div class="grade"><img src="${pageContext.request.contextPath}/resources/img/grade/beginning.png"/></div>
										</div>
									</c:when>
									<c:when test="${sessionScope.memberBgrade==1}">
										<div class="gradeBox">
											<div class="grade"><img src="${pageContext.request.contextPath}/resources/img/grade/bronze.png"/></div>
										</div>
									</c:when>
									<c:when test="${sessionScope.memberBgrade==2}">
										<div class="gradeBox">
											<div class="grade"><img src="${pageContext.request.contextPath}/resources/img/grade/gold.png"/></div>
										</div>
									</c:when>
									<c:when test="${sessionScope.memberBgrade==3}">
										<div class="gradeBox">
											<div class="grade"><img src="${pageContext.request.contextPath}/resources/img/grade/platinum.png"/></div>
										</div>
									</c:when>
									<c:when test="${sessionScope.memberBgrade==4}">
										<div class="gradeBox">
											<div class="grade"><img src="${pageContext.request.contextPath}/resources/img/grade/master.png"/></div>
										</div>
									</c:when>
									<c:otherwise>
										알 수 없는 오류
									</c:otherwise>
								</c:choose>
								</div>
								</td>
							</tr>
							<tr>
								<td class="myInfo2"><div>판매등급</div>
								<div>
								<c:choose>
									<c:when test="${sessionScope.memberSgrade==0}">
										<div class="gradeBox">
											<div class="grade"><img src="${pageContext.request.contextPath}/resources/img/grade/beginning.png"/></div>
										</div>
									</c:when>
									<c:when test="${sessionScope.memberSgrade==1}">
										<div class="gradeBox">
											<div class="grade"><img src="${pageContext.request.contextPath}/resources/img/grade/bronze.png"/></div>
										</div>
									</c:when>
									<c:when test="${sessionScope.memberSgrade==2}">
										<div class="gradeBox">
											<div class="grade"><img src="${pageContext.request.contextPath}/resources/img/grade/gold.png"/></div>
										</div>
									</c:when>
									<c:when test="${sessionScope.memberSgrade==3}">
										<div class="gradeBox">
											<div class="grade"><img src="${pageContext.request.contextPath}/resources/img/grade/platinum.png"/></div>
										</div>
									</c:when>
									<c:when test="${sessionScope.memberSgrade==4}">
										<div class="gradeBox">
											<div class="grade"><img src="${pageContext.request.contextPath}/resources/img/grade/master.png"/></div>
										</div>
									</c:when>
									<c:otherwise>
										알 수 없는 오류
									</c:otherwise>
								</c:choose>
								</div>
								</td>
							</tr>
						</table>
					</div>
				</c:if>
				</li>
				<li><a href="${pageContext.request.contextPath}/customer/customerService">고객센터</a></li>
			</ul>
		</div>
	</div>
</div>