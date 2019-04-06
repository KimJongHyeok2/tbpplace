<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(document).ready(function() {
	$("#nowBGradeMoney").html($("#nowBGradeMoney").html().replace(/\B(?=(\d{3})+(?!\d))/g,",") + "원");
	$("#nowSGradeMoney").html($("#nowSGradeMoney").html().replace(/\B(?=(\d{3})+(?!\d))/g,",") + "원");
});
</script>
<div class="myPageMainInnerRight">
	<div class="myGradeWrapper">
		<div class="innerTop">
			<div class="myGradeBox">
				<div class="gradeContent">
					<div class="gradeTitle">${memberName}님의 등급은 아래와 같습니다.</div>
					<table>
						<tr>
							<td class="gradeName">구매</td>
							<td class="myGrade">
								<div class="gradeImg">
									<c:choose>
										<c:when test="${memberBgrade == 0}">
											<img src="${pageContext.request.contextPath}/resources/img/grade/beginning.png"/>
										</c:when>
										<c:when test="${memberBgrade == 1}">
											<img src="${pageContext.request.contextPath}/resources/img/grade/bronze.png"/>
										</c:when>
										<c:when test="${memberBgrade == 2}">
											<img src="${pageContext.request.contextPath}/resources/img/grade/gold.png"/>
										</c:when>
										<c:when test="${memberBgrade == 3}">
											<img src="${pageContext.request.contextPath}/resources/img/grade/platinum.png"/>
										</c:when>
										<c:when test="${memberBgrade == 4}">
											<img src="${pageContext.request.contextPath}/resources/img/grade/master.png"/>
										</c:when>
									</c:choose>
								</div>
								<div class="gradeText">
									<c:choose>
										<c:when test="${memberBgrade == 0}">
											<span class="beginning">BEGINNING</span>
										</c:when>
										<c:when test="${memberBgrade == 1}">
											<span class="bronze">BRONZE</span>
										</c:when>
										<c:when test="${memberBgrade == 2}">
											<span class="gold">GOLD</span>
										</c:when>
										<c:when test="${memberBgrade == 3}">
											<span class="platinum">PLATINUM</span>
										</c:when>
										<c:when test="${memberBgrade == 4}">
											<span class="master">MASTER</span>
										</c:when>
									</c:choose>
								</div>
							</td>
						</tr>
						<tr>
							<td class="gradeName">판매</td>
							<td class="myGrade">
								<div class="gradeImg">
									<c:choose>
										<c:when test="${memberSgrade == 0}">
											<img src="${pageContext.request.contextPath}/resources/img/grade/beginning.png"/>
										</c:when>
										<c:when test="${memberSgrade == 1}">
											<img src="${pageContext.request.contextPath}/resources/img/grade/bronze.png"/>
										</c:when>
										<c:when test="${memberSgrade == 2}">
											<img src="${pageContext.request.contextPath}/resources/img/grade/gold.png"/>
										</c:when>
										<c:when test="${memberSgrade == 3}">
											<img src="${pageContext.request.contextPath}/resources/img/grade/platinum.png"/>
										</c:when>
										<c:when test="${memberSgrade == 4}">
											<img src="${pageContext.request.contextPath}/resources/img/grade/master.png"/>
										</c:when>
									</c:choose>
								</div>
								<div class="gradeText">
									<c:choose>
										<c:when test="${memberSgrade == 0}">
											<span class="beginning">BEGINNING</span>
										</c:when>
										<c:when test="${memberSgrade == 1}">
											<span class="bronze">BRONZE</span>
										</c:when>
										<c:when test="${memberSgrade == 2}">
											<span class="gold">GOLD</span>
										</c:when>
										<c:when test="${memberSgrade == 3}">
											<span class="platinum">PLATINUM</span>
										</c:when>
										<c:when test="${memberSgrade == 4}">
											<span class="master">MASTER</span>
										</c:when>
									</c:choose>
								</div>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<div class="nextGradeContent">
				<div class="nextGradeBox m">
					<div class="gradeTitle">구매등급 상향 조건</div>
					<div class="nextGrade">
						<div class="gradeImg">
							<c:choose>
								<c:when test="${memberBgrade == 0}">
									<img src="${pageContext.request.contextPath}/resources/img/grade/bronze.png"/>
								</c:when>
								<c:when test="${memberBgrade == 1}">
									<img src="${pageContext.request.contextPath}/resources/img/grade/gold.png"/>
								</c:when>
								<c:when test="${memberBgrade == 2}">
									<img src="${pageContext.request.contextPath}/resources/img/grade/platinum.png"/>
								</c:when>
								<c:when test="${memberBgrade == 3}">
									<img src="${pageContext.request.contextPath}/resources/img/grade/master.png"/>
								</c:when>
								<c:when test="${memberBgrade == 4}">
									<img src="${pageContext.request.contextPath}/resources/img/grade/master.png"/>
								</c:when>
							</c:choose>
						</div>
						<div class="gradeText">
							<c:choose>
								<c:when test="${memberBgrade == 0}">
									<span class="bronze">BRONZE</span>
								</c:when>
								<c:when test="${memberBgrade == 1}">
									<span class="gold">GOLD</span>
								</c:when>
								<c:when test="${memberBgrade == 2}">
									<span class="platinum">PLATINUM</span>
								</c:when>
								<c:when test="${memberBgrade == 3}">
									<span class="master">MASTER</span>
								</c:when>
								<c:when test="${memberBgrade == 4}">
									<span class="master">MASTER</span>
								</c:when>
							</c:choose>
						</div>
					</div>
					<div class="condition">
						<div class="now">
							<div id="nowBGradeMoney" class="gradeMoney">${bGradeMoney}</div><div class="sub">현재 구매금액</div>
						</div>
						<div class="next">
							<div class="gradeMoney">
								<c:choose>
									<c:when test="${memberBgrade == 0}">
										1,000,000원
									</c:when>
									<c:when test="${memberBgrade == 1}">
										2,000,000원
									</c:when>
									<c:when test="${memberBgrade == 2}">
										4,000,000원
									</c:when>
									<c:when test="${memberBgrade == 3}">
										8,000,000원
									</c:when>
									<c:when test="${memberBgrade == 4}">
										8,000,000원
									</c:when>
								</c:choose>
							</div><div class="sub">목표 구매금액</div>
						</div>
					</div>
				</div>
				<div class="nextGradeBox">
					<div class="gradeTitle">판매등급 상향 조건</div>
					<div class="nextGrade">
						<div class="gradeImg">
							<c:choose>
								<c:when test="${memberSgrade == 0}">
									<img src="${pageContext.request.contextPath}/resources/img/grade/bronze.png"/>
								</c:when>
								<c:when test="${memberSgrade == 1}">
									<img src="${pageContext.request.contextPath}/resources/img/grade/gold.png"/>
								</c:when>
								<c:when test="${memberSgrade == 2}">
									<img src="${pageContext.request.contextPath}/resources/img/grade/platinum.png"/>
								</c:when>
								<c:when test="${memberSgrade == 3}">
									<img src="${pageContext.request.contextPath}/resources/img/grade/master.png"/>
								</c:when>
								<c:when test="${memberSgrade == 4}">
									<img src="${pageContext.request.contextPath}/resources/img/grade/master.png"/>
								</c:when>
							</c:choose>
						</div>
						<div class="gradeText">
							<c:choose>
								<c:when test="${memberSgrade == 0}">
									<span class="bronze">BRONZE</span>
								</c:when>
								<c:when test="${memberSgrade == 1}">
									<span class="gold">GOLD</span>
								</c:when>
								<c:when test="${memberSgrade == 2}">
									<span class="platinum">PLATINUM</span>
								</c:when>
								<c:when test="${memberSgrade == 3}">
									<span class="master">MASTER</span>
								</c:when>
								<c:when test="${memberSgrade == 4}">
									<span class="master">MASTER</span>
								</c:when>
							</c:choose>
						</div>
					</div>
					<div class="condition">
						<div class="now">
							<div id="nowSGradeMoney" class="gradeMoney">${sGradeMoney}</div><div class="sub">현재 판매금액</div>
						</div>
						<div class="next">
							<div class="gradeMoney">
								<c:choose>
									<c:when test="${memberSgrade == 0}">
										1,000,000원
									</c:when>
									<c:when test="${memberSgrade == 1}">
										2,000,000원
									</c:when>
									<c:when test="${memberSgrade == 2}">
										4,000,000원
									</c:when>
									<c:when test="${memberSgrade == 3}">
										8,000,000원
									</c:when>
									<c:when test="${memberSgrade == 4}">
										8,000,000원
									</c:when>
								</c:choose>
							</div><div class="sub">목표 판매금액</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="innerBottom">
			<div class="gradeTitle">등급혜택</div>
			<ul>
				<li>
					<div class="left">BEGINNING</div>
					<div class="right">-</div>
				</li>
				<li>
					<div class="left">BRONZE</div>
					<div class="right">-</div>
				</li>
				<li>
					<div class="left">GOLD</div>
					<div class="right">-</div>
				</li>
				<li>
					<div class="left">PLATINUM</div>
					<div class="right">-</div>
				</li>
				<li>
					<div class="left">MASTER</div>
					<div class="right">-</div>
				</li>
			</ul>
		</div>
	</div>
</div>