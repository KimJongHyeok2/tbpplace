<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script>
$(document).ready(function() {
	var currPage = ${empty page? 1:page};
	var pageCount = ${empty productCount? 0:productCount};
	$("#nextBtn2").click(function() {
		if(pageCount == 0) {
			$("#registerPanel").css("display", "block");
			$("#registerText").html("등록된 상품이 없습니다.");
			$("#tbpRegisterCheckBtn").attr("onclick", "$('#registerPanel').css('display', 'none')");
			return false;				
		}
		if(currPage >= pageCount) {
			$("#registerPanel").css("display", "block");
			$("#registerText").html("마지막 페이지입니다.");
			$("#tbpRegisterCheckBtn").attr("onclick", "$('#registerPanel').css('display', 'none')");
			return false;
		}
		currPage += 1;
		location.href="salesManagement?pageType=merchandiseControl&memberNo=${sessionScope.memberNo}&page=" + currPage + "&allRow=8";
	});
	$("#prevBtn2").click(function() {
		if(pageCount == 0) {
			$("#registerPanel").css("display", "block");
			$("#registerText").html("등록된 상품이 없습니다.");
			$("#tbpRegisterCheckBtn").attr("onclick", "$('#registerPanel').css('display', 'none')");
			return false;
		}
		if(currPage == 1) {
			$("#registerPanel").css("display", "block");
			$("#registerText").html("첫번째 페이지입니다.");
			$("#tbpRegisterCheckBtn").attr("onclick", "$('#registerPanel').css('display', 'none')");
			return false;
		}
		currPage -= 1;
		location.href="salesManagement?pageType=merchandiseControl&memberNo=${sessionScope.memberNo}&page=" + currPage + "&allRow=8";
		});
	var productCount = ${fn:length(productList)};
	
	for(var i=0; i<productCount; i++) {
		var regDate = new Date($("#regDate" + (i+1) + "").html().replace(/-/g, '/').replace('.0', ''));
		var Year = regDate.getFullYear();
		var Month = ((regDate.getMonth() + 1) + "").length==1? (0 + "" + (regDate.getMonth() + 1)):(regDate.getMonth() + 1);
		var Day = (regDate.getDate() + "").length==1? (0 + "" + regDate.getDate()):regDate.getDate();
		var Hours = (regDate.getHours() + "").length==1? (0 + "" + regDate.getHours()):regDate.getHours();
		var Minutes = (regDate.getMinutes() + "").length==1? (0 + "" + regDate.getMinutes()):regDate.getMinutes();
		
		$("#regDate" + (i+1) + "").html(Year + "-" + Month + "-" + Day + " " + Hours + ":" + Minutes);
		$("#price" + (i+1) + "").html($("#price" + (i+1) + "").html().replace(/\B(?=(\d{3})+(?!\d))/g,",") + "원");
	}
	$(".merchandiseBtn").click(function() {
		var productNo = $(this).find("input[type=hidden]").val();
		$("#salesUpdate" + productNo).submit();
	});
	$(".merchandiseBtn2").click(function() {
		var productNo = $(this).find("input[type=hidden]").val();
		$(".confirmPanel2").css("display", "block");
		$("#confirmText2").html("정말로 삭제하시겠습니까?");
		$("#confirmOk").attr("onclick", "deleteProduct(" + productNo + ");");
		$("#confirmCancle").attr("onclick", "$('.confirmPanel2').css('display', 'none')");	
	});
});
function deleteProduct(productNo) {
	$(".confirmPanel2").css("display", "none");
	$.ajax({
		url: "${pageContext.request.contextPath}/product/delete",
		type: "POST",
		cache: false,
		data: {
			"productNo" : productNo
		},
		success: function(data, status) {
			if(status == "success") {
				if(data == "Ok") {
					location.reload();
				} else if(data == "hasOrder") {
					$("#registerPanel").css("display", "block");
					$("#registerText").html("거래 진행/판매완료 상품이 존재할 경우<br>삭제할 수 없습니다.");
					$("#tbpRegisterCheckBtn").attr("onclick", "$('#registerPanel').css('display', 'none')");
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
	<div class="mainTitle">상품관리</div>
	<div class="subTitle">판매관리 > 상품관리</div>
</div>
<div class="contentBox">
	<div class="merchandiseBox">
		<div class="merchandiseTitle">
			상품목록 / 수정 / 삭제
		<hr>
		</div>
		<table>
			<thead>
				<tr>
					<td class="th1">구분</td><td id="thThumb">섬네일</td><td id="thState">상태</td><td id="thSubject">상품제목/등록일시</td><td class="th1">재고</td><td id="thPrice">가격</td><td class="th1">바구니</td><td class="th1">평점</td><td class="th1">문의</td><td id="thFunc">관리</td>
				</tr>
			</thead>
			<tbody>
			<c:choose>
				<c:when test="${not empty productList || fn:length(productList) != 0}">
					<c:forEach items="${productList}" var="product" varStatus="index">
						<tr>
							<td>${product.productNo}</td><td><div id="tdThumb"><img class="tdThumbs" src="${pageContext.request.contextPath}/resources/upload/${product.productThumb}"/></div></td>
							<td>
							<c:choose>
								<c:when test="${product.productStatus==1}">
									판매중
								</c:when>
								<c:when test="${product.productStatus==2}">
									판매완료
								</c:when>
								<c:when test="${product.productStatus==3}">
									취소요청
								</c:when>
								<c:when test="${product.productStatus==4}">
									취소완료
								</c:when>
							</c:choose>
							</td>
							<td><a href="${pageContext.request.contextPath}/product/${product.productNo}">${product.productSubject}</a><br><br><span id="regDate${index.count}">${product.productRegDate}</span></td><td>${product.productStock}</td><td id="price${index.count}">${product.productPrice}</td><td>${product.cartCount}</td><td>${product.productScore}</td><td>${product.questionCount}</td><td><form action="salesManagement" id="salesUpdate${product.productNo}" method="post"><div id="updateBtn" class="merchandiseBtn">수정<input type="hidden" id="productNo" name="productNo" value="${product.productNo}"/><input type="hidden" id="pageType" name="pageType" value="salesUpdate"/></div></form><div id="deleteBtn" class="merchandiseBtn2">삭제<input type="hidden" id="productNo" name="productNo" value="${product.productNo}"/></div></td>
						</tr>
					</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="10">등록된 상품이 없습니다.</td>
						</tr>
				</c:otherwise>
				</c:choose>
			</tbody>
			</table>
		<div class="nextBtn2" id="nextBtn2">NEXT</div>
		<div class="prevBtn2" id="prevBtn2">PREV</div>
	</div>
</div>