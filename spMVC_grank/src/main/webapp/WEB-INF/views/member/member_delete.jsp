<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/include.jsp"%>
<link rel="stylesheet" type="text/css"
	href="${path}/resources/css/member_delete.css?ver=2019101703">
<%@ include file="../include/header.jsp"%>
<div class="wrapper">
	<div class="wrapper-header">
		<span class="header-text">회원 탈퇴</span>
	</div>
	<div class="delete-info">
		<h3>"${sessionScope.name}님" 회원탈퇴시 아래의 조치가 취해집니다.</h3>
		<div class="delete-info-content">
			1. 계정정보는 <span style="color: darkorchid; font-weight: bold">'개인정보
				보호 정책'에 따라 60일간 보관(잠김)되며, </span> 60일이 경과된 후에는 모든 개인정보는 완전히 삭제되어 복구할 수 없게
			됩니다.<br> 2. 작성된 게시물은 삭제되지 않으며, 익명처리 후 <span
				style="color: darkorchid; font-weight: bold">Grank로 소유권이 귀속</span>됩니다.<br>
			3. 게시물은 삭제가 필요한 경우에는 <span
				style="color: darkorchid; font-weight: bold">관리자(wkdghdrl1@naver.com)</span>로
			문의해주시기 바랍니다.
		</div>
	</div>
	<div class="delete-item">
		비밀번호 확인 : <input id="delete-password" type="password"
			placeholder="비밀번호">
	</div>
	<div class="delete-item">
		<span class="member-delete-err">필수 입력 정보입니다</span>
	</div>
	<div class="delete-item delete-confirm">
		<a class="a-button a-common" id="delete-no">취소</a> <a
			class="a-button a-delete" id="delete-yes">탈퇴</a>
	</div>
	<form action="${path}/member/delete" method="POST" id="mem_password">
		<input type="hidden" name="userid" value="${sessionScope.userid}">
	</form>
</div>
<%@ include file="../include/footer.jsp"%>
<script type="text/javascript" src="${path}/resources/js/validation.js"></script>
<script>
$(function() {
	var state = false;
	// 비밀번호 체크
	$('#delete-password').blur(function() {
		var user = "${sessionScope.userid}";
		var pass = $.trim($(this).val());
		// 비밀번호 공백 체크
		if(pass == null || pass.length == 0) {
			$('.member-delete-err').css('visibility','visible');
			$('#delete-password').focus();
		// 비밀번호 같은지 확인
		} else {
			$('.member-delete-err').css('visibility','hidden');
			state = ajaxPassCheck(user,pass);
		}
	})
	// 탈퇴 클릭시 true이면 delete-modal 띄우고 false이면 delete-modal = none하고 경고글 출력
	$('#delete-yes').click(function() {
		if(state) {
			$('.delete-modal').css('display','block')
			$('.delete-comment').text('정말 탈퇴하시겠습니까?')
		} else {
			$('.delete-modal').css('display','none');
			$('.member-delete-err').css('visibility','visible').text('비밀번호가 틀립니다.');
			$("#delete-password").val('');
			$("#delete-password").focus();
		}
	})
	// 취소 클릭시 마이페이지로 이동
	$('#delete-no').click(function() {
		location.href = "${path}/member/mypage"
	})
	// 아니오 클릭시 display : none
	$('#confirm-no').click(function(){
		$('.delete-modal').css('display','none')
	})
	// 예 클릭시 탈퇴 
	$('#confirm-yes').click(function(){
		$('#mem_password').submit();
	})
})
</script>