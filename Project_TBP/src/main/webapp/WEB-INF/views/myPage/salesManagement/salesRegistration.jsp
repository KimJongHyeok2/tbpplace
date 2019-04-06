<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
$(document).ready(function() {
// Select Box 숨김/표시 Count
var depth1_Count = 0;
var depth2_Count = 0;
var depth3_Count = 0;
var way_Count = 0;
var state_Count = 0;
// 페이지 로드 완료 후 카테고리 대분류 불러오기
$.ajax({
	url: getContextPath() + "/category/depth1",
	type: "POST",
	cache: false,
	success: function(data, status) {
		if(status == "success") {
			var count = data.count;
			var category = data.list;
 			var depth1 = "<ul>";
			for(var i=0; i<count; i++) {
 				depth1 += "<li value='" + category[i].categoryId + "'>" + category[i].categoryName + "</li>";
			}
 			depth1 += "</ul>";
 			$("#depth1_Category").html(depth1);
		}
	}
});
// 페이지 로드 완료 후 거래방식 목록 불러오기
$.ajax({
	url: getContextPath() + "/category/salesWay",
	type: "POST",
	cache: false,
	success: function(data, status) {
		if(status == "success") {
			var count = data.count;
			var category = data.list;
				var way = "<ul>";
			for(var i=0; i<count; i++) {
				way += "<li value='" + category[i].salesWayId + "'>" + category[i].salesWayName + "</li>";
			}
			way += "</ul>";
			$("#way_Category").html(way);
		}
	}
});
// 페이지 로드 완료 후 상품상태 목록 불러오기
$.ajax({
	url: getContextPath() + "/category/productState",
	type: "POST",
	cache: false,
	success: function(data, status) {
		if(status == "success") {
			var count = data.count;
			var category = data.list;
 			var state = "<ul>";
			for(var i=0; i<count; i++) {
 				state += "<li value='" + category[i].productStateId + "'>" + category[i].productStateName + "</li>";
			}
 			state += "</ul>";
 			$("#state_Category").html(state);
		}
	}
});
// 카테고리 대분류 Box 클릭시
$("#depth1_Box").click(function() {
	if(depth1_Count == 0) {		
		$("#depth1_Category").css("display", "block");
		depth1_Count = 1;
	} else {
		$("#depth1_Category").css("display", "none");
		depth1_Count = 0;
	}	
});
// 카테고리 중분류 Box 클릭시
$("#depth2_Box").click(function() {
	if(depth2_Count == 0) {
		$("#depth2_Category").css("display", "block");
		depth2_Count = 1;
	} else {
		$("#depth2_Category").css("display", "none");			
		depth2_Count = 0;
	}
});
// 카테고리 소분류 Box 클릭시
$("#depth3_Box").click(function() {
	if(depth3_Count == 0) {
		$("#depth3_Category").css("display", "block");
		depth3_Count = 1;
	} else {
		$("#depth3_Category").css("display", "none");			
		depth3_Count = 0;
	}
});
// 거래방식 Box 클릭시
$("#way_Box").click(function() {
	if(way_Count == 0) {
		$("#way_Category").css("display", "block");
		way_Count = 1;
	} else {
		$("#way_Category").css("display", "none");			
		way_Count = 0;
	}
});
// 상품상태 Box 클릭시
$("#state_Box").click(function() {
	if(state_Count == 0) {
		$("#state_Category").css("display", "block");
		state_Count = 1;
	} else {
		$("#state_Category").css("display", "none");			
		state_Count = 0;
	}
});
// 카테고리 대분류 선택시
$(document).on("click", "#depth1_Category ul li", function() {
	categoryValidity = false;
	$("#depth1_checkIMG").attr("src", getContextPath() + "/resources/img/join/after_all.png");
	$("#depth2_checkIMG").attr("src", getContextPath() + "/resources/img/join/before_all.png");
	$("#category_inputOkIMG").attr("src", getContextPath() + "/resources/img/join/before_all.png");
	$("#depth1_Category").css("display", "none");
	$("#depth2_Box").css("display", "inline-block");
	$("#depth3_Box").css("display", "none");
	$("#depth2_Select").html("선택");
	$("#depth3_Select").html("선택");
	$("#depth1_Select").html($(this).html());
// 선택한 대분류의 하위 카테고리 가져오기
	$.ajax({
		url: getContextPath() + "/category/depth2",
		type: "POST",
		cache: false,
		data: {
			"parentId" : $(this).val()
		},
		success: function(data, status) {
			if(status == "success") {
				var count = data.count;
				var category = data.list;
	 			var depth2 = "<ul>";
				for(var i=0; i<count; i++) {
	 				depth2 += "<li value='" + category[i].categoryId + "'>" + category[i].categoryName + "</li>";
				}
	 			depth2 += "</ul>";
	 			$("#depth2_Category").html(depth2);
			}
		}
	});
});
// 카테고리 중분류 선택시
$(document).on("click", "#depth2_Category ul li", function() {
	categoryValidity = false;
	$("#depth2_checkIMG").attr("src", getContextPath() + "/resources/img/join/after_all.png");
	$("#depth3_checkIMG").attr("src", getContextPath() + "/resources/img/join/before_all.png");
	$("#category_inputOkIMG").attr("src", getContextPath() + "/resources/img/join/before_all.png");
	$("#depth2_Category").css("display", "none");
	$("#depth3_Box").css("display", "inline-block");
	$("#depth2_Select").html($(this).html());
	$("#depth3_Select").html("선택");
	// 선택한 중분류의 하위 카테고리 가져오기
	$.ajax({
		url: getContextPath() + "/category/depth3",
		type: "POST",
		cache: false,
		data: {
			"parentId" : $(this).val()
		},
		success: function(data, status) {
			if(status == "success") {
				var count = data.count;
				var category = data.list;
	 			var depth3 = "<ul>";
				for(var i=0; i<count; i++) {
	 				depth3 += "<li value='" + category[i].categoryId + "'>" + category[i].categoryName + "</li>";
				}
	 			depth3 += "</ul>";
	 			$("#depth3_Category").html(depth3);
			}
		}
	});
});
// 카테고리 소분류 선택시
$(document).on("click", "#depth3_Category ul li", function() {
	categoryValidity = true;
	$("#depth3_checkIMG").attr("src", getContextPath() + "/resources/img/join/after_all.png");
	$("#depth3_checkIMG").attr("src", getContextPath() + "/resources/img/join/after_all.png");
	$("#category_inputOkIMG").attr("src", getContextPath() + "/resources/img/join/after_all.png");
	$("#depth3_Category").css("display", "none");
	$("#depth3_Select").html($(this).html());
	$("#selectCategoryId").val($(this).val());
});
// 거래방식 선택시
$(document).on("click", "#way_Category ul li", function() {
	wayValidity = true;
	$("#way_Category").css("display", "none");
	$("#way_checkIMG").attr("src", getContextPath() + "/resources/img/join/after_all.png");
	$("#way_inputOkIMG").attr("src", getContextPath() + "/resources/img/join/after_all.png");
	$("#way_Select").html($(this).html());
	if($(this).val() == 1) {
		wayValidity = false;
		$("#way_Box2").css("display", "inline-block");
		$("#way_inputOkIMG").attr("src", getContextPath() + "/resources/img/join/before_all.png");
		$("#selectWayId").val($(this).val());
	} else {
		wayValidity = true;
		$("#way_Box2").css("display", "none");
		$("#productAddr").val("");
		$("#way_inputOkIMG").attr("src", getContextPath() + "/resources/img/join/after_all.png");
		$("#selectWayId").val($(this).val());
		$("#productAddr").val("");
	}
});
// 상품상태 선택시
$(document).on("click", "#state_Category ul li", function() {
	stateValidity = true;
	$("#state_Category").css("display", "none");
	$("#state_checkIMG").attr("src", getContextPath() + "/resources/img/join/after_all.png");
	$("#state_inputOkIMG").attr("src", getContextPath() + "/resources/img/join/after_all.png");
	$("#state_Select").html($(this).html());
	$("#selectStateId").val($(this).val());
});
// 등록완료시
 $("#registerOk").click(function() {
	checkProductInputAll();
	var categoryIdValue = $("#selectCategoryId").val();
	var wayIdValue = $("#selectWayId").val();
	var productAddrValue = $("#productAddr").val();
	var stateIdValue = $("#selectStateId").val();
	var titleValue = $("#titleInput").val();
	var contentValue = $("#contentInput").val();
 	var priceValue = $("#priceInput").val();
 	var stockValue = $("#stockInput").val();
	
	if(priceValue < 1000 || priceValue.charAt(0) == 0) {
		$("#registerPanel").css("display", "block");
		$("#registerText").html("가격은 최소 1000원 이상으로 책정해주세요.");
		$("#tbpRegisterCheckBtn").attr("onclick", "$('#registerPanel').css('display', 'none')");
		return false;
	}
	if(priceValue > 10000000) {
		$("#registerPanel").css("display", "block");
		$("#registerText").html("가격은 최대 일천만원 이하로 책정해주세요.");
		$("#tbpRegisterCheckBtn").attr("onclick", "$('#registerPanel').css('display', 'none')");
		return false;
	}
	if(stockValue <= 0 || stockValue.charAt(0) == 0) {
		$("#registerPanel").css("display", "block");
		$("#registerText").html("수량을 확인해주세요.");
		$("#tbpRegisterCheckBtn").attr("onclick", "$('#registerPanel').css('display', 'none')");
		return false;
	}
	if(stockValue > 1000) {
		$("#registerPanel").css("display", "block");
		$("#registerText").html("수량은 1000개 이하로 등록해주세요. ");
		$("#tbpRegisterCheckBtn").attr("onclick", "$('#registerPanel').css('display', 'none')");
		return false;
	}
	if(!mainThumbnailValidity) {
		$("#registerPanel").css("display", "block");
		$("#registerText").html("노출할 메인 이미지를 선택해주세요.");
		$("#tbpRegisterCheckBtn").attr("onclick", "$('#registerPanel').css('display', 'none')");
		return false;
	}
	if(categoryValidity && wayValidity && stateValidity && titleValidity && contentValidity && priceValidity && stockValidity && fileList.length != 0 && mainThumbnailValidity) {
		$.ajax({
			url: getContextPath() + "/product/insert",
			type: "POST",
			cache: false,
			data: {
				"memberNo" : ${sessionScope.memberNo},
				"productThumb" : mainThumbnail,
				"productSubject" : titleValue,
				"productContext" : contentValue,
				"productAddr" : productAddrValue,
				"productStateId" : stateIdValue,
				"salesWayId" : wayIdValue,
				"productPrice" : priceValue,
				"productStock" : stockValue,
				"categoryId" : categoryIdValue,
				"hasOption" : "false",
				"images" : JSON.stringify(imgList).slice(1).slice(0, -1).replace(/\"/g, "")
			},
			success: function(data, status) {
				if(status == "success") {
					if(data == "Ok") {
						$("#registerPanel").css("display", "block");
						$("#registerText").html("상품이 등록되었습니다.");
						$("#tbpRegisterCheckBtn").attr("onclick", "location.href='salesManagement?pageType=merchandiseControl&memberNo=${sessionScope.memberNo}'");
					} else {
						$("#registerPanel").css("display", "block");
						$("#registerText").html("상품 등록을 실패하였습니다.");
						$("#tbpRegisterCheckBtn").attr("onclick", "$('#registerPanel').css('display', 'none')");
					}
				}
			}
		});
	} else {
		if(fileList.length == 0) {				
			$("#registerPanel").css("display", "block");
			$("#registerText").html("상품 이미지를 등록해주세요.");
			$("#tbpRegisterCheckBtn").attr("onclick", "$('#registerPanel').css('display', 'none')");			
		} else {
			$("#registerPanel").css("display", "block");
			$("#registerText").html("입력되지 않은 상품 정보란이 존재합니다.");
			$("#tbpRegisterCheckBtn").attr("onclick", "$('#registerPanel').css('display', 'none')");							
		}
	}
});
// 상품 정보 입력 전체 확인
$(".productInfoEssential on, *").mouseenter(function() {
	checkProductInputAll();
});
$(".productInfoEssential on, *").mouseleave(function() {
	checkProductInputAll();
});
$("input").mouseenter(function() {
	checkProductInputAll();
});
$("input").mouseleave(function() {
	checkProductInputAll();
});
// 이미지 드래그 업로드
fileDropDown();

// 이미지 직접 등록 업로드
$("#imgUpload").change(function() {
	selectFile();
});
// 이미지 프리뷰에 마우스 영역 위치시
$(document).on("mouseenter", "#imgUploadInnerTop div", function() {
	var childImg = $(this).find(".delete");
	childImg.css("display", "block");
});
$(document).on("mouseleave", "#imgUploadInnerTop div", function() {
	$(".delete").css("display", "none");
});
// 이미지 업로드 확인 버튼 클릭시
$("#tbpImgCheckBtn").click(function() {
	if(fileList.length != 0) {
		var html = "";
		for(var i=0; i<fileList.length; i++) {
			if(i==0) {
				html += "<div id='imgBoxInner" + i + "' class='imgBoxInner on'>";
				html += "<img style='width: 100%; height: 100%;' src='" + getContextPath() + "/resources/upload/" + fileList[i].name + "'/>"
				html += "</div>";
				if(fileList.length == 1) {					
					mainThumbnail = imgList[1];
					mainThumbnailValidity = true;
					html += "<div id='mainImgSelectBtn" + i + "' class='mainImgSelectBtn on'><img src='" + getContextPath() + "/resources/img/join/mainThumb_check.png'/></div>";
				} else {
					html += "<div id='mainImgSelectBtn" + i + "' class='mainImgSelectBtn on'>메인 이미지로 선택<input type='hidden' id='imgNumber" + i + "' value='" + fileList[i].name + "'/></div>";
					mainThumbnailValidity = false;
				}
			} else {
				html += "<div id='imgBoxInner" + i + "' class='imgBoxInner'>";
				html += "<img style='width: 100%; height: 100%;' src='" + getContextPath() + "/resources/upload/" + fileList[i].name + "'/>"
				html += "</div>";
				html += "<div id='mainImgSelectBtn" + i + "' class='mainImgSelectBtn'>메인 이미지로 선택<input type='hidden' id='imgNumber" + i + "' value='" + fileList[i].name + "'/></div>";
			}
		}
		imgMaxLength = fileList.length;
		imgCount = 0;
		if(fileList.length > 1) {
			html += "<div class='prevBtn'>PREV</div>";
			html += "<div class='nextBtn'>NEXT</div>";
		}
		$("#imgUpload_allCheck").attr("src", getContextPath() + "/resources/img/join/after_all.png");
		$(".imgBox").html(html);
		$("#imgUploadPanel").css("display", "none");
		$(".prevBtn").css("display", "block");
		$(".nextBtn").css("display", "block");
	} else {
		$("#registerPanel").css("display", "block");
		$("#registerText").html("등록된 이미지가 없습니다.");
		$("#tbpRegisterCheckBtn").attr("onclick", "$('#registerPanel').css('display', 'none')");
	}
});
// 이미지 업로드 취소 버튼 클릭시
$("#tbpImgCancleBtn").click(function() {
	if(fileList.length == 0) {
		$(".prevBtn").css("display", "none");
		$(".nextBtn").css("display", "none");
		$(".imgBox").html("<div class='imgBoxInner on'>이미지가 없습니다.</div>");
		$("#imgUpload_allCheck").attr("src", getContextPath() + "/resources/img/join/before_all.png");
		imgCount = 0;
		mainThumbnailValidity = false;
	} else {
		if(fileList.length != 0) {
			var html = "";
			for(var i=0; i<fileList.length; i++) {
				if(i==0) {
					html += "<div id='imgBoxInner" + i + "' class='imgBoxInner on'>";
					html += "<img style='width: 100%; height: 100%;' src='" + getContextPath() + "/resources/upload/" + fileList[i].name + "'/>"
					html += "</div>";
					if(fileList.length == 1) {					
						mainThumbnail = imgList[1];
						mainThumbnailValidity = true;
						html += "<div id='mainImgSelectBtn" + i + "' class='mainImgSelectBtn on'><img src='" + getContextPath() + "/resources/img/join/mainThumb_check.png'/></div>";
					} else {
						html += "<div id='mainImgSelectBtn" + i + "' class='mainImgSelectBtn on'>메인 이미지로 선택<input type='hidden' id='imgNumber" + i + "' value='" + fileList[i].name + "'/></div>";
						mainThumbnailValidity = false;
					}
				} else {
					html += "<div id='imgBoxInner" + i + "' class='imgBoxInner'>";
					html += "<img style='width: 100%; height: 100%;' src='" + getContextPath() + "/resources/upload/" + fileList[i].name + "'/>"
					html += "</div>";
					html += "<div id='mainImgSelectBtn" + i + "' class='mainImgSelectBtn'>메인 이미지로 선택<input type='hidden' id='imgNumber" + i + "' value='" + fileList[i].name + "'/></div>";
				}
			}
			imgMaxLength = fileList.length;
			imgCount = 0;
			if(fileList.length > 1) {
				html += "<div class='prevBtn'>PREV</div>";
				html += "<div class='nextBtn'>NEXT</div>";
			}
			$("#imgUpload_allCheck").attr("src", getContextPath() + "/resources/img/join/after_all.png");
			$(".imgBox").html(html);
			$("#imgUploadPanel").css("display", "none");
			$(".prevBtn").css("display", "block");
			$(".nextBtn").css("display", "block");
		}
	}
	$("#imgUploadPanel").css("display", "none");
});
// 이미지 이전 버튼 클릭시
$(document).on("click", ".prevBtn", function() {
	if(imgCount <= 0) {
		$("#registerPanel").css("display", "block");
		$("#registerText").html("이미지의 시작입니다.");
		$("#tbpRegisterCheckBtn").attr("onclick", "$('#registerPanel').css('display', 'none')");
		return;
	}
	$("#imgBoxInner" + imgCount).removeClass("on");
	$("#mainImgSelectBtn" + imgCount).removeClass("on");
	imgCount -= 1;
	$("#imgBoxInner" + imgCount).addClass("on");
	$("#mainImgSelectBtn" + imgCount).addClass("on");
	});
// 이미지 다음 버튼 클릭시
$(document).on("click", ".nextBtn", function() {
	if(imgCount == imgMaxLength-1) {
		$("#registerPanel").css("display", "block");
		$("#registerText").html("더 이상 이미지가 없습니다.");
		$("#tbpRegisterCheckBtn").attr("onclick", "$('#registerPanel').css('display', 'none')");
		return;
	}
	$("#imgBoxInner" + imgCount).removeClass("on");
	$("#mainImgSelectBtn" + imgCount).removeClass("on");
	imgCount += 1;
	$("#imgBoxInner" + imgCount).addClass("on");
	$("#mainImgSelectBtn" + imgCount).addClass("on");
	});
});
// 메인 이미지(섬네일) 선택
$(document).on("click", ".mainImgSelectBtn", function() {
	var thumbFlag = false;
	for(var i=0; i<fileList.length; i++) {
		$("#mainImgSelectBtn" + i).html("메인 이미지로 선택<input type='hidden' id='imgNumber" + i + "' value='" + fileList[i].name + "'/></div>");
	}
	for(var i=0; i<imgList.length; i++) {
 		if(imgList[i] == $("#imgNumber" + imgCount).val()) {
			mainThumbnail = imgList[i+1];
			mainThumbnailValidity = true;
			thumbFlag = true;
		}
 		if(thumbFlag) {
 			break;
 		}
	}
	$("#imgNumber" + imgCount).parent("#mainImgSelectBtn" + imgCount).html("<img src='" + getContextPath() + "/resources/img/join/mainThumb_check.png'/>");
});
// Drag 방식 이미지 업로드
function fileDropDown() {
	var dropZone = $("#imgUploadInnerTop");
	// Drag
	dropZone.on("dragenter", function(e) {
		e.preventDefault();
		$("#imgDragCheck").css("display", "none");
	});
	dropZone.on("dragleave", function(e) {
		e.stopPropagation();
		e.preventDefault();
		if(fileList.length == 0) {			
			$("#imgDragCheck").css("display", "block");
		}
	});
	dropZone.on("dragover", function(e) {
		e.stopPropagation();
		e.preventDefault();
	});
	dropZone.on("drop", function(e) {
		e.preventDefault();
		
		var files = e.originalEvent.dataTransfer.files;
		if(files != null) {
			if(files.length < 1) {
				alert("이미지 등록에 실패하였습니다.");
				return;
			}
			selectFile(files);
		} else {
			alert("이미지 등록에 실패하였습니다.");
		}
	});
}
// 이미지 등록
function selectFile(fileObject) {
	var files = null;
	if(fileObject != null) {
		files = fileObject;
	} else {
		files = $("#imgUpload")[0].files;
	}
	
	if(files != null) {
		for(var i=0; i<files.length; i++) {
			if(fileIndex > 5) {
				$("#registerPanel").css("display", "block");
				$("#registerText").html("더 이상 등록할 수 없습니다.");
				$("#tbpRegisterCheckBtn").attr("onclick", "$('#registerPanel').css('display', 'none')");
				break;
			}
			var fileName = files[i].name;
			var fileNameArr = fileName.split("\.");
			
			var ext = fileNameArr[fileNameArr.length-1];
			
			var fileSize = files[i].size / 1024 / 1024;
			
			if(!($.inArray(ext, ["jpg", "jpeg", "jpe", "png"]) >= 0)) {
				$("#registerPanel").css("display", "block");
				$("#registerText").html("허용되지 않는 확장자입니다.");
				$("#tbpRegisterCheckBtn").attr("onclick", "$('#registerPanel').css('display', 'none')");
				break;
			}
			if(fileSize > uploadSize) {
				$("#registerPanel").css("display", "block");
				$("#registerText").html("10MB 이하의 이미지 파일만 업로드 가능합니다.");
				$("#tbpRegisterCheckBtn").attr("onclick", "$('#registerPanel').css('display', 'none')");
				break;
			}
			
			totalFileSize += fileSize;
			fileList[fileIndex] = files[i];
			fileSizeList[fileIndex] = fileSize;
			fileIndex++;
		}
		
		$("#imgUpload").val("");
		var uploadFileList = Object.keys(fileList);
		if(uploadFileList.length == 0) {
			$("#imgDragCheck").css("display", "block");
			return;
		} else {
			$("#imgDragCheck").css("display", "none");
		}
		
		if(uploadFileList.length > 6) {
			return;
		}
		
		var formData = new FormData();
		for(var i=0; i<uploadFileList.length; i++) {
			formData.append("upload["+i+"]", fileList[uploadFileList[i]]);
		}
		
		$.ajax({
			url: getContextPath() + "/upload/img",
			type: "POST",
			data: formData,
			processData: false,
			contentType: false,
			cache: false,
			success: function(data) {
				imgList = new Array();
 				for(var i=0; i<fileList.length*2; i++) {
					imgList.push(data[i]);
				}
				addImgPreview(fileList);
			}
		});
	}
}
// 업로드된 이미지 프리뷰
function addImgPreview(fileList) {
	var html = "";
	for(var i=0; i<fileList.length; i++) {
		html += "<div id=" + i + ">";
		html += "<div class='delete' onclick='deleteImg(" + i + ")'>X</div>"
		html += "<img class='previewImg' src='" + getContextPath() + "/resources/upload/" + fileList[i].name + "'/>";
		html += "</div>";
		$("#imgUploadInnerTop").html(html);
	}
}
// 업로드된 이미지 삭제
function deleteImg(i) {
	fileList.splice(i, 1);
	fileIndex -= 1;
	
	if(fileList.length == 0) {
		$("#imgUploadInnerTop").html("");
		$("#imgDragCheck").css("display", "block");
		imgList = new Array();
	} else {
		var formData = new FormData();
		for(var i=0; i<fileList.length; i++) {
			formData.append("upload["+i+"]", fileList[i]);
		}

		$.ajax({
			url: getContextPath() + "/upload/img",
			type: "POST",
			data: formData,
			processData: false,
			contentType: false,
			cache: false,
			success: function(data) {
				imgList = new Array();
 				for(var i=0; i<fileList.length*2; i++) {
					imgList.push(data[i]);
				}
				addImgPreview(fileList);
			}
		});
	}
}
// 제목 입력시
function checkTitleLimit() {
	checkProductInputAll();
	var titleValue = $("#titleInput").val();
	
	if(titleValue.length >= 30) {
		titleValidity = false;
		$("#checkTitle").css("display", "block");
		$("#checkTitle").html("제목은 30자 이내로 입력해주세요.");
		$("#title_inputOkIMG").attr("src", getContextPath() + "/resources/img/join/before_all.png");
	}
}
function checkTitleOk() {
	checkProductInputAll();
	var titleValue = $("#titleInput").val();
	
 	if(titleValue.length >= 10 && titleValue.length <= 30) {
		titleValidity = true;
		$("#checkTitle").css("display", "none");
		$("#title_inputOkIMG").attr("src", getContextPath() + "/resources/img/join/after_all.png");
	} else {
		if(titleValue.length < 10) {
			titleValidity = false;
			$("#checkTitle").css("display", "block");
			$("#checkTitle").html("제목은 10자 이상으로 입력해주세요.");
			$("#title_inputOkIMG").attr("src", getContextPath() + "/resources/img/join/before_all.png");
		}
	}
}
// 설명 입력시
function checkContent() {
	checkProductInputAll();
	var contentValue = $("#contentInput").val();
	if(contentValue.length >= 10) {
		contentValidity = true;
		$("#checkTitle").css("display", "none");
		$("#content_inputOkIMG").attr("src", getContextPath() + "/resources/img/join/after_all.png");
	} else {
		contentValidity = false;
		$("#checkTitle").css("display", "block");
		$("#checkTitle").html("설명은 10자 이상으로 입력해주세요.");
		$("#content_inputOkIMG").attr("src", getContextPath() + "/resources/img/join/before_all.png");	
	}
}
// 가격 입력시
function checkPriceLimit() {
	checkProductInputAll();
	var priceValue = $("#priceInput").val();
	var price_Pattern = /^[\d]*$/;
		
	if(priceValue.length != 0) {
		if(new RegExp(price_Pattern).test(priceValue)) {
			priceValidity = true;
			$("#checkPrice").css("display", "none");
			$("#price_inputOkIMG").attr("src", getContextPath() + "/resources/img/join/after_all.png");
		} else {
			priceValidity = false;
			$("#checkPrice").css("display", "block");
			$("#checkPrice").html("가격은 정수만 입력 가능합니다.");
			$("#priceInput").val("");
			$("#price_inputOkIMG").attr("src", getContextPath() + "/resources/img/join/before_all.png");
			return false;
		}
	} else {
		priceValidity = false;
		$("#price_inputOkIMG").attr("src", getContextPath() + "/resources/img/join/before_all.png");
	}
}
// 수량 입력시
function checkStockLimit() {
	checkProductInputAll();
	var stockValue = $("#stockInput").val();
	var stock_Pattern = /^[\d]*$/;
		
	if(stockValue.length != 0) {
		if(new RegExp(stock_Pattern).test(stockValue)) {
			stockValidity = true;
			$("#checkStock").css("display", "none");
			$("#stock_inputOkIMG").attr("src", getContextPath() + "/resources/img/join/after_all.png");
		} else {
			stockValidity = false;
			$("#checkStock").css("display", "block");
			$("#checkStock").html("수량은 정수만 입력 가능합니다.");
			$("#stockInput").val("");
			$("#stock_inputOkIMG").attr("src", getContextPath() + "/resources/img/join/before_all.png");
			return false;
		}
	} else {
		stockValidity = false;
		$("#stock_inputOkIMG").attr("src", getContextPath() + "/resources/img/join/before_all.png");
	}
}
// 주소입력 API
function goPopup() {
	var pop = window.open(getContextPath() + "/myPage/salesManagement/jusoPopup","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
}
function jusoCallBack(roadFullAddr) {
	$("#productAddr").val(roadFullAddr);
	$("#way_inputOkIMG").attr("src", getContextPath() + "/resources/img/join/after_all.png");
	
	if($("#productAddr").val() != "" || $("#productAddr").val() != null) {
		wayValidity = true;
	} else {
		wayValidity = false;
	}
}
// 입력 정보에 대한 모든 유효성 체크
function checkProductInputAll() {
	if(categoryValidity && wayValidity && stateValidity && titleValidity && contentValidity && priceValidity && stockValidity) {
		$("#productInput_allCheck").attr("src", getContextPath() + "/resources/img/join/after_all.png");
	} else {
		$("#productInput_allCheck").attr("src", getContextPath() + "/resources/img/join/before_all.png");
		return false;
	}
}
//ContextPath
function getContextPath() {
	var set=location.href.indexOf(location.host)+location.host.length;
	var Path=location.href.substring(set, location.href.indexOf("/", set+1));
	return Path;
}
</script>
<div class="titleBox">
	<div class="mainTitle">상품등록</div>
	<div class="subTitle">판매관리 > 상품등록</div>
</div>
 	<div class="contentBox">
		<div class="imgUploadBox">
			<div class="imgUploadTitle">
				이미지 업로드
				<div class="uploadCheck"><img id="imgUpload_allCheck" src="${pageContext.request.contextPath}/resources/img/join/before_all.png"/></div>
			</div>
			<hr>
			<div class="imgUploadInner">
				<div class="imgBox">
					<div class="imgBoxInner on">
						이미지가 없습니다.
					</div>
				</div>
				<div class="imgInputBox">
					<ol type="1">
						<li>상품 이미지 사이즈는 400x400에 최적화 되어 있습니다.</li>
						<li>등록 가능한 이미지의 최대 크기는 10MB 입니다.</li>
						<li>최대 6개의 이미지를 등록할 수 있습니다.</li>
						<li>페이지 새로고침시 이미지를 다시 업로드 하셔야합니다.</li>
						<li>이미지 업로드시 이미지 파일명이 올바르지 않으면 이미지가 나타나지 않습니다.</li>
					</ol>
				</div>
			</div>
			<div class="imgUploadBottom">
				<div class="imgUploadBtn" onclick="$('#imgUploadPanel').css('display', 'block')">이미지 업로드/수정</div>
			</div>
		</div>
<!-- 			<div class="testBox">준비중</div> -->
		</div>
<div class="contentBox2">
	<div class="productInfoInputBox">
		<div class="productInfoInputTitle">
			상품 정보 입력
			<div class="InputCheck"><img id="productInput_allCheck" src="${pageContext.request.contextPath}/resources/img/join/before_all.png"/></div>
		</div>
		<hr>
		<div class="productInfoInputInner">
			<table>
				<tr>
					<td id="essential" class="active">필수</td><td id="option">옵션</td>
				</tr>
				<tr>
					<td colspan="2">
						<div class="productInfoEssential on">
							<div class="infoInputBox">
								<div class="inputLeftHead">
									카테고리
								</div>
								<div class="inputBoxInner">
									<div id="depth1_Box" class="boxAlign">
										<div id="depth1_Select" class="boxAlignLeft">선택</div>
										<div id="depth1_Category" class="dropDown">
										</div>
										<img id="depth1_checkIMG" src="${pageContext.request.contextPath}/resources/img/join/before_all.png"/>
									</div>
									<div id="depth2_Box" class="boxAlign">
										<div id="depth2_Select" class="boxAlignLeft">선택</div>
										<div id="depth2_Category" class="dropDown">
										</div>
										<img id="depth2_checkIMG" src="${pageContext.request.contextPath}/resources/img/join/before_all.png"/>
									</div>
									<div id="depth3_Box" class="boxAlign">
										<div id="depth3_Select" class="boxAlignLeft">선택</div>
										<div id="depth3_Category" class="dropDown last">
										</div>
										<input type="hidden" id="selectCategoryId" value=""/>
										<img id="depth3_checkIMG" src="${pageContext.request.contextPath}/resources/img/join/before_all.png"/>
									</div>
								</div>
								<div class="inputOkCheck">
									<img id="category_inputOkIMG" src="${pageContext.request.contextPath}/resources/img/join/before_all.png"/>
								</div>
							</div>
							<div class="infoInputBox">
								<div class="inputLeftHead">거래방식</div>								
								<div class="inputBoxInner">
									<div id="way_Box" class="boxAlign">
										<div id="way_Select" class="boxAlignLeft">선택</div>
										<div id="way_Category" class="dropDown">
										</div>
										<input type="hidden" id="selectWayId" value=""/>
										<img id="way_checkIMG" src="${pageContext.request.contextPath}/resources/img/join/before_all.png"/>
									</div>
								</div>
								<div class="inputBoxInner">
									<div id="way_Box2" class="boxAlign">
										<div id="way_Select2" class="boxAlignLeft" onclick="goPopup();">주소검색</div>
										<input class="addr1" type="text" id="productAddr" name="productAddr" disabled="disabled"/>
									</div>
								</div>
								<div class="inputOkCheck">
									<img id="way_inputOkIMG" src="${pageContext.request.contextPath}/resources/img/join/before_all.png"/>
								</div>
							</div>
							<div class="infoInputBox">
								<div class="inputLeftHead">
									상품상태
								</div>
								<div class="inputBoxInner">
									<div id="state_Box" class="boxAlign">
										<div id="state_Select" class="boxAlignLeft">선택</div>
										<div id="state_Category" class="dropDown">
										</div>
										<input type="hidden" id="selectStateId" value=""/>
										<img id="state_checkIMG" src="${pageContext.request.contextPath}/resources/img/join/before_all.png"/>
									</div>
								</div>
								<div class="inputOkCheck">
									<img id="state_inputOkIMG" src="${pageContext.request.contextPath}/resources/img/join/before_all.png"/>
								</div>
							</div>
							<div class="infoInputBox">
								<div class="inputLeftHead">판매제목</div>
								<div class="inputBoxInner">
									<div class="boxAlign2">
									<div id="checkTitle" class="checkInput"></div>
										<input id="titleInput" type="text" onkeydown="checkTitleLimit();" onkeyup="checkTitleOk();" placeholder="제목을 입력해주세요.(10자 이상 30자 이하)"/>
									</div>
								</div>
								<div class="inputOkCheck">
									<img id="title_inputOkIMG" src="${pageContext.request.contextPath}/resources/img/join/before_all.png"/>
								</div>				
							</div>
							<div class="infoInputBox">
								<div class="inputLeftHead">상품설명</div>
								<div class="inputBoxInner">
									<div class="boxAlign3">
										<textarea id="contentInput" onkeyup="checkContent();" placeholder="상품설명을 입력해주세요.(10자 이상)"></textarea>
									</div>
								</div>									
								<div class="inputOkCheck">
									<img id="content_inputOkIMG" src="${pageContext.request.contextPath}/resources/img/join/before_all.png"/>
								</div>				
							</div>
							<div class="infoInputBox">
								<div class="inputLeftHead">상품가격</div>
								<div class="inputBoxInner">
									<div class="boxAlign2">
									<div id="checkPrice" class="checkInput"></div>
										<input id="priceInput" type="text" onkeyup="checkPriceLimit();" onkeydown="return checkPriceLimit();"/>
									</div>
								</div>									
								<div class="inputOkCheck">
									<img id="price_inputOkIMG" src="${pageContext.request.contextPath}/resources/img/join/before_all.png"/>
								</div>
							</div>
							<div class="infoInputBox">
								<div class="inputLeftHead">상품수량</div>
								<div class="inputBoxInner">
									<div class="boxAlign2">
									<div id="checkStock" class="checkInput"></div>
										<input id="stockInput" type="text" onkeyup="checkStockLimit();" onkeydown="return checkStockLimit();"/>
									</div>
								</div>				
								<div class="inputOkCheck">
									<img id="stock_inputOkIMG" src="${pageContext.request.contextPath}/resources/img/join/before_all.png"/>
								</div>				
							</div>
						</div>
					</td>
				</tr>
			</table>
			<div class="productInfoBottom">
				<div id="registerOk" class="productInfoBottomBtn">등록완료</div>
			</div>
		</div>
	</div>
<!-- 			<div class="testBox">준비중</div> -->
</div>
<div id="imgUploadPanel">
	<div id="imgUploadBox">
		<div id="imgDragCheck">
			<img src="${pageContext.request.contextPath}/resources/img/main/upload.png"/>
				이미지를 이 곳에 드래그 해보세요!
			</div>
		<div id="imgUploadInner">
			<div id="imgUploadInnerTop">
			</div>
			<div id="imgUploadInnerBottom">
				<div id="tbpImgUploadBtn"><label for="imgUpload">이미지 직접 업로드</label></div>
				<input type="file" id="imgUpload" multiple="multiple"/>
				<div id="tbpImgCheckBtn">확인</div>
				<div id="tbpImgCancleBtn">취소</div>
			</div>
		</div>
	</div>
</div>
<script>
// 상품 정보 유효성 검사 Flag
var categoryValidity = false;
var wayValidity = false;
var stateValidity = false;
var titleValidity = false;
var contentValidity = false;
var priceValidity = false;
var stockValidity = false;
var mainThumbnailValidity = false;
	
// 파일 번호
var fileIndex = 0;
// 전체 파일 사이즈
var totalFileSize = 0;
// 파일 리스트
var fileList = new Array();
// 파일 사이즈 리스트
var fileSizeList = new Array();
// 등록 가능한 파일 사이즈 제한(단위:MB)
var uploadSize = 10;
// 등록 가능한 총 파일 사이즈 제한(단위:MB)
var maxUploadSize = 100;
// 등록된 이미지 목록 및 On/Off Count 변수
var imgList = new Array();
var imgCount = 0;
var imgMaxLength = fileList.length;
// 선택한 Thumbnail Img
var mainThumbnail = "";
</script>