<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TBP PLACE - 약관동의</title>
<jsp:include page="/resources/include/combineScript.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/memberClause.css"/>
<script type="text/javascript">
$(document).ready(function() {
	// TBP PLACE 회원가입 탭
	$("#tbpJoin").click(function() {
		$("#tbpJoin").addClass("active");
		$("#tbpJoinContent").addClass("on");
		$("#naverJoin").removeClass("active");
		$("#kakaoJoin").removeClass("active");
		$("#naverJoinContent").removeClass("on");
		$("#kakaoJoinContent").removeClass("on");
	});
	// 네이버 회원가입 탭
	$("#naverJoin").click(function() {
		$("#naverJoin").addClass("active");
		$("#naverJoinContent").addClass("on");
		$("#tbpJoin").removeClass("active");
		$("#kakaoJoin").removeClass("active");
		$("#tbpJoinContent").removeClass("on");
		$("#kakaoJoinContent").removeClass("on");
	});
	// 카카오 회원가입 탭
	$("#kakaoJoin").click(function() {
		$("#kakaoJoin").addClass("active");
		$("#kakaoJoinContent").addClass("on");
		$("#tbpJoin").removeClass("active");
		$("#naverJoin").removeClass("active");
		$("#tbpJoinContent").removeClass("on");
		$("#naverJoinContent").removeClass("on");
	});
	var checkAll = true;
	// checkbox : 전체선택
	$("#joinCheckAll").click(function() {
		if(checkAll) {
			var checkedAll = $("input[type=checkbox]");
			for(var i=0; i<checkedAll.length; i++) {
				checkedAll[i].checked = true;
			}
			$("#joinCheckAll_Img").attr("src", "${pageContext.request.contextPath}/resources/img/join/check2.jpg");
			$("#joinCheck1_Img").attr("src", "${pageContext.request.contextPath}/resources/img/join/check2.jpg");
			$("#joinCheck2_Img").attr("src", "${pageContext.request.contextPath}/resources/img/join/check2.jpg");
			$("#joinCheck3_Img").attr("src", "${pageContext.request.contextPath}/resources/img/join/check2.jpg");
			$("#joinCheck4_Img").attr("src", "${pageContext.request.contextPath}/resources/img/join/check2.jpg");
		} else {	
			var checkedAll = $("input[type=checkbox]");
			for(var i=0; i<checkedAll.length; i++) {
				checkedAll[i].checked = false;
			}
			$("#joinCheckAll_Img").attr("src", "${pageContext.request.contextPath}/resources/img/join/check1.jpg");
			$("#joinCheck1_Img").attr("src", "${pageContext.request.contextPath}/resources/img/join/check1.jpg");
			$("#joinCheck2_Img").attr("src", "${pageContext.request.contextPath}/resources/img/join/check1.jpg");
			$("#joinCheck3_Img").attr("src", "${pageContext.request.contextPath}/resources/img/join/check1.jpg");
			$("#joinCheck4_Img").attr("src", "${pageContext.request.contextPath}/resources/img/join/check1.jpg");
		}
		checkAll = !checkAll;
	});
	// checkbox : 1
	$("#joinCheck1").click(function() {
 		if($("input[id=joinCheck1]:checked").length == 1) {
			$("#joinCheck1_Img").attr("src", "${pageContext.request.contextPath}/resources/img/join/check2.jpg");
		} else {
			$("#joinCheck1_Img").attr("src", "${pageContext.request.contextPath}/resources/img/join/check1.jpg");
		}
	});
	// checkbox : 2
	$("#joinCheck2").click(function() {
 		if($("input[id=joinCheck2]:checked").length == 1) {
			$("#joinCheck2_Img").attr("src", "${pageContext.request.contextPath}/resources/img/join/check2.jpg");
		} else {
			$("#joinCheck2_Img").attr("src", "${pageContext.request.contextPath}/resources/img/join/check1.jpg");
		}
	});
	// checkbox : 3
	$("#joinCheck3").click(function() {
 		if($("input[id=joinCheck3]:checked").length == 1) {
			$("#joinCheck3_Img").attr("src", "${pageContext.request.contextPath}/resources/img/join/check2.jpg");
		} else {
			$("#joinCheck3_Img").attr("src", "${pageContext.request.contextPath}/resources/img/join/check1.jpg");
		}
	});
	// checkbox : 4
	$("#joinCheck4").click(function() {
 		if($("input[id=joinCheck4]:checked").length == 1) {
			$("#joinCheck4_Img").attr("src", "${pageContext.request.contextPath}/resources/img/join/check2.jpg");
		} else {
			$("#joinCheck4_Img").attr("src", "${pageContext.request.contextPath}/resources/img/join/check1.jpg");
		}
	});
});
// 약관동의 여부 확인
function joinAgreeCheck() {
	var joinChecked = $("input[type=checkbox]:checked");
	var joinCheck1 = $("input[id=joinCheck1]:checked").length;
	var joinCheck2 = $("input[id=joinCheck2]:checked").length;
	var joinCheck3 = $("input[id=joinCheck3]:checked").length;
	var joinCheck4 = $("input[id=joinCheck4]:checked").length;
	
	if(!(joinChecked.length >= 3 && joinCheck1 == 1 && joinCheck2 == 1 && joinCheck3 == 1 && joinCheck4 == 1)) {
		$(".joinText").html("가입 진행을 위해 약관에 모두 동의해주세요.");
		$("#joinOkPanel").css("display", "block");
		$("#tbpJoinCheckBtn").attr("onclick", "$('#joinOkPanel').css('display', 'none')");
	} else {
		var checkedAll = $("input[type=checkbox]");
		for(var i=0; i<checkedAll.length; i++) {
			checkedAll[i].checked = false;
		}
		$(".joinText").html("회원정보 입력 페이지로 이동합니다.");
		$("#joinOkPanel").css("display", "block");
		$("#tbpJoinCheckBtn").attr("onclick", "$('#clauseOk').submit();");
	}
}
</script>
</head>
<body>
<jsp:include page="/resources/include/header/joinHeader.jsp"/>
<div class="joinSection">
	<div class="joinSectionInner">
			<div class="joinSectionBottom">
				<div class="joinSectionBottomInner">
					<span>환영합니다!</span><br><br>
					간단한 가입만으로 TBP PLACE의 다양한 서비스를 만나보세요.
				</div>
			</div>
			<div class="joinSectionTop">
				<table>
					<tr>
						<td colspan="3">
							<span id="jf3">가입완료</span>
							<span id="jf2">정보입력</span>
							<span id="jf1" class="active">가입 및 약관동의</span>
						</td>
					</tr>
					<tr>
						<th id="tbpJoin" class="active">TBP PLACE</th><th id="naverJoin">네이버</th><th id="kakaoJoin">카카오</th>
					</tr>
					<tr>
						<td class="contentBorder" colspan="3">
							<div class="joinSectionTopInner">
								<div id="tbpJoinContent" class="on">
									<div class="tbpJoinContentTop">
										<form action="memberJoin" id="clauseOk" method="post">
											<div class="allCheckBox">
												<input type="checkbox" id="joinCheckAll" value="clauseAll" />
												<label for="joinCheckAll"><img id="joinCheckAll_Img" src="${pageContext.request.contextPath}/resources/img/join/check1.jpg"/></label>
												<div class="checkBoxText">&nbsp;전체선택</div>
											</div>
											<hr style="border: 1px solid #D5D5D5;">
											<div class="allCheckBox">
												<input type="checkbox" name="joinCheck" id="joinCheck1" value="clause1"/>
												<label for="joinCheck1"><img id="joinCheck1_Img" src="${pageContext.request.contextPath}/resources/img/join/check1.jpg"/></label>
												<div class="checkBoxText">&nbsp;구매회원 이용약관 <a href="#">(내용보기)</a></div>
											</div>
											<div class="allCheckBox">
												<input type="checkbox" name="joinCheck" id="joinCheck2" value="clause2"/>
												<label for="joinCheck2"><img id="joinCheck2_Img" src="${pageContext.request.contextPath}/resources/img/join/check1.jpg"/></label>
												<div class="checkBoxText">&nbsp;판매회원 이용약관 <a href="#">(내용보기)</a></div>
											</div>
											<div class="allCheckBox">
												<input type="checkbox" name="joinCheck" id="joinCheck3" value="clause3"/>
												<label for="joinCheck3"><img id="joinCheck3_Img" src="${pageContext.request.contextPath}/resources/img/join/check1.jpg"/></label>
												<div class="checkBoxText">&nbsp;전자금융서비스 이용약관 <a href="#">(내용보기)</a></div>
											</div>
											<div class="allCheckBox">
												<input type="checkbox" name="joinCheck" id="joinCheck4" value="clause4"/>
												<label for="joinCheck4"><img id="joinCheck4_Img" src="${pageContext.request.contextPath}/resources/img/join/check1.jpg"/></label>
												<div class="checkBoxText">&nbsp;개인정보 수집 및 이용 <a href="#">(내용보기)</a></div>
											</div>
											<input type="hidden" name="clauseCheck" id="clauseCheck" value="Ok"/>
										</form>
									</div>
									<div class="tbpJoinContentBottom">
										<div id="tbpJoinBtn" onclick="joinAgreeCheck();">다음</div>
										<div id="joinOkPanel">
											<div id="joinOk">
												<div class="joinText"></div>
												<div id="tbpJoinCheckBtn">확인</div>
											</div>
										</div>
									</div>
								</div>
								<div id="naverJoinContent">준비 중</div>
								<div id="kakaoJoinContent">준비 중</div>
							</div>
						</td>
					</tr>
				</table>
			</div>
	</div>
</div>
<jsp:include page="/resources/include/footer/mainFooter.jsp"/>
</body>
</html>