<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fnt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<%@ include file="../include/header.jsp" %>
    <!-- 출시 예정작 -->
    <div class="wrapper">
        <div class="wrapper-header"><span class="header-text">출시예정작</span></div>
        	<article class="flex-wrapper">
	        	<c:forEach items="${cList}" var="c">
			        <div class="c-cards">
            			<a class="c-card" href="#">
                		<span class="card-header" >
                		<img src='${c.c_img}'>
                    	<span class="card-title">
                        <h3>${c.c_name}</h3>
                    </span>
		                </span>
		                <span class="card-summary">
		                        ${c.platform}
		                </span>
		                <span class="card-meta">
		                        ${c.c_date}
		                </span>
            			</a>
            		</div>
					</c:forEach>
		    </article>
		     <div><a href="#">more...</a></div>
	</div>
<%@ include file="../include/footer.jsp" %>