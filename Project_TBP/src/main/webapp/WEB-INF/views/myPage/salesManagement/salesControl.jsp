<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script>
	$(document).ready(function() {
		var salesDetailLength = ${fn:length(salesDetailDto)};
		for(var i=0; i<salesDetailLength; i++) {
			var currDate = new Date($("#orderRegDate" + (i+1)).html().replace(/-/, '/').replace('.0', ''));
			var currYear = currDate.getFullYear();
			var currMonth = (currDate.getMonth()+1);
			currMonth = (currMonth + "").length==1? "0"+currMonth:currMonth;
			var currDate = currDate.getDate();
			currDate = (currDate + "").length==1? "0"+currDate:currDate;
			$("#orderPrice" + (i+1)).html($("#orderPrice" + (i+1)).html().trim().replace(/\B(?=(\d{3})+(?!\d))/g,",") + "원");
			$("#orderRegDate" + (i+1)).html(currYear + "-" + currMonth + "-" + currDate);
		}
		$(".pageNumbers").click(function() {
			var currPage = $(this).find("input[type=hidden]").val();
			if(currPage == null) {
				return false;
			} else {
				location.href = "salesManagement?pageType=salesControl&memberNo=${sessionScope.memberNo}&page=" + currPage;
			}
		});
		$(".pageNumberBtn").click(function() {
			var currPage = $(this).find("input[type=hidden]").val();
			if(currPage == null) {
				return false;
			} else {
				location.href = "salesManagement?pageType=salesControl&memberNo=${sessionScope.memberNo}&page=" + currPage;
			}
		});
	});
function orderCancle(orderNo) {
	$(".confirmPanel2").css("display", "block");
	$("#confirmText2").html("정말로 거래를 취소하시겠습니까?");
	$("#confirmOk").attr("onclick", "orderCancleOk(" + orderNo + ");");
	$("#confirmCancle").attr("onclick", "$('.confirmPanel2').css('display', 'none')");
}
function orderCancleOk(orderNo) {
	$(".confirmPanel2").css("display", "none");
	$.ajax({
		url: "${pageContext.request.contextPath}/product/orderCancle",
		type: "POST",
		cache: false,
		data: {
			"orderNo" : orderNo
		},
		success: function(data, status) {
			if(status == "success") {
				if(data == "Ok") {
					$("#registerPanel").css("display", "block");
					$("#registerText").html("정상적으로 처리되었습니다.");
					$("#tbpRegisterCheckBtn").attr("onclick", "location.reload();");
					return false;
				} else if(data == "Already") {
					$("#registerPanel").css("display", "block");
					$("#registerText").html("이미 구매확정 되었거나 취소진행/완료 상품입니다."); 
					$("#tbpRegisterCheckBtn").attr("onclick", "location.reload();");
					return false;
				} else {
					$("#registerPanel").css("display", "block");
					$("#registerText").html("알 수 없는 오류입니다."); 
					$("#tbpRegisterCheckBtn").attr("onclick", "$('#registerPanel').css('display', 'none')");
					return false;
				}
			}
		}
	});
}
</script>
<div class="titleBox">
	<div class="mainTitle">판매내역</div>
	<div class="subTitle">판매관리 > 판매내역</div>
</div>
<div class="contentBox">
	<div class="salesControlBox">
		<div class="salesControlTitle">
			판매/주문서 내역
		<hr>
		</div>
		<table id="productOrder">
		 <thead>
		 	<tr>
		 		<td id="productInfo">상품/주문정보</td><td id="buyerInfo">구매자 정보</td>
		 	</tr>
		 </thead>
		 <tbody>
			<c:choose>
				<c:when test="${empty salesDetailDto || fn:length(salesDetailDto) == 0}">
					<tr>
						<td colspan="2">
							<div class="emptyDto">거래 중이거나 판매한 상품이 없습니다.</div>
						</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach var="i" items="${salesDetailDto}" varStatus="index">
				 	<tr>
				 		<td class="productInfoContent">
				 			<div class="infoContentTop">
				 				<div class="productThumb">
				 					<img class="thumb" src="${pageContext.request.contextPath}/resources/upload/${i.productThumb}"/>
				 				</div>
				 				<div class="info">
				 					 &nbsp;상품 No.<span id="productId">${i.productNo}</span> / 주문 No.<span id="orderNo">${i.orderNo}</span>
				 				</div>
				 				<div class="info">
				 					 &nbsp;<span id="productSubhect"><a href="${pageContext.request.contextPath}/product/${i.productNo}">${i.productSubject}</a></span>
				 				</div>
				 				<div class="info">
				 					 &nbsp;<span class="important">수량 <span id="orderNumber">${i.orderStock}</span>개</span> / 
				 					 <span id="productState">
					 					 <c:choose>
					 					 	<c:when test="${i.productStateId == 1}">
					 					 		미개봉 새제품
					 					 	</c:when>
					 					 	<c:when test="${i.productStateId == 2}">
					 					 		새재품
					 					 	</c:when>
					 					 	<c:when test="${i.productStateId == 3}">
					 					 		중고
					 					 	</c:when>
					 					 	<c:when test="${i.productStateId == 4}">
					 					 		중고(하자있음)
					 					 	</c:when>
					 					 	<c:when test="${i.productStateId == 5}">
					 					 		중고(하자심함)
					 					 	</c:when>
					 					 </c:choose>
				 					 </span>
				 				</div>
				 				<div class="info">
				 					 <span id="salesWayId" class="important">
				 					 	<c:choose>
				 					 		<c:when test="${i.salesWayId == 1}">
				 					 		&nbsp;직접거래
				 					 		</c:when>
				 					 		<c:when test="${i.salesWayId == 2}">
				 					 		&nbsp;택배거래
				 					 		</c:when>
				 					 	</c:choose>
				 					 </span> / 
				 					 <span id="dealState" class="important">
				 					 	<c:choose>
				 					 		<c:when test="${i.orderStatus == 1}">
				 					 			거래중
				 					 		</c:when>
				 					 		<c:when test="${i.orderStatus == 2}">
				 					 			거래완료
				 					 		</c:when>
				 					 		<c:when test="${i.orderStatus == 3 || i.orderStatus == 4}">
				 					 			거래취소중
				 					 		</c:when>
				 					 		<c:when test="${i.orderStatus == 5}">
				 					 			취소완료
				 					 		</c:when>
				 					 	</c:choose>
				 					 </span> / 
				 					 <span id="orderPrice${index.count}" class="important">
				 					 	${i.orderPrice}
				 					 </span> / 
				 					 <span id="orderRegDate${index.count}" class="important">
				 					 	${i.orderRegDate}
				 					 </span>
				 				</div>
				 				<div class="info addr">
				 					 &nbsp;<span id="productAddr">${empty i.productAddr? '-':i.productAddr}</span>
				 				</div>
				 			</div>
				 			<div class="infoContentBottom">
				 				<c:choose>
				 					<c:when test="${i.orderStatus == 1}">
				 						<div class="cancleBtn" onclick="orderCancle(${i.orderNo});">거래취소</div>
				 					</c:when>
				 					<c:when test="${i.orderStatus == 2}">
				 						<div class="orderComment">거래가 완료되었습니다.</div>
				 					</c:when>
				 					<c:when test="${i.orderStatus == 3}">
				 						<div class="orderComment">거래취소 요청 중입니다.</div>
				 					</c:when>
				 					<c:when test="${i.orderStatus == 4}">
				 						<div class="orderComment">거래취소 요청 중입니다.</div>
				 					</c:when>
				 					<c:when test="${i.orderStatus == 5}">
				 						<div class="orderComment">거래취소가 완료되었습니다.</div>
				 					</c:when>
				 				</c:choose>
				 			</div>
				 		</td>
				 		<td class="buyerInfoContent">
							<div class="orderName">수령자</div>
							<div class="orderTel">연락처</div>
							<c:choose>
								<c:when test="${i.salesWayId == 1}">
									<div class="orderNameInfo">${i.memberName}</div>
									<div class="orderTelInfo">${i.memberPnum}</div>
									<div class="orderAddr">주소</div>
									<div class="orderAddrInfo">-</div>
								</c:when>
								<c:otherwise>
									<div class="orderNameInfo">${i.orderName}</div>
									<div class="orderTelInfo">${i.orderTel}</div>
									<div class="orderAddr">주소</div>
									<div class="orderAddrInfo">${i.orderAddr}</div>
								</c:otherwise>
							</c:choose>
				 		</td>
				 	</tr>
			 	</c:forEach>
				</c:otherwise>
			</c:choose>
		 </tbody>
		</table>
		<div class="pageNumberBox">
			<c:if test="${startPage > pageBlock}">
				<div class="pageNumberBtn">
					이전
					<input type="hidden" value="${startPage-10}"/>
				</div>
			</c:if>
			<c:forEach begin="${startPage}" end="${endPage}" varStatus="index">
				<c:if test="${page == index.index}">
					<div class="pageNumbers active">
						${index.index}
					</div>
				</c:if>
				<c:if test="${page != index.index}">
					<div class="pageNumbers">
						${index.index}
						<input type="hidden" value="${index.index}"/>
					</div>
				</c:if>
			</c:forEach>
			<c:if test="${endPage < pageCount}">
				<div class="pageNumberBtn">
					다음
					<input type="hidden" value="${startPage+10}"/>
				</div>
			</c:if>
		</div>
	</div>
</div>