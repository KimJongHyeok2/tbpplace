<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TBP - 상점</title>
<jsp:include page="/resources/include/combineScript.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/myShop.css"/>
<script type="text/javascript">
	$(document).ready(function() {
		// 상품목록 탭 클릭 시
		$("#shopProductList").click(function() {
			$(this).addClass("active");
			$(".productList").addClass("on");
			$(".QA").removeClass("on");
			$(".review").removeClass("on");
			$("#shopProductQA").removeClass("active");
			$("#shopProductReview").removeClass("active");
		});
		// 상품문의 탭 클릭 시
		$("#shopProductQA").click(function() {
			$(this).addClass("active");
			$(".QA").addClass("on");
			$(".productList").removeClass("on");
			$(".review").removeClass("on");
			$("#shopProductList").removeClass("active");
			$("#shopProductReview").removeClass("active");
		});
		// 상품문의 탭 클릭 시
		$("#shopProductQA").click(function() {
			$(this).addClass("active");
			$(".QA").addClass("on");
			$(".productList").removeClass("on");
			$(".review").removeClass("on");
			$("#shopProductList").removeClass("active");
			$("#shopProductReview").removeClass("active");
			loadQuestion();
		});
		// 상품후기 탭 클릭 시
		$("#shopProductReview").click(function() {
			$(this).addClass("active");
			$(".review").addClass("on");
			$(".productList").removeClass("on");
			$(".QA").removeClass("on");
			$("#shopProductList").removeClass("active");
			$("#shopProductQA").removeClass("active");
			loadReview();
		});
		// Shop 제목 수정 버튼 영역에 마우스 위치 시
		$(".shopNameUpdateBtn").mouseenter(function() {
			$(".shopInfoName").css("color", "#003399");
		});
		// Shop 제목 수정 버튼 영역에서 마우스가 벗어날 시
		$(".shopNameUpdateBtn").mouseleave(function() {
			$(".shopInfoName").css("color", "black");
		});
		// Shop 제목 수정 버튼 클릭 시
		$(".shopNameUpdateBtn").click(function() {
			shopName_Temp = $(".shopInfoName").html().trim();
			$(".shopInfoName").html("<input id='shopName' type='text'/>");
			$(this).css("display", "none");
			$(".shopNameUpdateBtnBox").css("display", "block");
			$("#shopName").val(shopName_Temp);
			$("#shopName").focus();
		});
		// Shop 소개말 수정 버튼 클릭 시
		$(".shopIntroductionUpdateBtn").click(function() {
			shopIntroduction_Temp = $(".shopIntroduction").html().trim().replace(/<br>/g, "\n");
			$(this).css("display", "none");
			$(".shopIntroductionUpdateBtnBox").css("display", "block");
			$(".shopIntroduction").html("<textarea id='shopIntroductionArea'>" + shopIntroduction_Temp + "</textarea>");
			$("#shopIntrodutionArea").focus();
		});
		loadProduct();
		// 상품 더 보기 클릭 시
		$(".productAddView").click(function() {
			$("#allRow").val(parseInt($("#allRow").val()) + 10);
			loadProduct();
		});
		// 상품문의 더 보기 클릭 시
		$(".questionAddView").click(function() {
			$("#questionRow").val(parseInt($("#questionRow").val()) + 5);
			loadQuestion();
		});
		// 상품후기 더 보기 클릭 시
		$(".reviewAddView").click(function() {
			$("#reviewRow").val(parseInt($("#reviewRow").val()) + 5);
			loadReview();
		});
	});
	var shopName_Temp;
	var shopIntroduction_Temp;
function bgradeCheck(bgrade) {
		if(bgrade == 0) {
			return "beginning";
		} else if(bgrade == 1) {
			return "bronze";
		} else if(bgrade == 2) {
			return "gold";
		} else if(bgrade == 3) {
			return "platinum";
		} else if(bgrade == 4) {
			return "master";
		}
}
// 해당 Shop 상품 불러오기
function loadProduct() {
	$.ajax({
		url: "${pageContext.request.contextPath}/shopInfo/product",
		type: "POST",
		cache: false,
		data: {
			"memberNo" : ${memberNo},
			"allRow" : $("#allRow").val()
		},
		success: function(data, status) {
			if(status == "success") {
				if(data.status == "Ok") {
					var productList = "";
					var count = 1;
					if(data.count == 0) {
						$(".resultEmpty").addClass("on");
						return false;
					}
					for(var i=0; i<data.count; i++) {
						if(count%5 == 0) {
							productList += "<div class='shopContentBox rowLast' onclick=location.href='${pageContext.request.contextPath}/product/" + data.list[i].productNo + "'>";
							productList += "<div class='shopContentThumb'><img style='height: 100%;' src='${pageContext.request.contextPath}/resources/upload/" + data.list[i].productThumb + "'/>" + "</div>";
							productList += "<div class='shopContentSubject'><a href='${pageContext.request.contextPath}/product/" + data.list[i].productNo + "'>" + data.list[i].productSubject + "</a></div>";
							productList += "<div class='shopContentOther'>" + formatPrice(data.list[i].productPrice) + "원" + "<div class='productDate'>" + formatDate(data.list[i].productRegDate) + "</div>" + "</div>";
							productList += "</div>";
						} else {
							productList += "<div class='shopContentBox' onclick=location.href='${pageContext.request.contextPath}/product/" + data.list[i].productNo + "'>";
							productList += "<div class='shopContentThumb'><img style='height: 100%;' src='${pageContext.request.contextPath}/resources/upload/" + data.list[i].productThumb + "'/>" + "</div>"
							productList += "<div class='shopContentSubject'><a href='${pageContext.request.contextPath}/product/" + data.list[i].productNo + "'>" + data.list[i].productSubject + "</a></div>";
							productList += "<div class='shopContentOther'>" + formatPrice(data.list[i].productPrice) + "원" + "<div class='productDate'>" + formatDate(data.list[i].productRegDate) + "</div>" + "</div>";
							productList += "</div>";
						}
						count++;
					}
					$("#productNumber").html(data.myProductCount);
					if(data.count < data.myProductCount) {
						$(".productAddView").css("display", "block");
					} else {						
						$(".productAddView").css("display", "none");
					}
					$(".productList.on .shopContentWrapper").html(productList);
				}
				if(data.stauts == "Fail") {
					$("#confirmPanel").css("display", "block");
					$("#confirmText").html("알 수 없는 오류가 발생하였습니다.");
					$("#confirmBtn").attr("onclick", "$('#confirmPanel').css('display', 'none')");
					return false;	
				}
			}
		}
	});	
}
function loadQuestion() {
		$.ajax({
			url: "${pageContext.request.contextPath}/shopInfo/question",
			cache: false,
			type: "POST",
			data: {
				"memberNo" : $("#memberNo").val(),
				"questionRow" : $("#questionRow").val()
			},
			success: function(data, status) {
				if(status == "success") {
					if(data.status == "Ok") {
						var questionData = "";
						var sessionMemberNo = ${empty sessionScope.memberNo? 0:sessionScope.memberNo};
						if(data.questionCount > data.count) {
							$(".questionAddView").addClass("on");
						} else {
							$(".questionAddView").removeClass("on");								
						}
						for(var i=0; i<data.count; i++) {		
 							questionData += "<li id='questionBox" + data.list[i].questionNo + "'>";
 							questionData += "<div class='buyerGrade'><img src='${pageContext.request.contextPath}/resources/img/grade/" + bgradeCheck(data.list[i].memberBgrade) + ".png'/></div>";
 							questionData += "<div class='left'><div class='thumbBox'><img class='thumb' src='${pageContext.request.contextPath}/resources/img/main/profile.png'/></div></div>";
							questionData += "<div class='right'><div class='titleBox'><div class='shopName'><a href='${pageContext.request.contextPath}/shop/" + data.list[i].memberNo + "'>" + (data.list[i].shopName==null? 'TBP SHOP ' + data.list[i].memberNo + '호':data.list[i].shopName) + "</a></div><div class='reviewRegDate'>" + formatDate(data.list[i].questionRegDate) + "</div></div>";
							questionData += "<div class='productSubject'><a href='${pageContext.request.contextPath}/product/" + data.list[i].productNo + "'>" + data.list[i].productSubject + "</a></div>";
							questionData += "<div id='questionContent" + data.list[i].questionNo + "' class='reviewContent'>" + data.list[i].questionContent.replace(/\n/g, "<br>") + "</div>";
							questionData += "<div id='qaAnswer' class='qaFuncBtn" + (sessionMemberNo==${shopInfo.memberNo}? ' on':'') + "' onclick='qaInputOpen(" + data.list[i].questionNo + ")'>답변</div>"
							questionData += "<div id='qaDelete" + data.list[i].questionNo + "' onclick='questionDelete(" + data.list[i].questionNo + ")' class='qaFuncBtn" + (data.list[i].memberNo==${empty sessionScope.memberNo? 0:sessionScope.memberNo}? ' on':'') + "'>삭제</div>";
							questionData += "<div id='qaUpdate" + data.list[i].questionNo + "' onclick='questionUpdate(" + data.list[i].questionNo + ")' class='qaFuncBtn" + (data.list[i].memberNo==${empty sessionScope.memberNo? 0:sessionScope.memberNo}? ' on':'') + "'>수정</div>";
							questionData += "<div id='qaCheck' class='qaFuncBtn on' onclick='qaOpen(" + data.list[i].questionNo + ")'>답글(<span id='anCount" + data.list[i].questionNo + "'>0</span>)</div>";
							questionData += "</div>";
							questionData += "</div>";
							questionData += "</li>";
							questionData += "<div id='answerInputBox" + data.list[i].questionNo + "' class='answerWrapper'>";
							questionData += "<div class='answerInputBox'>";
							questionData += "<div class='title'>";
							questionData += "답변작성";
							questionData += "</div>";
							questionData += "<div class='content'>";
							questionData += "<div class='contentTop'>";
							questionData += "<textarea id='answerInput" + data.list[i].questionNo + "' onkeyup='answerCheck(" + data.list[i].questionNo + ");' placeholder='답변 내용을 입력하세요.'></textarea>";
							questionData += "</div>";
							questionData += "<div class='contentBottom'>";
							questionData += "(<span id='answerLimitCheck" + data.list[i].questionNo + "'>0</span>/100)";
							questionData += "<div class='inputABtn' onclick='answerWrite(" + data.list[i].questionNo + ", " + data.list[i].productNo + ");'>등록</div>";
							questionData += "</div>";
							questionData += "</div>";
							questionData += "</div>";
							questionData += "</div>";
							questionData += "<ul class='questionRecomment' id=qaRecomment" + data.list[i].questionNo + ">";			
							questionData += "</ul>";
						}
						$("#questionCount").html(data.questionCount);
						$("#questionResult ul").html(questionData);
						answerList();
					}
					if(data.count == 0) {
						$("#questionResult").html("등록된 문의가 없습니다.");
						$("#questionResult").addClass("questionEmpty on");
					}
				}
			}
		});
}
function loadReview() {
		$.ajax({
			url: "${pageContext.request.contextPath}/shopInfo/review",
			cache: false,
			type: "POST",
			data: {
				"memberNo" : $("#memberNo").val(),
				"reviewRow" : $("#reviewRow").val()
			},
			success: function(data, status) {
				if(status == "success") {
					if(data.status == "Ok") {
						var reviewData = "";
						if(data.reviewCount > data.count) {
							$(".reviewAddView").addClass("on");
						} else {
							$(".reviewAddView").removeClass("on");								
						}
						for(var i=0; i<data.count; i++) {		
							reviewData += "<li>";
							reviewData += "<div class='buyerGrade'><img src='${pageContext.request.contextPath}/resources/img/grade/" + bgradeCheck(data.list[i].memberBgrade) + ".png'/></div>";
							reviewData += "<div class='left'><div class='thumbBox'><img class='thumb' src='${pageContext.request.contextPath}/resources/img/main/profile.png'/></div></div>";
							reviewData += "<div class='right'><div class='titleBox'><div class='shopName'><a href='${pageContext.request.contextPath}/shop/" + data.list[i].memberNo + "'>" + (data.list[i].shopName==null? 'TBP SHOP ' + data.list[i].memberNo + '호':data.list[i].shopName) + "</a></div><div class='reviewRegDate'>" + formatDate(data.list[i].reviewRegDate) + "</div></div>";
							reviewData += "<div class='productScoreBox'><div><a href='${pageContext.request.contextPath}/product/" + data.list[i].productNo + "'>" + data.list[i].productSubject + "</a></div><div class='score'>평점 : " + data.list[i].productScore + "점</div></div>";
							/* reviewData += "<div class='productScore'>평점 : " + data.list[i].productScore + "점</div>"; */
							reviewData += "<div class='reviewContent'>" + data.list[i].reviewContent.replace(/\n/g, "<br>") + "</div></div>";
							reviewData += "</li>";
						}
						$("#reviewCount").html(data.reviewCount);
						$("#reviewResult ul").html(reviewData);
					}
					if(data.count == 0) {
						$("#reviewResult").html("등록된 후기가 없습니다.");
						$("#reviewResult").addClass("resultEmpty on");
					}
				}
			}
		});	
}
function answerList() {
	$.ajax({
		url: "${pageContext.request.contextPath}/shopInfo/QRecomment",
		cache: false,
		type: "POST",
		data: {
			"memberNo" : ${memberNo}
		},
		success: function(data, status) {
			if(status == "success") {
				for(var i=0; i<data.count; i++) {
					$("#anCount" + data.list[i].questionNo).html(0);
					$("ul#qaRecomment" + data.list[i].questionNo).html("");
				}
				
				for(var i=0; i<data.count; i++) {
	 				var recommentData = "";
					recommentData += "<li>";
					recommentData += "<div class='title'>";
					recommentData += "<span>판매자 답변</span>";						
					recommentData += "</div>";
					recommentData += "<div id='qrDelete" + data.list[i].qRecommentNo + "' onclick='qRecommentDelete(" + data.list[i].qRecommentNo + ", " + data.list[i].questionNo + ")' class='func " + (${empty sessionScope.memberNo? 0:sessionScope.memberNo}==data.list[i].memberNo? 'on':'') + "'>";
					recommentData += "<span>삭제</span>";		
					recommentData += "</div>";
					recommentData += "<div id='qrUpdate" + data.list[i].qRecommentNo + "' onclick='qRecommentUpdate(" + data.list[i].qRecommentNo + ", " + data.list[i].questionNo + ")' class='func " + (${empty sessionScope.memberNo? 0:sessionScope.memberNo}==data.list[i].memberNo? 'on':'') + " first'>";
					recommentData += "<span>수정</span>";	
					recommentData += "</div>";
					recommentData += "<div class='rightComment'>";
					recommentData += "<div id='content" + data.list[i].qRecommentNo + "' class='content'>";
					recommentData += data.list[i].qRecommentContent.replace(/\n/g, "<br>");																													
					recommentData += "</div>";											
					recommentData += "<div class='regdate'>";						
					recommentData += formatDate(data.list[i].qRecommentRegDate);	
					recommentData += "</div>";
					recommentData += "</div>";
					recommentData += "</li>";
					$("ul#qaRecomment" + data.list[i].questionNo).append(recommentData);
					$("#anCount" + data.list[i].questionNo).html(parseInt($("#anCount" + data.list[i].questionNo).html())+1);
				}
			}
		}
	});	
}
function answerWrite(questionNo, productNo) {
	if($("#answerInput" + questionNo).val().length > 100) {
		$("#confirmPanel").css("display", "block");
		$("#confirmText").html("답변은 10자 이상 100자 이하로 작성해주세요.");
		$("#confirmBtn").attr("onclick", "$('#confirmPanel').css('display', 'none')");
		return false;
	}
	if(answerFlag) {
		var memberNo = ${empty sessionScope.memberNo? 0:sessionScope.memberNo};
		var answerContent = $("#answerInput" + questionNo).val();
		$.ajax({
			url: "${pageContext.request.contextPath}/product/qRecomment/insert",
			type: "POST",
			cache: false,
			data: {
				"questionNo" : questionNo,
				"productNo" : productNo,
				"memberNo" : memberNo,
				"qRecommentContent" : answerContent
			},
			success: function(data, status) {
				if(status == "success") {
					if(data == "Ok") {
						$("#answerInput" + questionNo).val("");
						$("#qaRecomment" + questionNo).html("");
						$("#anCount" + questionNo).html(0);
						answerList();
						$("#qaRecomment" + questionNo).css("display", "block");
						answerFlag = false;
					} else {
						$("#confirmPanel").css("display", "block");
						$("#confirmText").html("알 수 없는 오류입니다.");
						$("#confirmBtn").attr("onclick", "$('#confirmPanel').css('display', 'none')");
						return false;
					}
				}
			}
		});
	} else {
		$("#confirmPanel").css("display", "block");
		$("#confirmText").html("답변은 10자 이상 100자 이하로 작성해주세요.");
		$("#confirmBtn").attr("onclick", "$('#confirmPanel').css('display', 'none')");
		return false;
	}
}
// 문의 수정
function questionUpdate(questionNo) {
	var content = $("#questionContent" + questionNo).html();
	$("#questionContent" + questionNo).html("<textarea id='qUpdateContent" + questionNo + "' class='qUpdateContent'>" + content.replace(/<br>/g, "\n") + "</textarea>");
	$("#qaUpdate" + questionNo).html("확인");
	$("#qaUpdate" + questionNo).attr("onclick", "questionUpdateOk('" + questionNo + "', '" + content + "')");
	$("#qaDelete" + questionNo).html("취소");
	$("#qaDelete" + questionNo).attr("onclick", "questionCancle('" + questionNo + "', '" + content + "')");
	$("#qUpdateContent" + questionNo).focus();
}
// 문의 수정 요청
function questionUpdateOk(questionNo, content) {
	var updateContent = $("#qUpdateContent" + questionNo).val();
	if(updateContent.length > 100 || updateContent.length == 0 || updateContent == "") {
		$("#confirmPanel").css("display", "block");
		$("#confirmText").html("문의는 10자 이상 100자 이하로 작성해주세요.");
		$("#confirmBtn").attr("onclick", "$('#confirmPanel').css('display', 'none')");
		return false;
	} else {
		if(updateContent.length < 10) {
			$("#confirmPanel").css("display", "block");
			$("#confirmText").html("문의는 10자 이상 100자 이하로 작성해주세요.");
			$("#confirmBtn").attr("onclick", "$('#confirmPanel').css('display', 'none')");
			return false;
		} else {
			$.ajax({
				url: "${pageContext.request.contextPath}/product/question/update",
				cache: false,
				type: "POST",
				data: {
					"questionNo" : questionNo,
					"questionContent" : updateContent
				},
				success: function(data, status) {
					if(status == "success") {
						if(data == "Ok") {
							questionCancle(questionNo, updateContent);
						} else {
							$("#confirmPanel").css("display", "block");
							$("#confirmText").html("알 수 없는 오류입니다.");
							$("#confirmBtn").attr("onclick", "$('#confirmPanel').css('display', 'none')");
							return false;						
						}
					}
				}
				
			});
		}
	}
}
// 문의 수정 취소
function questionCancle(questionNo, content) {
	$("#questionContent" + questionNo).html(content.replace(/\n/g, "<br>"));
	$("#qaUpdate" + questionNo).html("수정");
	$("#qaUpdate" + questionNo).attr("onclick", "questionUpdate(" + questionNo + ")");
	$("#qaDelete" + questionNo).html("삭제");
	$("#qaDelete" + questionNo).attr("onclick", "questionDelete(" + questionNo + ")");
}
// 문의 삭제
function questionDelete(questionNo) {
	$.ajax({
		url: "${pageContext.request.contextPath}/product/question/delete",
		cache: false,
		type: "POST",
		data: {
			"questionNo" : questionNo
		},
		success: function(data, status) {
			if(status == "success") {
				$("#questionBox" + questionNo).remove();
				if(parseInt($("#questionCount").html()) != 0) {				
					$("#questionCount").html(parseInt($("#questionCount").html())-1);
 				}
				if(parseInt($("#questionCount").html()) == 0) {
					location.reload();
				}
			} else {
				$("#confirmPanel").css("display", "block");
				$("#confirmText").html("알 수 없는 오류입니다.");
				$("#confirmBtn").attr("onclick", "$('#confirmPanel').css('display', 'none')");
				return false;
			}
		}
	});
}
// 답변 수정
function qRecommentUpdate(qRecommentNo, questionNo) {
	var content = $("#content" + qRecommentNo).html();
	$("#qrUpdate" + qRecommentNo).attr("onclick", "qRecommentUpdateOk('" + qRecommentNo + "', '" + questionNo + "');");
	$("#qrUpdate" + qRecommentNo).html("<span>확인</span>");
	$("#qrUpdate" + qRecommentNo).css("color", "#003399");
	$("#qrDelete" + qRecommentNo).attr("onclick", "qRecommentCancle('" + qRecommentNo + "', '" + content + "', '" + questionNo + "');");
	$("#qrDelete" + qRecommentNo).html("<span>취소</span>");
	$("#qrDelete" + qRecommentNo).css("color", "#003399");
	$("#content" + qRecommentNo).html("<textarea id='updateComment" + qRecommentNo + "' class='update'>" + content.replace(/<br>/g, "\n") + "</textarea>");
	$("#updateComment" + qRecommentNo).focus();
}
// 답변 수정 요청
function qRecommentUpdateOk(qRecommentNo, questionNo) {
	var updateContent = $("#updateComment" + qRecommentNo).val();
	if(updateContent.length > 100 || updateContent.length == 0 || updateContent == "") {
		$("#confirmPanel").css("display", "block");
		$("#confirmText").html("답변은 10자 이상 100자 이하로 작성해주세요.");
		$("#confirmBtn").attr("onclick", "$('#confirmPanel').css('display', 'none')");
		return false;
	} else {
		if(updateContent.length < 10) {
			$("#confirmPanel").css("display", "block");
			$("#confirmText").html("답변은 10자 이상 100자 이하로 작성해주세요.");
			$("#confirmBtn").attr("onclick", "$('#confirmPanel').css('display', 'none')");
			return false;
		} else {
			$.ajax({
				url: "${pageContext.request.contextPath}/product/qRecomment/update",
				cache: false,
				type: "POST",
				data: {
					"qRecommentNo" : qRecommentNo,
					"qRecommentContent" : updateContent
				},
				success: function(data, status) {
					if(status == "success") {
						if(data == "Ok") {
							qRecommentCancle(qRecommentNo, updateContent, questionNo);
						} else {
							$("#confirmPanel").css("display", "block");
							$("#confirmText").html("알 수 없는 오류입니다.");
							$("#confirmBtn").attr("onclick", "$('#confirmPanel').css('display', 'none')");
							return false;						
						}
					}
				}
				
			});
		}
	}
}
// 답변 삭제
function qRecommentDelete(qRecommentNo, questionNo) {
	$.ajax({
		url: "${pageContext.request.contextPath}/product/qRecomment/delete",
		cache: false,
		type: "POST",
		data: {
			"qRecommentNo" : qRecommentNo,
		},
		success: function(data, status) {
			if(status == "success") {
				if(data == "Ok") {
					$("#qRecommentBox" + qRecommentNo).remove();
					$("#anCount" + questionNo).html(parseInt($("#anCount" + questionNo).html())-1);
				} else {
					$("#confirmPanel").css("display", "block");
					$("#confirmText").html("알 수 없는 오류입니다.");
					$("#confirmBtn").attr("onclick", "$('#confirmPanel').css('display', 'none')");
					return false;						
				}
			}
		}
	});
}
// 답변 수정 취소
function qRecommentCancle(qRecommentNo, content, questionNo) {
	$("#content" + qRecommentNo).html(content.replace(/\n/g, "<br>"));
	$("#qrUpdate" + qRecommentNo).attr("onclick", "qRecommentUpdate('" + qRecommentNo + "', '" + questionNo + "');");
	$("#qrUpdate" + qRecommentNo).html("<span>수정</span>");
	$("#qrUpdate" + qRecommentNo).css("color", "black");
	$("#qrDelete" + qRecommentNo).attr("onclick", "qRecommentDelete('" + qRecommentNo + "', '" + questionNo + "');");
	$("#qrDelete" + qRecommentNo).html("<span>삭제</span>");
	$("#qrDelete" + qRecommentNo).css("color", "black");
}
function answerCheck(questionNo) {
	var answer = $("#answerInput" + questionNo).val();
	
	if(answer.length > 100) {
		answer = answer.substr(0, 99);
		$("#answerInput" + questionNo).val(answer);
		answerFlag = false;
	} else {
		if(answer.length < 10) {
			answerFlag = false;
		} else {
			answerFlag = true;
		}
		$("#answerLimitCheck" + questionNo).html(answer.length);
	}
}
// 상품문의 답변 작성 토글
function qaInputOpen(questionNo) {
	$("#answerInputBox" + questionNo).slideToggle();
}
// 상품문의 답글 토글
function qaOpen(questionNo) {
	$("#qaRecomment" + questionNo).toggle(500, function() {
	});
	/* $("#qaRecomment" + questionNo).addClass("on"); */
}
// 상품 등록 일시 포맷 변환
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
// 상품 가격 천단위 변환
function formatPrice(productPrice) {
	return productPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g,",");
}
// Shop 제목 수정 확인 버튼 클릭 시
function checkShopName() {
	var shopName = $("#shopName").val();
	
	if(shopName == "" || shopName.length == 0) {
		$("#confirmPanel").css("display", "block");
		$("#confirmText").html("상점 이름을 입력해주세요.");
		$("#confirmBtn").attr("onclick", "$('#confirmPanel').css('display', 'none')");
		return false;
	}
	if(shopName.length > 10) {
		$("#confirmPanel").css("display", "block");
		$("#confirmText").html("상점 이름은 10자를 넘을 수 없습니다.");
		$("#confirmBtn").attr("onclick", "$('#confirmPanel').css('display', 'none')");
		return false;
	}
	$.ajax({
		url: "${pageContext.request.contextPath}/shopInfo/shopName",
		type: "POST",
		chche: false,
		data: {
			"memberNo" : ${shopInfo.memberNo},
			"shopName" : shopName
		},
		success: function(data, status) {
			if(status == "success") {
				if(data == "Ok") {
					$(".shopInfoName").html(shopName);
					$(".shopNameUpdateBtnBox").css("display", "none");
					$(".shopNameUpdateBtn").css("display", "block");
					$("#confirmPanel").css("display", "block");
					$("#confirmText").html("수정되었습니다.");
					$("#confirmBtn").attr("onclick", "$('#confirmPanel').css('display', 'none')");
				} else {
					$("#confirmPanel").css("display", "block");
					$("#confirmText").html("수정에 실패하였습니다.");
					$("#confirmBtn").attr("onclick", "$('#confirmPanel').css('display', 'none')");
				}
			}
		}
	});
}
function cancleShopName() {
	$(".shopInfoName").html(shopName_Temp);
	$(".shopNameUpdateBtnBox").css("display", "none");
	$(".shopNameUpdateBtn").css("display", "block");
}
function checkShopIntroduction() {
	var shopIntroductionArea = $("#shopIntroductionArea").val();
	
	if(shopIntroductionArea == "" || shopIntroductionArea.length == 0) {
		$("#confirmPanel").css("display", "block");
		$("#confirmText").html("상점 소개말을 입력해주세요.");
		$("#confirmBtn").attr("onclick", "$('#confirmPanel').css('display', 'none')");
		return false;
	}
	if(shopIntroductionArea.length > 80) {
		$("#confirmPanel").css("display", "block");
		$("#confirmText").html("상점 소개말은 80자를 넘을 수 없습니다.");
		$("#confirmBtn").attr("onclick", "$('#confirmPanel').css('display', 'none')");
		return false;
	}
	$.ajax({
		url: "${pageContext.request.contextPath}/shopInfo/shopIntroduction",
		type: "POST",
		chche: false,
		data: {
			"memberNo" : ${shopInfo.memberNo},
			"shopIntroduction" : shopIntroductionArea
		},
		success: function(data, status) {
			if(status == "success") {
				if(data == "Ok") {
					$(".shopIntroduction").html(shopIntroductionArea.replace(/\n/g, "<br>"));
					$(".shopIntroductionUpdateBtnBox").css("display", "none");
					$(".shopIntroductionUpdateBtn").css("display", "block");
					$("#confirmPanel").css("display", "block");
					$("#confirmText").html("수정되었습니다.");
					$("#confirmBtn").attr("onclick", "$('#confirmPanel').css('display', 'none')");
				} else {
					$("#confirmPanel").css("display", "block");
					$("#confirmText").html("수정에 실패하였습니다.");
					$("#confirmBtn").attr("onclick", "$('#confirmPanel').css('display', 'none')");
				}
			}
		}
	});
}
function cancleShopIntroduction() {
	$(".shopIntroduction").html(shopIntroduction_Temp.replace(/\n/g, "<br>"));
	$(".shopIntroductionUpdateBtnBox").css("display", "none");
	$(".shopIntroductionUpdateBtn").css("display", "block");
}
</script>
</head>
<body>
<jsp:include page="/resources/include/header/otherHeader.jsp"/>
<div class="shopInfoWrapper">
	<div class="shopInfoInner">
		<div class="shopInfoInnerTop">
			<div class="shopInfoInnerTopLeft">
				<div class="sellerGrade">
					<c:choose>
						<c:when test="${shopInfo.memberSgrade == 0}">
							<img src="${pageContext.request.contextPath}/resources/img/grade/beginning.png"/>
						</c:when>
						<c:when test="${shopInfo.memberSgrade == 1}">
							<img src="${pageContext.request.contextPath}/resources/img/grade/bronze.png"/>
						</c:when>
						<c:when test="${shopInfo.memberSgrade == 2}">
							<img src="${pageContext.request.contextPath}/resources/img/grade/gold.png"/>
						</c:when>
						<c:when test="${shopInfo.memberSgrade == 3}">
							<img src="${pageContext.request.contextPath}/resources/img/grade/platinum.png"/>
						</c:when>
						<c:when test="${shopInfo.memberSgrade == 4}">
							<img src="${pageContext.request.contextPath}/resources/img/grade/master.png"/>
						</c:when>
					</c:choose>
				</div>
				<div class="shopInfoProfile">
					<div class="profileBox">
						<img src="${pageContext.request.contextPath}/resources/img/main/profile.png"/>
					</div>
				</div>
				<div class="shopInfoName">
					${empty shopInfo.shopName? 'TBP SHOP ' += shopInfo.memberNo += '호':shopInfo.shopName}
				</div>
				<div class="shopInfoFunc">
					<input type="hidden" id="memberNo" value="${shopInfo.memberNo}"/>
					<c:if test="${sessionScope.memberNo == memberNo}">
						<div class="shopNameUpdateBtn">수정</div>
						<div class="shopNameUpdateBtnBox"><span class="updateOk" onclick="checkShopName();">확인</span><span class="updateCancle" onclick="cancleShopName();">취소</span></div>
					</c:if>
				</div>
				<div class="shopInfoManagement">
					<c:if test="${sessionScope.memberNo == memberNo}">
						<div class="salesManagementBtn" onclick="location.href='${pageContext.request.contextPath}/myPage/salesManagement'">판매관리</div>
					</c:if>
				</div>
			</div>
			<div class="shopInfoInnerTopRight">
				<div class="shopHistoryBox">
					<div class="historyBoxInner">
						<div class="historyImg">
							<img src="${pageContext.request.contextPath}/resources/img/shop/regdate.png"/>
						</div>
						<div class="historyText">
							오픈일
						</div>
						<div class="historyData">${shopInfo.shopOpeningDate==0? '오늘':shopInfo.shopOpeningDate += '일'}</div>
					</div>
					<div class="historyBoxInner">
						<div class="historyImg">
							<img src="${pageContext.request.contextPath}/resources/img/shop/viewcnt.png"/>
						</div>
						<div class="historyText">
							방문자
						</div>
						<div class="historyData">${shopInfo.shopVisitcnt}명</div>
					</div>
					<div class="historyBoxInner">
						<div class="historyImg">
							<img src="${pageContext.request.contextPath}/resources/img/shop/sales.png"/>
						</div>
						<div class="historyText">
							판매수
						</div>
						<div class="historyData">${shopInfo.shopSalesCount}회</div>
					</div>
						<c:if test="${sessionScope.memberNo==shopInfo.memberNo}">
						<div class="shopIntroductionUpdateBtn">상점 소개말 수정</div>
						<div class="shopIntroductionUpdateBtnBox"><span class="updateOk" onclick="checkShopIntroduction();">확인</span><span class="updateCancle" onclick="cancleShopIntroduction();">취소</span></div>
						</c:if>
				</div>
				<div class="shopIntroduction">
					<jsp:scriptlet>
					pageContext.setAttribute("EnterLine", "\n");
					</jsp:scriptlet>
					${fn:replace(shopInfo.shopIntroduction, EnterLine, '<br>')}
				</div>
			</div>
		</div>
		<div class="shopInfoInnerBottom">
			<table>
				<thead>
					<tr>
						<td id="shopProductList" class="active">상품목록</td><td id="shopProductQA">상품문의</td><td id="shopProductReview">상품후기</td>
					</tr>
				</thead>
			</table>
			<div class="productList on"> 
				<div class="shopContentTitle">
					상품 <span id="productNumber">0</span>
				</div>
				<hr>
				<div class="shopContentWrapper">
				</div>
				<div class="productAddView">상품 더 보기</div>
				<div class="resultEmpty">등록된 상품이 없습니다.</div>
				<input type="hidden" id="allRow" value="10"/>
			</div>
			<div class="QA">
				<div class="shopContentTitle">
					문의 <span id="questionCount">0</span>
				</div>
				<hr>
				<div class="shopContentWrapper">
				</div>
				<input type="hidden" id="questionRow" value="5"/>
				<div id="questionResult">
					<ul>
					</ul>
				</div>
				<div class="questionAddView">문의 더 보기</div>
			</div>
			<div class="review">
				<div class="shopContentTitle">
					후기 <span id="reviewCount">0</span>
				</div>
				<hr>
				<div class="shopContentWrapper">
				</div>
				<input type="hidden" id="reviewRow" value="5"/>
				<div id="reviewResult">
					<ul>
					</ul>
				</div>
				<div class="reviewAddView">후기 더 보기</div>
			</div>
		</div>
	</div>
</div>
<div id="confirmPanel">
	<div id="confirmBox">
		<div id="confirmText"></div>
		<div id="confirmBtn">확인</div>
	</div>
</div>
<jsp:include page="/resources/include/footer/mainFooter.jsp"/>
<script>
	var answerFlag = false;
</script>
</body>
</html>