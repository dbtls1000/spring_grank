<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fnt" %>
<% pageContext.setAttribute("w_newLine","\r\n"); %>
<% pageContext.setAttribute("u_newLine","\r\n"); %>   
<c:set var="path" value="${pageContext.request.contextPath}" />

<c:choose>
	<c:when test="${!empty rList}">
		<c:forEach items="${rList}" var="r">
			<div class="commentlist" id="reply-list">
				<div class="commentlist-content">
					<ul>
						<li><span>${r.r_writer}</span></li>
						<li><span>${r.r_regdate}</span></li>
						<c:if test="${sessionScope.name == r.r_writer}">
							<li><span class="reply-btn" data-content="${r.r_content}" data-rno="${r.rno}" id="reply-update-btn">수정</span></li>
							<li><span class="reply-btn" data-rno="${r.rno}" id="reply-delete-btn">삭제</span></li>
						</c:if>
					</ul>
					<div class="comment">${fnt:replace(fnt:replace(r.r_content,w_newLine,"<br/>"),u_newLine,"<br/>")}</div>
				</div>
			</div>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<div class="commentlist center infocomment">첫번째 댓글을 등록해주세요!</div>
	</c:otherwise>
</c:choose>
<c:choose>
	<c:when test="${!empty sessionScope.name}">
		<div class="commentlist" id="reply-write-form">
			<form id="frm_reply" method="POST">
			<div class="reply-info">
			<span>${sessionScope.name}</span><span id="reply-err">댓글을 공백없이 입력해주세요</span>
			</div>
			<div class="comment-text">
				<textarea name="r_content" id="txt" cols="30" rows="2"></textarea>
				<a class="a-button a-comment comment-btn" id="board-reply-btn"><i class="fas fa-pencil-alt i-btn"></i></a>
			</div>
			<input type="hidden" id="re_bno" name="bno">
			</form>
		</div>
	</c:when>
	<c:otherwise>
		<div class="commentlist center infocomment">
			<a class="login-btn">로그인</a>후 이용할 수 있습니다!
		</div>
	</c:otherwise>
</c:choose>



