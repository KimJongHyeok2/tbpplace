<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style type="text/css">
.footerWrapper {
	font-family: "나눔고딕";
	font-size: 10pt;
	color: gray;
}
.footerWrapper .footerWrapperMenu {
	border-top: 1px solid #D5D5D5;
	border-bottom: 1px solid #D5D5D5;
	text-align: center;
	background-color: #F6F6F6;
}
.footerWrapper .footerWrapperMenu .footerWrapperMenuInner {
	width: 1000px;
	margin: auto;
}
.footerWrapper .footerWrapperMenu .footerWrapperMenuInner ul {
	list-style-type: none;
	margin: 0;
	padding: 15px 15px;
	text-align: center;
}
.footerWrapper .footerWrapperMenu .footerWrapperMenuInner li {
	display: inline-block;
}
.footerWrapper .footerWrapperMenu .footerWrapperMenuInner li:not(#lastMenu) {
	border-right: 1px solid #D5D5D5;
	padding-right: 5px;
}
.footerWrapper .footerWrapperMenu .footerWrapperMenuInner li a:hover {
	text-decoration: underline;
	color: #003399;
	cursor: pointer;
}
.footerWrapper .footerWrapperInfo {

	position: relative;
	width: 1000px;
	height: 300px;
	margin: auto;
}
.footerWrapper .footerWrapperInfo .footerWrapperInfoContent {
	position: absolute;
	left: 50%;
	transform: translateX(-50%);
	bottom: 0;
}
</style>
<div class="footerWrapper">
	<div class="footerWrapperMenu">
		<div class="footerWrapperMenuInner">
			<ul>
				<li><a>개인 프로젝트</a></li>
				<li><a>이용약관</a></li>
				<li id="lastMenu"><a>개인정보처리방침</a></li>
			</ul>
		</div>
	</div>
	<div class="footerWrapperInfo">
		<div class="footerWrapperInfoContent">
		김종혁 proje_ct@naver.com
		<!-- Copyright © 2019 김종혁(혼자만듬) All Rights Reserved. -->
		</div>
	</div>
</div>