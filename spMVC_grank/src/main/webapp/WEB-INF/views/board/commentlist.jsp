<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<div class="commentlist">
	<ul>
		<li><span>야필패</span></li>
		<li><span>2019-09-29 14:56:55</span></li>
		<li><span>수정</span></li>
		<li><span>삭제</span></li>
	</ul>
	<div class="comment">야스오는 ㄹㅇ 과학이네 ㅋㅋ</div>
</div>
<div class="commentlist center infocomment">첫번째 댓글을 등록해주세요!</div>
<div class="commentlist center infocomment">
	<a href="#">로그인</a>후 이용할 수 있습니다!
</div>
<div class="commentlist">
	<span>야필패</span>
	<div class="comment-text">
		<textarea name="" id="txt" cols="30" rows="2"></textarea>
		<a class="a-button a-comment comment-btn"><i
			class="fas fa-pencil-alt"></i></a>
	</div>
</div>

