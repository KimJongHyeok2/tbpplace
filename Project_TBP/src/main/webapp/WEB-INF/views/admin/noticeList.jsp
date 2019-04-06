<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script>
$(document).ready(function() {
	var dtoLength = ${fn:length(allNoticeDto)};
	for(var i=0; i<dtoLength; i++) {
		var regDate = new Date($("#regDate2" + (i+1)).html());
		var c_year = regDate.getFullYear();
		var c_month = (regDate.getMonth() + 1);
		c_month = ((c_month + "").length==1? ("0"+c_month):c_month);
		var c_date = regDate.getDate();
		c_date = ((c_date + "").length==1? ("0"+c_date):c_date);
		var c_hour = regDate.getHours();
		c_hour = ((c_hour + "").length==1? ("0"+c_hour):c_hour);
		var c_minute = regDate.getMinutes();
		c_minute = ((c_minute + "").length==1? ("0"+c_minute):c_minute);		
		
		$("#regDate2" + (i+1)).html(c_year + "-" + c_month + "-" + c_date + " " + c_hour + ":" + c_minute);
	}
	$("table#noticeList tbody tr .td-2").click(function() {
		var allNoticeNo = $(this).parent("tr.notices").find("input[type=hidden]").val();
		$(".notices").removeClass("active");
		$(this).parent("tr.notices").addClass("active");
		
		$.ajax({
			url: "${pageContext.request.contextPath}/rAdmin/allNoticeView",
			type: "POST",
			cache: false,
			data: {
				"allNoticeNo" : allNoticeNo
			},
			success: function(data, status) {
				if(status == "success") {
					if(data.status == "Ok") {
						$(".innerView").css("display", "block");
						$(".innerView .subject").html(data.list[0].allNoticeSubject);
						$(".innerView .content").html(data.list[0].allNoticeContent);
					} else {
						$(".confirmPanel").css("display", "block");
			 			$("#confirmText").html("삭제되었거나 존재하지 않는 글입니다.");
						$("#confirmBtn").attr("onclick", "$('.confirmPanel').css('display', 'none')");
						return false;
					}
				}
			}
		});
	});
});
</script>
<div class="noticeListWrapper">
	<div class="innerList">
		<table id="noticeList">
			<thead>
				<tr>
					<td class="td-1">번호</td><td class="td-1">구분</td><td class="td-2">제목</td><td class="td-3">일시</td>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${fn:length(allNoticeDto) != 0}">
						<c:forEach var="i" items="${allNoticeDto}" varStatus="index">
							<tr class="notices">
								<td class="td-1">${i.allNoticeNo}
								<input type="hidden" value="${i.allNoticeNo}"/>
								</td>
								<td class="td-1">
									<c:choose>
										<c:when test="${i.allNoticeType == 1}">
											일반
										</c:when>
										<c:when test="${i.allNoticeType == 2}">
											시스템
										</c:when>
										<c:when test="${i.allNoticeType == 3}">
											이벤트
										</c:when>
										<c:otherwise>
											오류
										</c:otherwise>
									</c:choose>
								</td>
								<td id="td-2S" class="td-2">${i.allNoticeSubject}</td><td id="regDate2${index.count}" class="td-3">${i.allNoticeRegDate}</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="4" class="emptyDto">등록된 공지사항이 없습니다.</td>
						</tr>
					</c:otherwise>
				</c:choose>
				<tr id="noticePageNumber">
					<td colspan="4">
						<div class="pageNumberBox">
							<c:if test="${startPage > pageBlock}">
								<div class="pageFunc" onclick="location.href = '${pageContext.request.contextPath}/admin/tbpManagement?pageType=noticeList&page=${startPage - 10}'">
									이전
								</div>
							</c:if>
							<c:forEach begin="${startPage}" end="${endPage}" varStatus="index">
								<c:if test="${page == index.index}">
									<div class="pageNumbers active">${index.index}</div>
								</c:if>
								<c:if test="${page != index.index}">
									<div class="pageNumbers" onclick="location.href = '${pageContext.request.contextPath}/admin/tbpManagement?pageType=noticeList&page=${index.index}'">${index.index}</div>
								</c:if>
							</c:forEach>
							<c:if test="${endPage < pageCount}">
								<div class="pageFunc" onclick="location.href = '${pageContext.request.contextPath}/admin/tbpManagement?pageType=noticeList&page=${startPage + 10}'">
									다음
								</div>
							</c:if>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="innerView">
		<div class="subject">제목</div>
		<div class="content">내용</div>
		<div class="funcBox">
			<div id="update">수정하기</div>
		</div>
	</div>
</div>