<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	$.ajax({
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
	});
});
function categorySearch(categoryId) {
	location.href = "${pageContext.request.contextPath}/search/product/category?categoryId=" + categoryId + "&type=depth2";
}
</script>
<style type="text/css">
.navigation2 {
	border-top: 1px solid #D5D5D5;
	border-bottom: 1px solid #D5D5D5;
	font-family: "나눔고딕";
	font-size: 10pt;
	color: gray;
}
.navigation2 .navigationInner2 {
	position: relative;
	width: 1000px;
	margin: auto;
}
.navigation2 .navigationInner2:after {
  	content: "";
 	display: block;
	clear: both;
}
.navigation2 .navigationInner2 .allCategory2 {
	width: 150px;
	height: 37px;
	float: left;
	line-height: 37px;
	text-align: center;
}
.navigation2 .navigationInner2 .subCategory2 ul {
	list-style-type: none;
	margin: 0;
	padding: 0;
	overflow: hidden;
}
.navigation2 .navigationInner2 .subCategory2 li#allCategory2 {
	float: left;
	padding: 5px;
	cursor: pointer;
}
.navigation2 .navigationInner2 .subCategory2 li#allCategory2 .categoryBox {
	height: 30px;
}
.navigation2 .navigationInner2 .subCategory2 li#allCategory2 .categoryBox div {
	display: inline-block;
	vertical-align: middle;
}
.navigation2 .navigationInner2 .subCategory2 li#allCategory2 .categoryBox .imgBox {
	height: 100%;
}
.navigation2 .navigationInner2 .subCategory2 li#allCategory2 .categoryBox .imgBox img {
	height: 100%;
}
.navigation2 .navigationInner2 .subCategory2 li#allCategory2 .categoryBox .categoryName {
	color: black;
}
.navigation2 .navigationInner2 .subCategory2 li#allCategory2 .allCategoryContent {
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
	z-index: 2;
}
.navigation2 .navigationInner2 .subCategory2 li#allCategory2 .allCategoryContent .depth1 {
	width: 200px;
	border-right: 1px solid #D5D5D5;
}
.navigation2 .navigationInner2 .subCategory2 li#allCategory2 .allCategoryContent .depth1.other {
	padding-left: 5px;
}
.navigation2 .navigationInner2 .subCategory2 li#allCategory2 .allCategoryContent .depth1.last {
	border-right: none;
}
.navigation2 .navigationInner2 .subCategory2 li#allCategory2 .allCategoryContent .depth1 .depth1Name {
	padding: 5px;
	font-size: 15pt;
	color: black;
}
.navigation2 .navigationInner2 .subCategory2 li#allCategory2 .allCategoryContent .depth1 ul.depth2_list li {
	padding: 5px;
	cursor: pointer;
	transition-property: color;
	transition-duration: 0.5s;
}
.navigation2 .navigationInner2 .subCategory2 li#allCategory2 .allCategoryContent .depth1 ul.depth2_list li:hover {
	color: #003399;
}
</style>
<div class="navigation2">
	<div class="navigationInner2">
		<div class="subCategory2">
			<ul id="subCategory2">
				<li id="allCategory2">
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
							</ul>
						</div>
						<div class="depth1 other">
							<div class="depth1Name">의류/잡화</div>
							<ul id="depth2_c200" class="depth2_list">
							</ul>
						</div>
						<div class="depth1 other">
							<div class="depth1Name">레저/자동차</div>
							<ul id="depth2_c300" class="depth2_list">
							</ul>
						</div>
						<div class="depth1 other">
							<div class="depth1Name">뷰티</div>
							<ul id="depth2_c400" class="depth2_list">
							</ul>
						</div>
						<div class="depth1 other last">
							<div class="depth1Name">도서/취미</div>
							<ul id="depth2_c500" class="depth2_list">
							</ul>
						</div>
					</div>
				</li>
			</ul>
		</div>
	</div>
</div>