<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/include.jsp"%>
<link rel="stylesheet" type="text/css" href="${path}/resources/css/board-list.css?ver=2019101702">
<%@ include file="../include/header.jsp"%>
	<div class="wrapper">
		<div class="wrapper-header">
			<span class="header-text">자유 게시판</span>
		</div>
		<div class="list-search">
			<div class="flex-item">
			<c:if test="${!empty map.keyword}">
	   			<span class="search-comment">"${map.keyword}"(으)로 검색한 결과는 총 ${map.count}건 입니다</span>
	  		</c:if>
	  		</div>
	  		<div class="flex-item">
				<select id="search_option">
					<option value="title_content">제목+내용</option>
					<option value="title">제목</option>
					<option value="content">내용</option>
					<option value="writer">작성자</option>
				</select>
				<input type="text" id="keyword">
				<a class="a-button a-common" id="board-search-btn"><i class="fas fa-search"></i></a>
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
		<div class="wrapper-content right">
			<a class="a-button a-common" id="write-btn"><i class="fas fa-pencil-alt"></i></a>
		</div>
		<ul class="pagination">
			<c:if test="${page.curBlock > 1}">
				<li><a href="${path}/board/list?curPage=1"><i class="fas fa-angle-double-left"></i></a></li>
				<li><a href="${path}/board/list?curPage=${page.blockBegin -10}"><i class="fas fa-angle-left"></i></a></li>
			</c:if>
			<c:forEach begin="${page.blockBegin}" end="${page.blockEnd}" var="idx">
				<li <c:out value="${page.curPage == idx ? 'class=active' : '' }"/> ><a href="${path}/board/list?curPage=${idx}" >${idx}</a></li>
			</c:forEach>
			<c:if test="${page.curBlock < page.totalBlock}">
				<li><a href="${path}/board/list?curPage=${page.blockEnd+1}"><i class="fas fa-angle-right"></i></a></li>
				<li><a href="${path}/board/list?curPage=${page.totalPage}"><i class="fas fa-angle-double-right"></i></a></li>
			</c:if>
		</ul>
			</div>
<%@ include file="../include/footer.jsp"%>
<script>
	$(function(){
		$('#write-btn').click(function(){
			location.href = "${path}/board/write";
		})
		$('.view-one').click(function(){
			var bno = $(this).attr('data-seq');
			location.href = "${path}/board/view?bno=" + bno;
		})
		$('#board-search-btn').click(function(){
			var search_option = $.trim($('#search_option').val());
			var keyword = $.trim($('#keyword').val());
			location.href = '${path}/board/list?search_option=' + search_option + '&keyword=' + keyword;
		})
	})
</script>