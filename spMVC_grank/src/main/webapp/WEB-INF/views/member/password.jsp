<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/include.jsp"%>
<%@ include file="../include/header.jsp"%>
<link rel="stylesheet" type="text/css" href="${path}/resources/css/member_password.css?ver=20191030">
<c:if test="${sessionScope.userid == null}">
	<script>
		alert("로그인 후 사용해주세요")
		location.href="${path}/";
	</script>
</c:if>
<div class="wrapper member_wrapper">
    <div class="wrapper-header">
        <span class="header-text">비밀번호 변경</span>
    </div>
    <div>
	    <div class="member_password">
	        <div>
	            <p><span style="color : #ff6020;">안전한 비밀번호로 내정보를 보호하세요</span></p>
	            <p><span style="color : #ff6020;">이전에 사용한적 없는 비밀번호</span>가 안전합니다.</p>
	        </div>
	        <form action="${path}/member/psupdate" method="POST" id="mem_uppass">
		        <div class="member_new_password">
                    <div class="member-label"><span>현재 비밀번호</span></div>
                    <div class="member_new_ps">
                        <input type="password" id="new_ps" class="password_new pass-input">
                        <div class="member_password_err">
                        <span>필수 입력 정보입니다.</span>
                        </div>
                    </div>
                    <div class="member-label"><span>새 비밀번호</span></div>
                    <div class="member_new_ps">
                        <input class="pass-input" type="password" id="new_psword" name="passwd">
                        <div class="member_password_err">
                        <span>필수 입력 정보입니다.</span>
                        </div>
                    </div>
                    <div class="member-label"><span>비밀번호 확인</span></div>
                    <div class="member_new_ps">
                        <input class="pass-input" type="password" id="new_psword_re">
                        <div class="member_password_err">
                        <span>필수 입력 정보입니다.</span>
                        </div>
                    </div>
                </div>
		        <div class="member_password_btn">
		            <a class="a-button a-common" id="cancle">취소</a>
		            <a class="a-button a-delete" id="password_btn">확인</a>
		        </div>
				<input type="hidden" name="userid" value="${sessionScope.userid}">
			</form>
	    </div>
	</div>
</div>
<%@ include file="../include/footer.jsp" %>
<script type="text/javascript" src="${path}/resources/js/validation.js?ver=20191030"></script>
<script>
$(function() {
	var state = false;
	var new_ps = false;
	var new_psword = false;
	var new_psword_re = false;
	// 입력한 비밀번호가 로그인 한 id의 비밀번호와 맞는지 체크
	$('#new_ps').blur(function() {
		var user = "${sessionScope.userid}";
		var pass = $.trim($('.password_new').val());
		var regEmpty = /\s/g;
		// 입력한 비밀번호 null 체크
		if(pass == null || pass.length == 0) {
			$(this).next().css('visibility','visible').css('color','crimson');
			$('#delete-password').focus();
		} else if(pass.match(regEmpty)){
			$(this).next().text('공백없이 입력해주세요.').css('visibility','visible').css('color','crimson');
		} else {
			// 입력한 비밀번호와 id의 비밀번호 체크
			state = ajaxPassCheck(user,pass);
			// state가 true일때
			if(state) {
				$(this).next().text('비밀번호가 일치합니다.').css('visibility','visible').css('color','skyblue');
				
			} else {
				$(this).next().text('비밀번호가 일치하지 않습니다.').css('visibility','visible').css('color','crimson');
				return false;
			}
			new_ps = true;
			return true;
		}
		new_ps = false;
		return false;
	})
	// 새 비밀번호 유효성 체크 및 중복 체크
	$('#new_psword').blur(function() {
		
		var user = "${sessionScope.userid}";
		var newpass = $.trim($(this).val());
		// newpass와 repass로 joinValidate의 checkPs로 유효성 체크 후 resultCode 값 담기
		var checkResult = joinValidate.checkPs(newpass);
		// checkResult.code에 맞는 메시지 출력
		if(checkResult.code != 0) {
			$(this).next().text(checkResult.desc).css('visibility','visible').css('color','crimson');
		} else {
			// 입력한 비밀번호와 로그인한 id의 비밀번호가 같은지 체크
			if(ajaxPassCheck(user,newpass)) {
				$(this).next().text('현재 비밀번호와 같은 비밀번호입니다.').css('visibility','visible').css('color','crimson');
				return false;
			} else {
				$(this).next().text(checkResult.desc).css('visibility','visible').css('color','skyblue');
			}
			$('#new_psword_re').focus();
			$('#new_psword_re').next().css('visibility','hidden');
			new_psword = true;
			new_psword_re = false;
			return true;
		}
		new_psword = false;
		return false;
	})
	// 새 비밀번호 확인 체크
	$('#new_psword_re').blur(function() {
		
		var repass = $.trim($(this).val());
		var newpass = $.trim($('#new_psword').val());
		// repass와 newpass로 joinValidate의 checkRps로 유효성 체크 후 resultCode 값 담기
		var checkResult = joinValidate.checkRps(repass, newpass);
		// checkResult.code에 맞는 메시지 출력
		if(checkResult.code != 0) {
			$(this).next().text(checkResult.desc).css('visibility','visible').css('color','crimson');	
		} else {
			$(this).next().text(checkResult.desc).css('visibility','visible').css('color','skyblue');
			new_psword_re = true;
			return true;
		}
		new_psword_re = false;
		return false;
	})
	// 유효성 체크 후 submit
	$('#password_btn').click(function() {
		if(!new_ps) {
			$('#new_ps').focus();
			$('#new_ps').next().css('color','crimson');
			return false;
		} else if(!new_psword) {
			$('#new_psword').focus();
			$('#new_psword').next().css('color','crimson');
			return false;
		} else if(!new_psword_re) {
			$('#new_psword_re').focus();
			$('#new_psword_re').next().css('color','crimson');
			return false;
		}
		$('#mem_uppass').submit();
	})
	
	// 취소 버튼
	$('#cancle').click(function(){
		location.href = '${path}/member/mypage'
	})
})
</script>