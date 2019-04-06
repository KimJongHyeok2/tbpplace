<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TBP PLACE - 정보입력</title>
<jsp:include page="/resources/include/combineScript.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/memberJoin.css"/>
<script type="text/javascript">
$(document).ready(function() {
	// 각 selectBox 클릭 여부 확인 변수
	var yearClick = 0;
	var monthClick = 0;
	var dayClick = 0;
	var pnumClick = 0;	
	// 년도 선택 selectBox
	$("#selectYear").click(function() {
		if(yearClick == 0) {			
			$("#dropDownYear").css("display", "block");
			$("#dropDownMonth").css("display", "none");
			$("#dropDownDay").css("display", "none");
			yearClick = 1;
		} else {
			$("#dropDownYear").css("display", "none");
			yearClick = 0;
		}
		$("#dropDownYear div").click(function() {
			$("#selectYear").html($(this).html());
			$("#dropDownYear").css("display", "none");
		});
	});
	// 월 선택 selectBox
	$("#selectMonth").click(function() {
		if(monthClick == 0) {		
			$("#dropDownMonth").css("display", "block");
			$("#dropDownYear").css("display", "none");
			$("#dropDownDay").css("display", "none");
			monthClick = 1;
		} else {			
			$("#dropDownMonth").css("display", "none");
			monthClick = 0;
		}
		$("#dropDownMonth div").click(function() {
			$("#selectMonth").html($(this).html());
			$("#dropDownMonth").css("display", "none");
		});
	});
	// 일 선택 selectBox
	$("#selectDay").click(function() {
		if(dayClick == 0) {					
			$("#dropDownDay").css("display", "block");
			$("#dropDownYear").css("display", "none");
			$("#dropDownMonth").css("display", "none");
			dayClick = 1;
		} else {
			$("#dropDownDay").css("display", "none");
			dayClick = 0;
		}
		$("#dropDownDay div").click(function() {
			$("#selectDay").html($(this).html());
			$("#dropDownDay").css("display", "none");
		});
	});
	// 휴대폰 번호 선택 selectBox
	$("#selectPnum").click(function() {
		if(pnumClick == 0) {	
			$("#dropDownPnum").css("display", "block");
			pnumClick = 1;
		} else {			
			$("#dropDownPnum").css("display", "none");
			pnumClick = 0;
		}
		$("#dropDownPnum div").click(function() {
			$("#selectPnum").html($(this).html());
			$("#dropDownPnum").css("display", "none");
		});
	});
	// 이메일 선택 selectBox
	$("#selectEmail").click(function() {
		if(pnumClick == 0) {	
			$("#dropDownEmail").css("display", "block");
			pnumClick = 1;
		} else {			
			$("#dropDownEmail").css("display", "none");
			pnumClick = 0;
		}
		$("#dropDownEmail div").click(function() {
			$("#selectEmail").html($(this).html());
			if($(this).html() == "직접입력") {				
				$("#inputEmail2").val("");
				$("#inputEmail2").removeAttr("disabled");
			} else {				
				$("#inputEmail2").val($(this).html());
				$("#inputEmail2").attr("disabled", "disabled");
			}
			$("#dropDownEmail").css("display", "none");
		});
	});
	// 년/월별 일자를 마우스 영역 인/아웃에 따라 동적으로 변경
	$(".selectBox").mouseenter(function() {
		dayConfig();
	});
	$(".selectBox").mouseleave(function() {
		dayConfig();		
	});
	// 전화번호 정규표현식 마우스 영역 인/아웃에 따라 동적으로 확인
	$("#selectPnum").mouseenter(function() {
		checkPnum();
	});
	$("#selectPnum").mouseleave(function() {
		checkPnum();	
	});
	$("#dropDownPnum").mouseenter(function() {
		checkPnum();
	});
	$("#dropDownPnum").mouseleave(function() {
		checkPnum();	
	});
	// 이메일 정규표현식 마우스 영역 인/아웃에 따라 동적으로 확인
	$("#selectEmail").mouseenter(function() {
		checkEmail();
	});
	$("#selectEmail").mouseleave(function() {
		checkEmail();	
	});
	$("#dropDownEmail").mouseenter(function() {
		checkEmail();
	});
	$("#dropDownEmail").mouseleave(function() {
		checkEmail();	
	});
});
// ContextPath
function getContextPath() {
	var set=location.href.indexOf(location.host)+location.host.length;
	var Path=location.href.substring(set, location.href.indexOf("/", set+1));
	return Path;
}

// 생년월일 선택 selectBox
function dateConfig() {
	var nowDate = new Date();
	var Year = nowDate.getFullYear();
	$("#selectYear").html(Year);
	var Month = eval(nowDate.getMonth())+1;
	$("#selectMonth").html(Month);
	var nowDay = eval(nowDate.getDate());
	$("#selectDay").html(nowDay);
	var startYear = Year-70;
	
	var yearValue = "";
	var monthValue = "";
	for(var i=0; i<=70; i++) {
		yearValue += "<div id=Year"+ i + ">"+ (startYear + i) +"</div>";
	}
	for(var i=0; i<12; i++) {
		monthValue += "<div id=Month"+ i +">" + (i+1) + "</div>";
	}
	
	$("#dropDownYear").html(yearValue);
	$("#dropDownMonth").html(monthValue);
	dayConfig();
}
// 선택한 년/월에 따라 일자 변경
function dayConfig() {
	var Year = $("#selectYear").html();
	var Month = $("#selectMonth").html();
 	var Day = [31,28,31,30,31,30,31,31,30,31,30,31];
	
	if((Year % 4 == 0 && Year % 100 != 0) || Year % 400 == 0) {
		Day[1] = 29;	
	}
	
	var dayValue = "";
	for(var i=0; i<Day[Month-1]; i++) {
		dayValue += "<div id=Day"+ i +">" + (i+1) + "</div>";
	}
	
	$("#dropDownDay").html(dayValue);
	
	var selectDay = $("#selectDay").html();
	if(selectDay > Day[Month-1]) {
		$("#selectDay").html($("#Day"+(Day[Month-1]-1)).html());
	} else {
		$("#selectDay").html($("#Day"+(selectDay-1)).html());		
	}
}
// 정규표현식 Flag 변수
var id_Flag = false;
var pw_Flag = false;
var name_Flag = false;
var gender_Flag = false;
var pnum_Flag = false;
var email_Flag = false;

// 아이디 정규표현식(중복체크 포함)
function checkID() {
	var id = $("#inputID").val();
	var id_Pattern = /^([a-zA-Z\d]{6,10})$/;
	if(new RegExp(id_Pattern).test(id)) {
		idOverlap();
	} else {
		if(id.length == 0) {
			$("#idLabel").css("color", "#F15F5F");
			$("#idLabel").html("아이디를 입력해주세요.");
			$("#checkIMG_ID").attr("src", getContextPath() + "/resources/img/join/before_all.png");
			id_Flag = false;
		} else {
			if(id.length < 6 || id.length > 10) {
				$("#idLabel").css("color", "#F15F5F");
				$("#idLabel").html("아이디는 6자 이상 10자 이하로 입력해주세요.");
				$("#checkIMG_ID").attr("src", getContextPath() + "/resources/img/join/before_all.png");
				id_Flag = false;
			} else {
				$("#idLabel").css("color", "#F15F5F");
				$("#idLabel").html("아이디는 영문 대소문자 또는 숫자만 입력 가능합니다.");
				$("#checkIMG_ID").attr("src", getContextPath() + "/resources/img/join/before_all.png");
				id_Flag = false;
			}	
		}
	}
}
// 아이디 중복체크
function idOverlap() {
	var id = $("#inputID").val();
	$.ajax({
		url: getContextPath() + "/member/idOverlap",
		type: "POST",
		cache: false,
		data: {
			"id" : id
		},
		success: function(data, status) {
			if(status == "success") {
				if(data != "Ok") {
					$("#idLabel").css("color", "#F15F5F");
					$("#idLabel").html("이미 사용 중인 아이디입니다.");
					$("#checkIMG_ID").attr("src", getContextPath() + "/resources/img/join/before_all.png");
					id_Flag = false;
				} else {
					$("#idLabel").css("color", "#003399");
					$("#idLabel").html("사용 가능한 아이디입니다.");
					$("#checkIMG_ID").attr("src", getContextPath() + "/resources/img/join/after_all.png");
					id_Flag = true;
				}
			}
		}
	});
}
// 비밀번호 정규표현식
function checkPW1() {
	var pw1 = $("#inputPW1").val();
	var pw_Pattern = /^(?=.*\d)(?=.*\W)(?=.*[a-zA-Z]).{8,20}$/;
	
		if(new RegExp(pw_Pattern).test(pw1)) {
			$("#pw1Label").css("color", "#003399");
			$("#pw1Label").html("사용 가능한 비밀번호입니다.");
			$("#checkIMG_PW1").attr("src", getContextPath() + "/resources/img/join/after_pw1.png");
		} else {
			if(pw1.length == 0) {
				$("#pw1Label").css("color", "#F15F5F");
				$("#pw1Label").html("비밀번호를 입력해주세요.");
				$("#checkIMG_PW1").attr("src", getContextPath() + "/resources/img/join/before_pw1.png");
			} else {
				if(pw1.length < 8 || pw1.length > 20) {
					$("#pw1Label").css("color", "#F15F5F");
					$("#pw1Label").html("비밀번호는 8자 이상 20자 이하로 입력해주세요.");
					$("#checkIMG_PW1").attr("src", getContextPath() + "/resources/img/join/before_pw1.png");
				} else {
					$("#pw1Label").css("color", "#F15F5F");
					$("#pw1Label").html("비밀번호는 영문 대소문자/숫자/특수문자를 혼합하여 입력해주세요.");
					$("#checkIMG_PW1").attr("src", getContextPath() + "/resources/img/join/before_pw1.png");
				}
			}
		}
}
// 2차 비밀번호 정규표현식
function checkPW2() {
	var pw2 = $("#inputPW2").val();
	var pw_Pattern = /^(?=.*\d)(?=.*\W)(?=.*[a-zA-Z]).{8,20}$/;
	
		if(new RegExp(pw_Pattern).test(pw2) && pw2 == $("#inputPW1").val()) {
			$("#pw2Label").css("color", "#003399");
			$("#pw2Label").html("비밀번호가 일치합니다.");
			$("#checkIMG_PW2").attr("src", getContextPath() + "/resources/img/join/after_pw2.png");
			pw_Flag = true;
		} else {
			if(pw2.length == 0) {
				$("#pw2Label").css("color", "#F15F5F");
				$("#pw2Label").html("비밀번호를 입력해주세요.");
				$("#checkIMG_PW2").attr("src", getContextPath() + "/resources/img/join/before_pw2.png");
				pw_Flag = false;
			} else {
				if(pw2.length < 8 || pw2.length > 20) {
					$("#pw2Label").css("color", "#F15F5F");
					$("#pw2Label").html("비밀번호는 8자 이상 20자 이하로 입력해주세요.");
					$("#checkIMG_PW2").attr("src", getContextPath() + "/resources/img/join/before_pw2.png");
					pw_Flag = false;
				} else {
					if(pw2 != $("#inputPW1").val()) {
						$("#pw2Label").css("color", "#F15F5F");
						$("#pw2Label").html("위의 비밀번호와 일치하지 않습니다.");
						$("#checkIMG_PW2").attr("src", getContextPath() + "/resources/img/join/before_pw2.png");
						pw_Flag = false;
					} else {
						$("#pw2Label").css("color", "#F15F5F");
						$("#pw2Label").html("비밀번호는 영문 대소문자/숫자/특수문자를 혼합하여 입력해주세요.");
						$("#checkIMG_PW2").attr("src", getContextPath() + "/resources/img/join/before_pw2.png");
						pw_Flag = false;
					}
				}
			}
		}
}
// 이름 정규표현식
function checkName() {
	var name = $("#inputName").val();
	var name_Pattern = /^([가-힣]{2,10})$/;
	
	if(new RegExp(name_Pattern).test(name)) {
		$("#nameLabel").css("color", "#003399");
		$("#nameLabel").html("올바른 입력입니다.");
		$("#checkIMG_Name").attr("src", getContextPath() + "/resources/img/join/after_all.png");
		name_Flag = true;
	} else {
		if(name.length == 0) {
			$("#nameLabel").css("color", "#F15F5F");
			$("#nameLabel").html("이름을 입력해주세요.");
			$("#checkIMG_Name").attr("src", getContextPath() + "/resources/img/join/before_all.png");
			name_Flag = false;
		} else {
			if(name.length.length < 2 || name.length > 10) {				
				$("#nameLabel").css("color", "#F15F5F");
				$("#nameLabel").html("이름은 2자 이상 10자 이하로 입력해주세요.");
				$("#checkIMG_Name").attr("src", getContextPath() + "/resources/img/join/before_all.png");
				name_Flag = false;
			} else {				
				$("#nameLabel").css("color", "#F15F5F");
				$("#nameLabel").html("올바른 형식의 이름이 아닙니다.");
				$("#checkIMG_Name").attr("src", getContextPath() + "/resources/img/join/before_all.png");
				name_Flag = false;
			}
		}
	}
}
// 성별 선택 여부 확인
function checkGender() {
	var gender = $("input[type=radio][name=gender]:checked");
	if(gender.length > 0) {
		$("#bgLabel").css("color", "#003399");
		$("#bgLabel").html("올바른 입력입니다.");
		$("#checkIMG_BG").attr("src", getContextPath() + "/resources/img/join/after_all.png");
		gender_Flag = true;
	}
}
// 전화번호 정규표현식
function checkPnum() {
	var pnum = $("#selectPnum").html() + "-" + $("#inputPnum1").val() + "-" + $("#inputPnum2").val();
	var pnum_Pattern = /^[\d]{3}-[\d]{3,4}-[\d]{4}$/;
	
	if($("#selectPnum").html() != "선택") {
		$("#selectIMG_Pnum").attr("src", getContextPath() + "/resources/img/join/after_all.png");
	} else {
		$("#selectIMG_Pnum").attr("src", getContextPath() + "/resources/img/join/before_all.png");
	}
	
	if(new RegExp(pnum_Pattern).test(pnum)) {
		$("#pnumLabel").css("color", "#003399");
		$("#pnumLabel").html("올바른 전화번호입니다.");
		$("#checkIMG_Pnum").attr("src", getContextPath() + "/resources/img/join/after_all.png");
		pnum_Flag = true;
	} else {
		if($("#selectPnum").html() == "선택" || $("#inputPnum1").val().length == 0 || $("#inputPnum2").val().length == 0) {
			$("#pnumLabel").css("color", "#F15F5F");
			$("#pnumLabel").html("전화번호를 입력해주세요.");
			$("#checkIMG_Pnum").attr("src", getContextPath() + "/resources/img/join/before_all.png");
			pnum_Flag = false;
		} else {
			$("#pnumLabel").css("color", "#F15F5F");
			$("#pnumLabel").html("전화번호 형식이 올바르지 않습니다.");
			$("#checkIMG_Pnum").attr("src", getContextPath() + "/resources/img/join/before_all.png");
			pnum_Flag = false;
		}
	}
}
// 이메일 정규표현식
function checkEmail() {
	var email = $("#inputEmail1").val() + "@" + $("#inputEmail2").val();
	var email_Pattern = /^(([a-zA-Z\d][-_]?){3,15})@([a-zA-z\d]{5,15})\.([a-z]{2,3})$/;
	
	if($("#inputEmail2").val().length != 0) {
		$("#selectIMG_Email").attr("src", getContextPath() + "/resources/img/join/after_all.png");
	} else {
		$("#selectIMG_Email").attr("src", getContextPath() + "/resources/img/join/before_all.png");
	}
	
	if(new RegExp(email_Pattern).test(email)) {
		$("#emailLabel").css("color", "#003399");
		$("#emailLabel").html("올바른 이메일입니다.");
		$("#checkIMG_Email").attr("src", getContextPath() + "/resources/img/join/after_all.png");
		email_Flag = true;
	} else {
		if($("#inputEmail1").val().length == 0 || $("#inputEmail2").val().length == 0) {
			$("#emailLabel").css("color", "#F15F5F");
			$("#emailLabel").html("이메일을 입력해주세요.");
			$("#checkIMG_Email").attr("src", getContextPath() + "/resources/img/join/before_all.png");
			email_Flag = false;
		} else {
			$("#emailLabel").css("color", "#F15F5F");
			$("#emailLabel").html("올바른 이메일 형식이 아닙니다.");
			$("#checkIMG_Email").attr("src", getContextPath() + "/resources/img/join/before_all.png");
			email_Flag = false;
		}
	}
}
// 완료 버튼 클릭시 정규표현식 다시 한번 전체 확인 후 진행
function joinOk() {
	checkID(); checkPW1(); checkPW2(); checkName(); checkGender(); checkPnum(); checkEmail();
	if(id_Flag && pw_Flag && name_Flag && gender_Flag && pnum_Flag && email_Flag) {
		// 회원가입 진행
		$.ajax({
			url: getContextPath() + "/member/insert",
			type: "POST",
			cache: false,
			data: {
				"memberId" : $("#inputID").val(),
				"memberPw" : $("#inputPW2").val(),
				"memberName" : $("#inputName").val(),
				"memberBirth" : $("#selectYear").html() + "-" + $("#selectMonth").html() + "-" + $("#selectDay").html(),
				"memberGender" : $("input[type=radio][name=gender]:checked").val(),
				"memberPnum" : $("#selectPnum").html() + "-" + $("#inputPnum1").val() + "-" + $("#inputPnum2").val(),
				"memberEmail" : $("#inputEmail1").val() + "@" + $("#inputEmail2").val()
			},
			success: function(data, status) {
				if(status == "success") {
					var checkSuccess = data;
					if(checkSuccess == "Ok") {
						$(".joinText").html("가입되었습니다.");
						$("#tbpJoinCheckBtn").attr("onclick", "location.href='"+ getContextPath() +"/main/memberLogin'");		
						$("#joinOkPanel").css("display", "block");
						$("#jf2").removeClass("active");
						$("#jf3").addClass("active");
					} else {
						$(".joinText").html("가입에 실패하였습니다.");
						$("#tbpJoinCheckBtn").attr("onclick", "$('#joinOkPanel').css('display', 'none')");		
						$("#joinOkPanel").css("display", "block");
						$("#jf2").removeClass("active");
						$("#jf3").addClass("active");
					}
				}
			}
		});
	} else {
		if(!email_Flag) {
			$(".joinText").html("이메일을 다시 한번 확인해주세요.");
			$("#tbpJoinCheckBtn").attr("onclick", "$('#joinOkPanel').css('display', 'none')");
			$("#joinOkPanel").css("display", "block");		
		}
		if(!pnum_Flag) {
			$(".joinText").html("전화번호를 다시 한번 확인해주세요.");
			$("#tbpJoinCheckBtn").attr("onclick", "$('#joinOkPanel').css('display', 'none')");
			$("#joinOkPanel").css("display", "block");		
		}
		if(!gender_Flag) {
			$(".joinText").html("성별을 선택해주세요.");
			$("#tbpJoinCheckBtn").attr("onclick", "$('#joinOkPanel').css('display', 'none')");
			$("#joinOkPanel").css("display", "block");		
		}
		if(!name_Flag) {
			$(".joinText").html("이름을 다시 한번 확인해주세요.");
			$("#tbpJoinCheckBtn").attr("onclick", "$('#joinOkPanel').css('display', 'none')");
			$("#joinOkPanel").css("display", "block");					
		}
		if(!pw_Flag) {
			$(".joinText").html("비밀번호를 다시 한번 확인해주세요.");
			$("#tbpJoinCheckBtn").attr("onclick", "$('#joinOkPanel').css('display', 'none')");
			$("#joinOkPanel").css("display", "block");			
		}
		if(!id_Flag) {
			$(".joinText").html("아이디를 다시 한번 확인해주세요.");
			$("#tbpJoinCheckBtn").attr("onclick", "$('#joinOkPanel').css('display', 'none')");
			$("#joinOkPanel").css("display", "block");
		}
	}
}
</script>
</head>
<body onload="dateConfig();">
<jsp:include page="/resources/include/header/joinHeader.jsp"/>
<div class="joinSection">
	<div class="joinSectionInner">
			<div class="joinSectionTop">
				<table class="mainTable">
					<tr>
						<td colspan="3">
							<span class="joinContentTitle">회원가입</span>
							<span id="jf3">가입완료</span>
							<span id="jf2" class="active">정보입력</span>
							<span id="jf1">가입 및 약관동의</span>
						</td>
					</tr>
					<tr>
						<td class="contentBorder" colspan="3">
							<div class="joinSectionTopInner">
								<div id="tbpJoinContent" class="on">
									<div class="tbpJoinContentTop">
											<div class="tbpJoinContentInputAllBox">
												<div class="tbpJoinInputBox1">
													<input type="text" id="inputID" onkeyup="checkID();" onblur="checkID();" placeholder="아이디를 입력해주세요.(영문 /숫자) 6 ~ 10자"/>
												</div>
												<div class="tbpJoinInputBox2">
													<img id="checkIMG_ID" src="${pageContext.request.contextPath}/resources/img/join/before_all.png"/>
												</div>
											</div>
											<div class="tbpJoinContentInputLabel">
												<label id="idLabel"></label>
												<hr id="idHR">
											</div>
											<div class="tbpJoinContentInputAllBox">
												<div class="tbpJoinInputBox1">
													<input type="password" id="inputPW1"  onkeyup="checkPW1();" onblur="checkPW2();" placeholder="비밀번호를 입력해주세요.(영문 /숫자/특수문자) 8 ~ 15자"/>
												</div>
												<div class="tbpJoinInputBox2">
													<img id="checkIMG_PW1" src="${pageContext.request.contextPath}/resources/img/join/before_pw1.png"/>
												</div>
											</div>
											<div class="tbpJoinContentInputLabel">
												<label id="pw1Label"></label>
 												<hr id="pw1HR">
											</div>
											<div class="tbpJoinContentInputAllBox">
												<div class="tbpJoinInputBox1">
													<input type="password" id="inputPW2" onkeyup="checkPW2();" onblur="checkPW2();" placeholder="위의 비밀번호를 다시 한번 입력해주세요."/>
												</div>
												<div class="tbpJoinInputBox2">
													<img id="checkIMG_PW2" src="${pageContext.request.contextPath}/resources/img/join/before_pw2.png"/>
												</div>
											</div>
											<div class="tbpJoinContentInputLabel">
												<label id="pw2Label"></label>
												<hr id="pw2HR">
											</div>
											<div class="tbpJoinContentInputAllBox">
												<div class="tbpJoinInputBox1">
													<input type="text" id="inputName" onkeyup="checkName();" onblur="checkName();" placeholder="이름을 입력해주세요."/>
												</div>
												<div class="tbpJoinInputBox2">
													<img id="checkIMG_Name" src="${pageContext.request.contextPath}/resources/img/join/before_all.png"/>
												</div>
											</div>
											<div class="tbpJoinContentInputLabel">
												<label id="nameLabel"></label>
												<hr id="nameHR">
											</div>
											<div class="tbpJoinContentInputAllBox">
												<div class="tbpJoinInputBox1">
 														<div class="selectBox">
															<div class="selectBoxInner" id="selectYear" onclick="dayConfig();"></div><img src="${pageContext.request.contextPath}/resources/img/join/after_all.png"/>
															<div class="dropDown" id="dropDownYear">
															</div>
														</div>
 														<div class="selectBox">
															<div class="selectBoxInner" id="selectMonth" onclick="dayConfig();"></div><img src="${pageContext.request.contextPath}/resources/img/join/after_all.png"/>
															<div class="dropDown" id="dropDownMonth">
															</div>
														</div>
 														<div class="selectBox">
															<div class="selectBoxInner" id="selectDay" onclick="dayConfig();"></div><img src="${pageContext.request.contextPath}/resources/img/join/after_all.png"/>
															<div class="dropDown" id="dropDownDay">
															</div>
														</div>
														<input type="radio" class="checkGender" onclick="checkGender();" name="gender" value="0"> 남자
														<input type="radio" class="checkGender" onclick="checkGender();" name="gender" value="1"> 여자
												</div>
												<div class="tbpJoinInputBox2">
													<img id="checkIMG_BG" src="${pageContext.request.contextPath}/resources/img/join/before_all.png" />
												</div>
											</div>
											<div class="tbpJoinContentInputLabel">
												<label id="bgLabel"></label>
												<hr id="bgHR">
											</div>
											<div class="tbpJoinContentInputAllBox">
												<div class="tbpJoinInputBox1">
													<div class="selectBox">
														<div class="selectBoxInner" id="selectPnum">선택</div><img id="selectIMG_Pnum" src="${pageContext.request.contextPath}/resources/img/join/before_all.png"/>
														<div class="dropDownPnum" id="dropDownPnum">
															<div id="Pnum0">010</div>
															<div id="Pnum1">011</div>
															<div id="Pnum2">016</div>
															<div id="Pnum3">017</div>
															<div id="Pnum4">018</div>
															<div id="Pnum5">019</div>
														</div>
													</div>
													<input class="InputPnum" id="inputPnum1" onkeyup="checkPnum();" onblur="checkPnum();" type="text" placeholder="0000"/> - <input class="InputPnum" id="inputPnum2" onkeyup="checkPnum();" onblur="checkPnum();" type="text"  placeholder="0000"/>
												</div>
											<div class="tbpJoinInputBox2">
													<img id="checkIMG_Pnum" src="${pageContext.request.contextPath}/resources/img/join/before_all.png" />
											</div>
											</div>
											<div class="tbpJoinContentInputLabel">
												<label id="pnumLabel"></label>
												<hr id="pnumHR">
											</div>
											<div class="tbpJoinContentInputAllBox">
												<div class="tbpJoinInputBox1">
													<input class="InputEmail" id="inputEmail1"  onkeyup="checkEmail();" onblur="checkEmail();" type="text" placeholder="email"/> @ <input class="InputEmail" id="inputEmail2" onkeyup="checkEmail();" onblur="checkEmail();" type="text"  placeholder="naver.com"/>
													<div class="selectBoxEmail">
														<div class="selectBoxInnerEmail" id="selectEmail">직접입력</div><img id="selectIMG_Email" src="${pageContext.request.contextPath}/resources/img/join/before_all.png" />
														<div class="dropDownEmail" id="dropDownEmail">
															<div id="Email0">직접입력</div>
															<div id="Email1">naver.com</div>
															<div id="Email2">gmail.com</div>
														</div>
													</div>
												</div>
											<div class="tbpJoinInputBox2">
													<img id="checkIMG_Email" src="${pageContext.request.contextPath}/resources/img/join/before_all.png" />
											</div>
											</div>
											<div class="tbpJoinContentInputLabel">
												<label id="emailLabel"></label>
												<hr id="emailHR">
											</div>
									</div>
									<div class="tbpJoinContentBottom">
										<div id="tbpJoinBtn" onclick="joinOk();">완료</div>
										<div id="joinOkPanel">
											<div id="joinOk">
												<div class="joinText"></div>
												<div id="tbpJoinCheckBtn">확인</div>
											</div>
										</div>
									</div>
								</div>
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