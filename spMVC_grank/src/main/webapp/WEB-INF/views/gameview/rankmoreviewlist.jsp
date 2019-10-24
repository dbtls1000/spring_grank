<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fnt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" type="text/css" href="${path}/resources/css/gcard.css?ver=2019102311">
<!-- 게임순위평가리스트 -->
<div class="flex-wrapper">
	<c:forEach items="${gList}" var="g">
		<div class="g-card" data-code="${g.game_code}">
			<div class="g-card-item g-card-header">${g.platform}</div>
			<div class="g-card-item">
				<img src="${g.img_src}">
			</div>
			<div class="g-card-item g-card-content game-name"> 게임명 : ${g.game_name}</div>
			<div class="g-card-item g-card-content">유저 평점: ${g.u_score}</div>
			<div class="g-card-item g-card-content">전문가 평점: ${g.m_score}</div>
		</div>
	</c:forEach>
</div>
<script>
	$(".g-card").click(function(){
		let game_code = $(this).attr("data-code");
		location.href = "${path}/game/gameview?game_code="+game_code;
		alert(location.href)
	})
</script>