<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fnt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />	
<link rel="stylesheet" type="text/css" href="${path}/resources/css/gameview.css?ver=20191025">    

<div id="u-review">
	<c:choose>
		<c:when test="${!empty userList}">
			<c:forEach items ="${userList}" var="u" >
				<div class="review-content">
	    		<div style="font-weight: bold;font-size:18px;">
				<c:choose>
					<c:when test="${u.u_score < 6}">
						<c:if test="${u.u_score >= 3}">
							<span class="game-score middle-score">${u.u_score}</span> 
						</c:if>
						<c:if test="${u.u_score < 3}">
							<span class="game-score low-score">${u.u_score}</span> 
						</c:if>
					</c:when> 
					<c:otherwise>
						<span class="game-score high-score">${u.u_score}</span>
					</c:otherwise>	
				</c:choose>
				${u.u_name}</div>
				<div>${u.u_review}</div>
				</div>
			</c:forEach>
	    </c:when>
		<c:otherwise>
			<div class="review-content">
				<div>유저 댓글이 없습니다.</div>
			</div>
		</c:otherwise>
	</c:choose>
</div>
<script>
</script>
