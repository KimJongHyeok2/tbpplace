<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TBP - 고객센터</title>
<jsp:include page="/resources/include/combineScript.jsp"/>
<script type="text/javascript">
$(document).ready(function() {
	if(${not empty param.q}) {
		$(".innerBottom .innerLeft ul li").removeClass("active");
 		$(".innerBottom .innerRight .rightContent").removeClass("on");
		$("#qaTab").addClass("active");
		$("#otoQuestion").addClass("on");
	}
	$(".innerLeft ul li").click(function() {
		$(".innerLeft ul li").removeClass("active");
 		$(this).addClass("active");
		var type = $(this).val();
		if(type == 1) {
			$(".innerRight .rightContent").removeClass("on");
			$("#notice").addClass("on");
		} else if(type == 2) {
			$(".innerRight .rightContent").removeClass("on");
			$("#faq").addClass("on");			
		} else {
			$(".innerRight .rightContent").removeClass("on");
			$("#otoQuestion").addClass("on");						
		}
	});
	$("#questionList").click(function() {
		$(".questionTab").removeClass("active");
		$(this).addClass("active");
		$(".content").removeClass("on");
		$("#list").addClass("on");
		questionList();
	});
	$("#questionWrite").click(function() {
		$(".questionTab").removeClass("active");
		$(this).addClass("active");
		$(".content").removeClass("on");
		$("#write").addClass("on");
		$(".moreQuestionView").css("display", "none");
	});
/* 	$(".question").click(function() {
		$(this).find(".comment").toggle();
	}); */
	$(document).on("click", ".question", function() {
		$(this).find(".comment").toggle();
	});
	questionList()
	$("#cqWrite").click(function() {
		var memberNo = ${empty sessionScope.memberNo? 0:sessionScope.memberNo};
		var subject = $("#cQuestionSubject").val();
		var content = $("#cQuestionContent").val();
		if(subject.length < 10 || subject.length > 50) {
			$("#confirmPanel").css("display", "block");
			$("#confirmText").html("문의제목은 10자 이상 50자 이하로 입력해주세요.");
			$("#confirmBtn").attr("onclick", "$('#confirmPanel').css('display', 'none')");
			return false;	
		}
		if(content.length == 0 || content == "") {
			$("#confirmPanel").css("display", "block");
			$("#confirmText").html("문의내용을 입력해주세요.");
			$("#confirmBtn").attr("onclick", "$('#confirmPanel').css('display', 'none')");
			return false;	
		}
		$.ajax({
			url: "${pageContext.request.contextPath}/rCustomer/questionWrite",
			type: "POST",
			cache: false,
			data: {
				"memberNo" : memberNo,
				"cQuestionSubject" : subject,
				"cQuestionContent" : content
			},
			success: function(data, status) {
				if(status == "success") {
					if(data == "Ok") {
						location.reload();
					} else {
						$("#confirmPanel").css("display", "block");
						$("#confirmText").html("알 수 없는 오류입니다.");
						$("#confirmBtn").attr("onclick", "$('#confirmPanel').css('display', 'none')");
						return false;
					}
				}
			}
		});
	});
	$(".noticeTab").click(function() {
		var noticeType = $(this).find("input[type=hidden]").val();
		$("#noticeType").val(noticeType);
		page(1);
	});
	$(".moreQuestionView").click(function() {
		$("#allRow").val(parseInt($("#allRow").val())+5);
		questionList();
	});
	formatNoticeDate();
	$(".emptyNotice").hover(function() {
		$(this).css("background-color", "white");
	});
	$("ul#noticeList li").click(function() {
		var allNoticeNo = $(this).val();
		
		$.ajax({
			url: "${pageContext.request.contextPath}/rCustomer/allNoticeView",
			type: "POST",
			cache: false,
			data: {
				"allNoticeNo" : allNoticeNo
			},
			success: function(data, status) {
				if(status == "success") {
					if(data.status == "Ok") {
						var type = $(".viewTop .noticeType .type").html().trim();
						
						if(type == "일반") {
							$(".viewTop .noticeType .type").removeClass("type-1");
						} else if(type == "시스템") {
							$(".viewTop .noticeType .type").removeClass("type-2");							
						} else {
							$(".viewTop .noticeType .type").removeClass("type-3");
						}
						
						$(".viewTop .noticeType .type").addClass("type-" + data.list[0].allNoticeType);
						if(data.list[0].allNoticeType == 1) {							
							$(".viewTop .noticeType .type").html("일반");
						} else if(data.list[0].allNoticeType == 2) {
							$(".viewTop .noticeType .type").html("시스템");							
						} else {
							$(".viewTop .noticeType .type").html("이벤트");									
						}
						
						$(".viewTop .noticeSubject").html(data.list[0].allNoticeSubject);
						$(".viewTop .noticeRegDate").html(formatDate(data.list[0].allNoticeRegDate));
						$(".viewMiddle").html(data.list[0].allNoticeContent);
						
						$("ul#noticeList").css("display", "none");
						$("ul#noticeView").css("display", "block");
					} else {
						$("#confirmPanel").css("display", "block");
						$("#confirmText").html("삭제되었거나 존재하지 않는 글입니다.");
						$("#confirmBtn").attr("onclick", "$('#confirmPanel').css('display', 'none')");
						return false;
					}
				}
			}
		});
	});
	$(".listBtn").click(function() {
		$("ul#noticeView").css("display", "none");
		$("ul#noticeList").css("display", "block");
	});
});
function questionList() {
	var memberNo = ${empty sessionScope.memberNo? 0:sessionScope.memberNo};
	$.ajax({
		url: "${pageContext.request.contextPath}/rCustomer/questionSelect",
		type: "POST",
		cache: false,
		data: {
			"memberNo" : memberNo,
			"allRow" : parseInt($("#allRow").val())
		},
		success: function(data, status) {
			if(status == "success") {
				if(data.status == "Ok") {
					var questions = "";
					if(data.cQuestionCount > data.count) {
						$(".moreQuestionView").css("display", "block");
					} else {
						$(".moreQuestionView").css("display", "none");						
					}
					for(var i=0; i<data.count; i++) {
						questions += "<li class='question" + (data.count == (i+1)? ' last':'') + "'>";
							questions += "<div class='left'>" + data.list[i].cQuestionSubject + "</div>";
							questions += "<div class='right'>" + questionStatusFormat(data.list[i].cQuestionStatus) + "</div>";
							questions += "<div class='regDate'>" + formatDate(data.list[i].cQuestionRegDate) + "</div>";
							questions += "<ul id='qa-" + data.list[i].cQuestionNo + "' class='comment'>";
								questions += "<li>";
									questions += "<div class='title'>Q</div>";
									questions += "<div class='qContent'>" + data.list[i].cQuestionContent.replace(/\n/g, '<br>') + "</div>";
								questions += "</li>";
							questions += "</ul>";
							questions += "<ul id='an-" + data.list[i].cQuestionNo + "' class='comment answer'>";
							questions += "</ul>";
						questions += "</li>";
					}
					$("ul#list").html(questions);
					$.ajax({
						url: "${pageContext.request.contextPath}/rCustomer/recommentSelect",
						type: "POST",
						cache: false,
						data: {
							"memberNo" : memberNo,
							"allRow" : parseInt($("#allRow").val())
						},
						success: function(data, status) {
							if(status == "success") {
								if(data.status == "Ok") {
									for(var i=0; i<data.count; i++) {
										var answer = "";
										answer += "<li>";
											answer += "<div class='title'>A</div>";
											answer += "<div class='aContent'>" + data.list[i].cRecommentContent.replace(/\n/g, '<br>') + "</div>";
											answer += "<div class='aRegDate'>" + formatDate(data.list[i].cRecommentRegDate) + "</div>";
										answer += "</li>";
										$("#an-" + data.list[i].cQuestionNo).html(answer);
									}
								}
							}
						}
					});
				} else {
					if(${not empty sessionScope.loginCheck}) {
						var questions = "";
						questions += "<li class='emptyQuestion'>";
						questions += "등록된 문의가 없습니다.";
						questions += "</li>";
						$("ul#list").html(questions);	
					} else {
						var questions = "";
						questions += "<li class='emptyQuestion'>";
						questions += "로그인이 필요합니다.";
						questions += "</li>";
						$("ul#list").html(questions);
						$("ul#list").addClass("empty");
						$("ul#write").html(questions);
					}
				}
			}
		}
	});
}
function page(page) {
	$("#page").val(page);
	$("#noticeForm").submit();
}
function questionStatusFormat(cQuestionStatus) {
	if(cQuestionStatus == 1) {
		return "확인중";
	} else {
		return "답변완료";
	}
}
function formatDate(cQuestionRegDate) {
	var today, resultDate;
	
	today = new Date();
	resultDate = new Date(cQuestionRegDate);
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
function formatNoticeDate() {
	
	var dtoLength = ${fn:length(allNoticeDto)};
	
	for(var i=0; i<dtoLength; i++) {
	
		var today, resultDate;
		
		today = new Date();
		resultDate = new Date($("span#regDate" + (i+1)).html().replace(/-/g, '/').replace('.0', ''));
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
	
		$("span#regDate" + (i+1)).html(resultDate);
	}
}
</script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/customerService.css">
</head>
<body>
<jsp:include page="/resources/include/header/otherHeader.jsp"/>
<div class="customerMainWrapper">
	<div class="customerInner">
		<div class="innerTop">
			<div class="customerTitle">
				고객센터
			</div>
		</div>
		<div class="innerBottom">
			<div class="innerLeft">
				<ul>
					<li id="noticeTab" class="active" value="1">공지사항</li>
					<li id="faqTab" value="2">FAQ</li>
					<li id="qaTab" value="3">1:1 문의</li>
				</ul>
			</div>
			<div class="innerRight">
				<div id="notice" class="rightContent on">
					<div class="noticeTop">
						<div id="allNotice" class="noticeTab ${empty param.noticeType || param.noticeType == 'all'? 'active':''}">전체보기<input type="hidden" value="all"/></div><div id="normal" class="noticeTab ${param.noticeType == 'normal'? 'active':''}">일반<input type="hidden" value="normal"/></div><div id="system" class="noticeTab ${param.noticeType == 'system'? 'active':''}">시스템<input type="hidden" value="system"/></div><div id="event" class="noticeTab ${param.noticeType == 'event'? 'active':''} last">이벤트<input type="hidden" value="event"/></div>
						<form id="noticeForm" action="customerService" method="post">
							<input type="hidden" id="noticeType" name="noticeType" value="${empty noticeType? 'all':noticeType}"/>
							<input type="hidden" id="page" name="page" value="${empty page? 1:page}"/>
						</form>
					</div>
					<div class="noticeBottom">
						<ul id="noticeList">
							<c:choose>
								<c:when test="${fn:length(allNoticeDto) != 0}">
									<c:forEach var="i" items="${allNoticeDto}" varStatus="index">
										<li class="${index.count == fn:length(allNoticeDto)? 'last':''}" value="${i.allNoticeNo}">
											<div class="contentTop">
												<c:choose>
													<c:when test="${i.allNoticeType == 1}">
														<div class="type type-1">
															일반
														</div>
													</c:when>
													<c:when test="${i.allNoticeType == 2}">
														<div class="type type-2">
															시스템
														</div>
													</c:when>
													<c:when test="${i.allNoticeType == 3}">
														<div class="type type-3">
															이벤트
														</div>											
													</c:when>
												</c:choose>
												<div class="subject">
													${i.allNoticeSubject}
												</div>
											</div>
											<div class="contentBottom">
												<span id="regDate${index.count}">${i.allNoticeRegDate}</span>
											</div>
										</li>
									</c:forEach>								
								</c:when>
								<c:otherwise>
									<li class="emptyNotice">
										등록된 공지사항이 없습니다.
									</li>									
								</c:otherwise>
							</c:choose>
							<li id="pageNumberBox">
								<c:if test="${startPage > pageBlock}">
									<div class="pageFunc" onclick="page(${startPage - 10});">
										이전
									</div>
								</c:if>
								<c:forEach begin="${startPage}" end="${endPage}" varStatus="index">
									<c:choose>
										<c:when test="${page == index.index}">
											<div class="pageNumbers active">
												${index.index}
											</div>
										</c:when>
										<c:otherwise>
											<div class="pageNumbers" onclick="page(${index.index});">
												${index.index}
											</div>										
										</c:otherwise>
									</c:choose>
								</c:forEach>
								<c:if test="${endPage < pageCount}">
									<div class="pageFunc" onclick="page(${startPage + 10});">
										다음
									</div>
								</c:if>
							</li>
						</ul>
						<ul id="noticeView">
							<li id="view">
								<div class="viewTop">
									<div class="noticeType">
										<div class="type type-1">
										</div>
									</div>
									<div class="noticeSubject">
									</div>
									<div class="noticeRegDate">
									</div>
								</div>
								<div class="viewMiddle">
								</div>
								<div class="viewBottom">
									<div class="listBtn">
										목록
									</div>
								</div>
							</li>
						</ul>
					</div>
				</div>
				<div id="faq" class="rightContent">
					준비 중
				</div>
				<div id="otoQuestion" class="rightContent">
					<div class="questionTop">
						<div id="questionList" class="questionTab active">문의내역</div><div id="questionWrite" class="questionTab">문의하기</div>
					</div>
					<div class="questionBottom">
						<ul id="list" class="content on">
						</ul>
						<ul id="write" class="content">
							<li>
								<div class="subjectBox">
									<div class="left">제목</div><div class="right"><input type="text" id="cQuestionSubject" name="cQuestionSubject" placeholder="문의제목을 입력해주세요."/></div>
								</div>
							</li>
							<li>
								<div class="contentBox">
									<textarea id="cQuestionContent" name="cQuestionContent" placeholder="문의내용을 입력해주세요."></textarea>
								</div>
							</li>
							<li><div id="cqWrite">작성하기</div></li>
						</ul>
					</div>
					<div class="moreQuestionView">문의 더 보기
					<input type="hidden" id="allRow" value="10"/>
					</div>
				</div>
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
</body>
</html>