<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="${path}/resources/css/login.css?ver=20191028">
<div id="modal-login" class="modal">
	<div class="modal-box">
		<span class="modal-close"><i class="fas fa-times"></i></span>
		<h2>로그인</h2>
		<form>
			<div class="inputBox">
				<input autocomplete="off" id="login-id" type="text" name="" required=""> <label>UserId</label>
			</div>
			<div class="inputBox">
				<input id="login-pw" type="password" required="" name=""> <label>Password</label>
				<span class="login-err-msg">test</span>
			</div>
			<input id="login-submit" type="button" value="로그인"><br>
			<div class="auto-login">
               <input class="checkbox" type="checkbox"><span>로그인 상태 유지</span>
            </div>
			<div id="login-nav">
				<span class="login-join-btn">회원가입</span> <span>｜</span> <span class="login-idcheck">아이디찾기</span> <span>｜</span> <span class="login-pscheck">비밀번호찾기</span>
			</div>
		</form>
	</div>
</div>

