<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style type="text/css">
.joinHeadWrapper {
	margin-top: 20px;
	margin-bottom: 20px;
}
.joinHeadWrapper .joinHeadWrapperInner {
	width: 1000px;
	margin: auto;
}
.joinHeadWrapper .joinHeadWrapperInner .joinLogo {
	font-size: 30pt;
}
.joinHeadWrapper .joinHeadWrapperInner hr#joinHeadHr {
	border: 1px solid #D5D5D5;
}
</style>
<div class="joinHeadWrapper">
	<div class="joinHeadWrapperInner">
		<a href="${pageContext.request.contextPath}/main/index"><img src="${pageContext.request.contextPath}/resources/img/join/joinLogo.png" width="300" height="30"/></a>
		<hr id="joinHeadHr">
	</div>
</div>