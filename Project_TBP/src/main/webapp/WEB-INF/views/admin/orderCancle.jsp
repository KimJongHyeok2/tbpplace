<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script>
$(document).ready(function() {
	for(var i=0; i<${fn:length(orderCancleDto)}; i++) {
		$("#orderPrice" + (i+1)).html($("#orderPrice" + (i+1)).html().replace(/\B(?=(\d{3})+(?!\d))/g,","));
		
		var regDate = new Date($("#orderRegDate" + (i+1)).html().trim());
		var regDateYear = regDate.getFullYear();
		var regDateMonth = (regDate.getMonth()+1);
		regDateMonth = (("" + regDateMonth).length==1? ("0" + regDateMonth):regDateMonth);
		var regDateDate = regDate.getDate();
		regDateDate = (("" + regDateDate).length==1? ("0" + regDateDate):regDateDate);
		var regDateHour = regDate.getHours();
		regDateHour = (("" + regDateHour).length==1? ("0" + regDateHour):regDateHour);
		var regDateMinutes = regDate.getMinutes();
		regDateMinutes = (("" + regDateMinutes).length==1? ("0" + regDateMinutes):regDateMinutes);
		$("#orderRegDate" + (i+1)).html(regDateYear + "-" + regDateMonth + "-" + regDateDate + " " + regDateHour + ":" + regDateMinutes);
	}
});
function permission(orderNo) {
	$(".confirmPanel2").css("display", "block");
	$("#confirmText2").html("구매/거래취소를 승인하시겠습니까?");
	$("#confirmOk").attr("onclick", "permissionOk(" + orderNo + ");");
	$("#confirmCancle").attr("onclick", "$('.confirmPanel2').css('display', 'none')");
}
function permissionOk(orderNo) {
	$(".confirmPanel2").css("display", "none");
	$.ajax({
		url: "${pageContext.request.contextPath}/rAdmin/orderCancle/permission",
		type: "POST",
		cache: false,
		data: {
			"orderNo" : orderNo
		},
		success: function(data, status) {
			if(status == "success") {
				if(data == "Ok") {
					$(".confirmPanel").css("display", "block");
		 			$("#confirmText").html("정상적으로 처리되었습니다.");
					$("#confirmBtn").attr("onclick", "location.reload();");
				} else {
					$(".confirmPanel").css("display", "block");
		 			$("#confirmText").html("알 수 없는 오류입니다.");
					$("#confirmBtn").attr("onclick", "$('.confirmPanel').css('display', 'none')");
				}
			}
		}
	});
}
function returnOrder(orderNo) {
	$(".confirmPanel2").css("display", "block");
	$("#confirmText2").html("구매/거래취소를 반려하시겠습니까?");
	$("#confirmOk").attr("onclick", "returnOrderOk(" + orderNo + ");");
	$("#confirmCancle").attr("onclick", "$('.confirmPanel2').css('display', 'none')");
}
function returnOrderOk(orderNo) {
	$(".confirmPanel2").css("display", "none");
	$.ajax({
		url: "${pageContext.request.contextPath}/rAdmin/orderCancle/returnOrder",
		type: "POST",
		cache: false,
		data: {
			"orderNo" : orderNo
		},
		success: function(data, status) {
			if(status == "success") {
				if(data == "Ok") {
					$(".confirmPanel").css("display", "block");
		 			$("#confirmText").html("정상적으로 처리되었습니다.");
					$("#confirmBtn").attr("onclick", "location.reload();");
				} else {
					$(".confirmPanel").css("display", "block");
		 			$("#confirmText").html("알 수 없는 오류입니다.");
					$("#confirmBtn").attr("onclick", "$('.confirmPanel').css('display', 'none')");
				}
			}
		}
	});
}
</script>
<table id="orderCancleList">
	<thead>
		<tr>
			<td class="td-1">주문번호</td><td class="td-2">구분(요청자)</td><td class="td-3">상점명</td><td class="td-5">상품제목/주문일시</td><td>주문수량</td><td>주문가격</td><td class="td-7">연락처</td><td class="td-8">승인/반려</td>
		</tr>
	</thead>
	<tbody>
		<c:choose>
			<c:when test="${not empty orderCancleDto || fn:length(orderCancleDto) != 0}">
				<c:forEach var="i" items="${orderCancleDto}" varStatus="index">
					<tr>
						<td class="td-1">${i.orderNo}</td>
						<td class="td-2">${i.orderStatus == 3? '구매자':'판매자'}</td>
						<td class="td-3">
							<div><span class="buyer">B.</span><a href="${pageContext.request.contextPath}/shop/${i.orderShopNo}">${empty i.orderShopName? 'TBP SHOP ' += i.orderShopNo += '호':orderShopName}(${empty i.orderName? '별도확인':i.orderName})</a></div>
							<div><span class="seller">S.</span><a href="${pageContext.request.contextPath}/shop/${i.sellShopNo}">${empty i.sellShopName? 'TBP SHOP ' += i.sellShopNo += '호':sellShopName}(${i.sellMemberName})</a></div>
						</td>
						<td class="td-5 subject">
						<div><a href="${pageContext.request.contextPath}/product/${i.productNo}">${i.productSubject}</a></div>
						<div class="regDate" id="orderRegDate${index.count}">${i.orderRegDate}</div>
						</td>
						<td class="td-2">
							${i.orderStock}개
						</td>
						<td class="td-7">
							<span id="orderPrice${index.count}">${i.orderPrice}</span>원
						</td>
						<td class="td-7">
							<div><span class="buyer">B.</span>${empty i.orderTel? '별도확인':i.orderTel}</div>
							<div><span class="seller">S.</span>${i.sellMemberPnum}</div>
						</td>
						<td class="td-8">
							<div class="funcBtn" onclick="permission(${i.orderNo});">승인</div>
							<div class="funcBtn" onclick="returnOrder(${i.orderNo});">반려</div>
						</td>
					</tr>
				</c:forEach>
				<tr id="orderPageNumber">
					<td colspan="8">
						<div class="pageNumberBox">
							<c:if test="${startPage > pageBlock}">
								<div class="pageFunc" onclick="location.href = '${pageContext.request.contextPath}/admin/tbpManagement?pageType=orderCancle&page=${startPage - 10}'">
									이전
								</div>
							</c:if>
							<c:forEach begin="${startPage}" end="${endPage}" varStatus="index">
								<c:if test="${page == index.index}">
									<div class="pageNumbers active">${index.index}</div>
								</c:if>
								<c:if test="${page != index.index}">
									<div class="pageNumbers" onclick="location.href = '${pageContext.request.contextPath}/admin/tbpManagement?pageType=orderCancle&page=${index.index}'">${index.index}</div>
								</c:if>
							</c:forEach>
							<c:if test="${endPage < pageCount}">
								<div class="pageFunc" onclick="location.href = '${pageContext.request.contextPath}/admin/tbpManagement?pageType=orderCancle&page=${startPage + 10}'">
									다음
								</div>
							</c:if>
						</div>
					</td>
				</tr>
			</c:when>
			<c:otherwise>
				<tr>
					<td class="emptyDto" colspan="8">거래취소 요청이 없습니다.</td>
				</tr>
			</c:otherwise>
		</c:choose>
	</tbody>
</table>