<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/include.jsp"%>
<link rel="stylesheet" type="text/css" href="${path}/resources/css/board-list.css?ver=20191015">
<%@ include file="../include/header.jsp"%>
	<div class="wrapper">
		<div class="wrapper-header">
			<span class="header-text">자유 게시판</span>
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
			<li><i class="fas fa-angle-double-left"></i></li>
			<li><i class="fas fa-angle-left"></i></li>
			<li>1</li>
			<li>2</li>
			<li>3</li>
			<li>4</li>
			<li>5</li>
			<li>6</li>
			<li>7</li>
			<li>8</li>
			<li>9</li>
			<li>10</li>
			<li><i class="fas fa-angle-right"></i></li>
			<li><i class="fas fa-angle-double-right"></i></li>
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
	})
</script>