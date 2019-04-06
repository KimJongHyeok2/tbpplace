<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script>
$(document).ready(function() {
	var leftNavHeight = $(".leftBox").height();
	$(".myPageMainInnerLeft").css("height", leftNavHeight + "px");
	// 구매내역의 구매내역 탭 클릭시
	$("#buyHistory").click(function() {
		$("#buyHistory").addClass("active");
		$("#buyStats").removeClass("active");
	});
	// 구매내역의 구매통계 탭 클릭시
	$("#buyStats").click(function() {
		$(".confirmPanel").css("display", "block");
		$("#confirmText").html("준비 중인 기능입니다.");
		$("#confirmBtn").attr("onclick", "$('.confirmPanel').css('display', 'none')");
		return false;
/* 		$("#buyHistory").removeClass("active");
		$("#buyStats").addClass("active"); */
	});
	// 구매내역 가격/일자 포맷 변환
	var purchasesLength = ${fn:length(purchasesDto)};
	for(var i=0; i<purchasesLength; i++) {
		$("#productPrice" + (i+1)).html($("#productPrice" + (i+1)).html().replace(/\B(?=(\d{3})+(?!\d))/g,",") + "원");
		var regDate = $("#orderDate" + (i+1)).html().replace(/-/g, '/');
		regDate = regDate.replace('.0', '');
		var orderDate = new Date(regDate);
		var orderYear = orderDate.getFullYear();
		var orderMonth = (orderDate.getMonth()+1);
		orderMonth = (orderMonth + "").length==1? '0' + orderMonth:orderMonth;
		var orderDate = orderDate.getDate();
		orderDate = (orderDate + "").length==1? '0' + orderDate:orderDate;
		$("#orderDate" + (i+1)).html(orderYear + "-" + orderMonth + "-" + orderDate);
	}
	// 기간별조회
	$("#time7").click(function() {
		location.href = "${pageContext.request.contextPath}/myPage?pageType=purchases&time=7";
		$("#timeSet").val(7);
	});
	$("#time15").click(function() {
		location.href = "${pageContext.request.contextPath}/myPage?pageType=purchases&time=15";
		$("#timeSet").val(15);
	});
	$("#time30").click(function() {
		location.href = "${pageContext.request.contextPath}/myPage?pageType=purchases&time=30";
		$("#timeSet").val(30);
	});
	// 해당 상품 거래정보 클릭 시
	$(".orderView").click(function() {
		var detailInfo = $(this).find(".detailInfo").val().split(",");
		var salesWayId = $("#salesWayId" + detailInfo[1]).val();
		$(".orderDetailViewPanel").css("display", "block");
		$(".directContent").css("display", "none");
		$(".parcelContent").css("display", "none");
		$(".directly").removeClass("active");
		$(".parcel").removeClass("active");
		if(salesWayId == "1") {
			$(".directly").addClass("active");
			$(".directContent").css("display", "flex");
		} else {
			$(".parcel").addClass("active");
			$(".parcelContent").css("display", "flex");
		}
		$.ajax({
			url: "${pageContext.request.contextPath}/purchases/orderInfo",
			type: "POST",
			cache: false,
			data: {
				"productNo" : detailInfo[0]
			},
			success: function(data, status) {
				if(status == "success") {
					$("#viewOrderNo").html($("#orderNo" + detailInfo[1]).val());
					$("#viewDate").html($("#orderDate" + detailInfo[1]).html());
					$("#shopName").html("<a href='${pageContext.request.contextPath}/shop/" + data.shopNo + "'> " + (data.shopName==null? "TBP SHOP " + data.shopNo + "호":data.shopName) + "</a>")
					$("#sellerPnum").html(data.memberPnum);
					if(salesWayId == "1") {
						$("#dAddr").html(data.productAddr);
					} else {
						$("#dName").html($("#orderName" + detailInfo[1]).val());
						$("#dAddr2").html($("#orderAddr" + detailInfo[1]).val());
						$("#dTel").html($("#orderTel" + detailInfo[1]).val());
					}
				}
			}
		});
	});
	// 거래정보 닫기
	$(".detailViewCancle").click(function() {
		$(".orderDetailViewPanel").css("display", "none");
	});
	// 페이징
	$(".pageNumbers").click(function() {
		var selectPage = $(this).find(".number").val();
		if(selectPage == $("#page").val()) {
			return false;
		}
		location.href = "${pageContext.request.contextPath}/myPage?pageType=purchases&time=" + $("#timeSet").val() + "&page=" + selectPage;
	});
	$(".pageNumberBtn").click(function() {
		var selectPage = $(this).find(".number").val();
		if(selectPage == $("#page").val()) {
			return false;
		}
		location.href = "${pageContext.request.contextPath}/myPage?pageType=purchases&time=" + $("#timeSet").val() + "&page=" + selectPage;
	});
	// 구매확정
	$(".purchaseDecision").click(function() {
		var orderNo = $(this).find("input[type=hidden]").val();
		$(".confirmPanel2").css("display", "block");
		$("#confirmText2").html("정말로 구매를 확정 지으시겠습니까?");
		$("#confirmOk").attr("onclick", "purchaseDecision(" + orderNo + ");");
		$("#confirmCancle").attr("onclick", "$('.confirmPanel2').css('display', 'none')");
		return false;
	});
	$(".purchaseCancle").click(function() {		
		var orderNo = $(this).find("input[type=hidden]").val();
		$(".confirmPanel2").css("display", "block");
		$("#confirmText2").html("구매취소를 요청하시겠습니까?");
		$("#confirmOk").attr("onclick", "purchaseCancle(" + orderNo + ");");
		$("#confirmCancle").attr("onclick", "$('.confirmPanel2').css('display', 'none')");
		return false;
	});
	// 후기작성
	$(".writeReview").click(function() {
		$(".reviewPanel").css("display", "block");
		$("#reviewOrderNo").val($(this).find("input[type=hidden]").val());	
	});
});
function purchaseDecision(orderNo) {
	$.ajax({
		url: "${pageContext.request.contextPath}/purchases/decision",
		type: "POST",
		cache: false,
		data: {
			"orderNo" : orderNo
		},
		success: function(data, status) {
			if(status == "success") {
				if(data == "Ok") {
					location.reload();
				} else {
					$(".confirmPanel2").css("display", "none");
					$(".confirmPanel").css("display", "block");
					$("#confirmText").html(data);
					$("#confirmBtn").attr("onclick", "location.reload();");
					return false;
				}
			}
		}
	});
}
function purchaseCancle(orderNo) {
	$(".confirmPanel2").css("display", "none");
	$.ajax({
		url: "${pageContext.request.contextPath}/purchases/cancle",
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
				} else if(data == "Already") {
					$(".confirmPanel").css("display", "block");
					$("#confirmText").html("이미 구매확정 되었거나 취소진행/완료 상품입니다.");
					$("#confirmBtn").attr("onclick", "location.reload();");
					return false;
				} else {
					$(".confirmPanel").css("display", "block");
					$("#confirmText").html("알 수 없는 오류입니다.");
					$("#confirmBtn").attr("onclick", "$('.confirmPanel').css('display', 'none');");
					return false;
				}
			}
		}
	});
}
function checkReviewLimit() {
	var reviewContent = $("#reviewContent").val();
	if(reviewContent.length > 100) {
		reviewContent = reviewContent.substr(0, 99);
		$("#reviewContent").val(reviewContent);
		reviewFlag = false;
	} else {
		if(reviewContent.length >= 10) {			
			reviewFlag = true;
		} else {
			reviewFlag = false;
		}
	}
	$("#reviewLength").html(reviewContent.length);
}
function reviewWrite() {
	var productScore = $("#productScore option:selected").val();
	var reviewContent = $("#reviewContent").val();
	
	if(reviewContent == "" || reviewContent.length == 0 || reviewFlag == false) {
		$(".confirmPanel").css("display", "block");
		$(".confirmPanel").css("z-index", "2");
		$("#confirmText").html("후기는 10자 이상 100자 이하로 작성해주세요.");
		$("#confirmBtn").attr("onclick", "$('.confirmPanel').css('display', 'none')");
		return false;
	} else {
		$.ajax({
			url: "${pageContext.request.contextPath}/purchases/review",
			type: "POST",
			cache: false,
			data: {
				"reviewOrderNo" : $("#reviewOrderNo").val(),
				"memberNo" : ${sessionScope.memberNo},
				"productScore" : productScore,
				"reviewContent" : reviewContent
			},
			success: function(data, status) {
				if(status == "success") {
					if(data == "Ok") {
						location.reload();
					} else {
						$(".confirmPanel").css("display", "block");
						$("#confirmText").html("알 수 없는 오류입니다.");
						$("#confirmBtn").attr("onclick", "$('.confirmPanel').css('display', 'none')");
						return false;
					}
				}
			}
		});
	}
}
</script>
<div id="buyHistoryMenu" class="myPageMainInnerRight">
	<table class="buyHistoryTitle">
		<tr>
			<td id="buyHistory" class="active">구매내역</td><td id="buyStats">구매통계</td>
		</tr>
	</table>
	<div class="buyHistoryFuncBox">
		<div class="funcBoxInnerLeft">
			기간별조회
		</div>
		<div class="funcBoxInnerRight">
			<div id="time7" class="${param.time==7? 'active':'' || empty param.time? 'active':''}">1주일</div>
			<div id="time15" class="${param.time==15? 'active':''}">15일</div>
			<div id="time30" class="${param.time==30? 'active':''}">1개월</div>
			<input type="hidden" id="timeSet" value="${empty time? 7:time}"/>
		</div>
	</div>
	<table class="buyHistoryContent">
		<thead>
			<tr>
				<td class="orderDate">일자</td><td class="orderInfo">상품정보</td><td class="orderStatus">상태</td><td class="orderCheck">확인/취소/후기</td>
			</tr>
		</thead>
		<tbody>
			<c:choose>
				<c:when test="${not empty purchasesDto && fn:length(purchasesDto) != 0}">
					<c:forEach var="i" items="${purchasesDto}" varStatus="index">
						<tr>
							<td class="orderDate">
								<div class="dateBox">
									<div id="orderDate${index.count}">${i.orderRegDate}</div>
									<input type="hidden" id="orderNo${index.count}" value="${i.orderNo}"/>
									<div class="orderView">
									거래정보
									<input type="hidden" class="detailInfo" value="${i.productNo},${index.count}"/>
									</div>
								</div>
							</td>
							<td id="orderInfo1" class="orderInfos">
			 					<div class="orderInfoBox">
									<div class="orderInfoThumb">
										<img class="thumbs" src="${pageContext.request.contextPath}/resources/upload/${i.productThumb}"/>
									</div>
									<div class="orderInfoContent">
										<div class="productSubject"><a href="${pageContext.request.contextPath}/product/${i.productNo}">${i.orderSubject}</a></div>
										<div class="productNumber"><span>수량 ${i.orderStock}개</span> / 
										<span>
											<c:choose>
												<c:when test="${i.productStateId == 1}">
													미개봉 새제품
												</c:when>
												<c:when test="${i.productStateId == 2}">
													새제품
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
										</span> / 
										<span>
											<c:choose>
												<c:when test="${i.salesWayId == 1}">
													직접거래
													<input type="hidden" id="salesWayId${index.count}" value="${i.salesWayId}"/>
												</c:when>
												<c:when test="${i.salesWayId == 2}">
													택배거래
													<input type="hidden" id="salesWayId${index.count}" value="${i.salesWayId}"/>
													<input type="hidden" id="orderName${index.count}" value="${i.orderName}"/>
													<input type="hidden" id="orderAddr${index.count}" value="${i.orderAddr}"/>
													<input type="hidden" id="orderTel${index.count}" value="${i.orderTel}"/>
												</c:when>
											</c:choose>
										</span>
										</div>
										<hr>
										<div id="productPrice${index.count}" class="productPrice">${i.orderPrice}</div>
									</div>
								</div> 
							</td>
							<td class="orderStatus">
								<span>
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
								</span>
							</td>
							<td class="orderCheck">
								<c:choose>
									<c:when test="${i.orderStatus == 1}">						
										<div id="purchaseDecision${index.count}" class="purchaseDecision">구매확정
										<input type="hidden" value="${i.orderNo}"/>
										</div>
										<div id="purchaseCancle${index.count}"  class="purchaseCancle">구매취소
										<input type="hidden" value="${i.orderNo}"/>
										</div>
									</c:when>
									<c:when test="${i.orderStatus == 2 && i.orderReviewCheck == 1}">
										<div id="writeReview" class="writeReview">후기작성
										<input type="hidden" value="${i.orderNo}"/>
										</div>
									</c:when>
									<c:otherwise>
										-
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="4">
							<div class="emptyDto">거래 중이거나 구매한 상품이 없습니다.</div>						
						</td>
					</tr>
				</c:otherwise>
			</c:choose>

		</tbody>
	</table>
	<div class="pageNumberBox">
		<c:if test="${startPage > pageBlock}">
			<div class="pageNumberBtn">
					이전
				<input type="hidden" class="number" value="${startPage-10}"/>
			</div>
		</c:if>
		<c:forEach var="i" begin="${startPage}" end="${endPage}" varStatus="index">
			<c:if test="${page == index.index}">
				<div class="currPage active">${index.index}</div>
			</c:if>
			<c:if test="${page != index.index}">
				<div class="pageNumbers">
					${index.index}
				<input type="hidden" class="number" value="${index.index}"/>
				</div>
			</c:if>
		</c:forEach>
		<c:if test="${endPage < pageCount}">
			<div class="pageNumberBtn">
				다음
			<input type="hidden" class="number" value="${startPage+10}"/>
			</div>
		</c:if>
	</div>
	<input type="hidden" id="page" value="${page}"/>
	<input type="hidden" id="startPage" value="${startPage}"/>
	<input type="hidden" id="endPage" value="${endPage}"/>
	<input type="hidden" id="pageCount" value="${pageCount}"/>
</div>
<div class="orderDetailViewPanel">
	<div class="orderDetailViewInner">
		<div class="innerTop">
			<div class="innerTopTitle">
				거래정보 <span id="viewDate"></span> <span>주문 No.</span><span id="viewOrderNo">1</span>
			</div>
			<div class="detailViewCancle">
				X
			</div>
		</div>
		<div class="innerBottom">
			<div class="sellerInfo">판매자 정보</div>
			<table class="infoTable">
				<tr>
					<td class="leftHead">상점명</td><td class="rightContent"><span id="shopName"></span></td>
				</tr>
				<tr>
					<td class="leftHead">연락처</td><td class="rightContent"><span id="sellerPnum"></span></td>
				</tr>
			</table>
			<div class="sellerInfo last">거래방식</div>
			<table class="transaction">
				<tr>
					<td class="directly">직접거래</td><td class="parcel">택배거래</td>
				</tr>
			</table>
			<div class="directContent">
				<div class="left">
					거래지역
				</div>
				<div class="right">
					<span id="dAddr"></span>
				</div>
			</div>
			<div class="parcelContent">
				<div class="left">
					수령자
				</div>
				<div class="right">
					<span id="dName"></span>
				</div>
				<div class="left">
					주소
				</div>
				<div class="right">
					<span id="dAddr2"></span>
				</div>
				<div class="left last">
					연락처
				</div>
				<div class="right last">
					<span id="dTel"></span>
				</div>
			</div>
		</div>
	</div>
</div>
<div id="myPage" class="confirmPanel">
	<div class="confirmBox">
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
<div class="reviewPanel">
	<div class="reviewBox">
		<div class="reviewTitle">
			후기작성
		</div>
		<div class="reviewScoreBox">
			<div class="leftHead">평점</div>
			<div class="rightContent">
				<select id="productScore">
					<option>1</option>
					<option>2</option>
					<option>3</option>
					<option>4</option>
					<option>5</option>
				</select>
			</div>
		</div>
		<div class="reviewContentTitle">
			내용 (<span id="reviewLength">0</span>/100)
		</div>
		<div class="reviewContentBox">
			<textarea id="reviewContent" onkeyup="checkReviewLimit();"></textarea>
		</div>
		<div class="reviewBtnBox">
			<div class="reviewBtn" onclick="reviewWrite();">작성
			<input type="hidden" id="reviewOrderNo" value=""/>
			</div>
			<div id="reviewCancle" class="reviewBtn" onclick="$('.reviewPanel').css('display', 'none');">취소</div>
		</div>
	</div>
</div>
<script>
	var reviewFlag = false;
</script>