<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fnt" %>
<% pageContext.setAttribute("w_newLine","\r\n"); %>
<% pageContext.setAttribute("u_newLine","\r\n"); %>   
<c:set var="path" value="${pageContext.request.contextPath}" />
<jsp:useBean id="now" class="java.util.Date"/>
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd HH:mm:ss" var="today"/>
<c:choose>
	<c:when test="${!empty rList}">
		<c:forEach items="${rList}" var="r">
			<div class="commentlist" id="reply-list">
				<div class="commentlist-content">
					<ul class="comment-info">
						<li><span>${r.r_writer}</span></li>
						<c:if test="${sessionScope.name == r.r_writer}">
							<li><span class="reply-btn" data-content="${r.r_content}" data-rno="${r.rno}" id="reply-update-btn">수정</span></li>
							<li><span class="reply-btn" data-rno="${r.rno}" id="reply-delete-btn">삭제</span></li>
						</c:if>
						<li><span>${r.r_regdate}</span></li>
					</ul>
					<div class="comment">${fnt:replace(fnt:replace(r.r_content,w_newLine,"<br/>"),u_newLine,"<br/>")}</div>
				</div>
			</div>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<div class="commentlist" id="reply-list">
				<div class="commentlist-content">
					<ul class="comment-info">
						<li><span>GRank관리자</span></li>
						<li><span>${today}</span>
					</ul>
					<div class="comment">첫번째 댓글을 등록해주세요.</div>
				</div>
			</div>
	</c:otherwise>
</c:choose>
<c:choose>
	<c:when test="${!empty sessionScope.name}">
		<div class="commentlist" id="reply-write-form">
			<form id="frm_reply" method="POST">
			<div class="comment-text">
				<textarea name="r_content" id="reply-txt" cols="30" rows="2"></textarea>
				<a class="a-button a-comment comment-btn" id="board-reply-btn"><i class="fas fa-pencil-alt i-btn"></i></a>
			</div>
			<div class="reply-info">
			<span></span><span id="reply-err">댓글을 공백없이 입력해주세요.</span>
			</div>
			<input type="hidden" id="re_bno" name="bno">
			</form>
		</div>
	</c:when>
	<c:otherwise>
		<div class="commentlist" id="reply-write-form">
			<div class="comment-text">
				<textarea id="nologin-reply" name="r_content" id="txt" cols="30" rows="2" placeholder="댓글을 등록하려면 로그인 해주세요"></textarea>
				<a class="a-button a-comment comment-btn" id="board-reply-btn"><i class="fas fa-pencil-alt i-btn"></i></a>
			</div>
		</div>
	</c:otherwise>
</c:choose>



