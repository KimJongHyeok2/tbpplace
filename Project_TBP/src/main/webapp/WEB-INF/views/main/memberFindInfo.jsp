<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TBP - 아이디/비밀번호 찾기</title>
<jsp:include page="/resources/include/combineScript.jsp"/>
<script type="text/javascript">
$(document).ready(function() {
	$("#findIdTab").click(function() {
		$(".thead_td").removeClass("active");
		$(this).addClass("active");
		$("#findPw").removeClass("on");
		$("#findId").addClass("on");
		$("#findIdTab").css("border-right", "1px solid #003399");
		$(".title").html("아이디 찾기");
		$(".resultBox").remove();
	});
	$("#findPwTab").click(function() {
		$(".thead_td").removeClass("active");
		$(this).addClass("active");
		$("#findId").removeClass("on");
		$("#findPw").addClass("on");
		$("#findIdTab").css("border-right", "none");
		$(".title").html("비밀번호 찾기");
		$(".resultBox").remove();
	});
	$(".content ul li").click(function() {
		$(this).find("div.type").slideToggle(300);
	});
	$(".content ul li input, .checkBtn, #checkVal").click(function(e) {
		e.stopPropagation();
	});
	if(${not empty memberId || memberPw}) {
		$(".content").removeClass("on");
		if(${type=='type-1'}) {
			$(".thead_td").removeClass("active");
			$("#findIdTab").addClass("active");
		} else {
			$(".thead_td").removeClass("active");
			$("#findPwTab").addClass("active");			
			$("#findIdTab").css("border-right", "1px solid #003399");
		}
		$(".resultBox").css("display", "block");
	}
});
function checkEnter(type) {
	if(event.keyCode==13) {
		if(type == "type-1") {
			type_1_findId();
		} else if(type == "type-2") {
			type_2_findPw();
		}
	}
}
function type_1_findId() {
	var memberName = $("#type_1_name").val();
	var memberPnum = $("#type_1_pnum").val();
	var name_RegExp = /^([가-힣]{2,10})$/;
	var pnum_RegExp = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})([0-9]{3,4})([0-9]{4})$/;

	var nameFlag = false;
	var pnumFlag = false;

	if(name_RegExp.test(memberName)) {
		nameFlag = true;
	} else {
		$("#checkVal").css("display", "block");
		$("#checkVal").html("이름이 올바르지 않습니다.");
		nameFlag = false;
		return false;
	}
	if(pnum_RegExp.test(memberPnum)) {
		memberPnum = memberPnum.replace(/^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?([0-9]{3,4})-?([0-9]{4})$/, "$1-$2-$3");
		pnumFlag = true;
	} else {
		$("#checkVal").css("display", "block");
		$("#checkVal").html("휴대폰 번호가 올바르지 않습니다.");
		pnumFlag = false;
		return false;
	}

	if(nameFlag && pnumFlag) {
		$.ajax({
			url: "${pageContext.request.contextPath}/member/checkInfo",
			type: "POST",
			cache: false,
			data: {
				"memberName" : memberName,
				"memberPnum" : memberPnum,
				"type" : "type-1"
			},
			success: function(data, status) {
				if(data == "Ok") {
					$("#memberName").val(memberName);
					$("#memberPnum").val(memberPnum);
					$("#type").val("type-1");
					$("#find_Form").submit();
				} else {
					$("#checkVal").css("display", "block");
					$("#checkVal").html("존재하지 않는 회원정보입니다.");
				}
			}
		});
	}
}
function type_2_findPw() {
	var memberId = $("#type_2_id").val();
	var memberName = $("#type_2_name").val();
	var memberPnum = $("#type_2_pnum").val();
	var id_RegExp = /^([a-zA-Z\d]{6,10})$/;
	var name_RegExp = /^([가-힣]{2,10})$/;
	var pnum_RegExp = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})([0-9]{3,4})([0-9]{4})$/;

	var idFlag = false;
	var nameFlag = false;
	var pnumFlag = false;
	
	if(id_RegExp.test(memberId)) {
		idFlag = true;
	} else {
		$("#checkVal2").css("display", "block");
		$("#checkVal2").html("아이디 형식이 올바르지 않습니다.");
		idFlag = false;
		return false;
	}
	if(name_RegExp.test(memberName)) {
		nameFlag = true;
	} else {
		$("#checkVal2").css("display", "block");
		$("#checkVal2").html("이름이 올바르지 않습니다.");
		nameFlag = false;
		return false;
	}
	if(pnum_RegExp.test(memberPnum)) {
		memberPnum = memberPnum.replace(/^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?([0-9]{3,4})-?([0-9]{4})$/, "$1-$2-$3");
		pnumFlag = true;
	} else {
		$("#checkVal2").css("display", "block");
		$("#checkVal2").html("휴대폰 번호가 올바르지 않습니다.");
		pnumFlag = false;
		return false;
	}


	if(idFlag && nameFlag && pnumFlag) {
		$.ajax({
			url: "${pageContext.request.contextPath}/member/checkInfo",
			type: "POST",
			cache: false,
			data: {
				"memberId" : memberId,
				"memberName" : memberName,
				"memberPnum" : memberPnum,
				"type" : "type-2"
			},
			success: function(data, status) {
				if(data == "Ok") {
					$("#memberId").val(memberId);
					$("#memberName").val(memberName);
					$("#memberPnum").val(memberPnum);
					$("#type").val("type-2");
					$("#find_Form").submit();
				} else {
					$("#checkVal2").css("display", "block");
					$("#checkVal2").html("존재하지 않는 회원정보입니다.");
				}
			}
		});
	}
}
</script>
<style type="text/css">
* { font-family: "나눔고딕"; }
.title {
	height: 50px;
	line-height: 50px;
	text-align: center;
	font-size: 15pt;
	background-color: rgba(246, 246, 246, 0.8);
}
.contentWrapper {
	padding: 10px;
}
.contentWrapper table {
	width: 100%;
	border-collapse: collapse;
	margin: auto;
}
.contentWrapper table thead tr td.thead_td {
	width: 50%;
	padding: 15px;
	text-align: center;
	border: 1px solid #D5D5D5;
	border-bottom: 1px solid #003399;
	background-color: rgba(246, 246, 246, 0.4);
	cursor: pointer;
}
.contentWrapper table thead tr .thead_td.none {
	border-right: none;
}
.contentWrapper table thead tr .thead_td.active {
	border: 1px solid #003399;
	border-bottom: 1px solid white;
	background-color: white;
}
.contentWrapper table tbody tr td .content {
	display: none;
}
.contentWrapper table tbody tr td .content.on {
	display: block;
	margin-top: 10px;
}
.contentWrapper table tbody tr td .content.on ul {
	list-style-type: none;
	margin: 0;
	padding: 0;
	overflow: hidden;
}
.contentWrapper table tbody tr td .content.on ul li {
	padding: 15px;
	border: 1px solid #D5D5D5;
	cursor: pointer;
}
.contentWrapper table tbody tr td .content.on ul li .type {
	display: none;
	margin-top: 10px;
}
.contentWrapper table tbody tr td .content.on ul li .type .labelBox {
	margin-bottom: 10px;
}
.contentWrapper table tbody tr td .content.on ul li .type .labelBox label {
	display: none;
	font-size: 10pt;
	color: #F15F5F;
}
.contentWrapper table tbody tr td .content.on ul li .type .inputBox {
	margin-bottom: 10px;
}
.contentWrapper table tbody tr td .content.on ul li .type .inputBox input {
	width: 100%;
	height: 35px;
	outline: 0;
	border: 1px solid #D5D5D5;
	box-sizing: border-box;
}
.contentWrapper table tbody tr td .content.on ul li .type .inputBox input:hover {
	border-color: #003399;
}
.contentWrapper table tbody tr td .content.on ul li .type .inputBox input:focus {
	border-color: #003399;
}
.contentWrapper table tbody tr td .content.on ul li .type .checkBtn {
	padding: 10px;
	text-align: center;
	border: 1px solid #003399;
	background-color: #003399;
	transition-property: opacity;
	transition-duration: 0.5s;
	color: white;
}
.contentWrapper table tbody tr td .content.on ul li .type .checkBtn:hover {
	opacity: 0.5;
}
.contentWrapper table tbody tr td .resultBox {
	display: none;
	padding: 15px;
	margin-top: 10px;
	border: 1px solid #D5D5D5;
}
.contentWrapper table tbody tr td .resultBox .resultTitle {
	padding-bottom: 5px;
	border-bottom: 1px solid #D5D5D5;
}
.contentWrapper table tbody tr td .resultBox .resultContent {
	padding: 10px 0;
	font-weight: bold;
}
.contentWrapper table tbody tr td .resultBox .close {
	padding: 10px;
	text-align: center;
	border: 1px solid #003399;
	background-color: #003399;
	transition-property: opacity;
	transition-duration: 0.5s;
	color: white;
	cursor: pointer;
}
.contentWrapper table tbody tr td .resultBox .close:hover {
	opacity: 0.5;
}
</style>
</head>
<body>
<div class="title">아이디 찾기</div>
<div class="contentWrapper">
<table>
	<thead>
		<tr>
			<td id="findIdTab" class="thead_td ${param.find=='id'? 'active':'none'}">아이디 찾기</td><td id="findPwTab" class="thead_td ${param.find=='pw'? 'active':''}">비밀번호 찾기</td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td colspan="2">
			<div class="content ${param.find=='id'? 'on':''}" id="findId">
				<ul>
					<li>
						등록된 휴대폰 번호로 찾기
						<div class="type">
							<div class="inputBox">
								<input type="text" id="type_1_name" name="type_1_name" onkeyup="checkEnter('type-1');" placeholder="이름"/>
							</div>
							<div class="inputBox">
								<input type="text" id="type_1_pnum" name="type_1_pnum" onkeyup="checkEnter('type-1');" placeholder="휴대폰 번호(-없이 입력)"/>
							</div>
							<div class="labelBox">
								<label id="checkVal"></label>
							</div>
							<div class="checkBtn" onclick="type_1_findId();">확인</div>
						</div>
					</li>
				</ul>
			</div>
			<div class="content ${param.find=='pw'? 'on':''}" id="findPw">
				<ul>
					<li>
						등록된 휴대폰 번호로 찾기
						<div class="type">
							<div class="inputBox">
								<input type="text" id="type_2_id" name="type_2_id" onkeyup="checkEnter('type-2');" placeholder="아이디"/>
							</div>
							<div class="inputBox">
								<input type="text" id="type_2_name" name="type_2_name" onkeyup="checkEnter('type-2');" placeholder="이름"/>
							</div>
							<div class="inputBox">
								<input type="text" id="type_2_pnum" name="type_2_pnum" onkeyup="checkEnter('type-2');" placeholder="휴대폰 번호(-없이 입력)"/>
							</div>
							<div class="labelBox">
								<label id="checkVal2"></label>
							</div>
							<div class="checkBtn" onclick="type_2_findPw();">확인</div>
						</div>
					</li>
				</ul>
			</div>
			<form action="memberFindInfo" id="find_Form" method="post">
				<input type="hidden" id="memberId" name="memberId"/>
				<input type="hidden" id="memberName" name="memberName"/>
				<input type="hidden" id="memberPnum" name="memberPnum"/>
				<input type="hidden" id="type" name="type"/>
			</form>
			<div class="resultBox">
				<div class="resultTitle">${param.type=='type-1'? '아이디':'비밀번호'} 찾기 결과</div>
				<div class="resultContent">
					${param.type=='type-1'? memberId:memberPw}
				</div>
				<div class="close" onclick="window.close();">닫기</div>
			</div>
			</td>
		</tr>
	</tbody>
</table>
</div>
</body>
</html>