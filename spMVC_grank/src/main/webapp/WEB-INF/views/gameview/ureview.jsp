<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fnt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />	
<link rel="stylesheet" type="text/css" href="${path}/resources/css/gameview.css?ver=20191025">    

<div id="u-review">
<c:forEach items ="${userList}" var="u" >
    <div class="review-content">
        <div style="font-weight: bold;font-size:18px;"><span class="game-score">${u.u_score}</span>${u.u_name}</div>
        <div>${u.u_review}</div>
 	</div>
 </c:forEach>
</div>
