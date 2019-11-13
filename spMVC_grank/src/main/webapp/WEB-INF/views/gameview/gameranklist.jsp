<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fnt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<div class="flex-wrapper">
	<c:forEach items="${gList}" var="g">
		<div class="g-card">
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
				<img data-code="${g.game_code}" id="g_img" src="${g.img_src}">
			</div>
			<div class="g-card-item g-card-content game-name"> 게임명 : ${g.game_name}</div>
			<div class="g-card-item g-card-content">전문가 평점:&nbsp;<span class="c-score">${g.m_score}</span></div>
			<div class="g-card-item g-card-content">유저 평점:&nbsp;<span class="u-score">${g.u_score}</span></div>
			<c:choose>
			<c:when test="${g.tot_score <= 70}">
				<c:if test="${g.tot_score >= 30}">
					<div class="g-card-item g-card-content">Grank:&nbsp;<span class="middle-score">A</span></div>
				</c:if>
				<c:if test="${g.tot_score < 30}">
					<div class="g-card-item g-card-content">Grank:&nbsp;<span class="low-score">B</span></div>
				</c:if>
			</c:when>
			<c:otherwise>
				<div class="g-card-item g-card-content">Grank:&nbsp;<span class="high-score">S</span></div>
			</c:otherwise>
			</c:choose>
		</div>
	</c:forEach>
</div>
