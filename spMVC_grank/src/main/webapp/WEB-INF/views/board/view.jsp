<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/include.jsp"%>
<link rel="stylesheet" type="text/css" href="${path}/resources/css/board-view.css?ver=20191015">
	<%@ include file="../include/header.jsp"%>
	<div class="wrapper">
		<div class="wrapper-header">
			<span class="header-text">상세 게시글</span>
		</div>
		<div id="view_an_btn">
			<a class="a-button a-common">이전글</a> <a class="a-button a-common">다음글</a>
		</div>
		<table class="board-view">
			<colgroup>
				<col width="200" />
				<col width="500" />
			</colgroup>
			<jsp:useBean id="now" class="java.util.Date"/>
			<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today"/>
			<fmt:formatDate value="${bDto.b_regdate}" pattern="yyyy-MM-dd" var="regdate"/>
			<tr class="view_writer">
				<th colspan="2">[${bDto.b_platform}] ${bDto.b_title}</th>
				<th>${bDto.b_writer}</th>
				<th>
					<c:choose>
						<c:when test="${today == regdate}">
							<fmt:formatDate value="${bDto.b_regdate}" pattern="HH:mm:ss"/>
						</c:when>
						<c:otherwise>
							${regdate}
						</c:otherwise>
					</c:choose>
				</th>
			</tr>
			<tr>
				<td class="view_content" colspan="4" style="height: 100px;"><p style="text-align: left;">
					${bDto.b_content}		
				</p></td>
			</tr>
		</table>
		<div class="view_button">
			<ul>
				<li><a class="a-button a-common"">목록</a></li>
				<li><a class="a-button a-common" id="board-answer-btn">답변</a></li>
				<li><a class="a-button a-common" id="board-update-btn">수정</a></li>
				<li><a class="a-button a-delete">삭제</a></li>
			</ul>
		</div>
		<!-- 댓글 -->
		<div class="wrapper-reply" id="commnetlist">
			<div class="wrapper-header"><span class="header-text">댓글</span></div>
			
		</div>
	</div>
	<%@ include file="../include/footer.jsp"%>
<script>
	$(document).on('click','#board-update-btn',function(){
		location.href = "${path}/board/write?bno=${bDto.bno}"
	})
	$(document).on('click','#board-answer-btn',function(){
		location.href = "${path}/board/answer?bno=${bDto.bno}"
	})
</script>