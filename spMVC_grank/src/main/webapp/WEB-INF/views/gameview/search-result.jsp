<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<div class="search-result">
	<c:forEach items="${gList}" var="g">
    	<div class="search-result-item" data-code="${g.game_code}">[${g.platform}] ${g.game_name}</div>
    </c:forEach>
</div>
<script>
	$(document).on('click','.search-result-item',function(){
		var game_code = $(this).attr('data-code');
		location.href = "${path}/game/gameview?game_code="+game_code;
	})
</script>