<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fnt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<div class="flex-wrapper">
	<c:forEach items="${gList}" var="g">
		<div class="g-card">
			<div class="g-card-item g-card-header">${g.platform}</div>
			<div class="g-card-item">
				<img data-code="${g.game_code}" id="g_img" src="${g.img_src}">
			</div>
			<div class="g-card-item g-card-content game-name"> 게임명 : ${g.game_name}</div>
			<div class="g-card-item g-card-content">유저 평점: ${g.u_score}</div>
			<div class="g-card-item g-card-content">전문가 평점: ${g.m_score}</div>
		</div>
	</c:forEach>
</div>
