<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/include.jsp"%>
<link rel="stylesheet" type="text/css" href="${path}/resources/css/board-list.css?ver=2019102202">
<%@ include file="../include/header.jsp"%>
<%
	String message= request.getParameter("message");
%>
	<div class="wrapper">
		<div class="wrapper-header">
			<span class="header-text">자유 게시판</span>
		</div>
		<div class="list-search">
			<div class="flex-item">
				<span class="board-sort"><a id="sort_new" href="${path}/board/list?sort_option=new">최신순</a></span>
				<span>｜</span>
				<span class="board-sort"><a id="sort_reply" href="${path}/board/list?sort_option=reply">댓글순</a></span>
				<span>｜</span>
				<span class="board-sort"><a id="sort_view" href="${path}/board/list?sort_option=view">조회순</a></span>
			</div>
	  		<div class="flex-item">
				<select id="search_option">
					<option value="title_content" <c:if test="${search_option == 'title_content'}">selected="selected"</c:if> >제목+내용</option>
					<option value="title" <c:if test="${search_option == 'title'}">selected="selected"</c:if> >제목</option>
					<option value="content" <c:if test="${search_option == 'content'}">selected="selected"</c:if> >내용</option>
					<option value="writer" <c:if test="${search_option == 'writer'}">selected="selected"</c:if> >작성자</option>
				</select>
				<input type="text" id="keyword" value="${keyword}">
				<a class="a-button a-common" id="board-search-btn"><i class="fas fa-search i-btn"></i></a>
			</div>
		</div>
		<table class="board-list">
			<tr>
				<th class="recordNum">No.</th>
				<th class="board-title">제목</th>
				<th class="board-writer">작정사</th>
				<th class="board-regdate">작성일자</th>
				<th class="board-viewcnt">조회수</th>
			</tr>
			<c:forEach items="${blist}" var='list'>
				<jsp:useBean id="now" class="java.util.Date"/>
				<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today"/>
				<fmt:formatDate value="${list.b_regdate}" pattern="yyyy-MM-dd" var="regdate"/>
				<tr>
					<td class="board-content center">${list.bno}</td>
					<td class="board-content title"><a data-seq="${list.bno}" class="view-one" style="cursor:pointer">[${list.b_platform}] ${list.b_title}
						<c:if test="${list.b_replycnt > 0}"> 
						(${list.b_replycnt})
						</c:if>
						<c:if test="${today == regdate}">
							<span id="board-new">New</span>
						</c:if>
					</a>
					</td>
					<td class="board-content center">${list.b_writer}</td>
					<td class="board-content center">
						<c:choose>
							<c:when test="${today == regdate}">
								<fmt:formatDate value="${list.b_regdate}" pattern="HH:mm:ss"/>
							</c:when>
							<c:otherwise>
								${regdate}
							</c:otherwise>
						</c:choose>
					</td>
					<td class="board-content center">${list.b_viewcnt}</td>
				</tr>
			</c:forEach>
		</table>
		<div class="wrapper-content list-search">
			<div class="flex-item">
				<c:if test="${!empty keyword}">
		   			<span class="search-comment">"${keyword}"(으)로 검색한 결과는 총 ${count}건 입니다</span>
		  		</c:if>
	  		</div>
	  		<div class="flex-item">
				<a class="a-button a-common" id="write-btn"><i class="fas fa-pencil-alt i-btn"></i></a>
			</div>
		</div>
		<ul class="pagination">
			<c:if test="${page.curBlock > 1}">
				<li><a href="${path}/board/list?curPage=1&search_option=${search_option}&keyword=${keyword}&sort_option=${sort}"><i class="fas fa-angle-double-left"></i></a></li>
				<li><a href="${path}/board/list?curPage=${page.blockBegin -10}&search_option=${search_option}&keyword=${keyword}&sort_option=${sort}"><i class="fas fa-angle-left"></i></a></li>
			</c:if>
			<c:forEach begin="${page.blockBegin}" end="${page.blockEnd}" var="idx">
				<li <c:out value="${page.curPage == idx ? 'class=active' : '' }"/> ><a href="${path}/board/list?curPage=${idx}&search_option=${search_option}&keyword=${keyword}&sort_option=${sort}" >${idx}</a></li>
			</c:forEach>
			<c:if test="${page.curBlock < page.totalBlock}">
				<li><a href="${path}/board/list?curPage=${page.blockEnd+1}&search_option=${search_option}&keyword=${keyword}&sort_option=${sort}"><i class="fas fa-angle-right"></i></a></li>
				<li><a href="${path}/board/list?curPage=${page.totalPage}&search_option=${search_option}&keyword=${keyword}&sort_option=${sort}"><i class="fas fa-angle-double-right"></i></a></li>
			</c:if>
		</ul>
			</div>
<%@ include file="../include/footer.jsp"%>
<script>
	// 페이지가 준비되면
	$(document).ready(function(){
		var sort = '${sort}';
		// sort값이 new일때
		if(sort == 'new'){
			$('#sort_new').css('color','#341f97').css('font-weight','bold');
		}
		// sort값이 reply일때
		if(sort == 'reply'){
			$('#sort_reply').css('color','#341f97').css('font-weight','bold');
		}
		// sort값이 view일때
		if(sort == 'view'){
			$('#sort_view').css('color','#341f97').css('font-weight','bold');
		}
	})
	$(function(){
		var msg = "${message}"
		// msg가 nologin이면 모달창출력
		if(msg == 'nologin') {
			$('#modal-login').css('display', 'block');
			$('#login-id').focus();
		}
		// 작성버튼 클릭시 이동
		$('#write-btn').click(function(){
			location.href = "${path}/board/write";
		})
		// 상세게시글 클릭시 이동
		$('.view-one').click(function(){
			var bno = $(this).attr('data-seq');
			location.href = "${path}/board/view?bno=" + bno;
		})
		// 검색버튼 클릭시
		$('#board-search-btn').click(function(){
			var sort = '${sort}'
			var search_option = $.trim($('#search_option').val());
			var keyword = $.trim($('#keyword').val());
			location.href = '${path}/board/list?search_option=' + search_option + '&keyword=' + keyword + '&sort_option=' + sort;
		})
	})
</script>