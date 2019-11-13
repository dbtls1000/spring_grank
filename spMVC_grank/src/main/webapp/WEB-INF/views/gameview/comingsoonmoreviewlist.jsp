<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fnt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!-- 출시 예정작 -->
<div class="flex-wrapper">

	<c:forEach items="${cList}" var="c">
		<div class="c-card">
                	<c:if test="${c.platform == 'PS4' }">
	                    <div class="g-card-item g-card-header PS4-color">${c.platform}</div>
                    </c:if>
                   	<c:if test="${c.platform == 'XONE' }">
    	                <div class="g-card-item g-card-header XONE-color">${c.platform}</div>
                    </c:if>
                   	<c:if test="${c.platform == 'Switch' }">
        	            <div class="g-card-item g-card-header switch-color">${c.platform}</div>
                    </c:if>
                   	<c:if test="${c.platform == 'PC' }">
            	        <div class="g-card-item g-card-header PC-color">${c.platform}</div>
                    </c:if>
			<div class="g-card-item">
				<img src="${c.c_img}">
			</div>
			<div class="g-card-item g-card-content game-name">${c.c_name}</div>
			<div class="g-card-item g-card-content">${c.c_date}</div>
			<span class="tooltiptext">아직 출시되지 않은 게임입니다. </span>
		</div>
	</c:forEach>
</div>
