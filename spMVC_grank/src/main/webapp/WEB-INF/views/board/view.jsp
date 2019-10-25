<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/include.jsp"%>
<link rel="stylesheet" type="text/css" href="${path}/resources/css/board-view.css?ver=2019102101">
<link rel="stylesheet" type="text/css" href="${path}/resources/css/commentlist.css?ver=2019101803">
	<%@ include file="../include/header.jsp"%>
	<div class="wrapper">
		<div class="wrapper-header">
			<span class="header-text">상세 게시글</span>
		</div>
		<div id="view_an_btn">
			<div class="view-flex-item">
				<a class="a-button a-common" id="board-prev-btn">이전글</a>
				<a class="a-button a-common" id="board-next-btn">다음글</a>
			</div>
			<c:choose>
				<c:when test="${empty sessionScope.name}">
					<div><i id="like-btn-login" class="far fa-heart"></i><span class="likeCnt">${bDto.like_cnt}</span></div>
				</c:when>
				<c:when test="${lDto.like_check == 1}">
					<div><i id="like-btn" class="fas fa-heart"></i><span class="likeCnt">${bDto.like_cnt}</span></div>
				</c:when>
				<c:otherwise>
					<div><i id="like-btn" class="far fa-heart"></i><span class="likeCnt">${bDto.like_cnt}</span></div>
				</c:otherwise>
			</c:choose>
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
			<c:forEach items="${fList}" var="f">
				<tr>
					<td colspan="4"><img src="${path}/images/${f.file_name}"></td>
				</tr>
			</c:forEach>
		</table>
		<div class="view_button">
			<ul>
				<li><a class="a-button a-common" id="board-list-btn">목록</a></li>
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
				$('#commentlist').html(page);
			}
		})
	}
	// 페이지가 준비되면 메서드 호출
	$(document).ready(function(){
		comment_list();
	})
	// 목록버튼 클릭시 이벤트
	$(document).on('click','#board-list-btn',function(){
		location.href = "${path}/board/list"
	})
	// 수정버튼 클릭시 이벤트
	$(document).on('click','#board-update-btn',function(){
		location.href = "${path}/board/write?bno=${bDto.bno}";
	})
	// 답변버튼 클릭시 이벤트
	$(document).on('click','#board-answer-btn',function(){
		location.href = "${path}/board/answer?bno=${bDto.bno}";
	})
	// 삭제버튼 클릭시 이벤트
	$(document).on('click','#board-delete-btn',function(){
		$('.delete-modal').css('display','block');
	})
	// delete-modal 아니오버튼 클릭시 이벤트
	$(document).on('click','#confirm-no',function(){
		$('.delete-modal').css('display','none');
	})
	// delete-modal 예버튼 클릭시 이벤트
	$(document).on('click','#confirm-yes',function(){
		location.href = "${path}/board/delete?bno=${bDto.bno}";
	})
	// 댓글등록버튼 클릭시 이벤트
	$(document).on('click','#board-reply-btn',function(){
		var reply = $('#txt').val();
		console.log(reply)
		if(reply == '' || reply.length == 0){
			$('#txt').focus();
			$('#reply-err').css('visibility','visible');
			return false;
		} else {
			var bno = '${bDto.bno}';
			$('#re_bno').val(bno);
			$.ajax({
				url:'${path}/reply/write',
			 	type:'POST',
				data: $('#frm_reply').serialize(),
				contentType:'application/x-www-form-urlencoded;charset=UTF-8',
				success:function(){
					comment_list();
					$('#reply-err').css('visibility','hidden');
					$('#txt').val('');
				},
				error:function(){
					alert("댓글 등록 실패")
				}
			})
		}
	})
	// 댓글삭제버튼 클릭시 이벤트
	$(document).on('click','#reply-delete-btn',function(){
		var rno = $(this).attr('data-rno');
		var bno = '${bDto.bno}';
		$.ajax({
			url:"${path}/reply/delete",
			data:"rno="+rno+"&bno="+bno,
			success:function(result){
				comment_list();
			},
			error:function(){
				alert("System Error")
			}
		})
	})
	// 댓글수정 버튼 클릭시 이벤트
	$(document).on('click','#reply-update-btn',function(){
		var rno = $(this).attr('data-rno');
		var bno = '${bDto.bno}';
		var content = $(this).attr('data-content');
		console.log(rno+","+content+","+bno);
		var htmls = '';
		// 수정버튼 클릭시 기존의 댓글 폼을 없애고 댓글을 등록하는 폼에 댓글내용을 담아 새로 생성해준다.
		htmls += '<form id="frm_reply" method="POST">'
		htmls += '<div class="reply-info">'
		htmls += '<span>${sessionScope.name}</span><span id="reply-err">댓글을 공백없이 입력해주세요</span>'
		htmls += '</div>'
		htmls += '<div class="comment-text" style="border-bottom:1px solid grey">'
		// 댓글내용을 담는부분
		htmls += '<textarea style="width:860px;" name="r_content" id="txt" cols="30" rows="2">' + content + '</textarea>'
		htmls += '<a style="margin-left:5px;" class="a-button a-comment comment-btn" id="board-reply-btn"><i class="fas fa-pencil-alt"></i></a>'
		// 수정 취소하는 버튼도 생성
		htmls += '<a style="margin-left:5px;" class="a-button a-delete-comment comment-btn" id="board-cancel-btn"><i class="fas fa-times"></i></a>'
		htmls += '</div>'
		// bno값을 보낼 input태그를 hidden으로 생성
		htmls += '<input type="hidden" id="re_bno" name="bno">'
		// rno값을 보낼 input태그를 hidden으로 생성
		htmls += '<input type="hidden" id="rno" name="rno" value="'+rno+'">'
		htmls += '</form>'
		$(this).parent().parent().parent().parent().html(htmls);
		// 기존 댓글폼 삭제
		$(this).parent().parent().parent().remove();
	})
	$(document).on('click','#board-cancel-btn',function(){
		comment_list();
	})
	// 이전글 버튼 클릭시
	$(document).on('click','#board-prev-btn',function(){
		var prev = '${bDto.prev_bno}'
		// prev가 0이거나 null이면 이전 게시글이 없는것
		if(prev == '' || prev == 0){
			alert('이전 게시글이 없습니다.');
		}else{
			location.href = "${path}/board/view?bno=" + prev;
		}
	})
	// 다음글 버튼 클릭시
	$(document).on('click','#board-next-btn',function(){
		var next = '${bDto.next_bno}'
		// next가 0이거나 null이면 다음 게시글이 없는것
		if(next == '' || next == 0){
			alert('다음 게시글이 없습니다.');
		} else {
			location.href = "${path}/board/view?bno=" + next;	
		}
	})
	// 좋아요버튼 클릭시
	$(document).on('click','#like-btn',function(){
		var bno = '${bDto.bno}';
		$.ajax({
			url:'${path}/board/like',
			type:'GET',
			cache: false,
			dataType:'json',
			data:'bno='+bno,
			success:function(data){
				// icon변수 = 좋아요 아이콘의 클래스를 바꿔줄 변수
				var icon = '';
				var check = data.like_check;
				var cnt = data.like_cnt;
				console.log(check)
				// like_check가 0이면 꽉찬하트로 바꿔주고
				if(data.like_check == 0){
			        icon = "fas fa-heart";
			    } else { // like_check가 1이면 빈 하트로 바꿔준다
			        icon = "far fa-heart";
			    }
				// icon을 class속성에 대입
				$('#like-btn').attr('class',icon)
				$('.likeCnt').text(cnt);
			},
			error:function(){
				alert('error')
			}
		})
	})
	// 로그인하지 않은상태로 좋아요 버튼을 클릭하면 로그인 모달창을 띄우고 경고메세지를 출력한다
	$(document).on('click','#like-btn-login',function(){
		$('#modal-login').css('display', 'block');
		$('.login-err-msg').text('로그인후 사용할 수 있습니다.').css('visibility','visible');
	})

</script>