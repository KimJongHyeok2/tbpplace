<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="//cdn.ckeditor.com/4.11.3/standard/ckeditor.js"></script>
<script>
$(document).ready(function() {
	CKEDITOR.replace('content');
	CKEDITOR.config.width = 1000;
	CKEDITOR.config.height = 700;
	
	$("#nWriteOk").click(function() {
		var allNoticeSubject = $("#subject").val();
		var allNoticeContent = CKEDITOR.instances.content.getData();
		var allNoticeType = $("#selectType option:selected").val();
		if(allNoticeSubject == "" || allNoticeSubject == null || allNoticeSubject.length < 10 || allNoticeSubject.length > 70) {
			$(".confirmPanel").css("display", "block");
 			$("#confirmText").html("제목은 10자 이상 70자 이하로 입력해주세요.");
			$("#confirmBtn").attr("onclick", "$('.confirmPanel').css('display', 'none')");
			return false;
		}
		if(allNoticeContent.length == 0 || allNoticeContent == "" || allNoticeContent == null) {
			$(".confirmPanel").css("display", "block");
 			$("#confirmText").html("내용을 입력해주세요.");
			$("#confirmBtn").attr("onclick", "$('.confirmPanel').css('display', 'none')");
			return false;
		}
		$.ajax({
			url: "${pageContext.request.contextPath}/rAdmin/insertNotice",
			type: "POST",
			cache: false,
			data: {
				"allNoticeSubject" : allNoticeSubject,
				"allNoticeContent" : allNoticeContent,
				"allNoticeType" : allNoticeType
			},
			success: function(data, status) {
				if(status == "success") {
					if(data == "Ok") {
						location.href = "tbpManagement?pageType=noticeList";
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
<div class="noticeSubjectBox">
	<div class="left">제목</div>
	<div class="right"><input type="text" id="subject"/></div>
	<div class="selectType">
		<select id="selectType">
			<option value="1">일반</option>
			<option value="2">시스템</option>
			<option value="3">이벤트</option>
		</select>
	</div>
</div>
<textarea name="content" id="content" rows="10" cols="80">
</textarea>
<div class="noticeFuncBox">
	<div id="nWriteOk">작성하기</div>
</div>