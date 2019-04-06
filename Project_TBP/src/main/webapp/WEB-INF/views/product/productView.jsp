<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TBP - 상품 상세보기</title>
<jsp:include page="/resources/include/combineScript.jsp"/>
<script type="text/javascript">
	$(document).ready(function() {
		// 상단 카테고리 대분류 클릭 시
		var depth1_clickCount = 0;
		$("#depth1").click(function() {
			if(depth1_clickCount == 0) {				
				$("#depth1Box").css("display", "block");
				depth1_clickCount = 1;
			} else {				
				$("#depth1Box").css("display", "none");
				depth1_clickCount = 0;
			}
		});
		// 상단 카테고리 중분류 클릭 시
		var depth2_clickCount = 0;
		$("#depth2").click(function() {
			if(depth2_clickCount == 0) {				
				$("#depth2Box").css("display", "block");
				depth2_clickCount = 1;
			} else {				
				$("#depth2Box").css("display", "none");
				depth2_clickCount = 0;
			}
		});
		// 상단 카테고리 소분류 클릭 시
		var depth3_clickCount = 0;
		$("#depth3").click(function() {
			if(depth3_clickCount == 0) {				
				$("#depth3Box").css("display", "block");
				depth3_clickCount = 1;
			} else {				
				$("#depth3Box").css("display", "none");
				depth3_clickCount = 0;
			}
		});
		// 해당 상품 이미지 NEXT, PREV 버튼 클릭시
		var imgLength = ${fn:length(productViewDto.productImages)};
		var currThumbCount = 1;
		$(".thumbPrevBtn").click(function() {
			$("#productImg" + currThumbCount).removeClass("on");
			$("#subThumbSelect" + currThumbCount).removeClass("selected");
			currThumbCount -= 1;
			if(currThumbCount == 0) {
				$("#mainThumbnail").removeClass("on");
				$("#subThumbSelect1").removeClass("selected");				
				currThumbCount = imgLength;
				$("#productImg" + currThumbCount).addClass("on");
				$("#subThumbSelect" + currThumbCount).addClass("selected");
			} else if(currThumbCount == 1) {
				$("#mainThumbnail").addClass("on");
				$("#subThumbSelect" + currThumbCount).addClass("selected");
			} else {
				$("#productImg" + currThumbCount).addClass("on");
				$("#subThumbSelect" + currThumbCount).addClass("selected");
			}
		});
		// 이미지 다음 버튼 클릭 시
		$(".thumbNextBtn").click(function() {
			$("#mainThumbnail").removeClass("on");	
			$("#productImg" + currThumbCount).removeClass("on");
			$("#subThumbSelect" + currThumbCount).removeClass("selected");
			currThumbCount += 1;
			if(currThumbCount > imgLength) {
				$("#mainThumbnail").addClass("on");
				currThumbCount = 1;
				$("#subThumbSelect" + currThumbCount).addClass("selected");
			} else {			
				$("#productImg" + currThumbCount).addClass("on");
				$("#subThumbSelect" + currThumbCount).addClass("selected");		
			}
		});
		// 상품 이미지 하단 이미지 보조 버튼? 클릭 시
		$(".subThumbSelect").click(function() {
			$("#mainThumbnail").removeClass("on");
			$(".productSubImg").removeClass("on");
			$(".subThumbSelect").removeClass("selected");
			$(this).addClass("selected");
			currThumbCount = $(this).find(".thumbValue").val();
			if(currThumbCount == 1) {
				$("#mainThumbnail").addClass("on");
			} else {	
				$("#productImg" + currThumbCount).addClass("on");
			}
		});
		// 상품 수량 증가/감소
		var totalPrice = $("#totalPrice").html().trim().replace(/,/g, "");
		var totalPriceResult;
		var productNumbers = parseInt($("#productNumbers").html().trim());
		$("#productNumberPlus").click(function() {
			var retentionNumber = parseInt($("#retentionNumber").html().trim());
			if(retentionNumber == 0) {
				$("#confirmPanel").css("display", "block");
				$("#confirmText").html("해당 상품의 재고가 없습니다.");
				$("#confirmBtn").attr("onclick", "$('#confirmPanel').css('display', 'none')");
				return false;
			}
			productNumbers += 1;
			totalPriceResult = (totalPrice * productNumbers) + "";
			$("#totalPrice").html(totalPriceResult.replace(/\B(?=(\d{3})+(?!\d))/g,","));
			$("#orderPrice").val($("#totalPrice").html());
			$("#productNumbers").html(productNumbers);
			$("#orderNumber").val(productNumbers);
		});
		$("#productNumberMinus").click(function() {
			var retentionNumber = parseInt($("#retentionNumber").html().trim());
			if(retentionNumber == 0) {
				$("#confirmPanel").css("display", "block");
				$("#confirmText").html("해당 상품의 재고가 없습니다.");
				$("#confirmBtn").attr("onclick", "$('#confirmPanel').css('display', 'none')");
				return false;
			}
			if(productNumbers == 1) {
				return false;
			}
			productNumbers -= 1;
			totalPriceResult = (totalPrice * productNumbers) + "";
			$("#totalPrice").html(totalPriceResult.replace(/\B(?=(\d{3})+(?!\d))/g,","));
			$("#orderPrice").val($("#totalPrice").html());
			$("#productNumbers").html(productNumbers);
			$("#orderNumber").val(productNumbers);
		});
		// 구매버튼 클릭시 
		$(".buyBtn").click(function() {
			var retentionNumber = parseInt($("#retentionNumber").html().trim());
			var selectNumber = parseInt($("#productNumbers").html().trim());

			if(retentionNumber == 0) {
				$("#confirmPanel").css("display", "block");
				$("#confirmText").html("해당 상품의 재고가 없습니다.");
				$("#confirmBtn").attr("onclick", "$('#confirmPanel').css('display', 'none')");
				return false;
			} else if(retentionNumber < selectNumber) {
				$("#confirmPanel").css("display", "block");
				$("#confirmText").html("해당 상품의 재고가 부족합니다.");
				$("#confirmBtn").attr("onclick", "$('#confirmPanel').css('display', 'none')");
				return false;
			} else {
				if(${not empty sessionScope.loginCheck}) {
					var orderMemberNo = ${empty sessionScope.memberNo? "false":sessionScope.memberNo};
					var productMemberNo = ${productViewDto.productView.memberNo};
					if(orderMemberNo == productMemberNo) {
						$("#confirmPanel").css("display", "block");
						$("#confirmText").html("자신의 상품은 구매할 수 없습니다.");
						$("#confirmBtn").attr("onclick", "$('#confirmPanel').css('display', 'none')");
						return false;
					} else {			
						$("#orderForm").submit();
					}
				} else {
					$("#orderForm").submit();
				}
			}
		});
		// 장바구니 담기
		$(".cartBtn").click(function() {
			var orderMemberNo = ${empty sessionScope.memberNo? "false":sessionScope.memberNo};
			var productMemberNo = ${productViewDto.productView.memberNo};
			if(orderMemberNo == productMemberNo) {
				$("#confirmPanel").css("display", "block");
				$("#confirmText").html("자신의 상품은 장바구니에 담을 수 없습니다.");
				$("#confirmBtn").attr("onclick", "$('#confirmPanel').css('display', 'none')");
				return false;
			} else {
				$(".confirmPanel2").css("display", "block");
				$("#confirmText2").html("정말로 장바구니에 담으시겠습니까?");
				$("#confirmOk").attr("onclick", "cartIn();");
				$("#confirmCancle").attr("onclick", "$('.confirmPanel2').css('display', 'none')");	
			}
		});
		// 상품후기 불러오기
		reviewList();
		// 상품문의 불러오기
		questionList();
		if(${empty sessionScope.loginCheck}) {
			$("#qaInput").attr("disabled", "disabled");
			$("#qaInput").attr("placeholder", "로그인이 필요합니다.");
			$(".inputBtn").css("display", "none");
		} else if(${not empty sessionScope.memberNo? sessionScope.memberNo:0}==${productViewDto.productView.memberNo}) {
			$("#qaInput").attr("disabled", "disabled");
			$("#qaInput").attr("placeholder", "자신의 상품에는 문의를 남길 수 없습니다.");
			$(".inputBtn").css("display", "none");
		}
		// 상품문의 등록
		$(".inputBtn").click(function() {
			if($("#qaInput").val().length > 100) {
				$("#confirmPanel").css("display", "block");
				$("#confirmText").html("문의는 10자 이상 100자 이하로 작성해주세요.");
				$("#confirmBtn").attr("onclick", "$('#confirmPanel').css('display', 'none')");
				return false;
			}
			if(questionFlag) {
				var productNo = $("#productNo").val();
				var memberNo = ${empty sessionScope.memberNo? 0:sessionScope.memberNo};
				var questionContent = $("#qaInput").val();
				$.ajax({
					url: "${pageContext.request.contextPath}/product/question/insert",
					type: "POST",
					cache: false,
					data: {
						"productNo" : productNo,
						"memberNo" : memberNo,
						"questionContent" : questionContent
					},
					success: function(data, status) {
						if(status == "success") {
							if(data == "Ok") {
 								$("#qaInput").val("");
								$("#qaLimitCheck").html(0);
								questionList();
								questionFlag = false;
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
				$("#confirmText").html("문의는 10자 이상 100자 이하로 작성해주세요.");
				$("#confirmBtn").attr("onclick", "$('#confirmPanel').css('display', 'none')");
				return false;
			}
		});
		$(".productTab").click(function() {
			$(".productTab").removeClass("active");
			$(this).addClass("active");
		});
		// 상품문의 더 보기 클릭 시
		$("#questionMore").click(function() {
			$("#questionRow").val(parseInt($("#questionRow").val())+5);
			questionList();
		});
		// 상품후기 더 보기 클릭 시
		$("#reviewMore").click(function() {
			$("#reviewRow").val(parseInt($("#reviewRow").val())+5);
			reviewList();
		});
		$("#contentTab").click(function() {
			var moves = $("#contentArea").offset();
			$("body,html").animate({scrollTop:moves.top},500);
		});
		$("#questionTab").click(function() {
			var moves = $("#questionArea").offset();
			$("body,html").animate({scrollTop:moves.top},500);
		});
		$("#reviewTab").click(function() {
			var moves = $("#reviewArea").offset();
			$("body,html").animate({scrollTop:moves.top},500);
		});
		if(${not empty param.n}) {
/* 			var moves = $("#questionArea").offset();
			$("body,html").animate({scrollTop:moves.top},500);
			$(".productTab").removeClass("active");
			$("#questionTab").addClass("active"); */
			$("#questionTab").click();
		} else if(${not empty param.s}) {
/* /  			var moves = $("#reviewArea").offset();
			$("body,html").animate({scrollTop:moves.top},500);
			$(".productTab").removeClass("active");
			$("#reviewTab").addClass("active"); */
			$("#reviewTab").click();
			var count = 0;
		}
		$(window).scroll(function(){
			var docScrollTop = $(document).scrollTop();
			var contentScrollTop = Math.floor($("#contentArea").offset().top);
			var questionScrollTop = Math.floor($("#questionArea").offset().top);
			var reviewScrollTop = Math.floor($("#reviewArea").offset().top) - 500;

 			if(docScrollTop >= (contentScrollTop)) {
				$(".bottomInnerTop").addClass("on");
			} else {
				$(".bottomInnerTop").removeClass("on");				
			}
			
			if(docScrollTop <= contentScrollTop) {
				$(".productTab").removeClass("active");
				$("#contentTab").addClass("active");
			} else if(docScrollTop <= questionScrollTop) {
				$(".productTab").removeClass("active");
				$("#questionTab").addClass("active");	
				if(${not empty param.s} && count == 0) {
					$("#reviewTab").click();
					count += 1;
				}
			} else if(docScrollTop >= reviewScrollTop) {
				$(".productTab").removeClass("active");
				$("#reviewTab").addClass("active");								
			}
		});
		// 상단 카테고리 클릭 시 분류별 검색
		$("#depth3 ul li").click(function() {
			var categoryId = $(this).val();
			location.href = "${pageContext.request.contextPath}/search/product/category?categoryId=" + categoryId + "&page=1&type=depth3";
		});
		$("#depth2 ul li").click(function() {
			var categoryId = $(this).val();
			location.href = "${pageContext.request.contextPath}/search/product/category?categoryId=" + categoryId + "&page=1&type=depth2";
		});
		$("#depth1 ul li").click(function() {
			var categoryId = $(this).val();
			location.href = "${pageContext.request.contextPath}/search/product/category?categoryId=" + categoryId + "&page=1&type=depth1";
		});
		$(".tbpTalkBtn").click(function() {
			if(${empty sessionScope.loginCheck}) {
				$("#confirmPanel").css("display", "block");
				$("#confirmText").html("로그인 후 이용해주세요.");
				$("#confirmBtn").attr("onclick", "$('#confirmPanel').css('display', 'none')");
				return false;
			} else if(${sessionScope.memberNo == productViewDto.productView.memberNo}) {
				$("#confirmPanel").css("display", "block");
				$("#confirmText").html("자신과는 TALK을 할 수 없습니다.");
				$("#confirmBtn").attr("onclick", "$('#confirmPanel').css('display', 'none')");
				return false;
			}
			var pop = window.open("${pageContext.request.contextPath}/tbptalk/chat/${productViewDto.productView.memberNo}","pop","width=570,height=800, scrollbars=yes, resizable=yes");
		});
	});
function cartIn() {
	var retentionNumber = parseInt($("#retentionNumber").html().trim());
	if(retentionNumber < $("#orderNumber").val()) {
		$(".confirmPanel2").css("display", "none");
		$("#confirmPanel").css("display", "block");
		$("#confirmText").html("해당 상품의 재고가 부족합니다.");
		$("#confirmBtn").attr("onclick", "$('#confirmPanel').css('display', 'none')");
		return false;
	} else {
		if(${empty sessionScope.loginCheck}) {
			location.href = "${pageContext.request.contextPath}/cart/insert?productNo=" + $("#productNo").val();
			return false;
		}
		$.ajax({
			url: "${pageContext.request.contextPath}/cart/insert",
			type: "POST",
			cache: false,
			data: {
				"productNo" : $("#productNo").val(),
				"memberNo" : $("#memberNo").val(),
				"cartStock" : $("#orderNumber").val()
			},
			success: function(data, status) {
				if(status == "success") {
					if(data == "Ok") {
						$(".confirmPanel2").css("display", "none");
						$(".confirmPanel3").css("display", "block");
						$("#confirmText3").html("장바구니에 상품을 담았습니다.");
						$("#goCart").attr("onclick", "location.href='${pageContext.request.contextPath}/myCart'");
						$("#goCancle").attr("onclick", "$('.confirmPanel3').css('display', 'none')");
					} else {
						$(".confirmPanel2").css("display", "none");
						$("#confirmPanel").css("display", "block");
						$("#confirmText").html("알 수 없는 오류입니다.");
						$("#confirmBtn").attr("onclick", "$('#confirmPanel').css('display', 'none')");
					}
				}
			}
		});
	}
}
function questionList() {
	$.ajax({
		url: "${pageContext.request.contextPath}/product/question/select",
		type: "POST",
		cache: false,
		data: {
			"productNo" : $("#productNo").val(),
			"questionRow" : $("#questionRow").val()
		},
		success: function(data, status) {
			if(data.count != 0) {
				var questionData = "";
				var sessionMemberNo = ${empty sessionScope.memberNo? 0:sessionScope.memberNo};
				if(data.questionCount > data.count) { //productViewDto.productView.memberNo
					$("#questionMore").addClass("on");
				} else {
					$("#questionMore").removeClass("on");
				}
				for(var i=0; i<data.count; i++) { //" + (i == data.count-1? ' last':'') + "
					questionData += "<li id='questionBox" + data.list[i].questionNo + "'>";
					questionData += "<div class='buyerGrade'><img src='${pageContext.request.contextPath}/resources/img/grade/" + bgradeCheck(data.list[i].memberBgrade) + ".png'/></div>";
					questionData += "<div class='left'><div class='thumbBox'><img class='thumb' src='${pageContext.request.contextPath}/resources/img/main/profile.png'/></div></div>";
					questionData += "<div class='right'><div class='titleBox'><div class='shopName'><a href='${pageContext.request.contextPath}/shop/" + data.list[i].memberNo + "'>" + (data.list[i].shopName==null? 'TBP SHOP ' + data.list[i].memberNo + '호':data.list[i].shopName) + "</a></div><div class='reviewRegDate'>" + reviewFormat(data.list[i].questionRegDate) + "</div></div>";
					/* questionData += "<div class='productSubject'><a href='${pageContext.request.contextPath}/product/" + data.list[i].productNo + "'>" + data.list[i].productSubject + "</a></div>"; */
					questionData += "<div id='questionContent" + data.list[i].questionNo + "' class='reviewContent'>" + data.list[i].questionContent.replace(/\n/g, "<br>") + "</div>";
					questionData += "<div id='qaAnswer' class='qaFuncBtn" + (sessionMemberNo==${productViewDto.productView.memberNo}? ' on':'') + "' onclick='qaInputOpen(" + data.list[i].questionNo + ")'>답변</div>"
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
					questionData += "<div class='inputABtn' onclick='answerWrite(" + data.list[i].questionNo + ");'>등록</div>";
					questionData += "</div>";
					questionData += "</div>";
					questionData += "</div>";
					questionData += "</div>";
					questionData += "<ul class='questionRecomment' id=qaRecomment" + data.list[i].questionNo + ">";
					questionData += "</ul>";
				}
				$(".contentList ul#questions").html(questionData);
				answerList();
			} else {
				var questionData = "<li class='last'>";
				questionData += "<div class='contentList2'>등록된 문의가 없습니다.</div>"
				questionData += "</li>";
				$(".contentList ul#questions").html(questionData);		
			}
		}
	});
}
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
function reviewList() {
	$.ajax({
		url: "${pageContext.request.contextPath}/product/review",
		cache: false,
		type: "POST",
		data: {
			"productNo" : $("#productNo").val(),
			"reviewRow" : $("#reviewRow").val()
		},
		success: function(data, status) {
			if(status == "success") {
				if(data.status == "Ok") {
					if(data.count != 0) {
						var reviewData = "";
						if(data.reviewCount > data.count) {
							$("#reviewMore").addClass("on");
						} else {					
							$("#reviewMore").removeClass("on");
						}
						for(var i=0; i<data.count; i++) {
							if(i == data.count-1) {									
								reviewData += "<li class='last'>";
							} else {
								reviewData += "<li>";
							} //" + (i == data.count-1? ' last':'') + "
							reviewData += "<div class='buyerGrade'><img src='${pageContext.request.contextPath}/resources/img/grade/" + bgradeCheck(data.list[i].memberBgrade) + ".png'/></div>";
							reviewData += "<div class='left'><div class='thumbBox'><img class='thumb' src='${pageContext.request.contextPath}/resources/img/main/profile.png'/></div></div>";
							reviewData += "<div class='right'><div class='titleBox'><div class='shopName'><a href='${pageContext.request.contextPath}/shop/" + data.list[i].memberNo + "'>" + (data.list[i].shopName==null? 'TBP SHOP ' + data.list[i].memberNo + '호':data.list[i].shopName) + "</a></div><div class='reviewRegDate'>" + reviewFormat(data.list[i].reviewRegDate) + "</div></div>";
							/* reviewData += "<div class='productScoreBox'><div><a href='#'>" + data.list[i].productSubject + "</a></div><div class='score'>평점 : " + data.list[i].productScore + "점</div></div>"; */
							reviewData += "<div class='productScoreBox'><div class='score'>평점 : " + data.list[i].productScore + "점</div></div>";
							reviewData += "<div class='reviewContent'>" + data.list[i].reviewContent.replace(/\n/g, "<br>") + "</div></div>";
							reviewData += "</li>";
						}
						$(".contentList ul#reviews").html(reviewData);
						return false;
					} else {
						var reviewData = "<li class='last'>";
						reviewData += "<div class='contentList2'>등록된 후기가 없습니다.</div>"
						reviewData += "</li>";
						$(".contentList#reviewEmpty ul#reviews").html(reviewData);		
					}
				}
			}
		}
	});
}
function answerList() {
	$.ajax({
		url: "${pageContext.request.contextPath}/product/qRecomment/select",
		cache: false,
		type: "POST",
		data: {
			"productNo" : $("#productNo").val()
		},
		success: function(data, status) {
			if(status == "success") {
				for(var i=0; i<data.count; i++) {
					$("#anCount" + data.list[i].questionNo).html(0);
					$("ul#qaRecomment" + data.list[i].questionNo).html("");
				}
				
				for(var i=0; i<data.count; i++) {
	 				var recommentData = "";
					recommentData += "<li id='qRecommentBox" + data.list[i].qRecommentNo + "'>";
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
					recommentData += reviewFormat(data.list[i].qRecommentRegDate);	
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
function answerWrite(questionNo) {
	if($("#answerInput" + questionNo).val().length > 100) {
		$("#confirmPanel").css("display", "block");
		$("#confirmText").html("답변은 10자 이상 100자 이하로 작성해주세요.");
		$("#confirmBtn").attr("onclick", "$('#confirmPanel').css('display', 'none')");
		return false;
	}
	if(answerFlag) {
 		var productNo = $("#productNo").val();
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
				if(data == "Ok") {					
					$("#questionBox" + questionNo).remove();
					return false;
				} else if(data == "hasComment") {
					$("#confirmPanel").css("display", "block");
					$("#confirmText").html("답변이 등록되어 있어 삭제할 수 없습니다.");
					$("#confirmBtn").attr("onclick", "$('#confirmPanel').css('display', 'none')");
					return false;
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
function questionCheck() {
	var question = $("#qaInput").val();
	
	if(question.length > 100) {
		question = question.substr(0, 99);
		$("#qaInput").val(question);
		questionFlag = false;
	} else {
		if(question.length < 10) {
			questionFlag = false;
		} else {
			questionFlag = true;
		}
		$("#qaLimitCheck").html(question.length);
	}
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
//상품문의 답변 작성 토글
function qaInputOpen(questionNo) {
	$("#answerInputBox" + questionNo).slideToggle();
}
// 상품문의 답글 토글
function qaOpen(questionNo) {
	$("#qaRecomment" + questionNo).toggle(500, function() {
	});
	/* $("#qaRecomment" + questionNo).addClass("on"); */
}
// 해당 상품 페이지 로딩 후 일시, 가격 등 포맷 변환
function allFormat() {
	var today, resultDate;
	
	var regDate = $("#regDateCount").html().replace(/-/g, '/');
	
	regDate = regDate.replace('.0', '');
	
	today = new Date();
 	resultDate = new Date(regDate);
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
	
	var shopSubjects = new Array();
	
	if(${not empty productViewDto.shopProducts}) {
		var shopProductsLength = ${fn:length(productViewDto.shopProducts)};
		
		for(var i=0; i<shopProductsLength; i++) {			
			var shopSubject = $("#shopSubject" + (i+1) + " a").html().trim();
			shopSubjects.push(shopSubject);
		}

		for(var i=0; i<shopSubjects.length; i++) {
/* 			if(shopSubjects[i].length > 10) {
				$("#shopSubject" + (i+1) + " a").html(shopSubjects[i].substr(0, 10) + "...");
			} */
			$("#shopPrice" + (i+1) + "").html($("#shopPrice" + (i+1) + "").html().replace(/\B(?=(\d{3})+(?!\d))/g,","));
		}
	}
	
	var retentionNumber = parseInt($("#retentionNumber").html().trim());
	
	if(retentionNumber == 0) {
		$("#productNumbers").html("0");
		productNumbers = 0;
	}
	
	$("#thisPrice").html($("#thisPrice").html().replace(/\B(?=(\d{3})+(?!\d))/g,","));
	$("#totalPrice").html($("#totalPrice").html().replace(/\B(?=(\d{3})+(?!\d))/g,","));
	$("#regDateCount").html(resultDate);
};
function reviewFormat(regDate) {
	var today, resultDate;
	
	today = new Date();
	resultDate = new Date(regDate);
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
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/productView.css" >
</head>
<body onload="allFormat();">
<jsp:include page="/resources/include/header/otherHeader.jsp"/>
<div class="productViewWrapperTop">
	<div class="productViewInner">
		<div class="productViewInnerTop">
			<span class="ctHome">홈</span> <span class="text1">></span> 
			<div id="depth1" class="depth">
				<div class="currName">${productViewDto.currDepth1}</div>
				<div id="depth1Box" class="dropBox">
					<ul>
						<c:forEach var="i" items="${productViewDto.depth1}">
							<li value="${i.categoryId}"><a href="#">${i.categoryName}</a></li>
						</c:forEach>
					</ul>
				</div>
				<div class="depthImgBox">
					<img src="${pageContext.request.contextPath}/resources/img/join/after_all.png"/>
				</div>
			</div> <span class="text1">></span>
			<div id="depth2" class="depth">
				<div class="currName">${productViewDto.currDepth2}</div>
				<div id="depth2Box" class="dropBox">
					<ul>
						<c:forEach var="i" items="${productViewDto.depth2}">
							<li value="${i.categoryId}"><a href="#">${i.categoryName}</a></li>
						</c:forEach>
					</ul>
				</div>
				<div class="depthImgBox">
					<img src="${pageContext.request.contextPath}/resources/img/join/after_all.png"/>
				</div>
			</div> <span class="text1">></span>
			<div id="depth3" class="depth">
				<div class="currName">${productViewDto.currDepth3}</div>
				<div id="depth3Box" class="dropBox">
					<ul>
						<c:forEach var="i" items="${productViewDto.depth3}">
							<li value="${i.categoryId}"><a href="#">${i.categoryName}</a></li>
						</c:forEach>
					</ul>
				</div>
				<div class="depthImgBox">
					<img src="${pageContext.request.contextPath}/resources/img/join/after_all.png"/>
				</div>
			</div>
		</div>
		<hr>
		<div class="productViewInnerCenter">
			<div class="thumbnailBox">
				<img id="mainThumbnail" class="thumbnailImg on" src="${pageContext.request.contextPath}/resources/upload/${productViewDto.productView.productThumb}"/>
				<c:if test="${fn:length(productViewDto.productImages) > 1}">				
					<div class="thumbPrevBtn">PREV</div>
					<c:set value="${fn:length(productViewDto.productImages)}" var="last"></c:set>
					<c:set value="1" var="numbers"></c:set>
					<c:forEach var="i" items="${productViewDto.productImages}" varStatus="index">
						<c:if test="${productViewDto.productView.productThumb != i.productImgFileSystemName}">
							<img id="productImg${numbers+1}" class="productSubImg" src="${pageContext.request.contextPath}/resources/upload/${i.productImgFileSystemName}"/>
							<c:set value="${numbers+1}" var="numbers"></c:set>			
						</c:if>
					</c:forEach>
					<div class="thumbNextBtn">NEXT</div>
				</c:if>
			</div>
			<div class="detailBox">
 			<form id="orderForm" action="order" method="post">
			<input type="hidden" id="productNo" name="productNo" value="${productViewDto.productView.productNo}"/>
			<input type="hidden" id="memberNo" name="memberNo" value="${sessionScope.memberNo}"/>
				<div class="detailSubject">${productViewDto.productView.productSubject}</div>
				<div class="detailPrice"><span id="thisPrice">${productViewDto.productView.productPrice}</span>원
				<div class="productNumber">
					<div id="productNumberMinus">
						<img src="${pageContext.request.contextPath}/resources/img/product/minus.png">
					</div>
					<div id="productNumberResult">
						<span id="productNumbers">1</span>
						<input type="hidden" id="orderNumber" name="orderNumber" value="1"/>
					</div>
					<div id="productNumberPlus">
						<img src="${pageContext.request.contextPath}/resources/img/product/plus.png">
					</div>
				</div>
				</div>
				<div class="productHistory">
					<div class="historyInner first">
						<img class="historyImg" src="${pageContext.request.contextPath}/resources/img/product/productCart.png"/>
						&nbsp;<span id="cartCount">${productViewDto.productView.cartCount}</span>
					</div>
					<div class="historyInner">
						<img class="historyImg" src="${pageContext.request.contextPath}/resources/img/product/productViewcnt.png"/>
						&nbsp;<span id="viewCount">${productViewDto.productView.productViewcnt}</span>
					</div>
					<div class="historyInner last">
						<img class="historyImg" src="${pageContext.request.contextPath}/resources/img/product/productRegdate.png"/>
						&nbsp;<span id="regDateCount">${productViewDto.productView.productRegDate}</span>
					</div>
				</div>
				<div class="detailProductInfo">
					<div class="productInfoInner">
						상품상태<span id="state"><c:if test="${productViewDto.productView.productStateId == 1}">미개봉 새제품</c:if><c:if test="${productViewDto.productView.productStateId == 2}">새제품</c:if><c:if test="${productViewDto.productView.productStateId == 3}">중고</c:if><c:if test="${productViewDto.productView.productStateId == 4}">중고(하자있음)</c:if><c:if test="${productViewDto.productView.productStateId == 5}">중고(하자심함)</c:if></span>
					</div>
					<div class="productInfoInner">
						보유재고<span id="retentionNumber">${productViewDto.productView.productStock}</span>
					</div>
					<div class="productInfoInner">
						거래방식<span id="way" ><c:if test="${productViewDto.productView.salesWayId == 1}">직접거래</c:if><c:if test="${productViewDto.productView.salesWayId == 2}">택배거래</c:if></span>
					</div>
					<div class="productInfoInner">
						거래지역<c:choose><c:when test="${productViewDto.productView.salesWayId == 1}"><span id="Addr">${productViewDto.productView.productAddr}</span></c:when><c:otherwise><span>-</span></c:otherwise></c:choose>
					</div>
				</div>
				<div class="detailFuncBox">
					<div class="detailFuncInner">
						<div class="funcInnerLeft">
						총 합계 금액
						</div>
						<div class="funcInnerRight">
						<span id="totalPrice">${productViewDto.productView.productPrice}</span><span>원</span>
						</div>
					</div>
				</div>
 			</form> 
			</div>
		</div>
		<div class="thumbnailBoxSub">
			<c:forEach var="i" begin="1" end="${fn:length(productViewDto.productImages)}">
				<c:choose>
					<c:when test="${i == 1}">
						<div id="subThumbSelect${i}" class="subThumbSelect selected">
						<input type="hidden" class="thumbValue" value="${i}"/>
						</div>
					</c:when>
					<c:otherwise>
						<div id="subThumbSelect${i}" class="subThumbSelect">
						<input type="hidden" class="thumbValue" value="${i}"/>
						</div>					
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</div>
		<div class="productViewInnerFunction">
			<div class="innerFunctionBox">
				<div class="cartBtn">장바구니</div><div class="tbpTalkBtn">TBP TALK</div><div class="buyBtn">구매하기</div>
			</div>
		</div>
	</div>
</div>
<div class="productViewShopInfo">
	<div class="shopInfoInner">
		<div class="shopInfoInnerLeft">
			<div class="sellerGrade">
				<c:choose>
					<c:when test="${productViewDto.memberSgrade == 0}">
						<img src="${pageContext.request.contextPath}/resources/img/grade/beginning.png"/>
					</c:when>
					<c:when test="${productViewDto.memberSgrade == 1}">
						<img src="${pageContext.request.contextPath}/resources/img/grade/bronze.png"/>
					</c:when>
					<c:when test="${productViewDto.memberSgrade == 2}">
						<img src="${pageContext.request.contextPath}/resources/img/grade/gold.png"/>
					</c:when>
					<c:when test="${productViewDto.memberSgrade == 3}">
						<img src="${pageContext.request.contextPath}/resources/img/grade/platinum.png"/>
					</c:when>
					<c:when test="${productViewDto.memberSgrade == 4}">
						<img src="${pageContext.request.contextPath}/resources/img/grade/master.png"/>
					</c:when>
				</c:choose>
			</div>
			<div class="leftTitle">
				${empty productViewDto.shop.shopName? 'TBP SHOP ' += productViewDto.shop.memberNo += '호':productViewDto.shop.shopName}
			</div>
			<div class="shopBtn">
				<a href="${pageContext.request.contextPath}/shop/${productViewDto.productView.memberNo}">상점 바로가기</a>
			</div>
		</div>
		<div class="shopInfoInnerRight">
			<div class="rightTitle">
				판매자의 인기 상품
				<hr>
			</div>
			<c:forEach var="i" items="${productViewDto.shopProducts}" varStatus="index">
				<c:choose>
					<c:when test="${index.count == 5}">
						<div class="productList last" onclick="location.href='${pageContext.request.contextPath}/product/${i.productNo}'">
							<div class="productThumb">
								<img class="preview" src="${pageContext.request.contextPath}/resources/upload/${i.productThumb}"/>
							</div>
							<div id="shopSubject${index.count}" class="productSubject">
							<a href="${pageContext.request.contextPath}/product/${i.productNo}">
								${i.productSubject}
							</a>
							</div>
							<div class="productPrice2">
								<span id="shopPrice${index.count}">${i.productPrice}</span><span>원</span>
							</div>
						</div>
					</c:when>
					<c:otherwise>
						<div class="productList" onclick="location.href='${pageContext.request.contextPath}/product/${i.productNo}'">
							<div class="productThumb">
								<img class="preview" src="${pageContext.request.contextPath}/resources/upload/${i.productThumb}"/>
							</div>
							<div id="shopSubject${index.count}" class="productSubject">
							<a href="${pageContext.request.contextPath}/product/${i.productNo}">
								${i.productSubject}
							</a>
							</div>
							<div class="productPrice2">
								<span id="shopPrice${index.count}">${i.productPrice}</span><span>원</span>
							</div>
						</div>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</div>
	</div>
</div>
<div class="productViewWrapperBottom">
	<div class="bottomInnerTop">
		<div class="fixedBox">
			<div class="fixedInner">
				<div class="titleBox">
					<div id="contentTab" class="productTab active">상품설명</div>
					<div id="questionTab" class="productTab">상품문의</div>
					<div id="reviewTab" class="productTab">상품후기</div>
				</div>
			</div>
		</div>
	</div>
 	<div class="bottomInnerBottom">
		<div id="contentArea" class="contentTitle">상품설명</div>
		<div class="contentBox">
			<jsp:scriptlet>
			pageContext.setAttribute("EnterLine", "\n");
			</jsp:scriptlet>
			${fn:replace(productViewDto.productView.productContext, EnterLine, '<br>')}
		</div>
		<div id="questionArea" class="contentTitle">상품문의</div>
		<div class="contentBox2">
			<div class="InputBox">
				<div class="inputBoxTop">
					<textarea id="qaInput" onkeyup="questionCheck();" placeholder="문의 내용을 입력하세요."></textarea>
				</div>
				<div class="inputBoxBottom">
					(<span id="qaLimitCheck">0</span>/100)
					<div class="inputBtn">
						등록
					</div>
				</div>
			</div>
			<div class="contentList">
				<div id="questionEmpty">
					<ul id="questions">
					</ul>
				</div>
			</div>
			<div id="questionMore" class="viewMoreBtn">문의 더 보기</div>
			<input type="hidden" id="questionRow" value="5"/>
		</div>
		<div id="reviewArea" class="contentTitle">상품후기</div>
		<div class="contentBox2 last">
			<div id="reviewEmpty" class="contentList">
				<ul id="reviews">
				</ul>
			</div>
		<div id="reviewMore" class="viewMoreBtn">후기 더 보기</div>
		<input type="hidden" id="reviewRow" value="5"/>
		</div>
	</div>
</div>
<div id="confirmPanel">
	<div id="confirmBox">
		<div id="confirmText"></div>
		<div id="confirmBtn">확인</div>
	</div>
</div>
<div class="confirmPanel2">
	<div class="confirmBox2">
		<div id="confirmText2"></div>
		<div class="confirmBtn2" id="confirmOk">확인</div>
		<div class="confirmBtn2" id="confirmCancle">취소</div>
	</div>
</div>
<div class="confirmPanel3">
	<div class="confirmBox3">
		<div id="confirmText3"></div>
		<div class="confirmBtn3" id="goCart">장바구니로</div>
		<div class="confirmBtn3" id="goCancle">취소</div>
	</div>
</div>
<jsp:include page="/resources/include/footer/mainFooter.jsp"/>
<script>
	var questionFlag = false;
	var answerFlag = false;
</script>
</body>
</html>