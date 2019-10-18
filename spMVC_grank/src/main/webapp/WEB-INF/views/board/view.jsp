<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/include.jsp"%>
<link rel="stylesheet" type="text/css" href="${path}/resources/css/board-view.css?ver=20191015">
<link rel="stylesheet" type="text/css" href="${path}/resources/css/commentlist.css?ver=2019101801">
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
				<c:if test="${!empty sessionScope.name}">
					<li><a class="a-button a-common" id="board-answer-btn">답변</a></li>
				</c:if>
				<c:if test="${sessionScope.name == bDto.b_writer}">
					<li><a class="a-button a-common" id="board-update-btn">수정</a></li>
					<li><a class="a-button a-delete" id="board-delete-btn">삭제</a></li>
				</c:if>
			</ul>
		</div>
		<!-- 댓글 -->
		<div class="wrapper-reply">
			<div class="wrapper-header"><span class="header-text">댓글</span></div>
			<div id="commentlist"></div>
		</div>
	</div>
	<%@ include file="../include/footer.jsp"%>
<script>
	// 댓글을 띄어주는 Ajax메서드 생성
	function comment_list(){
		$.ajax({
			url:'${path}/reply/list?bno=${bDto.bno}',
			type:'GET',
			success:function(page){
				$('#commentlist').html(page)
			}
		})
	}
	// 페이지가 준비되면 메서드 호출
	$(document).ready(function(){
		comment_list();
	})
	// 수정버튼 클릭시 이벤트
	$(document).on('click','#board-update-btn',function(){
		location.href = "${path}/board/write?bno=${bDto.bno}"
	})
	// 답변버튼 클릭시 이벤트
	$(document).on('click','#board-answer-btn',function(){
		location.href = "${path}/board/answer?bno=${bDto.bno}"
	})
	// 삭제버튼 클릭시 이벤트
	$(document).on('click','#board-delete-btn',function(){
		$('.delete-modal').css('display','block')
	})
	// delete-modal 아니오버튼 클릭시 이벤트
	$(document).on('click','#confirm-no',function(){
		$('.delete-modal').css('display','none')
	})
	// delete-modal 예버튼 클릭시 이벤트
	$(document).on('click','#confirm-yes',function(){
		location.href = "${path}/board/delete?bno=${bDto.bno}"
	})
	
</script>