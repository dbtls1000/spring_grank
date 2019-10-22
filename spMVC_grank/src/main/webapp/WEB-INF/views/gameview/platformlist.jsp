<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fnt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!-- 플랫폼 눌렀을 때 보여줄 리스트-->
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
		                   	   <div>플랫폼 : ${g.platform}</div>
		                       <div>유저 평점: ${g.u_score}</div> 
		                       <div>전문가 평점: ${g.m_score}</div>
		                </span>
		                <span class="card-meta">
		                </span>
            			</a>
            		</div>
					</c:forEach>
		    </article>