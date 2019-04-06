<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(document).ready(function() {
	var categoryViewFlag = false;
	$(".categoryBox").click(function() {
		if(categoryViewFlag == false) {
			$(".allCategoryContent").css("visibility", "visible");
			$(".allCategoryContent").animate({"opacity":"1"}, 500);
			categoryViewFlag = true;
		} else {
			$(".allCategoryContent").animate({"opacity":"0"}, 500, function() {
				$(".allCategoryContent").css("visibility", "hidden");
			});
			categoryViewFlag = false;
		}
	});
/* 	$.ajax({
		url: "${pageContext.request.contextPath}/category/navCategory",
		type: "POST",
		cache: false,
		success: function(data, status) {
			if(status == "success") {
				if(data.status == "Ok") {
					for(var i=0; i<data.count; i++) {
						if(data.list[i].categoryParent == 100) {
							$("ul#depth2_c100").append("<li onclick='categorySearch(" + data.list[i].categoryId + ")'>" + data.list[i].categoryName + "</li>");
						} else if(data.list[i].categoryParent == 200) {
							$("ul#depth2_c200").append("<li onclick='categorySearch(" + data.list[i].categoryId + ")'>" + data.list[i].categoryName + "</li>");
						} else if(data.list[i].categoryParent == 300) {
							$("ul#depth2_c300").append("<li onclick='categorySearch(" + data.list[i].categoryId + ")'>" + data.list[i].categoryName + "</li>");
						} else if(data.list[i].categoryParent == 400) {
							$("ul#depth2_c400").append("<li onclick='categorySearch(" + data.list[i].categoryId + ")'>" + data.list[i].categoryName + "</li>");
						} else if(data.list[i].categoryParent == 500) {
							$("ul#depth2_c500").append("<li onclick='categorySearch(" + data.list[i].categoryId + ")'>" + data.list[i].categoryName + "</li>");
						}
					}
				} else {
					alert("알 수 없는 오류입니다.");
				}
			}
		}
	}); */
});
function categorySearch(categoryId) {
	location.href = "${pageContext.request.contextPath}/search/product/category?categoryId=" + categoryId + "&type=depth2";
}
</script>
<style type="text/css">
.navigation {
	border-top: 1px solid #D5D5D5;
	border-bottom: 1px solid #D5D5D5;
	font-family: "나눔고딕";
	font-size: 10pt;
	color: gray;
}
.navigation .navigationInner {
	position: relative;
	width: 1000px;
	margin: auto;
}
.navigation .navigationInner:after {
  	content: "";
 	display: block;
	clear: both;
}
.navigation .navigationInner .allCategory {
	width: 150px;
	height: 37px;
	float: left;
	line-height: 37px;
	text-align: center;
}
.navigation .navigationInner .subCategory ul {
	list-style-type: none;
	margin: 0;
	padding: 0;
	overflow: hidden;
}
.navigation .navigationInner .subCategory li#allCategory {
	float: left;
	padding: 5px;
	cursor: pointer;
}
.navigation .navigationInner .subCategory li#allCategory .categoryBox {
	height: 30px;
}
.navigation .navigationInner .subCategory li#allCategory .categoryBox div {
	display: inline-block;
	vertical-align: middle;
}
.navigation .navigationInner .subCategory li#allCategory .categoryBox .imgBox {
	height: 100%;
}
.navigation .navigationInner .subCategory li#allCategory .categoryBox .imgBox img {
	height: 100%;
}
.navigation .navigationInner .subCategory li#allCategory .categoryBox .categoryName {
	color: black;
}
.navigation .navigationInner .subCategory li#allCategory .allCategoryContent {
	visibility: hidden;
	position: absolute;
	display: flex;
	justify-content: space-between;
	padding: 15px;
	width: 1000px;
	top: 100%;
	left: 0;
	cursor: default;
	border: 1px solid #D5D5D5;
	background-color: white;
	box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
	box-sizing: border-box;
	opacity: 0;
	z-index: 3;
}
.navigation .navigationInner .subCategory li#allCategory .allCategoryContent .depth1 {
	width: 200px;
	border-right: 1px solid #D5D5D5;
}
.navigation .navigationInner .subCategory li#allCategory .allCategoryContent .depth1.other {
	padding-left: 5px;
}
.navigation .navigationInner .subCategory li#allCategory .allCategoryContent .depth1.last {
	border-right: none;
}
.navigation .navigationInner .subCategory li#allCategory .allCategoryContent .depth1 .depth1Name {
	padding: 5px;
	font-size: 15pt;
	color: black;
}
.navigation .navigationInner .subCategory li#allCategory .allCategoryContent .depth1 ul.depth2_list li {
	padding: 5px;
	cursor: pointer;
	transition-property: color;
	transition-duration: 0.5s;
}
.navigation .navigationInner .subCategory li#allCategory .allCategoryContent .depth1 ul.depth2_list li:hover {
	color: #003399;
}
</style>
<div class="navigation">
	<div class="navigationInner">
		<div class="subCategory">
			<ul>
				<li id="allCategory">
					<div class="categoryBox">
						<div class="imgBox">
							<img src="${pageContext.request.contextPath}/resources/img/main/category.png"/>
						</div>
						<div class="categoryName">
							전체 카테고리
						</div>
					</div>
					<div class="allCategoryContent">
						<div class="depth1">
							<div class="depth1Name">디지털/가전</div>
							<ul id="depth2_c100" class="depth2_list">
								<c:forEach var="i" items="${categoryPopularDto.c100}">
									<li onclick="searchCategory(${i.categoryId})">${i.categoryName}</li>
								</c:forEach>
							</ul>
						</div>
						<div class="depth1 other">
							<div class="depth1Name">의류/잡화</div>
							<ul id="depth2_c200" class="depth2_list">
								<c:forEach var="i" items="${categoryPopularDto.c200}">
									<li onclick="searchCategory(${i.categoryId})">${i.categoryName}</li>
								</c:forEach>
							</ul>
						</div>
						<div class="depth1 other">
							<div class="depth1Name">레저/자동차</div>
							<ul id="depth2_c300" class="depth2_list">
								<c:forEach var="i" items="${categoryPopularDto.c300}">
									<li onclick="searchCategory(${i.categoryId})">${i.categoryName}</li>
								</c:forEach>
							</ul>
						</div>
						<div class="depth1 other">
							<div class="depth1Name">뷰티</div>
							<ul id="depth2_c400" class="depth2_list">
								<c:forEach var="i" items="${categoryPopularDto.c400}">
									<li onclick="searchCategory(${i.categoryId})">${i.categoryName}</li>
								</c:forEach>
							</ul>
						</div>
						<div class="depth1 other last">
							<div class="depth1Name">도서/취미</div>
							<ul id="depth2_c500" class="depth2_list">
								<c:forEach var="i" items="${categoryPopularDto.c500}">
									<li onclick="searchCategory(${i.categoryId})">${i.categoryName}</li>
								</c:forEach>
							</ul>
						</div>
					</div>
				</li>
			</ul>
		</div>
	</div>
</div>