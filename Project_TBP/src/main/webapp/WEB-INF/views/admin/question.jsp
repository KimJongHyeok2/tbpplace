<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script>
$(document).ready(function() {
	var dtoLength = ${fn:length(cQuestionDto)};
	for(var i=0; i<dtoLength; i++) {
		var regDate = new Date($("#regDate" + (i+1)).html());
		var c_year = regDate.getFullYear();
		var c_month = (regDate.getMonth() + 1);
		c_month = ((c_month + "").length==1? ("0"+c_month):c_month);
		var c_date = regDate.getDate();
		c_date = ((c_date + "").length==1? ("0"+c_date):c_date);
		var c_hour = regDate.getHours();
		c_hour = ((c_hour + "").length==1? ("0"+c_hour):c_hour);
		var c_minute = regDate.getMinutes();
		c_minute = ((c_minute + "").length==1? ("0"+c_minute):c_minute);		
		
		$("#regDate" + (i+1)).html(c_year + "-" + c_month + "-" + c_date + " " + c_hour + ":" + c_minute);
	}
	$(".cQuestion").click(function() {
		var cQuestionNo = $(this).find("input[type=hidden]").val(); 
		$.ajax({
			url: "${pageContext.request.contextPath}/rAdmin/selectCQuestion",
			type: "POST",
			cache: false,
			data: {
				"cQuestionNo" : cQuestionNo
			},
			success: function(data, status) {
				if(status == "success") {
					if(data.status == "Ok") {
						$("#qSubject").html(data.list[0].cQuestionSubject);
						$("#qContent").html(data.list[0].cQuestionContent.replace(/\n/g, '<br>'));
						$(".questionWrapper").css("display", "block");						
						$(".cQuestion").removeClass("active");
						$("#cQuestion" + cQuestionNo).addClass("active");
						$("#cQuestionNo").val(cQuestionNo);
						$("#inputAnswer").focus();
					} else {
						$(".confirmPanel").css("display", "block");
			 			$("#confirmText").html("삭제되었거나 존재하지 않는 문의글입니다.");
						$("#confirmBtn").attr("onclick", "location.reload();");
						return false;
					}
				}
			}
		});
	});
	$("#writeOk").click(function() {
		var cQuestionNo = $("#cQuestionNo").val();
		var cRecommentContent = $("#inputAnswer").val();
		if(cRecommentContent.length < 10 || cRecommentContent.length > 100 || cRecommentContent == "") {			
			$(".confirmPanel").css("display", "block");
 			$("#confirmText").html("답변은 10자 이상 100자 이하로 작성해주세요.");
			$("#confirmBtn").attr("onclick", "$('.confirmPanel').css('display', 'none')");
			return false;
		}
		$.ajax({
			url: "${pageContext.request.contextPath}/rAdmin/insertCRecomment",
			type: "POST",
			cache: false,
			data: {
				"cQuestionNo" : cQuestionNo,
				"cRecommentContent" : cRecommentContent
			},
			success: function(data, status) {
				if(status == "success") {
					if(data == "Ok") {
						location.reload();
					} else if(data == "hasRecomment") {						
						$(".confirmPanel").css("display", "block");
			 			$("#confirmText").html("이미 답변이 등록되어 있습니다.");
						$("#confirmBtn").attr("onclick", "$('.confirmPanel').css('display', 'none')");
						return false;
					} else {
						$(".confirmPanel").css("display", "block");
			 			$("#confirmText").html("알 수 없는 오류입니다.");
						$("#confirmBtn").attr("onclick", "$('.confirmPanel').css('display', 'none')");
						return false;
					}
				}
			}
		});
	});
});
</script>
<table id="questionList">
	<thead>
		<tr>
			<td class="list-1">구분</td><td class="list-3">상점명</td><td class="list-2">문의제목</td><td class="list-3">일시</td><td class="list-5">상태</td>
		</tr>
	</thead>
	<tbody>
		<c:choose>
			<c:when test="${fn:length(cQuestionDto) == 0}">
				<tr>
					<td class="emptyDto" colspan="5">등록된 문의가 없습니다.</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach var="i" items="${cQuestionDto}" varStatus="index">
					<tr id="cQuestion${i.cQuestionNo}" class="cQuestion">
						<td class="list-1">${i.cQuestionNo}</td><td class="list-3"><a href="${pageContext.request.contextPath}/shop/${i.shopNo}">${empty i.shopName? 'TBP SHOP ' += i.shopNo += '호':i.shopName}</a></td><td class="list-2 subject">${i.cQuestionSubject}</td><td id="regDate${index.count}" class="list-3">${i.cQuestionRegDate}</td>
						<td class="list-5">
						<c:choose>
							<c:when test="${i.cQuestionStatus == 1}">
								답변요망
							</c:when>
							<c:otherwise>
								답변완료
							</c:otherwise>
						</c:choose>
						<input type="hidden" value="${i.cQuestionNo}"/>
						</td>
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
		<tr id="pageNumber">
			<td colspan="5">
				<div class="pageNumberBox">
					<c:if test="${startPage > pageBlock}">
						<div class="pageFunc" onclick="location.href='${pageContext.request.contextPath}/admin/tbpManagement?pageType=question&page=${startPage-10}'">이전</div>					
					</c:if>
					<c:forEach var="i" begin="${startPage}" end="${endPage}" varStatus="index">
						<c:if test="${page == index.index}">
							<div class="pageNumbers active">${index.index}</div>
						</c:if>
						<c:if test="${page != index.index}">
							<div class="pageNumbers" onclick="location.href='${pageContext.request.contextPath}/admin/tbpManagement?pageType=question&page=${index.index}'">${index.index}</div>
						</c:if>
					</c:forEach>
					<c:if test="${endPage < pageCount}">
						<div class="pageFunc" onclick="location.href='${pageContext.request.contextPath}/admin/tbpManagement?pageType=question&page=${startPage+10}'">다음</div>
					</c:if>
				</div>
			</td>
		</tr>
	</tbody>
</table>
<div class="questionWrapper">
	<div class="innerLeft">
		<div class="inputBox">
			<textarea id="inputAnswer"></textarea>
		</div>
		<div class="funcBox">
			<div id="writeOk">작성하기</div>
			<input type="hidden" id="cQuestionNo" value=""/>
		</div>
	</div>
	<div class="innerRight">
		<div id="qSubject" class="subject">
			문의등록 테스트입니다.
		</div>
		<div id="qContent" class="content">
			내문의등록 테스트입니다. 내용
		</div>
	</div>
</div>