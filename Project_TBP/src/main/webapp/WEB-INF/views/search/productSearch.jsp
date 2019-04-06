<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TBP - ${searchValue} 검색</title>
<jsp:include page="/resources/include/combineScript.jsp"/>
<script type="text/javascript">
$(document).ready(function() {
	$(".pageNumbers").click(function() {
		if($(this).find("input[type=hidden]").val() == null) {
			return false;
		} else {
			var page = $(this).find("input[type=hidden]").val();
			var pageType = $("#pageType").val();
			if(pageType == "re") {
/* 				location.href = "${pageContext.request.contextPath}/search/product?searchValue=${searchValue}&page=" + page; */
				location.href = "${pageContext.request.contextPath}/search/product/reSearch?categoryId=${categoryId}&searchValue=${searchValue}&page=" + page;
			} else if(pageType == "category") {
				location.href = "${pageContext.request.contextPath}/search/product/category?categoryId=${categoryId}&page=" + page + "&type=${type}";			
			} else {
				location.href = "${pageContext.request.contextPath}/search/product?searchValue=${searchValue}&page=" + page;			
			}
		}
	});
 	$("#rightContent div").click(function() {
 		if($(this).find("span").html().replace(/\(|\)/g, "") == "0") {
 			return false;
 		}
 		var rSearchValue = $(this).find("input[type=hidden]").val().split(",");
 		var subType = $("#subType").val();
		if(subType == "depth1") { 			
			location.href = "${pageContext.request.contextPath}/search/product/category?categoryId="+ rSearchValue[0] +"&type=depth2&page=1";
			return false;
 		}
 		location.href = "${pageContext.request.contextPath}/search/product/reSearch?categoryId="+ rSearchValue[0] +"&searchValue=${searchValue}&page=1";
 	});
});
//상품 등록 일시 포맷 변환
function allFormat() {
	var today, resultDate;
	
	for(var i=0; i<${fn:length(searchDto)}; i++) {
		today = new Date();
		resultDate = new Date($("#productRegDate" + (i+1)).html().replace(/-/g, "/").replace(".0", ""));
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
		
		$("#productPrice" + (i+1)).html($("#productPrice" + (i+1)).html().replace(/\B(?=(\d{3})+(?!\d))/g,",") + "원");		
		$("#productRegDate" + (i+1)).html(resultDate);
	}
}
// 상품 가격 천단위 변환
function formatPrice(productPrice) {
	return productPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g,",");
}
</script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/productSearch.css">
</head>
<body onload="allFormat();">
<jsp:include page="/resources/include/header/otherHeader.jsp"/>
<div class="searchWrapper">
	<div class="searchWrapperInner">
		<div class="innerTop">
			<span id="searchValue">${searchValue}</span> 검색결과 <span id="searchCount">${searchAllCount}</span>개 상품
			<input type="hidden" id="pageType" value="${pageType}"/>
			<input type="hidden" id="subType" value="${type}"/>
		</div>
		<div class="innerCenter">
			<table>
				<tr>
					<td id="leftHead">카테고리</td>
					<td id="rightContent">
						<c:forEach var="i" items="${categoryResult}" varStatus="index">
							<div class="categoryBox2">
							${i.categoryName}<br>
							<span>(${i.categoryCount})</span>
							<input type="hidden" value="${i.categoryId},${i.searchValue}"/>
							</div>
						</c:forEach>
					</td>
				</tr>
			</table>
		</div>
		<div class="innerBottom">
			<ul>
				<c:choose>
					<c:when test="${empty searchDto || fn:length(searchDto)==0}">
						<li class="emptyDto"><span>${not empty type? '선택한 카테고리':searchValue}</span>에 대한 검색결과가 없습니다.</li>
					</c:when>
					<c:otherwise>
						<c:forEach var="i" items="${searchDto}" varStatus="index">
							<li class="searchDtoBox${index.count==1? ' first':''}" value="${i.productNo}">
								<div class="thumbBox">
									<a href="${pageContext.request.contextPath}/product/${i.productNo}"><img class="thumb" src="${pageContext.request.contextPath}/resources/upload/${i.productThumb}"/></a>
								</div>
								<div class="subjectBox">
									<a href="${pageContext.request.contextPath}/product/${i.productNo}">${i.productSubject}</a>
								</div>
								<div class="infoBox1">
									<span class="productPrice" id="productPrice${index.count}">${i.productPrice}</span>
									<div class="subInfo">
										<span class="salesWay" id="salesWayId">
											<c:choose>
												<c:when test="${i.salesWayId == 1}">
													직접거래
												</c:when>
												<c:when test="${i.salesWayId == 2}">
													택배거래
												</c:when>
											</c:choose>
										</span>
										<span class="productRegDate" id="productRegDate${index.count}">
											${i.productRegDate}
										</span>
									</div>
								</div>
								<div class="infoBox2">
									<a href="${pageContext.request.contextPath}/shop/${i.shopNo}">${empty i.shopName? 'TBP SHOP ' += i.shopNo += '호':i.shopName}</a>
								</div>
							</li>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>
		<div class="pageNumberBox">
			<c:if test="${startPage > pageBlock}">
				<div class="numberBtn">
					이전
				<input type="hidden" value="${startPage-10}"/>
				</div>
			</c:if>
			<c:forEach begin="${startPage}" end="${endPage}" varStatus="index">
				<c:choose>
					<c:when test="${page==index.index}">
						<div class="pageNumbers active">
							${index.index}
						</div>
					</c:when>
					<c:otherwise>
						<div class="pageNumbers">
							${index.index}
						<input type="hidden" value="${index.index}"/>
						</div>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${endPage < pageCount}">
				<div class="numberBtn">
					다음
				<input type="hidden" value="${startPage+10}"/>
				</div>
			</c:if>
		</div>
	</div>
</div>
<jsp:include page="/resources/include/footer/mainFooter.jsp"/>
</body>
</html>