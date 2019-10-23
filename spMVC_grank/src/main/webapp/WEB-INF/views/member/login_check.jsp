<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/include.jsp"%>
<%@ include file="../include/header.jsp"%>
<link rel="stylesheet" type="text/css"
	href="${path}/resources/css/login-check.css?ver=2019101703">
<c:if test="${sessionScope.userid != null}">
	<script>
		alert("로그아웃 후 사용해주세요");
		location.href="${path}/";
	</script>
</c:if>
<div class="wrapper login-check">
	<div class="wrapper-header">
		<span class="header-text" id="idcheck">아이디 찾기</span>&nbsp;&nbsp;&nbsp;<span>||</span><span class="header-text" id="pscheck">비밀번호 찾기</span>
	</div>
	<div>
		<form method="POST" id="login-frm">
			<div class="login-check-main">
				<h3 class="login-check-h3">회원정보에 등록한 이메일로 아이디 찾기</h3>
				<div class="login-pwcheck-email">
					<input type="text" class="login-check-input" id="check-id" placeholder="아이디">
				</div>
				<div class="login-idcheck-email">
					<input type="text" class="login-check-input" id="check-email" placeholder="이메일">
				</div>
			</div>
			<div class="login-check-btn">
				<a class="a-button a-common" id="check-btn">찾기</a>
			</div>
			<div class="login-check-main">
				<div class="email-checkid">
					<span></span>
				</div>
			</div>
		</form>
	</div>
</div>
<%@ include file="../include/footer.jsp"%>
<script type="text/javascript" src="${path}/resources/js/validation.js"></script>
<script>
	$(function() {
		var code = "${code}";
		if(code != "idcheck") {
			$('#pscheck').css('color','yellow')
			$('.login-pwcheck-email').css('display','block')
			$('.login-check-h3').text('회원정보에 등록한 아이디와 이메일로 비밀번호 찾기')
		} else {
			$('#idcheck').css('color','yellow')
		}
		$("#idcheck").click(function() {
			location.href = "${path}/member/login_check?code=idcheck"
		})
		$("#pscheck").click(function() {
			location.href = "${path}/member/login_check?code=pscheck"
		})
		$("#check-btn").click(function() {
			if(code == "idcheck") {
				var email = $.trim($("#check-email").val())
				if(email == null || email.length ==0) {
					alert("이메일을 입력해주세요")
				} else {
					var email_check = ajaxEmailCheck(email);
				}
				if(email_check != "") {
					$(".email-checkid").text("회원님의 아이디는 "+email_check+"입니다.")
				} else {
					$(".email-checkid").text("일치하는 이메일이 없습니다")
				}	
			} else {
				var userid = $.trim($("#check-id").val())
				var email = $.trim($("#check-email").val())
				
				var psword = ajaxPswordCheck(userid, email);
				if(email_check != "") {
					$(".email-checkid").text("임시 비밀번호는 "+psword+"입니다.")
				} else {
					$(".email-checkid").text("일치하지 않습니다")
				}
			}
			
			
		})
	})
</script>