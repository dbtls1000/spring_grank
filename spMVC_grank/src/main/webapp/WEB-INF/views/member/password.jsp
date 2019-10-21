<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/include.jsp"%>
<%@ include file="../include/header.jsp"%>
<link rel="stylesheet" type="text/css" href="${path}/resources/css/member_password.css?ver=2019101703">
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
		            <div class="member_new_ps">
		                <input type="password" id="new_ps" class="password_new" placeholder="현재 비밀번호">
		            </div>
		            <div class="member_password_err">
						<span class="member-pass-err">필수 입력 정보입니다</span>
					</div>
		            <div>
		                <input type="password" id="new_ps" name="passwd" placeholder="새 비밀번호">
		            </div>
		            <div>
		                <input type="password" id="new_ps_re" placeholder="새 비밀번호 확인">
		            </div>
		        </div>
		        <div class="member_password_btn">
		            <a class="a-button a-common">취소</a>
		            <a class="a-button a-delete" id="password_tbn">확인</a>
		        </div>
				<input type="hidden" name="userid" value="${sessionScope.userid}">
			</form>
	    </div>
	</div>
</div>
<%@ include file="../include/footer.jsp" %>
<script type="text/javascript" src="${path}/resources/js/validation.js"></script>
<script>
$(function() {
	var state = false;
	$('#new_ps').blur(function() {
		var user = "${sessionScope.userid}";
		var pass = $.trim($('.password_new').val());
		
		if(pass == null || pass.length == 0) {
			$('.member-pass-err').css('visibility','visible');
			$('#delete-password').focus();
		} else {
			$('.member-pass-err').css('visibility','hidden');
			state = ajaxPassCheck(user,pass);
		}
	})
	
	$('#password_tbn').click(function() {
		if(state) {
			$('#mem_uppass').submit();
		}
	})
})
</script>