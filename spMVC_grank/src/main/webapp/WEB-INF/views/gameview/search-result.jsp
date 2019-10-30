<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<div class="search-result s-box">
	<c:choose>
		<c:when test="${gList.size() > 0}">
			<c:forEach items="${gList}" var="g">
		    	<div class="search-result-item s-box" data-code="${g.game_code}">[${g.platform}] ${g.game_name}</div>
		    </c:forEach>
	    </c:when>
	    <c:otherwise>
	    	<div class="search-result-item s-box">검색결과가 없습니다.</div>
	    </c:otherwise>
    </c:choose>
</div>
<script>
	$(document).on('click','.search-result-item',function(){
		var game_code = $(this).attr('data-code');
		location.href = "${path}/game/gameview?game_code="+game_code;
	})
</script>