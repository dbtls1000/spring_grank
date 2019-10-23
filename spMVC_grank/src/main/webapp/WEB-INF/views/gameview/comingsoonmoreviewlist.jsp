<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fnt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!-- 출시 예정작 -->
<div class="flex-wrapper">
	<c:forEach items="${cList}" var="c">
		<div class="g-card">
			<div class="g-card-item g-card-header">${c.platform}</div>
			<div class="g-card-item">
				<img src="${c.c_img}">
			</div>
			<div class="g-card-item g-card-content game-name">${c.c_name}</div>
			<div class="g-card-item g-card-content">날짜 : ${c.c_date}</div>
		</div>
	</c:forEach>
</div>
