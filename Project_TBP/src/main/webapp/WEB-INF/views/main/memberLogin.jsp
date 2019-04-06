<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TBP PLACE - 로그인</title>
<jsp:include page="/resources/include/combineScript.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/memberLogin.css"/>
<script type="text/javascript">
$(document).ready(function() {
	$("#tbpLogin").click(function() {
		loginOk();
	});
	$("#naverLogin").click(function() {
		$(".loginCheckPanel").css("display", "block");
		$("#loginText").html("준비 중인 기능입니다.");
		$(".loginCheckBtn").attr("onclick", "$('.loginCheckPanel').css('display', 'none')");
	});
	$("#kakaoLogin").click(function() {
		$(".loginCheckPanel").css("display", "block");
		$("#loginText").html("준비 중인 기능입니다.");
		$(".loginCheckBtn").attr("onclick", "$('.loginCheckPanel').css('display', 'none')");
	});
});
function enterLogin() {
	if(event.keyCode == 13) {
		loginOk();
	}
}
function loginOk() {
	var inputId = $("#id").val();
	var inputPw = $("#pw").val();
	
	var idFlag = false;
	var pwFlag = false;
	
	if(inputId == null || inputId.length == 0) {
		$(".loginCheckPanel").css("display", "block");
		$("#loginText").html("아이디를 입력해주세요.");
		$(".loginCheckBtn").attr("onclick", "$('.loginCheckPanel').css('display', 'none')");
		return false;
	} else {
		idFlag = true;
	}
	if(inputPw == null || inputPw.length == 0) {
		$(".loginCheckPanel").css("display", "block");
		$("#loginText").html("비밀번호를 입력해주세요.");
		$(".loginCheckBtn").attr("onclick", "$('.loginCheckPanel').css('display', 'none')");
		return false;
	} else {
		pwFlag = true;
	}
	
	if(idFlag && pwFlag) {
		$.ajax({
			url: "${pageContext.request.contextPath}/member/loginOk",
			type: "POST",
			cache: false,
			data: {
				"id" : inputId,
				"pw" : inputPw
			},
			success: function(data, status) {	
				if(status == "success") {
					if(data == "Ok") {
						location.href = "index";
					} else if(data != "Fail") {
						location.href = data;							
					} else {
						$(".loginCheckPanel").css("display", "block");
						$("#loginText").html("아이디 또는 비밀번호를 확인해주세요.");
						$(".loginCheckBtn").attr("onclick", "$('.loginCheckPanel').css('display', 'none')");
					}
				}
			}
		});
	}
}
function openFindInfo(type) {
	if(type == "type-1") {		
		var pop = window.open("memberFindInfo?find=id","pop","width=570,height=500, scrollbars=yes, resizable=yes");
	} else if(type == "type-2") {
		var pop = window.open("memberFindInfo?find=pw","pop","width=570,height=500, scrollbars=yes, resizable=yes");
	}
}
</script>
</head>
<body>
<jsp:include page="/resources/include/header/otherHeader.jsp"/>
<div class="loginWrapper">
	<div class="loginWrapperInner">
		<table>
			<tr>
				<td><input type="text" id="id" placeholder="아이디" onkeyup="enterLogin();" autofocus/></td>
			</tr>
			<tr>
				<td><input type="password" id="pw" placeholder="비밀번호" onkeyup="enterLogin();"/></td>
			</tr>
			<tr>
				<td><div id="tbpLogin" class="loginBtn">로그인</div></td>
			</tr>
			<tr>
				<td><hr></td>
			</tr>
			<tr>
				<td><img id="naverLogin" src="${pageContext.request.contextPath}/resources/img/login/naver_login.png" width="298" height="64"/></td>
			</tr>
			<tr>
				<td><img id="kakaoLogin" src="${pageContext.request.contextPath}/resources/img/login/kakao_login.png" width="298" height="64"/></td>
			</tr>
			<tr>
				<td><div class="find" onclick="openFindInfo('type-1');">아이디 찾기</div><div class="find" onclick="openFindInfo('type-2');">비밀번호 찾기</div></td>
			</tr>
		</table>
	</div>
	<div class="loginCheckPanel">
		<div class="loginCheck">
			<div id="loginText"></div>
			<div class="loginCheckBtn">확인</div>
		</div>
	</div>
</div>
<jsp:include page="/resources/include/footer/mainFooter.jsp"/>
</body>
</html>