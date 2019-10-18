<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fnt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<div class="flex-wrapper">
	<div class="flex-item item1">
		<c:forEach items="${gList}" var="g">
			<div class="card">
				<div>
					<img src="${g.img_src}" alt="">
				</div>
				<div class="center">${g.platform}</div>
				<div class="center">${g.game_name}</div>
				<div class="center">${g.m_score}</div>
				<div class="center">${g.u_score}</div>
			</div>
		</c:forEach>
	</div>
</div>