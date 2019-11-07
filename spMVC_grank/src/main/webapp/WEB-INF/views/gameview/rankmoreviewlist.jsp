<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fnt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" type="text/css" href="${path}/resources/css/gcard.css?ver=2019103102">
<!-- 게임순위평가리스트 -->
<div class="flex-wrapper">
	<c:forEach items="${gList}" var="g">
		<div id="gSize"></div>
		<div class="g-card" data-code="${g.game_code}">
			<c:if test="${g.platform == 'Switch'}">				
			<div class="g-card-item g-card-header switch-color">${g.platform}</div>
			</c:if>
			<c:if test="${g.platform == 'PC'}">				
			<div class="g-card-item g-card-header PC-color">${g.platform}</div>
			</c:if>
			<c:if test="${g.platform == 'PS4'}">				
			<div class="g-card-item g-card-header PS4-color">${g.platform}</div>
			</c:if>
			<c:if test="${g.platform == 'XONE'}">				
			<div class="g-card-item g-card-header XONE-color">${g.platform}</div>
			</c:if>
			<div class="g-card-item">
				<img src="${g.img_src}">
			</div>
			<div class="g-card-item g-card-content game-name"> 게임명 : ${g.game_name}</div>
			<div class="g-card-item g-card-content">전문가 평점:&nbsp;<span class='c-score'>${g.m_score}</span></div>
			<div class="g-card-item g-card-content">유저 평점:&nbsp;<span class="u-score">${g.u_score}</span></div>
		    <c:choose>
				<c:when test="${g.tot_score <= 70}">
					<c:if test="${g.tot_score >= 30}">
						<div class="g-card-item g-card-content">Grank:&nbsp;<span class="middle-score">A</span></div>
					</c:if>
	`				<c:if test="${g.tot_score < 30}">
						<div class="g-card-item g-card-content">Grank:&nbsp;<span class="low-score">B</span></div>
					</c:if>
				</c:when>
			<c:otherwise>
				<div class="g-card-item g-card-content">Grank:&nbsp;<span class="high-score">S</span></div>
			</c:otherwise>
			</c:choose>
		</div>
		<input type="hidden" id="gsize" value="${gSize}">
	</c:forEach>
</div>
<script>
	// 상세게시글을 보기위해서 data-code를 controller로 보내줌
	$(".g-card").click(function(){
		let game_code = $(this).attr("data-code");
		location.href = "${path}/game/gameview?game_code="+game_code;
	})
	
	
</script>