<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fnt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<style>
.c-cards{
	display:flex;
	
}

.c-cards a{
text-decoration:none;
color:black;
}
</style>
<%@ include file="../include/header.jsp" %>
	   <div class="wrapper">
        <div class="wrapper-header"><span class="header-text">게임평가 순위</span></div>
        	<article class="flex-wrapper">
	        	<c:forEach items="${gList}" var="g">
			        <div class="c-cards">
            			<a class="c-card" href="#">
                		<span class="card-header" >
                		<h3>${g.game_name}</h3>
                    	<span class="card-title">
                    	<img src='${g.img_src}'>
                    </span>
		                </span>
		                <span class="card-summary">
		                   
		                </span>
		                <span class="card-meta">
		                	   <div>플랫폼 : ${g.platform}</div>
		                       <div>유저 평점: ${g.u_score}</div> 
		                       <div>전문가 평점: ${g.m_score}</div>
		                </span>
            			</a>
            		</div>
					</c:forEach>
		    </article>
		    <div ><button type="submit" id="more" >more...</button></div>
		    <input type="hidden" id="limit-count" value="10">
	</div>
<script>
	$(document).on('click','#more',function(){
		var count = Number($("#limit-count").val());
		count += 10;
		$('#limit-count').val(count);
		alert(count)
	})
</script>
<%@ include file="../include/footer.jsp" %>