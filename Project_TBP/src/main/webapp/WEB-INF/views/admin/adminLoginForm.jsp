<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TBP - 관리자 로그인</title>
<jsp:include page="/resources/include/combineScript.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/memberLogin.css"/>
<script type="text/javascript">
$(document).ready(function() {
	$("#tbpLogin").click(function() {
		$("#adminLogin").submit();
	});
	if(${empty sessionScope.loginCheck}) {
		location.href = "${pageContext.request.contextPath}/main/index";
	} else {
		if(${sessionScope.memberStatus != 5}) {
			location.href = "${pageContext.request.contextPath}/main/index";			
		}
	}
});
function enterLogin() {
	if(event.keyCode == 13) {
		$("#adminLogin").submit();
	}
}
</script>
</head>
<body>
<jsp:include page="/resources/include/header/otherHeader.jsp"/>
<c:url value="/auth" var="loginUrl"/>
<form id="adminLogin" action="${loginUrl}" method="post">
<div class="loginWrapper">
	<div class="loginWrapperInner">
		<table>
			<tr>
				<td><span id="t1">TBP</span> PLACE <span id="t2">ADMINISTRATOR LOGIN</span></td>
			</tr>
			<tr>
				<td>
				 <c:if test="${SPRING_SECURITY_LAST_EXCEPTION != null}">
				 	<span id="error"><c:out value="${SPRING_SECURITY_LAST_EXCEPTION.message}"/></span>
				 </c:if>
				</td>
			</tr>
			<tr>
				<td><input type="text" name="j_username" placeholder="아이디" onkeyup="enterLogin();" autofocus/></td>
			</tr>
			<tr>
				<td><input type="password" name="j_password" placeholder="비밀번호" onkeyup="enterLogin();"/></td>
			</tr>
			<tr>
				<td><div id="tbpLogin" class="loginBtn">로그인</div></td>
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
</form>
<jsp:include page="/resources/include/footer/mainFooter.jsp"/>
</body>
</html>