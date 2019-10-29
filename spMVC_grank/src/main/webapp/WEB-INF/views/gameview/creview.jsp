<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fnt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />	
<link rel="stylesheet" type="text/css" href="${path}/resources/css/gameview.css?ver=2019102801">    

<div id="c-review">
	<c:choose>
	   <c:when test="${!empty ccList}">
			<c:forEach items ="${ccList}" var="c" >
	    		<div class="review-content">
	        		<div style="font-weight: bold;font-size:18px;">
	        			<c:choose>
	        				<c:when test="${c.c_score <= 70}">
	        					<c:if test="${c.c_score >=31}">
	        						<span class="game-score middle-score">${c.c_score}</span>
	        					</c:if>		
				        		<c:if test="${c.c_score < 31}">
				        			<span class="game-score low-score">${c.c_score}</span>
				        		</c:if>
	        				</c:when>
				        	<c:otherwise>
				        		<span class="game-score high-score">${c.c_score}</span>
				        	</c:otherwise>
	        			</c:choose>
	       				${c.c_critic}</div>
	        			<div>${c.c_review}</div>
	 			</div>		
	 	 	</c:forEach>
  	 </c:when>
  	 <c:otherwise>
  	 	비평가 댓글이 없습니다.
  	 </c:otherwise>
    </c:choose>
</div>
<script>
</script>
	
