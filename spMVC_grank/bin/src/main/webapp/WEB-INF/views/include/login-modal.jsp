<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="${path}/resources/css/login.css?ver=20191014">
<div id="modal-login" class="modal">
	<div class="modal-box">
		<span class="modal-close"><i class="fas fa-times"></i></span>
		<h2>로그인</h2>
		<form>
			<div class="inputBox">
				<input id="login-id" type="text" name="" required=""> <label>UserId</label>
				<span class="err-msg">test</span>
			</div>
			<div class="inputBox">
				<input id="login-pw" type="password" required="" name=""> <label>Password</label>
			</div>
			<input id="login-submit" type="button" value="로그인"><br>
			<div id="login-nav">
				<span>회원가입</span> <span>｜</span> <span>아이디찾기</span> <span>｜</span> <span>비밀번호찾기</span>
			</div>
		</form>
	</div>
</div>

